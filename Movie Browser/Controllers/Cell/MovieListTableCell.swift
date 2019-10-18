//
//  MovieListTableCell.swift
//  Movie Browser
//
//  Created by Nitin on 17/10/19.
//  Copyright © 2019 Nitin. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListTableCell: UITableViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieDetail: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var lblVoteCount: UILabel!
    
    func configureCell(for data: MovieData, index: Int){
        let imgURL = URL(string: K.ProductionServer.imageBaseURL + (data.poster_path ?? ""))
        imgMovie.kf.setImage(with: imgURL)
        lblMovieName.text = "\(index). \(data.title ?? "")"
        var language = data.original_language ?? ""
        let releaseDate = data.release_date ?? ""
        let releaseDateToDisplay = releaseDate.getFormattedDateStr()
        if data.original_language?.lowercased() == "en"{
            language = "English"
        }
        lblMovieDetail.text = "U/A | \(language) | \(releaseDateToDisplay)"
        lblPopularity.text = data.popularity?.description
        lblVoteAverage.text = data.vote_average?.description
        lblVoteCount.text = data.vote_count?.description
    }
    
}
