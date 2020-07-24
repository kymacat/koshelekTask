//
//  Constants.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

struct Constants {

    // MARK: - Design

    struct Design {

        // MARK: - Colors

        struct Color {
        
            static let cellsSeparatorColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)

        }

        // MARK: - Images

        struct Image {
            
            static let breedsTabBarItemImage = UIImage(systemName: "list.bullet")
            
            static let notEnabledHearthButtonImage = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(weight: .light))?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
            
            static let enabledHearthButtonImage = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .light))?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
            
        }

        // MARK: - Fonts

        struct Font {

            static let navigationTitleFont = UIFont(name: "Noteworthy-Bold", size: 20)
            
            static let breedCellBreedLabelFont = UIFont(name: "Noteworthy", size: 18)
            
            static let breedCellSubbreedLabelFont = UIFont(name: "Noteworthy", size: 14)
                
            static let tabBarItemTitleFont = UIFont(name: "Noteworthy-Bold", size: 11)

        }
        
    }

    // MARK: - Content

    struct Content {
        
        static let breedCellReuseIdentifier = "breedCell"
        
        static let galleryCellReuseIdentifier = "galaryCell"
        
    }


    // MARK: - API

    struct API {
        
    }

}
