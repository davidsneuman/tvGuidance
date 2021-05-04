//
//  SearchResultsTableViewController.swift
//  TV-Guidance
//
//  Created by Farhan Tanmoy on 4/30/21.
//

import UIKit
import AlamofireImage

class SearchResultsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tvShows: [[String: Any]]!
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultsTableViewCell") as! SearchResultsTableViewCell
        let tvShow = tvShows[indexPath.row]
        var tvTitle = ""
        
        if tvShow["original_name"] != nil
        {
            tvTitle = tvShow["original_name"] as! String
        }
        else if tvShow["original_title"] != nil
        {
            tvTitle = tvShow["original_title"] as! String
        }
        
        let synopsis = tvShow["overview"] as! String
        cell.titleLabel.text = tvTitle
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"

        if let posterPath = tvShow["poster_path"] as? String
        {
        let posterUrl = URL(string: baseUrl + posterPath)
      
        cell.posterView.af.setImage(withURL: posterUrl!)
    }


        return cell
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }



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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // find selected show
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let tvShow = tvShows[indexPath.row]

        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.tvShow = tvShow

        tableView.deselectRow(at: indexPath, animated: true)


//
//        //TO DO!!!!
//        //Set up API Request for providers here
//
//
//        let showId = tvShow["id"] as! Int
//
//
//
//
//        let url = URL(string: "https://api.themoviedb.org/3/movie/\(showId)/watch/providers?api_key=081cd3e558e599982d21d7d81eecb1cc")!
//        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//        let task = session.dataTask(with: request) { (data, response, error) in
//             // This will run when the network request returns
//             if let error = error {
//                    print(error.localizedDescription)
//             } else if let data = data {
//                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//
//                    // TODO: Get the array of movies
//
//                self.providers = dataDictionary["results"] as! [[String: Any]]
//
//
//
//
//
//
//             }
//        }
//
//        task.resume()
    }
 


}
