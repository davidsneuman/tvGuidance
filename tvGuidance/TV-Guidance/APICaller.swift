//
//  APICaller.swift
//  TV-Guidance
//
//  Created by David Neuman on 5/1/21.
//

import Foundation

class APICaller {
    func getShows(title: String)
    {
        let searchText = title.replacingOccurrences(of: " ", with: "%20")
        
        let url = URL(string: "https://api.themoviedb.org/3/search/multi?api_key=081cd3e558e599982d21d7d81eecb1cc&language=en-US&query=\(searchText)&page=1&include_adult=false")!
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
                
                print(dataDictionary)

             }
        }
    }
}
