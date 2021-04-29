//
//  MovieDetailsViewController.swift
//  TV-Guidance
//
//  Created by Kevin Xie on 4/24/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var providerLabel: UILabel!
    
    
    var tvShow: [String:Any]!
    var tvShowProviders: [String: Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = tvShow["original_name"] as? String
        
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        let posterPath = tvShow["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        posterView.af.setImage(withURL: posterUrl)
        
        // Do any additional setup after loading the view.
    }
    
    func getProviders() {
        
        let providersApiUrl = "https://api.themoviedb.org/3/tv/"
        let showId = tvShow["id"] as! String
        let endUrl = "/watch/providers?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let providersUrl = URL(string: providersApiUrl + showId + endUrl)
        
        providerLabel.text =
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
