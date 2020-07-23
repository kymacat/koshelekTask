//
//  ImageRequest.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

class ImageRequest: IRequest {
    let imageUrl: String
    
    // MARK: - IRequest
    
    var urlRequest: URLRequest? {
        if let url = URL(string: imageUrl) {
            return URLRequest(url: url)
        }
        return nil
    }
    
    // MARK: - Initialization

    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}
