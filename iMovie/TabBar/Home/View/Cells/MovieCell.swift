//
//  MovieCell.swift
//  iMovie
//
//  Created by bruno on 21/01/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    func setup(_ movie: Film) {
        movieImage.kf.setImage(with: movie.posterImagePath)
    }
}
