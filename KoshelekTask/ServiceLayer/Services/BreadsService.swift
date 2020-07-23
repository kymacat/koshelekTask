//
//  BreadsService.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

struct BreadModel {
    let name: String
    let subbreads: [String]
}

protocol IBreadsService {
    func loadBreads(completionHandler: @escaping ([BreadModel]?, String?) -> Void)
}

class BreadsService : IBreadsService {
    
    let requestSender: IRequestSender
    
    init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    func loadBreads(completionHandler: @escaping ([BreadModel]?, String?) -> Void) {
        
        let requestConfig = RequestsFactory.breadsConfig()
        
        requestSender.send(requestConfig: requestConfig) { (result: Result<[String: [String]]>) in
                   
            switch result {
                case .success(let breads):
                    
                    var breadModels = [BreadModel]()
                
                    for (key, value) in breads {
                        let newModel = BreadModel(name: key, subbreads: value)
                        breadModels.append(newModel)
                    }
                
                    completionHandler(breadModels, nil)
                
                case .error(let error):
                    completionHandler(nil, error)
                
            }
            
        }
        
    }
    
    
}
