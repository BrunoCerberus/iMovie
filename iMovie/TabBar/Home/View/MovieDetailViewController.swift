//
//  MovieDetailViewController.swift
//  iMovie
//
//  Created by bruno on 01/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    var movie: Film!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(_ movie: Film) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
        title = movie.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
