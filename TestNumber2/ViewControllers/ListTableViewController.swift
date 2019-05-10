//
//  ListTableViewController.swift
//  TestNumber2
//
//  Created by Jordan Hendrickson on 5/10/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController , ButtonTableViewCellDelegate{

    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let list = ListController.shared.fetchedResultsController.object(at: indexPath)
        ListController.shared.toggleIsComplete(list: list)
        sender.updateButton(list.isComplete)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
       showInput()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListController.shared.fetchedResultsController.delegate = self as NSFetchedResultsControllerDelegate
        title = "Grocery List"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source
    func showInput(){//not sure how to make it print to my cell
        let alertController = UIAlertController(title: "Add Item", message: "Please add an Item to your shopping list", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = ""
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let name = alertController.textFields?[0].text
            ListController.shared.add(name: name!, isComplete: false)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListController.shared.fetchedResultsController.fetchedObjects?.count ?? 0
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ButtonTableViewCell else {return UITableViewCell()}

        let list = ListController.shared.fetchedResultsController.object(at: indexPath)
        
        cell.update(withList: list)
        
        cell.delegate = self
        

        return cell
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
         let list = ListController.shared.fetchedResultsController.object(at: indexPath)
            ListController.shared.delete(list: list)
        }
    }
}
extension ListTableViewController: NSFetchedResultsControllerDelegate {
    // Conform to the NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    //sets behavior for cells
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type{
        case .delete:
            guard let indexPath = indexPath else { break }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let newIndexPath = newIndexPath else { break }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { break }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { break }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
}
