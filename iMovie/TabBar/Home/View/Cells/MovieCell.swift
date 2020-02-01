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
    
    var carouselType: CarouselType = .popular
    
    func setup(_ movie: Film) {
        
        switch carouselType {
        case .nowPlaying:
            movieImage.kf.setImage(with: movie.backdropImagePath)
        case .topRated, .popular:
            movieImage.kf.setImage(with: movie.posterImagePath)
        }
        
    }
}
