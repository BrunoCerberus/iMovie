//
//  MovieCell.swift
//  iMovie
//
//  Created by bruno on 10/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    
    func setup(_ movie: Film) {
        movieImage.kf.setImage(with: movie.backdropImagePath)
    }
}
