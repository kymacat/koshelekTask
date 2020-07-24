//
//  GalleryVCModel.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol GalleryModelDelegate {
    func setImages(images: [BreedImageModel])
    func showError(error: String)
}

protocol IGalleryVCModel {
    
    var delegate: GalleryModelDelegate? { get set }
    
    func getBreedImages()
    func getImageForCell(imageUrl: String, completionHandler: @escaping (UIImage?, String, String?) -> Void)
    
    func saveImages(images: [BreedImageModel])
}

class GalleryVCModel: IGalleryVCModel {
    
    var delegate: GalleryModelDelegate?
    
    private var service: IGalleryService
    
    private let breedModel: BreedModel
    
    init(service: IGalleryService, breed: BreedModel) {
        self.breedModel = breed
        self.service = service
    }
    
    // MARK: - get images
    
    func getBreedImages() {
        
        var breed = breedModel.name
        var subbreed: String? = nil
        
        if let parent = breedModel.parentBreed {
            breed = parent
            subbreed = breedModel.name
        }
        
        var breedName = breed
        
        if let subbreed = subbreed {
            breedName = subbreed + " " + breed
        }
        
        service.loadBreedAllImages(breed: breed, subbreed: subbreed) { images, error in
            
            guard var images = images, error == nil else {
                if let error = error {
                    DispatchQueue.main.async {
                        self.delegate?.showError(error: error)
                    }
                }
                return
            }
            
            let data = self.service.getImagesFromBD(breedName: breedName)
            
            if let imagesFromDB = data.0 {
                for (index, image) in images.enumerated() {
                    for dbImage in imagesFromDB {
                        if dbImage.url == image.url {
                            images[index] = dbImage
                            
                        }
                    }
                }
            }
            
            
            DispatchQueue.main.async {
                self.delegate?.setImages(images: images)
            }
            
        }
        
    }
    
    // MARK: - Load one image
    
    func getImageForCell(imageUrl: String, completionHandler: @escaping (UIImage?, String, String?) -> Void) {
        service.loadBreedImage(imageUrl: imageUrl, completionHandler: completionHandler)
    }
    
    // MARK: - saveImages
    
    func saveImages(images: [BreedImageModel]) {
        
        var breed = breedModel.name
        var subbreed: String? = nil
        
        if let parent = breedModel.parentBreed {
            breed = parent
            subbreed = breedModel.name
        }
        
        var breedName = breed
        
        if let subbreed = subbreed {
            breedName = subbreed + " " + breed
        }
        DispatchQueue.global(qos: .background).async {
            self.service.saveBreed(name: breedName, images: images)
        }
        
    }
}
