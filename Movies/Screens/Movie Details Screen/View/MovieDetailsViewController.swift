//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Chandru M on 22/07/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var tableViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var ratingsTableView: UITableView!
    
    //MARK: - Internal Variables
    var movieDetailsViewModel = MovieDetailsViewModel()
    var movie: Movie?
    var showRatings = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        titleLabel.text = movie?.Title
        releaseDateLabel.text = "\t" + (movie?.Released ?? "")
        castLabel.text = "\t" + (movie?.Actors ?? "")
        plotLabel.text = "\t" + (movie?.Plot ?? "")
        genreLabel.text = "\t" + (movie?.Genre ?? "")
        UIUtils.setImage(movie?.Poster, imageView: posterImageView)
        setRatingsView()
        configureTableView()
    }
    
    @IBAction func actionOnRatingsView(_ sender: UIButton) {
        showRatings.toggle()
       setRatingsView()
    }
    
    func setRatingsView() {
        if showRatings {
            arrowImageView.image =  UIImage(named: "down_arrow_icon")
            let tableViewheight = CGFloat(((movie?.Ratings?.count ?? 0) * 70))
            tableViewHeightCons.constant = tableViewheight
            ratingsTableView.reloadData()
            let bottomOffset = CGPoint(x: 0, y: tableViewheight + 10)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
        } else {
            tableViewHeightCons.constant = 0
            arrowImageView.image =  UIImage(named: "right_arrow_icon")
        }
    }
    
    private func configureTableView() {
        ratingsTableView.register(
            UINib(nibName: TableViewCellIds.ratingTableViewCell, bundle: nil),
            forCellReuseIdentifier: TableViewCellIds.ratingTableViewCell)
        
    }
}
