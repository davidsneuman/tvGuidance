//
//  MovieDetailsViewController.swift
//  TV-Guidance
//
//  Created by Kevin Xie on 4/24/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController/*, UICollectionViewDataSource, UICollectionViewDelegate */{

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    var tvShow: [String:Any]!
//    var tvShowProviders = [[String: Any]]()
//    var providersCollection: [String:Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

             }
 
    // TO DO!!!!!
    // Set up collection view with watch provider logos
    /*
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    1
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

}
 */

}
//        task.resume()
        
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


