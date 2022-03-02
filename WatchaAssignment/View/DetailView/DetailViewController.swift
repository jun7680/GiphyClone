//
//  DetailViewController.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/03/01.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    let detailData: DataDTO
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(favoriteDidtap), for: .touchUpInside)
        return button
    }()
    
    init(data: DataDTO) {
        self.detailData = data
        super.init(nibName: nil, bundle: nil)
        print(detailData.images.fixedWidth.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "Detail"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setViews()
    }
    
    private func setViews() {
        view.addSubview(imageView)
        view.addSubview(favoriteButton)
        fetchFavorite()
        setConstraints()
        setImage()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            favoriteButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 36),
            favoriteButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func setImage() {
        imageView.image = UIImage.gifImageFromURL(detailData.images.previewGif.url)
    }
    
    @objc private func favoriteDidtap() {
        let favorite = favoriteButton.currentImage == UIImage(systemName: "star")

        checkFavorite(favorite)
        
        saveFavoriteStatus(isFavorite: favorite)
    }
    
    private func saveFavoriteStatus(isFavorite: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: context)
        
        if let entity = entity {
            let favorite = NSManagedObject(entity: entity, insertInto: context)
            favorite.setValue(detailData.id, forKey: "id")
            favorite.setValue(isFavorite, forKey: "favorite")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchFavorite() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let favorite = try context.fetch(Favorite.fetchRequest())
            favorite.forEach { saveValue in
                let id = saveValue.id ?? String()
                if id == detailData.id {
                    checkFavorite(saveValue.favorite)
                } else {
                    checkFavorite(false)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func checkFavorite(_ isFavorite: Bool) {
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
