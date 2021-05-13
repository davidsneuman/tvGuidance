//
//  MovieDetailsViewController.swift
//  TV-Guidance
//
//  Created by Kevin Xie on 4/24/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usResults.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchProviderCell", for: indexPath) as! WatchProviderCell

        
        let usResult = usResults[indexPath.item]
        
        //var provider = providers[indexPath.item]

        let baseProviderUrl = "https://image.tmdb.org/t/p/w185"
        let logoPath = usResults["logo_path"] as! String
        let providerLogoUrl = URL(string: baseProviderUrl + logoPath)

        cell.watchProviderLogo.af_setImage(withURL: providerLogoUrl!)

        return cell
    }
    

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    var tvShow: [String:Any]!
    var tvShowProvidersResults = [String: Any]()
    var usResults = [String: Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        var tvTitle = ""
        if tvShow["original_name"] != nil
        {
            tvTitle = tvShow["original_name"] as! String
        }
        else if tvShow["original_title"] != nil
        {
            tvTitle = tvShow["original_title"] as! String
        }
        titleLabel.text = tvTitle
        titleLabel.sizeToFit()
        
        synopsisLabel.text = tvShow["overview"] as! String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"

        if let posterPath = tvShow["poster_path"] as? String
        {
        let posterUrl = URL(string: baseUrl + posterPath)
      
        posterView.af.setImage(withURL: posterUrl!)
        }
        if let backdropPath = tvShow["backdrop_path"] as? String
        {
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
      
        backdropView.af.setImage(withURL: backdropUrl!)
        }
        
        
        // api call for watch providers
        
        let tvId = "\(tvShow["id"] ?? "")"
        
        let url = URL(string: "https://api.themoviedb.org/3/tv/\(tvId)/watch/providers?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    // TODO: Get the array of movies
                
                self.tvShowProvidersResults =  dataDictionary["results"] as! [String: Any]
                self.usResults = self.tvShowProvidersResults["US"] as! [String: Any]
                
                
                
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
                self.collectionView.reloadData()
                
                print(self.usResults)
                //print(providers)
                
               // print(resultsShows)
               // print("us results are ----- ", usResults)
                
               


             }
            
        }
        task.resume()
        
        
        
        
        
    }
    
    
    
    

 
    // TO DO!!!!!
    // Set up collection view with watch provider logos

}
//
        
//        titleLabel.text = tvShow["original_name"] as? String
//
//
//
//        let baseUrl = "https://image.tmdb.org/t/p/w342"
//        let posterPath = tvShow["poster_path"] as! String
//        let posterUrl = URL(string: baseUrl + posterPath)!
//
//        posterView.af.setImage(withURL: posterUrl)
        
        
        // change the watch on section images based on the api results
//        providersCollection = tvShowProviders["flatrate"]
               
//        if(tvShowProviders["provider_name"] == "fuboTV") {
//            var image: UIImage = UIImage(named: "fubotv")!
            
//        }
        
        // Do any additional setup after loading the view.
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
