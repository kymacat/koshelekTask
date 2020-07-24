//
//  BreedsFileManager.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import CoreData

protocol IBreedsFileManager {
    func saveImages(breedName: String, images: [BreedImageEntity])
    func fetchBreeds() -> ([Breed]?, Error?)
    func fetchedResultsController() -> NSFetchedResultsController<Breed>
}

class BreedsFileManager: CoreDataStack, IBreedsFileManager {
    
    private let breedEntityName = Constants.CoreData.Entities.breedEntityName
    private let imageEntityName = Constants.CoreData.Entities.imageEntityName
    
    
    var fetchedController: NSFetchedResultsController<Breed>?
    
    override init() {
        super.init()
        let fetchRequest = NSFetchRequest<Breed>(entityName: breedEntityName)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
    }
    
    func fetchedResultsController() -> NSFetchedResultsController<Breed> {
        return fetchedController!
    }
    
    
    // MARK: - Save images
    
    func saveImages(breedName: String, images: [BreedImageEntity]) {
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: breedEntityName, in: self.managedObjectContext) else {
            print("entity description error")
            return
        }
        
        var managedObject: Breed?
        
        
        let fetch = fetchBreeds()
        
        var inBD = false
        if let breeds = fetch.0 {
            for breed in breeds {
                if breed.name == breedName {
                    managedObject = breed
                    inBD = true
                }
            }
        }
        
        if !inBD {
            managedObject = Breed(entity: entityDescription, insertInto: self.managedObjectContext)
        }
        
        managedObject?.name = breedName
        
        guard let dbImages = managedObject?.images?.allObjects as? [Image] else {
            return
        }
        
        var deletedImagesCount = 0
        
        for imageModel in images {

            var inBD = false
            for dbImage in dbImages {
                
                if dbImage.url == imageModel.url {

                    if !imageModel.isLiked {
                        managedObjectContext.delete(dbImage)
                        deletedImagesCount += 1
                    }

                    inBD = true
                }
            }

            if !inBD && imageModel.isLiked {

                guard let imageEntityDescription = NSEntityDescription.entity(forEntityName: imageEntityName, in: self.managedObjectContext) else {
                    print("entity description error")
                    continue
                }

                let imageManagedObject = Image(entity: imageEntityDescription, insertInto: self.managedObjectContext)

                imageManagedObject.image = imageModel.image
                imageManagedObject.url = imageModel.url
                imageManagedObject.isliked = imageModel.isLiked

                managedObject?.addToImages(imageManagedObject)

            }
        }
        
        if let newData = managedObject?.images?.allObjects as? [Image] {
            if newData.count == 0 || newData.count == deletedImagesCount {
                managedObjectContext.delete(managedObject!)
            }
        }

        self.saveContext(completion: nil)
    }
    
    // MARK: - Fetch Breeds
    
    func fetchBreeds() -> ([Breed]?, Error?) {
        let fetchRequest = NSFetchRequest<Breed>(entityName: breedEntityName)
        do {
            let breeds = try self.managedObjectContext.fetch(fetchRequest)
            return (breeds, nil)
        } catch {
            return (nil, error)
        }
    }

    
}
