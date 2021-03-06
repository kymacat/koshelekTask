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
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    
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
        
        breedsView.tableView.refreshControl = refreshControl
        refreshControl.beginRefreshing()
        
        model.fetchBreeds()
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        refreshControl.beginRefreshing()
        model.fetchBreeds()
    }
    
     // MARK: - ErrorAlert
    
    private func showErrorAlert(with message: String) {
           
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
           
        present(alert, animated: true, completion: nil)
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
        
        let breed = data[indexPath.row]
        let subbreeds = breed.subbreeds
        
        if subbreeds.count != 0 {
            
            var subbreedsModels = [BreedModel]()
            
            for subbreed in subbreeds {
                var newSubbreed = BreedModel(name: subbreed, subbreeds: [])
                newSubbreed.parentBreed = breed.name
                subbreedsModels.append(newSubbreed)
            }
            
            
            let subbreedsController = assembly.breedsViewController(breeds: subbreedsModels)
            subbreedsController.navigationItem.title = data[indexPath.row].name.capitalizingFirstLetter()
            navigationController?.pushViewController(subbreedsController, animated: true)
            
        } else {
            
            let breed = data[indexPath.row]
            
            let galleryController = assembly.galleryViewController(breed: breed, images: nil)
            
            if let parent = breed.parentBreed {
                galleryController.navigationItem.title = breed.name.capitalizingFirstLetter() + " " + parent 
            } else {
                galleryController.navigationItem.title = breed.name.capitalizingFirstLetter()
            }
            
            navigationController?.pushViewController(galleryController, animated: true)
            
        }
        
    }
    
}

// MARK: - BreedsModelDelegate

extension BreedsViewController: BreedsModelDelegate {
    
    func setBreeds(breeds: [BreedModel]) {
        data = breeds
        breedsView.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func showError(error: String) {
        showErrorAlert(with: error)
        refreshControl.endRefreshing()
    }
    
    
}
