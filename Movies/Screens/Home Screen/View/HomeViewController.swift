//
//  HomeViewController.swift
//  Movies
//
//  Created by Chandru M on 21/07/23.
//

import UIKit

class HomeViewController: BaseViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var emptyMovieLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Internal Variables
    var homeViewModel = HomeViewModel()
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies Database"
        configureTableView()
        homeViewModel.delegate = self
        homeViewModel.getMoviesList()
        moviesTableView.alwaysBounceVertical = false
        
    }
    
    private func configureTableView() {
        moviesTableView.register(
            UINib(nibName: TableViewCellIds.nameTableViewCell, bundle: nil),
            forCellReuseIdentifier: TableViewCellIds.nameTableViewCell)
        moviesTableView.register(
            UINib(nibName: TableViewCellIds.headerTableViewCell, bundle: nil),
            forCellReuseIdentifier: TableViewCellIds.headerTableViewCell)
        moviesTableView.register(
            UINib(nibName: TableViewCellIds.movieTableViewCell, bundle: nil),
            forCellReuseIdentifier: TableViewCellIds.movieTableViewCell)
    }

    @IBAction func actionOnFilterCacelButton(_ sender: UIButton) {
        homeViewModel.showFilteredList = false
        homeViewModel.isFromSearchText = true
       updateView()
    }
    
}
