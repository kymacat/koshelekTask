//
//  BreedCell.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class BreedCell: UITableViewCell {
    
    // MARK: - UI
    
    let breedLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Design.Font.breedCellBreedLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subbreedLabel: UILabel = {
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
    
    var model: BreedModel?
    
    func configure(with model: BreedModel) {
        
        self.model = model
        
        breedLabel.text = model.name.capitalizingFirstLetter()
        
        if model.subbreeds.count != 0 {
            subbreedLabel.text = "(\(model.subbreeds.count) subbreeds)"
        } else {
            subbreedLabel.text = ""
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
        
        addSubview(subbreedLabel)
        
        NSLayoutConstraint.activate([
            subbreedLabel.centerYAnchor.constraint(equalTo: breedLabel.centerYAnchor),
            subbreedLabel.leadingAnchor.constraint(equalTo: breedLabel.trailingAnchor, constant: 10)
        ])
    }
    
}

// MARK: - String extension

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
}
