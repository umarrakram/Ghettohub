//
//  NetworkManager.swift
//  Github Clone
//
//  Created by Umar Akram on 25/06/2025.
//

import Foundation
class NetworkManager {
    static let shared = NetworkManager()
    let baseURL       = "https://api.github.com/user"
    
    private init(){}
    
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void){
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, "The server didn't respood. Please try again later!")
            return
        }
        let task = URLSession.shared.dataTask(with: url) {  data, response, error in
            if let error {
                completion(nil, "The server has returned error. \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "There was a problem fetching the username from server. Try again!")
                return
            }
            guard let data = data else {
                completion(nil, "The data received was invalid!")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
            }
            catch {
                completion(nil, "Error while fetching data")
            }
            
        }
        task.resume()
    }
}
