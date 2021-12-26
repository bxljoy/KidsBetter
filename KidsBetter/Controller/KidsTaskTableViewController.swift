//
//  KidsTaskTableViewController.swift
//  KidsBetter
//
//  Created by bxl on 2021/11/29.
//

import UIKit

class KidsTaskTableViewController: UITableViewController {
    
    var tasks: [Task] = [
        Task(title: "Phonics", isComplete: false, image: "Cafe Loisl"),
        Task(title: "Swimming", isComplete: true, image: "Cafe Lore")
    ]
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the data source of the table view
        tableView.dataSource = dataSource
        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Task>()
        snapshot.appendSections([.taskItem])
        snapshot.appendItems(tasks, toSection: .taskItem)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - UITableView Diffable Data Source
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Task> {
        
        let cellIdentifier = "taskcell"
        
        let dataSource = TaskDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, task in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TaskTableViewCell
                
                cell.titleLabel.text = task.title
                let buttonImage = UIImage(systemName: task.isComplete ? "checkmark.circle.fill" : "xmark.circle.fill")
                // configure the SF Symbol 3 Color
                let buttonColor: [UIColor] = [task.isComplete ? .systemGreen : .systemRed]
                cell.completeButton.setImage(buttonImage, for: .normal)
                let config = UIImage.SymbolConfiguration(paletteColors: buttonColor)
                cell.completeButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
                cell.taskImageView.image = UIImage(named: task.image)
                
                return cell
            }
        )
        
        return dataSource
    }
    
    // MARK: - swipe from leading to trailing
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Mark as incomplete action
        let incompleteAction = UIContextualAction(style: .destructive, title: "incomplete") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            
            self.tasks[indexPath.row].isComplete = false
            //display the buttonImage
            let buttonImage = UIImage(systemName: "xmark.circle.fill")
            // configure the SF Symbol 3 Color
            let buttonColor: [UIColor] = [.systemRed]
            cell.completeButton.setImage(buttonImage, for: .normal)
            let config = UIImage.SymbolConfiguration(paletteColors: buttonColor)
            cell.completeButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        // Configure swipe action
        incompleteAction.backgroundColor = UIColor.systemRed
        incompleteAction.image = UIImage(systemName: "xmark.circle.fill")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [incompleteAction])
            
        return swipeConfiguration
    }
    
    // MARK: - swipe from trailing to leading
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Get the selected restaurant
        guard let task = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        // complete action
        let completeAction = UIContextualAction(style: .destructive, title: "complete") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            
            self.tasks[indexPath.row].isComplete = false
            //display the buttonImage
            let buttonImage = UIImage(systemName: "checkmark.circle.fill")
            // configure the SF Symbol 3 Color
            let buttonColor: [UIColor] = [.systemGreen]
            cell.completeButton.setImage(buttonImage, for: .normal)
            let config = UIImage.SymbolConfiguration(paletteColors: buttonColor)
            cell.completeButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        // Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([task])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        // Configure swipe action
        completeAction.backgroundColor = UIColor.systemGreen
        completeAction.image = UIImage(systemName: "checkmark.circle.fill")
        deleteAction.backgroundColor = .systemOrange
        deleteAction.image = UIImage(systemName: "trash")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [completeAction, deleteAction])
            
        return swipeConfiguration
    }
}

    

