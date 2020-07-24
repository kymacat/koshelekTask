//
//  PresentationAssembly.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol IPresentationAssembly {
    
    func rootTabBarController() -> UITabBarController
    
    func breedsViewController(breeds: [BreedModel]?) -> BreedsViewController
    
    func galleryViewController(breed: BreedModel) -> GalleryViewController
    
    func favouritesViewController() -> FavouritesViewController
}

class PresentationAssembly: IPresentationAssembly {
    
    private let serviceAssembly: IServicesAssembly
    
    init(serviceAssembly: IServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: - RootTabBarController
    
    func rootTabBarController() -> UITabBarController {
        
        let tabBarController = UITabBarController()
        
        let breedsController = breedsViewController(breeds: nil)
        breedsController.navigationItem.title = "Breeds"
        
        let navigationForBreeds = UINavigationController(rootViewController: breedsController)
        navigationForBreeds.tabBarItem.title = "List"
        
        if let navigationTitleFont = Constants.Design.Font.navigationTitleFont {
            navigationForBreeds.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont]
        }
        
        if let tabBarItemTitleFont = Constants.Design.Font.tabBarItemTitleFont {
            navigationForBreeds.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: tabBarItemTitleFont], for: .normal)
        }
        
        navigationForBreeds.tabBarItem.image = Constants.Design.Image.breedsTabBarItemImage
        
        
        let favouritesController = favouritesViewController()
        favouritesController.navigationItem.title = "Favourites"
        
        let navigationForFavourites = UINavigationController(rootViewController: favouritesController)
        navigationForFavourites.tabBarItem.title = "Favourites"
        
        if let navigationTitleFont = Constants.Design.Font.navigationTitleFont {
            navigationForFavourites.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont]
        }
        
        if let tabBarItemTitleFont = Constants.Design.Font.tabBarItemTitleFont {
            navigationForFavourites.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: tabBarItemTitleFont], for: .normal)
        }
        
        navigationForFavourites.tabBarItem.image = Constants.Design.Image.favouritesTabBarItemImage
        
        tabBarController.viewControllers = [navigationForBreeds, navigationForFavourites]
        
        return tabBarController
        
    }
    
    // MARK: - BreedsViewController
    
    func breedsViewController(breeds: [BreedModel]?) -> BreedsViewController {
        let model = breedsVCModel(breeds: breeds)
        let controller = BreedsViewController(model: model, assembly: self)
        return controller
    }
    
    private func breedsVCModel(breeds: [BreedModel]?) -> IBreedsVCModel {
        return BreedsVCModel(breedsService: serviceAssembly.breedsService, breeds: breeds)
    }
    
    // MARK: - GaleryViewController
    
    func galleryViewController(breed: BreedModel) -> GalleryViewController {
        let model = galleryVCModel(breed: breed)
        let controller = GalleryViewController(model: model, assembly: self)
        return controller
    }
    
    private func galleryVCModel(breed: BreedModel) -> GalleryVCModel {
        return GalleryVCModel(service: serviceAssembly.galleryService, breed: breed)
    }
    
    // MARK: - FavouritesViewController
    
    func favouritesViewController() -> FavouritesViewController {
        let model = favouritesVCModel()
        let controller = FavouritesViewController(model: model, assembly: self)
        return controller
    }
    
    private func favouritesVCModel() -> FavouritesVCModel {
        return FavouritesVCModel(service: serviceAssembly.favouritesService)
    }
    
}
