//
//  CoreAssembly.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol ICoreAssembly {

    var requestSender: IRequestSender { get }
    
}

class CoreAssembly: ICoreAssembly {
    
    lazy var requestSender: IRequestSender = RequestSender()
    
}
