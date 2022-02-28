//
//  ViewController.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/02/28.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var cancelBag = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchManager().search("tee", offset: 0, limit: 25).sink { result in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print("error", error)
            }
        }.store(in: &cancelBag)
    }


}

