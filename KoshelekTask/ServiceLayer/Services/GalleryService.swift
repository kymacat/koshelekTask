//
//  GalleryService.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol IGalleryService {
    func loadBreedAllImages(breed: String, subbreed: String?, completionHandler: @escaping ([BreedImageModel]?, String?) -> Void)
    func loadBreedImage(imageUrl: String, completionHandler: @escaping (UIImage?, String, String?) -> Void)
    func saveBreed(name: String, images: [BreedImageModel])
    func getImagesFromBD(breedName: String) -> ([BreedImageModel]?, Error?)
}

class GalleryService: IGalleryService {
    
    private let requestSender: IRequestSender
    
    private let breedsFileManager: IBreedsFileManager
    
    init(requestSender: IRequestSender, fileManager: IBreedsFileManager) {
        self.requestSender = requestSender
        self.breedsFileManager = fileManager
    }
    
    // MARK: - loadAllImages
    
    func loadBreedAllImages(breed: String, subbreed: String?, completionHandler: @escaping ([BreedImageModel]?, String?) -> Void) {
        let requestConfig = RequestsFactory.breedImagesConfig(breed: breed, subbreed: subbreed)
        
        requestSender.send(requestConfig: requestConfig) { (result: Result<[String]>) in
            switch result {
                case .success(let images):
                    
                    var models = [BreedImageModel]()
                    
                    for image in images {
                        let newModel = BreedImageModel(url: image)
                        models.append(newModel)
                    }
                    
                    completionHandler(models, nil)
                
                case .error(let error):
                    completionHandler(nil, error)
            }
        }
        
    }
    
    // MARK: - LoadBreedImage
    
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
    
    // MARK: - saveBreed
    
    func saveBreed(name: String, images: [BreedImageModel]) {
        
        var entities = [BreedImageEntity]()
        
        for imageModel in images {
            
            guard let imageData = imageModel.image?.pngData() else {
                continue
            }
            
            let newEntity = BreedImageEntity(url: imageModel.url, image: imageData, isLiked: imageModel.isLiked)
            
            entities.append(newEntity)
        }

        
        breedsFileManager.saveImages(breedName: name, images: entities)
    }
    
    // MARK: - get images from DB
    
    func getImagesFromBD(breedName: String) -> ([BreedImageModel]?, Error?) {
        let data = breedsFileManager.fetchBreeds()
        
        guard let breeds = data.0, data.1 == nil else {
            return (nil, data.1)
        }
        
        for breed in breeds {
            if breedName == breed.name {
                
                var models = [BreedImageModel]()
                
                guard let dbImages = breed.images?.allObjects as? [Image] else {
                    break
                }
                
                for dbImage in dbImages {
                    
                    guard let url = dbImage.url,
                        let imageData = dbImage.image,
                        let image = UIImage(data: imageData) else {
                            continue
                    }
                    
                    let newModel = BreedImageModel(url: url, image: image, isLiked: dbImage.isliked)
                    
                    models.append(newModel)
                }
                
                return (models, nil)
            }
        }
        return ([], nil)
    }
    
}
