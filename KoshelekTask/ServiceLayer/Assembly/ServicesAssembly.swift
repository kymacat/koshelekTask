//
//  ServicesAssembly.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol IServicesAssembly {
    var breedsService: IBreedsService { get }
    var galleryService: IGalleryService { get }
    var favouritesService: IFavouritesService { get }
}

class ServicesAssembly: IServicesAssembly {
    
    private let coreAssembly: ICoreAssembly
    
    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
    
    lazy var breedsService: IBreedsService = BreedsService(requestSender: coreAssembly.requestSender)
    
    lazy var galleryService: IGalleryService = GalleryService(requestSender: coreAssembly.requestSender, fileManager: coreAssembly.breedsFileManager)
    
    lazy var favouritesService: IFavouritesService = FavouritesService(fileManager: coreAssembly.breedsFileManager)
    
}
