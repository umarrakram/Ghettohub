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
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result{
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Things Happend", message: error.rawValue, buttonTitle: "Ok")
                
            case .success(let followers):
                print(result)
                print(followers)
            }
            
            // Do any additional setup after loading the view.
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

