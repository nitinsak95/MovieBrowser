//
//  APIRouter.swift
//  Movie Browser
//
//  Created by Nitin on 17/10/19.
//  Copyright © 2019 Nitin. All rights reserved.
//

import Alamofire

let apiKey = K.ProductionServer.apiKey

enum APIRouter: URLRequestConvertible {
    
    case getMovieGenreList
    case getMovieList(genreId: Int, pageNo: Int)
    case searchMovies(searchText: String)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getMovieGenreList, .getMovieList, .searchMovies:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getMovieGenreList:
            return "/genre/movie/list?\(apiKey)"
        case .getMovieList(let genreId, let pageNo):
            return "/genre/\(genreId)/movies?\(apiKey)&page=\(pageNo)"
        case .searchMovies(let searchText):
            return "/search/movie?\(apiKey)&query=\(searchText)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters {
        switch self {
        default:
            return [:]
        }
    }
    
    // MARK: - Headers
    var headers: HTTPHeaders {
        switch self {
        default:
            return [:]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        var str: URL?
        str = URL(string: url.appendingPathComponent(path).absoluteString.removingPercentEncoding ?? "")
        str = URL(string: url.appendingPathComponent(path).absoluteString.replacingOccurrences(of: "%3F", with: "?"))
        var urlRequest = URLRequest(url: str!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.timeoutInterval = TimeInterval(10 * 1000)
        print("URL REQUESTED IS \(urlRequest)")
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
