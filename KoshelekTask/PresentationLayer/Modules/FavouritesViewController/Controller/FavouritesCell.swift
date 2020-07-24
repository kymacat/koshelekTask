//
//  FavouritesCell.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class FavouritesCell: UITableViewCell {
    
    // MARK: - UI
    
    let breedLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Design.Font.breedCellBreedLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countLabel: UILabel = {
       let label = UILabel()
        label.font = Constants.Design.Font.breedCellSubbreedLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fillView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    var model: Breed?
    
    func configure(with model: Breed) {
        
        self.model = model
        
        breedLabel.text = model.name?.capitalizingFirstLetter()
        
        guard let dbImages = model.images?.allObjects as? [Image] else {
            return
        }
        
        if dbImages.count != 0 {
            if dbImages.count == 1 {
                countLabel.text = "(\(dbImages.count) photo)"
            } else {
                countLabel.text = "(\(dbImages.count) photos)"
            }
        } else {
            countLabel.text = ""
        }
        
    }
    
    // MARK: - Animation
    
    func animationOfSelection() {
        backgroundColor = .lightGray
        UIView.animate(withDuration: 1) {
            self.backgroundColor = .white
        }
    }
    
    // MARK: - Fill
    
    private func fillView() {
        backgroundColor = .white
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = Constants.Design.Color.cellsSeparatorColor
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: topAnchor),
            separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        addSubview(breedLabel)
        
        NSLayoutConstraint.activate([
            breedLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            breedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            breedLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])
        
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            countLabel.centerYAnchor.constraint(equalTo: breedLabel.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: breedLabel.trailingAnchor, constant: 10)
        ])
    }
    
}
