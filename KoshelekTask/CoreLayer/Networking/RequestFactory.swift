//
//  RequestFactory.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

struct RequestsFactory {
    
    static func breedsConfig() -> RequestConfig<BreedsParser> {
        let request = BreedsRequest()
        return RequestConfig<BreedsParser>(request: request, parser: BreedsParser())
    }
        
}
