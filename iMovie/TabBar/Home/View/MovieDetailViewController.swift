//
//  MovieDetailViewController.swift
//  iMovie
//
//  Created by bruno on 01/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var titleMovieLabel: UILabel!
    
    var movie: Film!
    
    private var anotherViewController: MovieDetailViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleMovieLabel.text = movie.title
    }
    
    init(_ movie: Film) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
