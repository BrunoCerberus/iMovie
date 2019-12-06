//
//  ConfigViewController.swift
//  iMovie
//
//  Created by bruno on 06/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

class ConfigViewController: BaseViewController {
    
    var viewModel: ConfigViewModel!
    
    init(viewModel: ConfigViewModel) {
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
