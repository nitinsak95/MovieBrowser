//
//  MovieGenreListModel.swift
//  Movie Browser
//
//  Created by Nitin on 17/10/19.
//  Copyright © 2019 Nitin. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieGenreListModel : Mappable {
    var genres : [Genres]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        genres <- map["genres"]
    }
    
}

struct Genres : Mappable {
    var id : Int?
    var name : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
    }
    
}
