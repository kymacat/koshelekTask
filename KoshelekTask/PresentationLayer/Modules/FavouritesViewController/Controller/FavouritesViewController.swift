//
//  FavouritesViewController.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit
import CoreData

class FavouritesViewController: UIViewController {
    
    // MARK: - Properties
    private let model: IFavouritesVCModel
    private let assembly: IPresentationAssembly
    
    private let favouritesView = FavouritesVCView()
    
    private let reuseIdentifier = Constants.Content.favouritesCellReuseIdentifier
    
    // MARK: - Init
    
    init(model: IFavouritesVCModel, assembly: IPresentationAssembly) {
        self.model = model
        self.assembly = assembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = favouritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouritesView.tableView.dataSource = self
        favouritesView.tableView.delegate = self
        
        model.fetchedResultsController().delegate = self
        
        favouritesView.tableView.register(FavouritesCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        do {
            try model.fetchedResultsController().performFetch()
        } catch {
            print(error)
        }
    }

}

// MARK: - TableViewDataSource

extension FavouritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = model.fetchedResultsController().sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? FavouritesCell else {
            return UITableViewCell()
        }
        
        let breed = model.fetchedResultsController().object(at: indexPath)
        
        cell.configure(with: breed)
        
        return cell
        
    }
    
    
}


// MARK: - UITableViewDelegate

extension FavouritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? FavouritesCell else {
            return
        }
        
        cell.animationOfSelection()
        
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension FavouritesViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.favouritesView.tableView.beginUpdates()
        }
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        DispatchQueue.main.async {
            switch type {
            case .insert:
                if let indexPath = newIndexPath {
                    self.favouritesView.tableView.insertRows(at: [indexPath], with: .automatic)
                }
            case .move:
                if let indexPath = indexPath {
                    self.favouritesView.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                if let newIndexPath = newIndexPath {
                    self.favouritesView.tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            case .delete:
                if let indexPath = indexPath {
                    self.favouritesView.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            case .update:
                if let indexPath = indexPath {
                    
                    if let cell = self.favouritesView.tableView.cellForRow(at: indexPath) as? FavouritesCell {
                        
                        let breed = self.model.fetchedResultsController().object(at: indexPath)
                        
                        cell.configure(with: breed)
                        
                    }
                    
                    
                }
            @unknown default:
                fatalError()
            }
        
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.favouritesView.tableView.endUpdates()
        }
    }
    
}
