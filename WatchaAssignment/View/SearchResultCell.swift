//
//  SearchResultCell.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/03/01.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    static let identifier = "SearchResultCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(url: String) {
        let key = NSString(string: url)
        
        if let cacheImage = ImageCacheManager.shared.object(forKey: key) {
            imageView.image = cacheImage
            return
        }
        DispatchQueue.global().async { [weak self] in
            let image = UIImage.gifImageFromURL(url)
            DispatchQueue.main.async {
                ImageCacheManager.shared.setObject(image, forKey: key)
                self?.imageView.image = image
            }
        }
    }
    
    private func setup() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
    
