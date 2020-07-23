//
//  GalleryViewController.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private var model: IGalleryVCModel
    private let assembly: IPresentationAssembly
    
    private let galleryView = GalleryVCView()
    
    private var breedImages = [String]()
    private var cachedImages: [String: UIImage] = [:]
    
    private let reuseIdentifier = Constants.Content.galleryCellReuseIdentifier
    
    
    // MARK: - Init
    
    init(model: IGalleryVCModel, assembly: IPresentationAssembly) {
        self.model = model
        self.assembly = assembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = galleryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryView.collectionView.delegate = self
        galleryView.collectionView.dataSource = self
        
        model.delegate = self
        
        galleryView.collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        tabBarController?.tabBar.isHidden = true
        
        model.getBreedImages()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - ErrorAlert
    
    private func showErrorAlert(with message: String) {
              
        let title = NSLocalizedString("Error", comment: "")
              
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
              
        present(alert, animated: true, completion: nil)
    }
    

}

// MARK: - Collection View DataSource

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GalleryCell else {return UICollectionViewCell()}
        
        cell.delegate = self
        
        if let image = cachedImages[breedImages[indexPath.row]] {
            cell.imageView.image = image
        } else {
            cell.configure(imageUrl: breedImages[indexPath.row])
        }
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension GalleryViewController: UICollectionViewDelegate {
    
    
}

// MARK: - Collection view Flow Layout

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension GalleryViewController: GalleryModelDelegate {
    
    func setImages(images: [String]) {
        self.breedImages = images
        galleryView.collectionView.reloadData()
    }
    
    func showError(error: String) {
        showErrorAlert(with: error)
    }
    
}


// MARK: - GalleryCellDelegate

extension GalleryViewController: GalleryCellDelegate {

    func cacheImage(imageUrl: String, image: UIImage) {
        cachedImages[imageUrl] = image
    }

    func loadImage(imageUrl: String, completionHandler: @escaping (UIImage?, String, String?) -> Void) {
        model.getImageForCell(imageUrl: imageUrl, completionHandler: completionHandler)
    }

}
