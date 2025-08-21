//
//  GFImageView.swift
//  Github Clone
//
//  Created by Umar Akram on 27/06/2025.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    var placeholderImage = UIImage(named: "avatar-placeholder")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from url: String){
        guard let url = URL(string: url) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self else {return}
            
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data else {return}
            
            DispatchQueue.main.async{
                self.image = UIImage(data: data)
            }

        }
        
        task.resume()
    }
}
