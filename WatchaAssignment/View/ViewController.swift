//
//  ViewController.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/02/28.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = " test "
        search.searchBarStyle = UISearchBar.Style.prominent
        search.sizeToFit()
        search.isTranslucent = false
        search.backgroundImage = UIImage()
        return search
    }()
    
    let textImage: UIImage = {
        let url = "https://media1.giphy.com/media/E1ZvWGc8KQr16ePDc7/giphy-preview.gif?cid=af0ce35cql11mb2wggpfvtsss8z9h36qtt1xhnginirmxi0m&rid=giphy-preview.gif&ct=g"
        let image = UIImage.gifImageFromURL(url)
        
        return image
    }()
    
    let testImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .white
        self.title = "Search"
    }
    
    private func setViews() {
        
        view.addSubview(searchBar)
        view.addSubview(testImageView)
        setConstraint()
    }
    
    private func setConstraint() {
        
        testImageView.image = textImage
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
        
            testImageView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 100),
            testImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            testImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            testImageView.heightAnchor.constraint(equalToConstant: 200)                    
        ])
    }


}

