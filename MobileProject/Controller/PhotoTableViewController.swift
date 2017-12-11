//
//  PhotoTableViewController.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 6..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class PhotoTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    var account = Account();
    
    //MARK:- properties
    @IBOutlet var newMemoButton: UIBarButtonItem!
    var searchController: UISearchController!
    var photoMemo: [PhoteMemoMO] = []
    var fetchResultController: NSFetchedResultsController<PhoteMemoMO>!
    var searchResults: [PhoteMemoMO] = []
    
    
    //MARK:- viewDIdLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = account.id! + "'s Memo List"
        
        newMemoButton.title = "Add new Memo"
        
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        let fetchRequest: NSFetchRequest<PhoteMemoMO> = PhoteMemoMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                               managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    photoMemo = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //가져오기 메모 수
        if searchController.isActive{
            return searchResults.count
        } else {
            return photoMemo.count
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTabelViewCell
        
        let aphotoMemo = (searchController.isActive) ? searchResults[indexPath.row] : photoMemo[indexPath.row]
        
        cell.memoTitleLabel.text = aphotoMemo.title
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        let date = dateformatter.string(from: aphotoMemo.date!)
        cell.memoDateLabel.text = date
        cell.thumbnailImageView.image = UIImage(data: aphotoMemo.photo!)
        
        return cell
    }
    
    //MARK:- search 메소드
    func filterContent(for searchText: String) {
        searchResults = photoMemo.filter({ (aphotoMemo) -> Bool in
            if let title = aphotoMemo.title {
                let isMatch = title.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    //MARK:- NSFetchdelegate 메소드
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath{
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            photoMemo = fetchedObjects as! [PhoteMemoMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotoMemoDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailPhotoMemoController
                destinationController.photoMemo = (searchController.isActive) ? searchResults[indexPath.row] :  photoMemo[indexPath.row]
                destinationController.account = account
            }
        }
        else if segue.identifier == "newMemoSegue" {
            let navController = segue.destination as! UINavigationController
            let destinationController = navController.topViewController as! NewMemoTableViewController
            destinationController.account = account
        }
    }
    

}
