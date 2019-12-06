//
//  HomeViewController.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        tabBarItem.title = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
