//
//  NowPlayingCarouselCell.swift
//  iMovie
//
//  Created by bruno on 10/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

protocol NowPlayingCarouselDelegate: AnyObject {
    func didSelectMovie(_ carouselView: CarouselMovieCell, movie: Film?)
}

class CarouselMovieCell: UICollectionViewCell {
    
    @IBOutlet var carousel: UICollectionView!
    
    weak var delegate: NowPlayingCarouselDelegate?
    var carouselMovies: [Film]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        carousel.delegate = self
        carousel.dataSource = self
        carousel.register(HeaderMovieCell.self)
    }
    
    func setup(_ movies: [Film]) {
        carouselMovies = movies
        carousel.reloadData()
    }
}

extension CarouselMovieCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return carouselMovies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(of: HeaderMovieCell.self, for: indexPath) { cell in
            cell.setup(self.carouselMovies![indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectMovie(self, movie: nil)
    }
}

extension CarouselMovieCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}
