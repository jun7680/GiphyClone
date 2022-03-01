//
//  SearchViewModel.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/02/28.
//

import Foundation
import Combine

class SearchViewModel {
    private let manager = OperateManger.shared.searchManager
    private var cancellabel = Set<AnyCancellable>()
    
    private var offset = 0
    private var limit = 25
    
    // collectionview datasource
    private var searchResultData = [DataDTO]()
    
    // output -> collectionview
    var numberOfRows: Int {
        searchResultData.count
    }
    
    var searchReslt: [DataDTO] {
        searchResultData
    }
    
    var reloadData: AnyPublisher<Void, Never> {
        reloadDataSubject.eraseToAnyPublisher()
    }
    
    private let reloadDataSubject = PassthroughSubject<Void, Never>()
    func search(word: String) {
        DispatchQueue.global().async {[weak self] in
            guard let self = self else { return }
            self.manager.search(word, offset: self.offset, limit: self.limit)
                .sink {  result in
                    switch result {
                    case .success(let value):
                        self.searchResultData.append(contentsOf: value.data)
                        if self.offset < value.pagination.totalCount {
                            self.offset += value.pagination.count
                        }
                        
                        self.reloadDataSubject.send()
                    case .failure(let error):
                        print(error)
                    }
                }.store(in: &self.cancellabel)
        }
    }
}
