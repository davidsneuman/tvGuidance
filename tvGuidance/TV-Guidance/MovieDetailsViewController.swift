//
//  MovieDetailsViewController.swift
//  TV-Guidance
//
//  Created by Kevin Xie on 4/24/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var providersCollectionView: UICollectionView!
    //    @IBOutlet weak var providerLabel: UILabel!
    
//    @IBOutlet weak var watchProvidersCell: UICollectionViewCell!
    
    var tvShow: [String:Any]!
    var tvShowProviders = [[String: Any]]()
    var providersCollection: [String:Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        providersCollectionView.delegate = self
        providersCollectionView.dataSource = self
        
        
        let layout = providersCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
//        calling api for watch providers
        let url = URL(string: "https://api.themoviedb.org/3/watch/providers/tv?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    // TODO: Get the array of movies

                self.tvShowProviders = dataDictionary["results"] as! [[String: Any]]
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
        
        titleLabel.text = tvShow["original_name"] as? String
        
        
        
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        let posterPath = tvShow["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        posterView.af.setImage(withURL: posterUrl)
        
        
        // change the watch on section images based on the api results
//        providersCollection = tvShowProviders["flatrate"]
               
//        if(tvShowProviders["provider_name"] == "fuboTV") {
//            var image: UIImage = UIImage(named: "fubotv")!
            
//        }
        
        // Do any additional setup after loading the view.
    }
    
//    func getProviders() {
//
//        let providersApiUrl = "https://api.themoviedb.org/3/tv/"
//        let showId = tvShow["id"] as! String
//        let endUrl = "/watch/providers?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
//        let providersUrl = URL(string: providersApiUrl + showId + endUrl)
//
//
//        if(tvShowProviders["provider_name"] == "fuboTV") {
//            var image: UIImage = UIImage(named: "fubotv")!
//            watchProvidersCell.contentView.af.setImage(image)
//        }
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
