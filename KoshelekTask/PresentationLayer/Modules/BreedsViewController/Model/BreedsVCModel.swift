//
//  BreadsVCModel.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol BreedsModelDelegate {
    func setBreeds(breeds: [BreedModel])
    func showError(error: String)
}

protocol IBreedsVCModel {
    
    var delegate: BreedsModelDelegate? { get set }
    
    func fetchBreeds()
}

class BreedsVCModel: IBreedsVCModel {
    
    var delegate: BreedsModelDelegate?
    
    private let service: IBreedsService
    
    private let data: [BreedModel]?
    
    init(breedsService: IBreedsService, breeds: [BreedModel]?) {
        self.service = breedsService
        self.data = breeds
    }
    
    func fetchBreeds() {
        
        if let data = data {
            delegate?.setBreeds(breeds: data)
            return
        }
        
        service.loadBreeds() { breeds, error in
            
            guard let breeds = breeds, error == nil else {
                if let error = error {
                    DispatchQueue.main.async {
                        self.delegate?.showError(error: error)
                    }
                }
                return
            }
            
            DispatchQueue.main.async {
                self.delegate?.setBreeds(breeds: breeds)
            }
            
            
        }
        
    }
    
}
