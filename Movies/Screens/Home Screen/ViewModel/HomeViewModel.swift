//
//  HomeViewModel.swift
//  Movies
//
//  Created by Chandru M on 21/07/23.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func updateView()
}

class HomeViewModel: NSObject {
    
    //MARK: - Internal Variables
    var allMoviesList = [Movie]()
    var movieSections = [Section]()
    var filteredMoviesList = [Movie]()
    var showFilteredList = false //to show filtered movies
    var isFromSearchText = true
    weak var delegate: HomeViewModelDelegate?
    
    /// Method to get allMovies list and set all section categories
    func getMoviesList() {
        if let movies = loadJson("movies") {
            allMoviesList = movies
            
            var allYears = Set<String>()
            var allGeners = Set<String>()
            var allDirectors = Set<String>()
            var allActors = Set<String>()
            movies.forEach({ movie in
                if let years = movie.Year?.components(separatedBy: "–") {
                    for year in years {
                        if year.isNotEmpty() {
                            allYears.insert(year)
                        }
                    }
                }
                
                if let genres = movie.Genre?.components(separatedBy: ",") {
                    for genre in genres {
                        if genre.isNotEmpty() {
                            allGeners.insert(genre)
                        }
                    }
                }
                
                if let directors = movie.Director?.components(separatedBy: ",") {
                    for director in directors {
                        if director.isNotEmpty() {
                            allDirectors.insert(director)
                        }
                    }
                }
                
                if let actors = movie.Actors?.components(separatedBy: ",") {
                    for actor in actors {
                        if actor.isNotEmpty() {
                            allActors.insert(actor)
                        }
                    }
                }
                
            })
            movieSections.append(Section(title: "Year", data: allYears.sorted(by: <)))
            movieSections.append(Section(title: "Genre", data: allGeners.sorted(by: <)))
            movieSections.append(Section(title: "Directors", data: allDirectors.sorted(by: <)))
            movieSections.append(Section(title: "Actors", data: allActors.sorted(by: <)))
            movieSections.append(Section(title: "All Movies", data:[]))
            delegate?.updateView()
        }
        
        
    }
    
    /// Method to fetch Json string from json file and map to our custom object
    /// - Parameter fileName: Denotes file name
    /// - Returns: Return [Movies] object
    func loadJson(_ fileName: String) -> [Movie]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let movies = try decoder.decode([Movie].self, from: data)
                return movies
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    
    
    /// Method to search movies from serach bar text and update UI
    /// - Parameter searchText: Denotes search bar text
    func filterMovies(using searchText: String) {
        filteredMoviesList.removeAll()
        allMoviesList.forEach({ movie in
            if movie.Title?.lowercased().contains(searchText) ?? false ||
                movie.Year?.lowercased().contains(searchText) ?? false ||
                movie.Actors?.lowercased().contains(searchText) ?? false ||
                movie.Director?.lowercased().contains(searchText) ?? false ||
                movie.Genre?.lowercased().contains(searchText) ?? false
            {
                filteredMoviesList.append(movie)
            }
            
        })
        isFromSearchText = true
        showFilteredList = true
        delegate?.updateView()
    }
    
    
    /// Method to search movies from selected category and update UI
    /// - Parameters:
    ///   - category: Denotes selected category
    ///   - searchText: Denotes user selected value from selected category in string format
    func filterMovies(of category: MovieCategory, from searchText: String) {
        filteredMoviesList.removeAll()
        switch category {
            
        case .year:
            allMoviesList.forEach({ movie in
                if movie.Year?.lowercased().contains(searchText) ?? false {
                    filteredMoviesList.append(movie)
                }
            })
        case .genrie:
            allMoviesList.forEach({ movie in
                if movie.Genre?.lowercased().contains(searchText) ?? false {
                    filteredMoviesList.append(movie)
                }
            })
        case .director:
            allMoviesList.forEach({ movie in
                if movie.Director?.lowercased().contains(searchText) ?? false {
                    filteredMoviesList.append(movie)
                }
            })
        case .actor:
            allMoviesList.forEach({ movie in
                if movie.Actors?.lowercased().contains(searchText) ?? false {
                    filteredMoviesList.append(movie)
                }
            })
        }
        
        showFilteredList = true
        isFromSearchText = false
        delegate?.updateView()
    }
    
}
