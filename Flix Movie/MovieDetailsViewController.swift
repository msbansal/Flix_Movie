//
//  MovieDetailsViewController.swift
//  Flix Movie
//
//  Created by Mahak Bansal on 9/26/20.
//  Copyright © 2020 Mahak Bansal. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var backdropImg: UIImageView!
  
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTitle.text = movie["title"] as? String
        self.movieDesc.text = movie["overview"] as? String
        movieTitle.sizeToFit()
        movieDesc.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl+posterPath)
        posterImg.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780"+backdropPath)
        backdropImg.af.setImage(withURL: backdropUrl!)
        
        // Do any additional setup after loading the view.
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
