//
//  GalleryCell.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol GalleryCellDelegate {
    func cacheImage(imageUrl: String, image: UIImage)
    func loadImage(imageUrl: String, completionHandler: @escaping (UIImage?, String, String?) -> Void)
}

class GalleryCell: UICollectionViewCell {
    
    var delegate: GalleryCellDelegate?
    
    let imageView = UIImageView()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        return indicator
    }()
    
    var imageUrl = ""
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill()
    }
    
    func configure(imageUrl: String) {
        self.imageUrl = imageUrl
        self.imageView.image = .none
        
        activityIndicator.startAnimating()
        
        self.delegate?.loadImage(imageUrl: imageUrl) { image, url, error in
            
            if let image = image {
                
                DispatchQueue.main.async {
                    if self.imageUrl == url {
                        self.imageView.image = image
                        self.activityIndicator.stopAnimating()
                        UIView.transition(with: self.imageView,
                                          duration: 0.75,
                                          options: .transitionCrossDissolve,
                                          animations: { self.imageView.image = image },
                                          completion: nil)
                        self.delegate?.cacheImage(imageUrl: url, image: image)
                    }
                }
                
            } else {
                if let error = error {
                    print(error)
                }
            }
            
        }
        
    }
    
    private func fill() {
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        imageView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
    }

}
