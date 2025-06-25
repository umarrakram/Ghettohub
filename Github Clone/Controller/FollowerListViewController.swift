//
//  FollowerListViewController.swift
//  Github Clone
//
//  Created by Umar Akram on 23/03/2025.
//

import UIKit

class FollowerListViewController: UIViewController {

    var username: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { followers, string in
            guard let followers = followers else {
                
                return
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
