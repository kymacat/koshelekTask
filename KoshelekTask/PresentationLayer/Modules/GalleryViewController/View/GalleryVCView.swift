//
//  GalleryVCView.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class GalleryVCView: UIView {
    
    // MARK: - UI
    
    let collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flow)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let heartButton = HeartButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill()
    }
    
    // MARK: - Fill
    
    private func fill() {
        backgroundColor = .white
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(heartButton)
        
        NSLayoutConstraint.activate([
            heartButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -10),
            heartButton.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -10),
            heartButton.heightAnchor.constraint(equalToConstant: 60),
            heartButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
