//
//  HomeViewController+Extension.swift
//  Movies
//
//  Created by Chandru M on 21/07/23.
//

import UIKit

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if homeViewModel.showFilteredList {
            return homeViewModel.filteredMoviesList.count
        } else {
            let section = homeViewModel.movieSections[section]
            if section.isExpanded {
                //check if user expanded "All Movies" section or not
                if section.title == "All Movies" {
                    return homeViewModel.allMoviesList.count + 1
                } else {
                    return section.data.count + 1
                }
            } else {
                return 1
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if homeViewModel.showFilteredList {
            return 1
        } else {
           return homeViewModel.movieSections.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if homeViewModel.showFilteredList {
            return 200
        } else {
            let section = homeViewModel.movieSections[indexPath.section]
            if section.title == "All Movies" && indexPath.row != 0 {
                //to display movie details like thumbnail, tittl, year
                return 200
            } else {
                return 50
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if homeViewModel.showFilteredList {
            //upadte cell for filtered movies
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIds.movieTableViewCell, for: indexPath) as! MovieTableViewCell
            cell.configureCell(homeViewModel.filteredMoviesList[indexPath.row])
            return cell
        } else {
            let section = homeViewModel.movieSections[indexPath.section]
            if indexPath.row == 0,
               let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIds.headerTableViewCell, for: indexPath) as? HeaderTableViewCell {
                //Header Cells
                cell.configureCell(section.title, isExpanded: section.isExpanded)
                return cell
            } else if section.title == "All Movies",
                      let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIds.movieTableViewCell, for: indexPath) as? MovieTableViewCell {
                //all movies Cells
                cell.configureCell(homeViewModel.allMoviesList[indexPath.row - 1])
                return cell
            } else if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIds.nameTableViewCell, for: indexPath) as? NameTableViewCell {
                cell.configureCell(section.data[indexPath.row - 1])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if homeViewModel.showFilteredList {
           let movie = homeViewModel.filteredMoviesList[indexPath.row]
            navigateToMovieDetailsScreen(movie)
        } else {
            if indexPath.row == 0 {
                homeViewModel.movieSections[indexPath.section].isExpanded.toggle()
                moviesTableView.reloadSections([indexPath.section], with: .none)
            } else if indexPath.section == 4 {
               let movie = homeViewModel.allMoviesList[indexPath.row - 1]
                navigateToMovieDetailsScreen(movie)
            } else {
                let section = homeViewModel.movieSections[indexPath.section]
                let selectedText = section.data[indexPath.row - 1]
                homeViewModel.filterMovies(of: getMovieCategory(section: indexPath.section), from: selectedText.lowercased())
            }
        }
    }
    
    
    /// Method to get selected category
    /// - Parameter section: Denotes selected section index
    /// - Returns: Returns catrgory based on section index
    private func getMovieCategory(section: Int) -> MovieCategory {
        switch section {
        case 0:
            return .year
        case 1:
            return .genrie
        case 2:
            return .director
        case 3:
            return .actor
        default:
            return .year
        }
    }
    
}

//MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    
    func updateView() {
        searchBar.isHidden = !homeViewModel.isFromSearchText
        cancelButton.isHidden = homeViewModel.isFromSearchText
        
        if homeViewModel.showFilteredList && homeViewModel.filteredMoviesList.count == 0 {
            //hide moviesTableView only if searched movies list is empty
            showOrHideEmptyMovieView(show: true)
        } else {
            showOrHideEmptyMovieView(show: false)
            moviesTableView.reloadData()
        }
    }
    
    func showOrHideEmptyMovieView(show: Bool) {
        emptyMovieLabel.isHidden = !show
        moviesTableView.isHidden = show
    }
    
    /// Method to navigate movie details screen
    /// - Parameter movie: Denotes selected movie
    func navigateToMovieDetailsScreen(_ movie: Movie) {
        searchBar.resignFirstResponder()
        let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetailsVC.movie = movie
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if  searchText.trim() != "" {
            homeViewModel.filterMovies(using: searchText.trim().lowercased())
        } else {
            homeViewModel.showFilteredList = false
            updateView()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
