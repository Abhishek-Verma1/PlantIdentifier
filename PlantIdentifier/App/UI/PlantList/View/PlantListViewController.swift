//
//  PlantListViewController.swift
//  PlantIdentifier
//
//  Created by Clean Slate on 4/21/22.
//

import UIKit

final class PlantListViewController: UIViewController, AlertsPresentable {
   
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: PlantListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindViewModel()
        viewModel.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = AppColor.navigationItemTintColor
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupCollectionView() {
        collectionView.setdelegateAndDatasource(for: self)
        collectionView.register(PlantCollectionViewCell.self)
        collectionView.registerSupplementryFooterView(cellClass: RetakePhotoView.self)
    }
    
    private func bindViewModel() {
        title = viewModel.title
        viewModel.error.observe(on: self) { [weak self] _ in self?.collectionView.reloadData() }
        viewModel.reload.observe(on: self) { [weak self] _ in self?.collectionView.reloadData() }
        viewModel.loader.observe(on: self) { ($0) ? LoadingView.show() : LoadingView.hide() }
    }
}

extension PlantListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,  numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeResuseableCell(for: indexPath) as PlantCollectionViewCell
        cell.setup(viewModel.celViewModel(at: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeReusableSupplementryView(reusableViewClass: RetakePhotoView.self, kind: kind, indexPath: indexPath)
        
        if kind == UICollectionView.elementKindSectionFooter, !viewModel.loader.value {
            view.delegate = self
            view.populateData(title: viewModel.getFooterTitle(),
                              description: viewModel.getFooterDescriptionTitle(),
                              buttonTitle: viewModel.getRetakeTitle())
            
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let contextConfiguration = UIContextMenuConfiguration(identifier: nil, previewProvider: {[weak self] in
            guard let self = self, let image = self.viewModel?.selectedImage else { return nil }
            let data = self.viewModel.celViewModel(at: indexPath.row)
            let viewcontroller = self.viewModel.delegate?.openImagePreviewer(data: data, currentImage: image)
            return viewcontroller
        }, actionProvider: nil)
        return contextConfiguration
    }
}

extension PlantListViewController: RetakePhotoViewDelagate {
    func retakeBtnTapped() {
        viewModel.delegate?.moveToPreviousScreen()
    }
}

extension PlantListViewController: UICollectionViewDelegateFlowLayout {
#warning("Magic numbers needs to be replaced later.")

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let footerHeight = !viewModel.loader.value ? 200 : 0.0
        return CGSize(width: collectionView.frame.width, height: footerHeight)
    }
}
