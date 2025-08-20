//
//  FollowerListViewController.swift
//  Github Clone
//
//  Created by Umar Akram on 23/03/2025.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    enum Section{
        case main
    }
    var username: String!
    var followers:[Follower] = []
    
    var followerCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    func getFollowers(){
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self else{return}
            switch result{
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Things Happend", message: error.rawValue, buttonTitle: "Ok")
                
            case .success(let followers):
                self.followers = followers
                self.updateData()
            }
        }
    }
    
    
    func configureCollectionView(){
        followerCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(followerCollectionView)
        followerCollectionView.backgroundColor = .systemBackground
        followerCollectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: followerCollectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async{
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
}
