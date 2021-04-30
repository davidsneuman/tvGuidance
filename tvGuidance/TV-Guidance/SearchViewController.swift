//
//  SearchViewController.swift
//  TV-Guidance
//
//  Created by Kevin Xie on 4/23/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    var tvShows = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
        self.view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/76341?api_key=081cd3e558e599982d21d7d81eecb1cc")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    // TODO: Get the array of movies
                
                self.tvShows = dataDictionary["results"] as! [[String: Any]]
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    }
    
    @objc func dismisskeyboard(){
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let cell = sender as! UICollectionViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let tvShow = tvShows[indexPath.row]
        
        // Pass the selected object to the new view controller.
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.tvShow = tvShow
        
    }
    

}