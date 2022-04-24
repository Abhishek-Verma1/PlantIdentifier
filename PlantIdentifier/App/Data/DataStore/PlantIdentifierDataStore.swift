//
//  PlantIdentifierDataStore.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/21/22.
//

import UIKit

#warning("Optimization is required in the next sprint.")
final class PlantIdentifierDataStore: PlantRepositoryProtocol {
    
    func postPlantIdentify(image: UIImage, onCompletion: @escaping (Response) -> ()) {
        let languageCode = "en"
        
        let endpoint = URL(string: "\(Constants.PlantNetAPI.baseURL)/v2/\(Constants.PlantNetAPI.identify)/all?api-key=\(Constants.PlantNetAPI.apiKey)&lang=\(languageCode)")!
       
        
        var request = URLRequest(url: endpoint)
        request = PlantIdentifierDataStore.imageUploadRequest(endPointURL: endpoint, method: "POST", image: image)
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data,
                  error == nil
            else {
                onCompletion(.failure(PlantIdentifierError(statusCode: (error as NSError?)?.code ?? 0,
                                                           error: "Error",
                                                           message: (error as NSError?)?.domain ?? "unknown")))
                return
            }
            
            if let result = try? PlantIdentifierDataStore.newJSONDecoder().decode(PlantIdentifierDataModel.self, from: data) {
                onCompletion(.success(result))
            } else if let error = try? JSONDecoder().decode(PlantIdentifierError.self, from: data) {
                onCompletion(.failure(error))
            } else {
                onCompletion(.failure(
                    PlantIdentifierError(statusCode: 0,
                                         error: "undefined",
                                         message: "undefined")))
            }
        }.resume()
    }
    
    class func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    
    class func imageUploadRequest(endPointURL: URL, method: String, image: UIImage) -> URLRequest {
        let boundary = "Boundary-\(NSUUID().uuidString)"
        var request = URLRequest(url: endPointURL)
        
        guard let mediaImage = MultipartFormDataRequest.Media(withImage: image, forKey: "images") else { return request }
        
        request.httpMethod = method
        
        request.allHTTPHeaderFields = [
            "X-User-Agent": "ios",
            "Accept-Language": "en",
            "Accept": "application/json",
            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        ]
        
        let dataBody = MultipartFormDataRequest.createDataBody(
            withParameters: nil,
            media: [mediaImage],
            boundary: boundary
        )
        request.httpBody = dataBody
        return request
    }
    
}
