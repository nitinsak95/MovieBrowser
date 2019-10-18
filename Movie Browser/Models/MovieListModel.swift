//
//  MovieListModel.swift
//  Movie Browser
//
//  Created by Nitin on 17/10/19.
//  Copyright © 2019 Nitin. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieListModel : Mappable {
    var id : Int?
    var page : Int?
    var results : [MovieData]?
    var total_pages : Int?
    var total_results : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        page <- map["page"]
        results <- map["results"]
        total_pages <- map["total_pages"]
        total_results <- map["total_results"]
    }
    
}

struct MovieData : Mappable {
    var popularity : Double?
    var vote_count : Int?
    var poster_path : String?
    var id : Int?
    var original_language : String?
    var original_title : String?
    var title : String?
    var vote_average : Double?
    var overview : String?
    var release_date : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        popularity <- map["popularity"]
        vote_count <- map["vote_count"]
        poster_path <- map["poster_path"]
        id <- map["id"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        title <- map["title"]
        vote_average <- map["vote_average"]
        overview <- map["overview"]
        release_date <- map["release_date"]
    }
    
}
