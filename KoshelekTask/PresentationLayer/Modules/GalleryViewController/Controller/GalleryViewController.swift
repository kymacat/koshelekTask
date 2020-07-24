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
    
    private var breedImages = [BreedImageModel]()
    
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
        
        galleryView.heartButton.addTarget(self, action: #selector(likeButtonAction(_:)), for: .touchUpInside)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        model.saveImages(images: breedImages)
    }
    
    // MARK: - Selectors
    
    @objc func likeButtonAction(_ sender: UIButton) {
        
        if let button = sender as? HeartButton {
            
            for cell in galleryView.collectionView.visibleCells {
                if let indexPath = galleryView.collectionView.indexPath(for: cell) {
                    breedImages[indexPath.row].isLiked = button.isLiked
                }
                
            }

        }
        
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
        
        if let image = breedImages[indexPath.row].image {
            cell.imageView.image = image
        } else {
            cell.configure(model: breedImages[indexPath.row])
        }
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension GalleryViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        for cell in galleryView.collectionView.visibleCells {
            if let indexPath = galleryView.collectionView.indexPath(for: cell) {
                galleryView.heartButton.isLiked = breedImages[indexPath.row].isLiked
            }
            
        }
    }
    
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

// MARK: - GalleryModelDelegate

extension GalleryViewController: GalleryModelDelegate {
    
    func setImages(images: [BreedImageModel]) {
        self.breedImages = images
        if images.first?.isLiked == true {
            galleryView.heartButton.isLiked = true
        }
        galleryView.collectionView.reloadData()
    }
    
    func showError(error: String) {
        showErrorAlert(with: error)
    }
    
}


// MARK: - GalleryCellDelegate

extension GalleryViewController: GalleryCellDelegate {

    func cacheImage(imageUrl: String, image: UIImage) {
        for (index, breedImage) in breedImages.enumerated() {
            if breedImage.url == imageUrl && breedImage.image == nil {
                breedImages[index].image = image
            }
        }
    }
    
    func loadImage(imageUrl: String, completionHandler: @escaping (UIImage?, String, String?) -> Void) {
        model.getImageForCell(imageUrl: imageUrl, completionHandler: completionHandler)
    }

}
