//
//  BreadsRequest.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

class BreedsRequest: IRequest {
    
    private var baseUrl: String = Constants.API.listOfBreedsApiRequest

    private var urlString: String {
        return baseUrl
    }
    
    // MARK: - IRequest
    
    var urlRequest: URLRequest? {
        if let url = URL(string: urlString) {
            return URLRequest(url: url)
        }
        return nil
    }
    
}
