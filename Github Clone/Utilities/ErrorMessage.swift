//
//  ErrorMessage.swift
//  Github Clone
//
//  Created by Umar Akram on 26/06/2025.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "The server didn't respood. Please try again later!"
    case unableToComplete = "The server has returned error"
    case invalidResponse = "There was a problem fetching the username from server. Try again!"
    case invalidData     = "The data received was invalid!"
    case fetchingError    = "Error while fetching data"
}
