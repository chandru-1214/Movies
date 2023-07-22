//
//  MovieDetailsViewController+Extension.swift
//  Movies
//
//  Created by Chandru M on 22/07/23.
//

import UIKit

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie?.Ratings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let rating = movie?.Ratings?[indexPath.row] {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIds.ratingTableViewCell, for: indexPath) as! RatingTableViewCell
            cell.configureCell(rating)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
