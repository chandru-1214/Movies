//
//  UIUtils.swift
//  Movies
//
//  Created by Chandru M on 22/07/23.
//

import UIKit

class UIUtils {
    
    /// Method to set image to imageview using imageurl
    /// - Parameters:
    ///   - imageURl: Denotes image url
    ///   - imageView: Denotes imageview
    static func setImage(_ imageURl: String?, imageView: UIImageView) {
        imageView.image = UIImage(named: "default_movie_icon")
        let dispatchQueue = DispatchQueue(label: "upadte.image", attributes: .concurrent)
        if let posterURL = imageURl,
           posterURL != "N/A",
           let posterUrl = URL(string: posterURL) {
            dispatchQueue.async {
                do {
                    let posterData = try Data(contentsOf: posterUrl)
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: posterData)
                    }
                } catch {
                    // print("Image Load Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
