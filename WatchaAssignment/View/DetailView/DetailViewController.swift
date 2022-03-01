//
//  DetailViewController.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/03/01.
//

import UIKit

class DetailViewController: UIViewController {

    let detailData: DataDTO
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(favoriteDidtap), for: .touchUpInside)
        return button
    }()
    
    init(data: DataDTO) {
        self.detailData = data
        super.init(nibName: nil, bundle: nil)
        print("init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setViews()
    }
    
    private func setViews() {
        view.addSubview(imageView)
        view.addSubview(favoriteButton)
        
        setConstraints()
        setImage()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setImage() {
        imageView.image = UIImage.gifImageFromURL(detailData.images.previewGif.url)
    }
    
    @objc private func favoriteDidtap() {
        print("didTap")
    }
    
}
