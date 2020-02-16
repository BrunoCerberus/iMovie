//
//  SearchViewController.swift
//  iMovie
//
//  Created by Bruno on 16/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

class SearchViewController: BaseViewController {
    
    var viewModel: SearchViewModel!
    
    init(viewModel: SearchViewModel) {
        super.init(nibName: nil, bundle: nil)
        viewModel.viewDelegate = self
        self.viewModel = viewModel
        title = "Search"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: SearchViewModelViewDelegate {
    
}
