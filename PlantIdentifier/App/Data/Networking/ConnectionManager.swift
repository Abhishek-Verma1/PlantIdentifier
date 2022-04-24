//
//  ConnectionManager.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/24/22.
//

import Network

final class ConnectionManager {
    
    static let shared = ConnectionManager()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    public func stop() {
        monitor.cancel()
    }
    
}
