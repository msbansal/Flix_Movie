//
//  MovieViewController.swift
//  Flix Movie
//
//  Created by Mahak Bansal on 9/19/20.
//  Copyright © 2020 Mahak Bansal. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCell
        cell.title.text = movieDict[indexPath.row]["title"] as! String
        cell.desc.text = movieDict[indexPath.row]["overview"] as! String

        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movieDict[indexPath.row]["poster_path"] as! String
        let posterUrl = URL(string: baseUrl+posterPath)
        cell.poster.af.setImage(withURL: posterUrl!)
        
        return cell
        
    }
    

    var movieDict : [[String:Any]] = [[String:Any]]()
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            print(dataDictionary)
            self.movieDict = dataDictionary["results"] as! [[String : Any]]
            print("Appear")
            self.movieTableView.reloadData()
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = movieTableView.indexPath(for: cell)!
        let movie = movieDict[indexPath.row]
        
        let segueVC = segue.destination as! MovieDetailsViewController
        segueVC.movie = movie
        
        movieTableView.deselectRow(at: indexPath, animated: true)
        
        
    }


}
