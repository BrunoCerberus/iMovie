//
//  NowPlayingCarouselCell.swift
//  iMovie
//
//  Created by bruno on 10/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

protocol NowPlayingCarouselDelegate: AnyObject {
    func didSelectMovie(_ carouselView: NowPlayingCarouselCell, movie: Film?)
}

class NowPlayingCarouselCell: UICollectionViewCell {
    
    @IBOutlet weak var carouselCollection: UICollectionView!
    
    weak var delegate: NowPlayingCarouselDelegate?
    var carouselMovies: [Film]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        carouselCollection.delegate = self
        carouselCollection.dataSource = self
        carouselCollection.register(HeaderMovieCell.self)
    }
    
    func setup(_ movies: [Film]) {
        carouselMovies = movies
        carouselCollection.reloadData()
    }
}

extension NowPlayingCarouselCell: UICollectionViewDelegate, UICollectionViewDataSource {
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
