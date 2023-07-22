//
//  Constants.swift
//  Movies
//
//  Created by Chandru M on 21/07/23.
//

import Foundation


enum TableViewCellIds  {
    static let nameTableViewCell: String = "NameTableViewCell"
    static let headerTableViewCell: String = "HeaderTableViewCell"
    static let movieTableViewCell: String = "MovieTableViewCell"
    static let ratingTableViewCell: String = "RatingTableViewCell"
}


enum MovieCategory {
    case year
    case genrie
    case director
    case actor
}
