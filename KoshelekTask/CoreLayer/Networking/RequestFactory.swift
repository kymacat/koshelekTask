//
//  RequestFactory.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

struct RequestsFactory {
    
    static func breadsConfig() -> RequestConfig<BreadsParser> {
        let request = BreadsRequest()
        return RequestConfig<BreadsParser>(request: request, parser: BreadsParser())
    }
        
}
