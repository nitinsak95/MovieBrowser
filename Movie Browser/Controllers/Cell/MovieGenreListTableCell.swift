//
//  MovieGenreListTableCell.swift
//  Movie Browser
//
//  Created by Nitin on 17/10/19.
//  Copyright © 2019 Nitin. All rights reserved.
//

import UIKit

class MovieGenreListTableCell: UITableViewCell {
    
    @IBOutlet weak var lblGenreName: UILabel!
    
    func configureCell(for data: Genres){
        lblGenreName.text = data.name
    }
    
}
