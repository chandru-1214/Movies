//
//  HeaderTableViewCell.swift
//  Movies
//
//  Created by Chandru M on 21/07/23.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    func configureCell(_ title: String, isExpanded: Bool) {
        titleLabel.text = title
        arrowImageView.image = UIImage(named: isExpanded ? "down_arrow_icon" : "right_arrow_icon")
        selectionStyle = .none
    }

}
