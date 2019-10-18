//
//  MovieGenreListVC.swift
//  Movie Browser
//
//  Created by Nitin on 16/10/19.
//  Copyright © 2019 Nitin. All rights reserved.
//

import UIKit

class MovieGenreListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [Genres]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movie Genre List"
        
        tableView.register(UINib(nibName: "MovieGenreListTableCell", bundle: nil), forCellReuseIdentifier: "MovieGenreListTableCell")
        
        getMovieGenreList()
        
    }
    
    func getMovieGenreList(){
        APIClient.shared.getMovieGenreList() { response in
            guard let genreList = response?.genres else { return }
            self.data = genreList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension MovieGenreListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieGenreListTableCell", for: indexPath) as! MovieGenreListTableCell
        cell.configureCell(for: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieListVC") as! MovieListVC
        vc.genreData = self.data[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
