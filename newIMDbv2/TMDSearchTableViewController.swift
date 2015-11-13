//
//  TMDSearchTableViewController.swift
//  newIMDbv2
//
//  Created by Dino Praso on 13.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit
import Alamofire

class TMDSearchTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {

    let searchController = UISearchController(searchResultsController: nil)
    var searchResults = [TMDMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search for Movies or TV Shows"
        self.tableView.tableHeaderView = searchController.searchBar

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let url = "https://api.themoviedb.org/3/search/movie"
        let urlParamteres = ["api_key":"d94cca56f8edbdf236c0ccbacad95aa1", "query":"\(self.searchController.searchBar.text!)"]
        
        Alamofire
            .request(.GET, url, parameters: urlParamteres)
            .responseArray("results") { (response:[TMDMovie]?, error: ErrorType?) in
                if let searchResults = response {
                    self.searchResults = searchResults
                }
                self.tableView.reloadData()
        }

    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchResults = []
        self.searchController.active = false
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.searchResults.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath)

        let currentResult = self.searchResults[indexPath.row]
        cell.textLabel?.text = currentResult.title
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(currentResult.getDate())

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.searchController.active = false
        
        if segue.identifier == "showDetails" {
            let destinationViewController = segue.destinationViewController as! TMDDetailsTableViewController
            let indexPath: NSIndexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)!
            destinationViewController.movie = self.searchResults[indexPath.item]
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
