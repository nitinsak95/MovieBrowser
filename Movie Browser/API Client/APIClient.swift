//
//  APIClient.swift
//  Movie Browser
//
//  Created by Nitin on 17/10/19.
//  Copyright © 2019 Nitin. All rights reserved.
//

import Alamofire
import SVProgressHUD
import ObjectMapper

class APIClient {
    
    static let shared = APIClient()
    private init() {}
    
    func getMovieGenreList(completion: @escaping (MovieGenreListModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRouter.getMovieGenreList)
            .responseJSON { response in
                SVProgressHUD.dismiss()
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        print(response.result.value!)
                        let apiResponse = Mapper<MovieGenreListModel>().map(JSONObject: response.result.value)
                        completion(apiResponse)
                    }
                    break
                case .failure(_):
                    print(response.result.error!)
                    break
                }
        }
    }
    
    func getMovieList(genreId: Int, pageNo: Int, completion: @escaping (MovieListModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRouter.getMovieList(genreId: genreId, pageNo: pageNo))
            .responseJSON { response in
                SVProgressHUD.dismiss()
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        print(response.result.value!)
                        let apiResponse = Mapper<MovieListModel>().map(JSONObject: response.result.value)
                        completion(apiResponse)
                    }
                    break
                case .failure(_):
                    print(response.result.error!)
                    break
                }
        }
    }
    
    func getSearchedMovieList(searchText: String, completion: @escaping (MovieListModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRouter.searchMovies(searchText: searchText))
            .responseJSON { response in
                SVProgressHUD.dismiss()
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        print(response.result.value!)
                        let apiResponse = Mapper<MovieListModel>().map(JSONObject: response.result.value)
                        completion(apiResponse)
                    }
                    break
                case .failure(_):
                    print(response.result.error!)
                    break
                }
        }
    }
    
}
