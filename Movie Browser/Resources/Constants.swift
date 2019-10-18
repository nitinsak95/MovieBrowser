//
//  Constants.swift
//  Movie Browser
//
//  Created by Nitin on 17/10/19.
//  Copyright © 2019 Nitin. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://api.themoviedb.org/3"
        static let apiKey = "api_key=a5ae83891eb2ec3c23227a9cf54943a9"
        static let imageBaseURL = "https://image.tmdb.org/t/p/original"
    }
}

extension String{
    func getFormattedDateStr() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
}
