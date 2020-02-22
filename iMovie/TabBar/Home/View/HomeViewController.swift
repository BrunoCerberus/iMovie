//
//  HomeViewController.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation
import UIKit

final class HomeViewController: BaseViewController {
    
    @IBOutlet weak var homeCollection: UICollectionView!
    @IBOutlet weak var homeFlow: UICollectionViewFlowLayout!
    
    private var viewModel: HomeViewModel!
    private var dispatchGroup: DispatchGroup!
    private var refreshControl: UIRefreshControl!
    private var bottomRefreshControl: UIRefreshControl!
    private var pageCount: Int = 1
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        viewModel.viewDelegate = self
        self.viewModel = viewModel
        dispatchGroup = DispatchGroup()
        title = "Home"
    }
    
    enum HomeSections: Int {
        case nowPlaying
        case topRated
        case popular
        
        static var count: Int { return 3 }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.showHUD()
        setup()
    }
    
    private func setup() {
        registerCells()
        addRefreshControl()
        refreshHome()
    }
    
    private func registerCells() {
        homeCollection.register(CarouselMovieCell.self)
        homeCollection.register(MovieCell.self)
        homeCollection.register(UINib(nibName: "SectionHeader", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "SectionHeader")
    }
    
    private func requestAll() {
        requestNowPlaying()
        requestTopRated()
        requestPopularMovies()
    }
    
    private func requestNowPlaying() {
        dispatchGroup.enter()
        viewModel.requestNowPlaying()
    }
    
    private func requestTopRated() {
        dispatchGroup.enter()
        viewModel.requestTopRated()
    }
    
    private func requestPopularMovies() {
        dispatchGroup.enter()
        viewModel.requestPopular()
    }
    
    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        bottomRefreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        bottomRefreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshHome), for: .valueChanged)
        bottomRefreshControl.addTarget(self, action: #selector(fetchMorePopularMovie), for: .valueChanged)
        homeCollection.refreshControl = refreshControl
        homeCollection.bottomRefreshControl = bottomRefreshControl
    }
    
    @objc func refreshHome() {
        requestAll()
        
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async { [weak self] in
                self?.view.hideHUD()
                self?.refreshControl.endRefreshing()
                self?.homeCollection.reloadData()
            }
        }
    }
    
    @objc func fetchMorePopularMovie() {
        dispatchGroup.enter()
        viewModel.requestPopular(in: pageCount + 1)
        dispatchGroup.notify(queue: .main) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.pageCount += 1
                self?.bottomRefreshControl.endRefreshing()
                self?.homeCollection.reloadData()
            }
        }
    }
    
    private func didSelectMovie(_ movie: Film?) {
        viewModel.didSelectMovie(movie)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sec = HomeSections(rawValue: section) else { return 0 }
        
        switch sec {
        case .nowPlaying:
            return 1
        case .topRated:
            return 1
        case .popular:
            return viewModel.popularMovies?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = HomeSections(rawValue: indexPath.section)
        switch section {
        case .nowPlaying:
            return collectionView.dequeueReusableCell(of: CarouselMovieCell.self, for: indexPath) { [weak self] cell in
                guard let nowPlayingMovies = self?.viewModel.nowPlayingMovies else { return }
                cell.delegate = self
                cell.carousel.bounces = false
                cell.setup(nowPlayingMovies)
            }
        case .topRated:
            return collectionView.dequeueReusableCell(of: CarouselMovieCell.self, for: indexPath) { [weak self] cell in
                guard let topRatedMovies = self?.viewModel.topRatedMovies else { return }
                cell.delegate = self
                cell.carouseType = .topRated
                cell.setup(topRatedMovies)
            }
            
        case .popular:
            return collectionView.dequeueReusableCell(of: MovieCell.self, for: indexPath) { [weak self] cell in
                guard let popularMovies = self?.viewModel.popularMovies else { return }
                cell.setup(popularMovies[indexPath.row])
            }
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == HomeSections.popular.rawValue {
            guard let popularMovies = self.viewModel.popularMovies else { return }
            didSelectMovie(popularMovies[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let section = HomeSections(rawValue: indexPath.section) else { return UICollectionReusableView() }
        guard let sectionHeader = collectionView
            .dequeueReusableSupplementaryView(ofKind: kind,
                                              withReuseIdentifier: "SectionHeader",
                                              for: indexPath) as? SectionHeader else { return UICollectionReusableView() }
        
        switch section {
        case .topRated:
            sectionHeader.sectionHeaderlabel.text = "Top Rated"
            return sectionHeader
        case .popular:
            sectionHeader.sectionHeaderlabel.text = "Popular"
            return sectionHeader
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let section = HomeSections(rawValue: section) else { return .zero }
        
        switch section {
        case .nowPlaying:
            return .zero
        default:
            return CGSize(width: 60.0, height: 30.0)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sec = HomeSections(rawValue: indexPath.section)
        switch sec {
        case .nowPlaying:
            return CGSize(width: collectionView.frame.width, height: 200)
        case .topRated:
            return CGSize(width: collectionView.frame.width, height: 200)
        case .popular:
            return CGSize(width: (collectionView.frame.width - 30) / 3, height: 200)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let sec = HomeSections(rawValue: section) else { return .zero }
        
        switch sec {
        case .popular:
            return UIEdgeInsets(top: 0, left: 10, bottom: 24, right: 10)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        guard let sec = HomeSections(rawValue: section) else { return .zero }
        
        switch sec {
        case .popular:
            return 10
        default:
            return 0
        }
    }
}

extension HomeViewController: CarouselMovieDelegate {
    func didSelectMovie(_ carouselView: CarouselMovieCell, movie: Film?) {
        didSelectMovie(movie)
    }
}

extension HomeViewController: HomeViewModelViewDelegate {
    func homeViewModelDidFinishLoadNowPlaying(_ viewModel: HomeViewModel) {
        dispatchGroup.leave()
    }
    
    func homeViewModelDidFinishLoadTopRated(_ viewModel: HomeViewModel) {
        dispatchGroup.leave()
    }
    
    func homeViewModelDidFinishLoadPopular(_ viewModel: HomeViewModel) {
        dispatchGroup.leave()
    }
}
