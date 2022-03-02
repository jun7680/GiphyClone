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
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = " test "
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setViews() {
        view.addSubview(searchBar)
        view.addSubview(searchResultCollectionView)
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
            searchResultCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setBinding() {
        viewModel.reloadData
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.searchResultCollectionView.reloadData()
                    
                    self?.viewModel.isLoading = false
                }
            }.store(in: &cancelladble)
    }    
}

extension ViewController: UICollectionViewDataSource,
                          UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("😛", viewModel.numberOfRows)
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchResultCell.identifier,
            for: indexPath
        ) as? SearchResultCell
        else { return .init() }
        print("😛 cellforItemAt")
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
            viewModel.paginationSearch(word: word)
        }
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("sizeForItemAt")
        let image = viewModel.searchReslt[indexPath.row].images.fixedWidth
        let height = HeightCalculate.calculateImageHeight(image: image, width: UIScreen.main.bounds.width / 2)
        return CGSize(width: collectionView.frame.width / 2, height: height)
    }
}

extension ViewController: SearchResultLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        print("😛 result delegate")
        let image = viewModel.searchReslt[indexPath.row].images.fixedWidth
        let height = HeightCalculate.calculateImageHeight(image: image, width: UIScreen.main.bounds.width / 2)
        return height
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let word = searchBar.text ?? String()
        viewModel.search(word: word)
    }
}

// pagination
//extension ViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(searchResultCollectionView.contentOffset.y >= (self.searchResultCollectionView.contentSize.height - self.searchResultCollectionView.bounds.size.height))
//
//        if searchResultCollectionView.contentOffset.y >= (self.searchResultCollectionView.contentSize.height - self.searchResultCollectionView.bounds.size.height) - 100 {
//            let word = searchBar.text ?? String()
//            viewModel.paginationSearch(word: word)
//        }
//    }
//}
