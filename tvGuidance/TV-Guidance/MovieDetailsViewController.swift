//
//  MovieDetailsViewController.swift
//  TV-Guidance
//
//  Created by Kevin Xie on 4/24/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var watchFreeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var tvShow: [String:Any]!
    var tvShowProvidersResults = [String: Any]()
    var usResults = [String: Any]()
    var flatrate = [NSDictionary]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        // Collection view layout
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 3) / 4
        layout.itemSize = CGSize(width: width, height: width * 6/7)
        
        
        var tvTitle = ""
        var date = "TV Show"
        if tvShow["original_name"] != nil
        {
            tvTitle = tvShow["original_name"] as! String
        }
        else if tvShow["original_title"] != nil
        {
            tvTitle = tvShow["original_title"] as! String
            
            date = tvShow["release_date"] as! String
            if (date != "")
            {
                let index = date.index(date.startIndex, offsetBy: 4)
                date = String(date.prefix(upTo: index))
                date = "(\(date))"
            }
        }
        titleLabel.text = tvTitle
        titleLabel.sizeToFit()
        dateLabel.text = date
        
        synopsisLabel.text = tvShow["overview"] as? String ?? ""
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"

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
        
        
        var url = URL(string: "")
        // api call for watch providers
        if (tvShow["media_type"] as! String == "tv")
        {
            let tvId = "\(tvShow["id"] ?? "")"
            url = URL(string: "https://api.themoviedb.org/3/tv/\(tvId)/watch/providers?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        }
        else if (tvShow["media_type"] as! String == "movie")
        {
            let movieId = "\(tvShow["id"] ?? "")"
            url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/watch/providers?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        }
        else
        {
            print("error in watch provider call")
        }
        
        let request = URLRequest(url: url! , cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    // TODO: Get the array of movies
                
                self.tvShowProvidersResults =  dataDictionary["results"] as? [String: Any] ?? [:]
                self.usResults = self.tvShowProvidersResults["US"] as? [String: Any] ?? [:]
                self.flatrate = self.usResults["flatrate"] as? [NSDictionary] ?? []
                
                
                
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
                self.collectionView.reloadData()
                

             }
            
        }
        task.resume()
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (flatrate.count == 0)
        {
            return 1
        }
        return flatrate.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchProviderCell", for: indexPath) as! WatchProviderCell

        if (flatrate.count == 0)
        {
            cell.watchProviderLogo.image = UIImage(named: "notAvailable")
            return cell
        }
        
        let providers = flatrate[indexPath.item]

        let baseProviderUrl = "https://image.tmdb.org/t/p/w185"
        let logoPath = providers["logo_path"] as! String
        if (logoPath != "")
        {
            let providerLogoUrl = URL(string: baseProviderUrl + logoPath)
            print(providerLogoUrl!)
            cell.watchProviderLogo.af.setImage(withURL: providerLogoUrl!)
        }
        
        
        return cell
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

    
