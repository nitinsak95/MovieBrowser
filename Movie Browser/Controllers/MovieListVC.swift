//
//  MovieListVC.swift
//  Movie Browser
//
//  Created by Nitin on 17/10/19.
//  Copyright © 2019 Nitin. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var totalResults: Int?
    var data = [MovieData]()
    var genreData: Genres?
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        self.title = genreData?.name
        
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "descendant"), style: .plain, target: self, action:  #selector(sortMovieList))
        navigationItem.rightBarButtonItem = barButton
        
        tableView.register(UINib(nibName: "MovieListTableCell", bundle: nil), forCellReuseIdentifier: "MovieListTableCell")
        
        getMovieList()
        
    }
    
    // fetch movie list
    func getMovieList(){
        guard let id = genreData?.id else { return }
        APIClient.shared.getMovieList(genreId: id, pageNo: pageNumber){ response in
            guard let movieList = response?.results, let totalItems = response?.total_results else { return }
            self.data.append(contentsOf: movieList)
            self.totalResults = totalItems
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // sort movies
    @objc func sortMovieList(){
        let alertController = UIAlertController(title: "", message: "Sort By", preferredStyle: .actionSheet)
        let mostPopularMovies = UIAlertAction(title: "Most Popular", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.data = self.data.sorted { Double($0.popularity ?? 0) > Double($1.popularity ?? 0) }
            self.tableView.reloadData()
        })
        let highestRatedMovies = UIAlertAction(title: "Highest Rated", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.data = self.data.sorted { Double($0.vote_average ?? 0) > Double($1.vote_average ?? 0) }
            self.tableView.reloadData()
        })
        let mostVotedMovies = UIAlertAction(title: "Most Voted", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.data = self.data.sorted { Int($0.vote_count ?? 0) > Int($1.vote_count ?? 0) }
            self.tableView.reloadData()
        })
        alertController.addAction(mostPopularMovies)
        alertController.addAction(highestRatedMovies)
        alertController.addAction(mostVotedMovies)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Search Movies
    @objc func searchMovies(){
        guard let searchText = searchBar.text else { return }
        APIClient.shared.getSearchedMovieList(searchText: searchText){ response in
            guard let movieList = response?.results, let totalItems = response?.total_results else { return }
            self.data = movieList
            self.totalResults = totalItems
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        if searchText == ""{
            self.data.removeAll()
            getMovieList()
        }
    }
    
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableCell", for: indexPath) as! MovieListTableCell
        cell.configureCell(for: data[indexPath.row], index: indexPath.row + 1)
        
        if indexPath.row == data.count - 1 {
            if let totalItems = self.totalResults{
                if totalItems > data.count {
                    self.pageNumber += 1
                    self.getMovieList()
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        vc.data = data[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MovieListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchMovies), object: nil)
        perform(#selector(searchMovies), with: nil, afterDelay: 0.5)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
    }
    
}
