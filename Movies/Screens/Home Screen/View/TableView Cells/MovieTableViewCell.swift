//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Chandru M on 21/07/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    //MARK: - @IBOutlets
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var languagelabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    func configureCell(_ movie: Movie) {
        movieNameLabel.text = movie.Title ?? ""
        languagelabel.text = "Language: \(movie.Language ?? "")"
        yearLabel.text = "Year: \(movie.Year ?? "")"
        coverImageView.image = UIImage(named: "default_movie_icon")
        UIUtils.setImage(movie.Poster, imageView: coverImageView)
        selectionStyle = .none
    }
}
