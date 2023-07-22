//
//  String+Extension.swift
//  Movies
//
//  Created by Vignesh S on 22/07/23.
//

import Foundation

extension String {
    
    /// Method to check if string not empty and not contain "N/A"
    /// - Returns: Returns true if string not empty and not contain "N/A" otherwise false
    func isNotEmpty() -> Bool {
        return self != "" && self != "N/A"
    }
    
    func trim() -> String {
        return (trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
