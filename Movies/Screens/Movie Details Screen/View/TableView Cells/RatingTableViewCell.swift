//
//  RatingTableViewCell.swift
//  Movies
//
//  Created by Chandru M on 22/07/23.
//

import UIKit

@available(iOS 13.0, *)
class RatingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var starImage_1: UIImageView!
    @IBOutlet weak var starImage_2: UIImageView!
    @IBOutlet weak var starImage_3: UIImageView!
    @IBOutlet weak var starImage_4: UIImageView!
    @IBOutlet weak var starImage_5: UIImageView!
    @IBOutlet weak var starImage_6: UIImageView!
    @IBOutlet weak var starImage_7: UIImageView!
    @IBOutlet weak var starImage_8: UIImageView!
    @IBOutlet weak var starImage_9: UIImageView!
    @IBOutlet weak var starImage_10: UIImageView!
    @IBOutlet weak var sourceNameLabel: UILabel!
    

    func configureCell(_ model: RatingModel) {
        sourceNameLabel.text = model.Source
        let percentage = getPercentage(from: model.Value ?? "")
        let allImageViews = getAllImageViews()
        for i in 1...Int(percentage) {
            allImageViews[i-1].image = UIImage(systemName: "star.fill")
            if i == Int(percentage) && i != 10 && percentage.truncatingRemainder(dividingBy: 1) != 0 {
                allImageViews[i].image = UIImage(systemName: "star.fill.left")
            }
        }
        selectionStyle = .none
    }
    
    func getAllImageViews() -> [UIImageView] {
        return [starImage_1, starImage_2,starImage_3, starImage_4,starImage_5, starImage_6,starImage_7, starImage_8,starImage_9, starImage_10]
    }
    
    /// Method to get rating percentage  from rating value
    /// - Parameter rating: Denotes ratiing value
    /// - Returns: Returns rating value in "10/10" format
    func getPercentage(from rating: String) -> Float {
        var percentage = rating
        if rating.contains("/100") || rating.contains("%") {
            percentage = percentage.replacingOccurrences(of: "%", with: "")
            percentage = percentage.replacingOccurrences(of: "/100", with: "")
            return (Float(percentage) ?? 0)/10
        } else  {
            percentage = percentage.replacingOccurrences(of: "/10", with: "")
            return Float(percentage) ?? 0
        }
    }
    
    
}
