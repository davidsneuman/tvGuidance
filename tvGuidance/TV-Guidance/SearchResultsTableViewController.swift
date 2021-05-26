//
//  SearchResultsTableViewController.swift
//  TV-Guidance
//
//  Created by David Neuman on 4/30/21.
//

import UIKit
import AlamofireImage

class SearchResultsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tvShows: [[String: Any]]!   //Results of multisearch API call passed from SearchViewController
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    
    // MARK: - Table view data source
    
    // Number of sections will either be 0 if no results from search or 1 to display table view
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if (tvShows.count != 0) //If there are results, display table view
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else // No results from API Call, display "No Results"
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No Results"
            noDataLabel.textColor     = UIColor.label
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    //  Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    //  Individual Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultsTableViewCell") as! SearchResultsTableViewCell
        let tvShow = tvShows[indexPath.row] //Individual tv show from array of tv shows
        var tvTitle = "Not Available"       //Assigned to not available in case of bad data, should never happen because of filter
        var date = "TV Show"                //Tv Shows dont have date from data
        if (tvShows.count == 0)             //Should never happen because of filter
        {
            tvTitle = "No Results"
        }
        if (tvShow["original_name"] != nil)
        {
            tvTitle = tvShow["original_name"] as! String
        }
        else if (tvShow["original_title"] != nil)
        {
            tvTitle = tvShow["original_title"] as! String
            date = tvShow["release_date"] as! String
            
            if (date != "")                 //Format Date
            {
                let index = date.index(date.startIndex, offsetBy: 4)
                date = String(date.prefix(upTo: index))
                date = "(\(date))"
            }
        }
        
        let synopsis = tvShow["overview"] as? String ?? "Not available"
        cell.titleLabel.text = tvTitle
        cell.synopsisLabel.text = synopsis
        cell.dateLabel.text = date
        
        //Poster View
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        if let posterPath = tvShow["poster_path"] as? String
        {
            let posterUrl = URL(string: baseUrl + posterPath)
            cell.posterView.af.setImage(withURL: posterUrl!)
        }
        
        // if an unavailable movie-- disallow interaction to prevent error
        // Should never happen because of filter
        if (tvTitle == "Not Available" || synopsis == "Not Available")
        {
            cell.isUserInteractionEnabled = false
        }
      
            return cell
        
    }
    
    // MARK: - Navigation

    //  Segue to MovieDetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // find selected show
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let tvShow = tvShows[indexPath.row]

        // Get the new view controller using segue.destination.
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        // Pass the selected show to the new view controller.
        detailsViewController.tvShow = tvShow

        tableView.deselectRow(at: indexPath, animated: true)

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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



 


}
