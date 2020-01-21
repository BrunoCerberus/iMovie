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
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var pageControl: UIPageControl!
    
    weak var delegate: NowPlayingCarouselDelegate?
    var carouselMovies: [Film]?
    var carouseType: CarouselType = .nowPlaying
    
    var edgeCellDistance: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        carousel.delegate = self
        carousel.dataSource = self
        carousel.register(HeaderMovieCell.self)
    }
    
    func setup(_ movies: [Film]) {
        carouselMovies = movies
        pageControl.numberOfPages = movies.count
        carousel.reloadData()
        
        if carouseType == .topRated {
            pageControl.isHidden = true
            carousel.isPagingEnabled = false
            carousel.bounces = true
        }
    }
    
    /// Return index of main cell collection
    ///
    /// - Returns: index of main cell
    private func indexOfMainCell() -> Int {
        let itemWidth = self.frame.width - edgeCellDistance
        let proportionalOffset = collectionViewLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(Darwin.round(proportionalOffset))
        let numberOfItems = carousel.numberOfItems(inSection: 0)
        let safeIndex = max(0, min(numberOfItems - 1, index))
        return safeIndex
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
        delegate?.didSelectMovie(self, movie: carouselMovies?[indexPath.row])
    }
}

extension CarouselMovieCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch carouseType {
        case .nowPlaying:
            return CGSize(width: collectionView.frame.width, height: 200)
        case .topRated:
            return CGSize(width: 140, height: 180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch carouseType {
        case .nowPlaying:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .topRated:
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
}
