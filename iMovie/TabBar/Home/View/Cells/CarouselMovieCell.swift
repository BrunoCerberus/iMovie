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
    
    var edgeCellDistance: CGFloat = 0
    private var indexOfCellBeforeDragging = 0
    private let swipeVelocityThreshold: CGFloat = 0.5
    
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
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
           indexOfCellBeforeDragging = indexOfMainCell()
       }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Animation of card transition effect in scroolView.
        targetContentOffset.pointee = scrollView.contentOffset
        
        let indexOfMainCell = self.indexOfMainCell()
        
        let dataSourceCount = collectionView(carousel!,
                                             numberOfItemsInSection: carousel.numberOfItems(inSection: 0))
        
        let hasVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1
            < dataSourceCount && velocity.x > swipeVelocityThreshold
        
        let hasVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1
            >= 0 && velocity.x < -swipeVelocityThreshold
        
        let majorCellIsTheCellBeforeDragging = indexOfMainCell == indexOfCellBeforeDragging
        
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging &&
            (hasVelocityToSlideToTheNextCell || hasVelocityToSlideToThePreviousCell)
        
        if didUseSwipeToSkipCell {
            
            let snapToIndex = indexOfCellBeforeDragging + (hasVelocityToSlideToTheNextCell ? 1 : -1)
            
            let indexPath = IndexPath(row: snapToIndex, section: 0)
            pageControl.currentPage = snapToIndex
            collectionViewLayout.collectionView!.scrollToItem(at: indexPath,
                                                              at: .centeredHorizontally, animated: true)
        } else {
            
            let indexPath = IndexPath(row: indexOfMainCell, section: 0)
            pageControl.currentPage = indexPath.row
            collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
