//
//  BreedsImagesRequest.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

class BreedImagesRequest: IRequest {
    
    private var baseUrl: String = "https://dog.ceo/api/breed/"
    private var breed: String
    private var subbreed: String?

    private var urlString: String {
        
        if let subbreed = subbreed {
            return baseUrl + breed + "/" + subbreed + "/" + "images"
        }
        
        return baseUrl + breed + "/" + "images"
    }
    
    // MARK: - IRequest
    
    var urlRequest: URLRequest? {
        if let url = URL(string: urlString) {
            return URLRequest(url: url)
        }
        return nil
    }
    
    // MARK: - Init
    
    init(breed: String, subbreed: String?) {
        self.breed = breed
        self.subbreed = subbreed
    }
    
}
