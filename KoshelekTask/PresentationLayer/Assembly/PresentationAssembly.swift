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
    
    func breedsViewController() -> BreedsViewController
}

class PresentationAssembly: IPresentationAssembly {
    
    private let serviceAssembly: IServicesAssembly
    
    init(serviceAssembly: IServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: - RootTabBarController
    
    func rootTabBarController() -> UITabBarController {
        
        let tabBarController = UITabBarController()
        
        let breedsController = breedsViewController()
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
        
        tabBarController.viewControllers = [navigationForBreeds]
        
        return tabBarController
        
    }
    
    // MARK: - BreedsViewController
    
    func breedsViewController() -> BreedsViewController {
        let model = breedsVCModel()
        let controller = BreedsViewController(model: model, assembly: self)
        return controller
    }
    
    private func breedsVCModel() -> IBreedsVCModel {
        return BreedsVCModel(breedsService: serviceAssembly.breedsService)
    }
    
}
