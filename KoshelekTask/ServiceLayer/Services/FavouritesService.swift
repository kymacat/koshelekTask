//
//  FavouritesService.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import CoreData

protocol IFavouritesService {
    func fetchedResultsController() -> NSFetchedResultsController<Breed>
}

class FavouritesService: IFavouritesService {
    
    private let fileManager: IBreedsFileManager
    
    init(fileManager: IBreedsFileManager) {
        self.fileManager = fileManager
    }
    
    func fetchedResultsController() -> NSFetchedResultsController<Breed> {
        return fileManager.fetchedResultsController()
    }
    
}
