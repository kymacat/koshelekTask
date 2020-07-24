//
//  FavouritesVCModel.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import CoreData

protocol IFavouritesVCModel {
    func fetchedResultsController() -> NSFetchedResultsController<Breed>
}

class FavouritesVCModel: IFavouritesVCModel {
    
    private let service: IFavouritesService
    
    init(service: IFavouritesService) {
        self.service = service
    }
    
    func fetchedResultsController() -> NSFetchedResultsController<Breed> {
        return service.fetchedResultsController()
    }
    
}
