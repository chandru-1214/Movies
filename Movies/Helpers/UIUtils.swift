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
        
        if let posterURL = imageURl,
           posterURL != "N/A",
           let posterUrl = URL(string: posterURL) {
            
            let dispatchQueue = DispatchQueue(label: "update.image")
            
            dispatchQueue.async {
                let urlSession = URLSession(configuration: .default)
                let sessionTask = urlSession.downloadTask(with: posterUrl) { data, response, error in
                    if error != nil {
                        print("Error: \(String(describing: error))")
                        setImage(for: imageView)
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse,
                       httpResponse.statusCode == 200,
                       let data = data {
                        do {
                            let posterData = try Data(contentsOf: data)
                            setImage(UIImage(data: posterData), for: imageView)
                        } catch {
                            print("image conversion error: \(error.localizedDescription)")
                            setImage(for: imageView)
                        }
                    } else {
                        print("data is empty")
                        setImage(for: imageView)
                    }
                    
                }
                sessionTask.resume()
            }
            
        } else {
            imageView.image = UIImage(named: "default_movie_icon")
        }
    }
    
    /// Method to update image in main thread   
    static func setImage(_ image: UIImage? = UIImage(named: "default_movie_icon"), for imageView: UIImageView) {
        DispatchQueue.main.async {
            imageView.image = image
        }
    }
}
