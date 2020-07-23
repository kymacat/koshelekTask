//
//  GalleryService.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol IGalleryService {
    func loadBreedAllImages(breed: String, subbreed: String?, completionHandler: @escaping ([String]?, String?) -> Void)
    func loadBreedImage(imageUrl: String, completionHandler: @escaping (UIImage?, String, String?) -> Void)
}

class GalleryService: IGalleryService {
    
    let requestSender: IRequestSender
    
    init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    func loadBreedAllImages(breed: String, subbreed: String?, completionHandler: @escaping ([String]?, String?) -> Void) {
        let requestConfig = RequestsFactory.breedImagesConfig(breed: breed, subbreed: subbreed)
        
        requestSender.send(requestConfig: requestConfig) { (result: Result<[String]>) in
            switch result {
                case .success(let images):
                    completionHandler(images, nil)
                case .error(let error):
                    completionHandler(nil, error)
            }
        }
        
    }
    
    
    func loadBreedImage(imageUrl: String, completionHandler: @escaping (UIImage?, String, String?) -> Void) {
        let requestConfig = RequestsFactory.imageConfig(imageUrl: imageUrl)
        
        requestSender.send(requestConfig: requestConfig) { (result: Result<Data>) in
            switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    completionHandler(image, imageUrl, nil)
                case .error(let error):
                    completionHandler(nil, imageUrl, error)
            }
        }
    }
    
}
