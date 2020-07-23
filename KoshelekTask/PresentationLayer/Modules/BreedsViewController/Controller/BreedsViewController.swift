//
//  BreadsViewController.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class BreedsViewController: UIViewController {
    
    // MARK: - Properties
    
    private var model: IBreedsVCModel
    private let assembly: IPresentationAssembly
    
    private let breedsView = BreedsView()
    
    private let reuseIdentifier = Constants.Content.breedCellReuseIdentifier
    
    private var data = [BreedModel]()
    
    
    // MARK: - Init
    
    init(model: IBreedsVCModel, assembly: IPresentationAssembly) {
        self.model = model
        self.assembly = assembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        view = breedsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        breedsView.tableView.dataSource = self
        breedsView.tableView.delegate = self
        model.delegate = self
        
        breedsView.tableView.register(BreedCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        model.fetchBreeds()
    }

}

// MARK: - UITableViewDataSource

extension BreedsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? BreedCell else { return UITableViewCell() }
        
        cell.configure(with: data[indexPath.row])
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension BreedsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? BreedCell else {
            return
        }
        
        cell.animationOfSelection()
        
        let subbreeds = data[indexPath.row].subbreeds
        
        if subbreeds.count != 0 {
            
            var subbreedsModels = [BreedModel]()
            
            for subbreed in subbreeds {
                let newSubbreed = BreedModel(name: subbreed, subbreeds: [])
                subbreedsModels.append(newSubbreed)
            }
            
            
            let subbreedsController = assembly.breedsViewController(breeds: subbreedsModels)
            subbreedsController.navigationItem.title = data[indexPath.row].name.capitalizingFirstLetter()
            navigationController?.pushViewController(subbreedsController, animated: true)
            
        }
        
    }
    
}

// MARK: - BreedsModelDelegate

extension BreedsViewController: BreedsModelDelegate {
    
    func setBreeds(breeds: [BreedModel]) {
        data = breeds
        breedsView.tableView.reloadData()
    }
    
    func showError(error: String) {
        print(error)
    }
    
    
}
