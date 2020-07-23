//
//  BreadsService.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol IBreedsService {
    func loadBreeds(completionHandler: @escaping ([BreedModel]?, String?) -> Void)
}

class BreedsService : IBreedsService {
    
    let requestSender: IRequestSender
    
    init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    func loadBreeds(completionHandler: @escaping ([BreedModel]?, String?) -> Void) {
        
        let requestConfig = RequestsFactory.breedsConfig()
        
        requestSender.send(requestConfig: requestConfig) { (result: Result<[String: [String]]>) in
                   
            switch result {
                case .success(let breeds):
                    
                    var breedModels = [BreedModel]()
                
                    for (key, value) in breeds {
                        let newModel = BreedModel(name: key, subbreeds: value)
                        breedModels.append(newModel)
                    }
                    
                    let sortedBreeds = breedModels.sorted { (left, right) -> Bool in
                        if left.name < right.name { return true }
                        return false
                    }
                    
                    completionHandler(sortedBreeds, nil)
                
                case .error(let error):
                    completionHandler(nil, error)
                
            }
            
        }
        
    }
    
    
}
