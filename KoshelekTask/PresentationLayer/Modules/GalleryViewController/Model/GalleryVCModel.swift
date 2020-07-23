//
//  GalleryVCModel.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol GalleryModelDelegate {
    func setImages(images: [String])
    func showError(error: String)
}

protocol IGalleryVCModel {
    
    var delegate: GalleryModelDelegate? { get set }
    
    func getBreedImages()
    func getImageForCell(imageUrl: String, completionHandler: @escaping (UIImage?, String, String?) -> Void)
}

class GalleryVCModel: IGalleryVCModel {
    
    var delegate: GalleryModelDelegate?
    
    private var service: IGalleryService
    
    private let breedModel: BreedModel
    
    init(service: IGalleryService, breed: BreedModel) {
        self.breedModel = breed
        self.service = service
    }
    
    func getBreedImages() {
        
        var breed = breedModel.name
        var subbreed: String? = nil
        
        if let parent = breedModel.parentBreed {
            breed = parent
            subbreed = breedModel.name
        }
        
        service.loadBreedAllImages(breed: breed, subbreed: subbreed) { images, error in
            
            guard let images = images, error == nil else {
                if let error = error {
                    DispatchQueue.main.async {
                        self.delegate?.showError(error: error)
                    }
                }
                return
            }
            
            DispatchQueue.main.async {
                self.delegate?.setImages(images: images)
            }
            
        }
        
    }
    
    func getImageForCell(imageUrl: String, completionHandler: @escaping (UIImage?, String, String?) -> Void) {
        service.loadBreedImage(imageUrl: imageUrl, completionHandler: completionHandler)
    }
}
