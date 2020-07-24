//
//  HearthButton.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class HeartButton: UIButton {
    
    // MARK: - Init
    
    init() {
        super.init(frame: CGRect())
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private let notEnabledImage = Constants.Design.Image.notEnabledHearthButtonImage
    private let enabledImage = Constants.Design.Image.enabledHearthButtonImage
    
    var isLiked: Bool = false {
        didSet {
            if isLiked == true {
                buttonTouchedIn(with: 0.25)
            } else {
                buttonTouchedOut(with: 0.25)
            }
        }
    }
    
    private func setupButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setImage(notEnabledImage, for: .normal)
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isLiked = !isLiked
        }
    }
    
    // MARK: - Events
    
    
    private func buttonTouchedIn(with duration: Double) {
        guard let imageView = imageView else {
            return
        }
        
        setImage(enabledImage, for: .normal)
        UIView.transition(with: imageView,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: { imageView.image = self.enabledImage },
                          completion: nil)
    }
    
    private func buttonTouchedOut(with duration: Double) {
        
      guard let imageView = imageView else {
          return
      }
      
      setImage(notEnabledImage, for: .normal)
      UIView.transition(with: imageView,
                        duration: duration,
                        options: .transitionCrossDissolve,
                        animations: { imageView.image = self.notEnabledImage },
                        completion: nil)
    }
    
}
