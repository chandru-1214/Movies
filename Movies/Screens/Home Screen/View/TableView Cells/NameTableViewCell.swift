//
//  TitleTableViewCell.swift
//  Movies
//
//  Created by Chandru M on 21/07/23.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureCell(_ title: String) {
        nameLabel.text = title
        selectionStyle = .none
    }
}
