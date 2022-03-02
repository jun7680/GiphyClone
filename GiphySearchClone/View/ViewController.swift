//
//  ViewController.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/02/28.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private var cancelladble = Set<AnyCancellable>()
    private let viewModel = SearchViewModel()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        loading.center = view.center
        loading.color = .gray
        loading.hidesWhenStopped = true
        loading.style = .large
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.stopAnimating()
        return loading
    }()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = "검색어를 입력하세요."
        search.searchBarStyle = UISearchBar.Style.prominent
        search.sizeToFit()
        search.isTranslucent = false
        search.backgroundImage = UIImage()
        search.delegate = self
        return search
    }()
    
    lazy var searchResultCollectionView: UICollectionView = {
        let layout = SearchResultLayout()
        layout.delegate = self
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .white
        self.title = "Search"
    }
    
    private func setViews() {
        view.addSubview(searchBar)
        view.addSubview(searchResultCollectionView)
        view.addSubview(activityIndicator)
        setConstraint()
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            searchResultCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchResultCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setBinding() {
        viewModel.reloadData
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.searchResultCollectionView.reloadData()
                    self?.viewModel.isLoading = false
                    self?.activityIndicator.stopAnimating()
                }
            }.store(in: &cancelladble)
    }    
}

extension ViewController: UICollectionViewDataSource,
                          UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchResultCell.identifier,
            for: indexPath
        ) as? SearchResultCell
        else { return .init() }
        if viewModel.numberOfRows != 0 {
            let url = viewModel.searchReslt[indexPath.row].images.fixedWidth.url
            cell.configure(url: url)            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = viewModel.searchReslt[indexPath.row]
        
        self.navigationController?.pushViewController(DetailViewController(data: data), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.searchReslt.count - 3 {
            let word = searchBar.text ?? String()
            activityIndicator.startAnimating()
            viewModel.paginationSearch(word: word)
        }
    }
    
}

// 동적 height를 위한 delegate
extension ViewController: SearchResultLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        let image = viewModel.searchReslt[indexPath.row].images.fixedWidth
        let height = HeightCalculate.calculateImageHeight(image: image, width: cellWidth)
        return height
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let word = searchBar.text ?? String()
        activityIndicator.startAnimating()
        searchResultCollectionView.layoutIfNeeded()
        searchResultCollectionView.contentSize.height = 0
        searchResultCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        viewModel.search(word: word)
    }
}
