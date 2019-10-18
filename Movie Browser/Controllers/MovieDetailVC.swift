//
//  MovieDetailVC.swift
//  Movie Browser
//
//  Created by Nitin on 17/10/19.
//  Copyright © 2019 Nitin. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieLanguage: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var lblVoteCount: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    var data: MovieData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"

        let imgURL = URL(string: K.ProductionServer.imageBaseURL + (data?.poster_path ?? ""))
        imgMoviePoster.kf.setImage(with: imgURL)
        lblMovieName.text = data?.original_title
        var language = data?.original_language ?? ""
        if data?.original_language?.lowercased() == "en"{
            language = "English"
        }
        lblMovieLanguage.text = "Language : \(language) (U/A)"
        lblReleaseDate.text = "Release : \(data?.release_date ?? "")"
        lblPopularity.text = data?.popularity?.description
        lblVoteAverage.text = data?.vote_average?.description
        lblVoteCount.text = data?.vote_count?.description
        lblOverview.text = data?.overview
        
    }

}
