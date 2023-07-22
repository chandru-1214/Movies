//
//  Model.swift
//  Movies
//
//  Created by Chandru M on 21/07/23.
//

import Foundation

struct Section {
    var title: String = ""
    var data: [String] = []
    var isExpanded = false
    
    init(title: String, data: [String], isExpanded: Bool = false) {
        self.title = title
        self.data = data
        self.isExpanded = isExpanded
    }
}


struct Movie: Codable {
    let Title: String?
    let Year: String?
    let Rated: String?
    let Released: String?
    let Runtime: String?
    let Genre: String?
    let Director: String?
    let Writer: String?
    let Actors: String?
    let Plot: String?
    let Language: String?
    let Country: String?
    let Awards: String?
    let Poster: String?
    let Metascore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let imdbID: String?
    let DVD: String?
    let BoxOffice: String?
    let Production: String?
    let Website: String?
    let Response: String?
    let Ratings: [RatingModel]?
}

struct RatingModel: Codable {
    let Source: String?
    let Value: String?
}


