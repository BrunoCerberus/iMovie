//
//  HomeViewController.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    @IBOutlet weak var homeCollection: UICollectionView!
    @IBOutlet weak var homeFlow: UICollectionViewFlowLayout!
    @IBOutlet weak var backgroundTop: UIView!
    @IBOutlet weak var pullAreaConstraint: NSLayoutConstraint!
    
    private var viewModel: HomeViewModel!
    private var dispatchGroup: DispatchGroup!
    private var refreshControl: UIRefreshControl!
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
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
        
        setup()
    }
    
    private func setup() {
        registerCells()
        addRefreshControl()
        
        if Device.size() >= .screen5_8Inch || Device.size() == .unknownSize {
            pullAreaConstraint.constant = 44
        }
        
        refreshHome()
    }
    
    private func registerCells() {
        homeCollection.register(CarouselMovieCell.self)
    }
    
    private func requestAll(completion: CompletionSuccess? = nil) {
        requestNowPlaying(completion)
        requestTopRated(completion)
        requestPopularMovies(completion)
    }
    
    private func requestNowPlaying(_ completion: CompletionSuccess? = nil) {
        dispatchGroup.enter()
        viewModel.requestNowPlaying {
            self.dispatchGroup.leave()
        }
    }
    
    private func requestTopRated(_ completion: CompletionSuccess? = nil) {
        dispatchGroup.enter()
        viewModel.requestTopRated {
            self.dispatchGroup.leave()
        }
    }
    
    private func requestPopularMovies(_ completion: CompletionSuccess? = nil) {
        dispatchGroup.enter()
        viewModel.requestPopular {
            self.dispatchGroup.leave()
        }
    }
    
    func showNetworkOperation(_ show: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = show
        }
    }
    
    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor       = .clear
        refreshControl.addTarget(self, action: #selector(refreshHome), for: .valueChanged)
        self.homeCollection.insertSubview(refreshControl, at: 0)
        
        let screen = UIScreen.main.bounds
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: screen.width / 2 - 12.5,
                                                                      y: 0,
                                                                      width: 25.0,
                                                                      height: 25.0))
        activityIndicator.type = .ballClipRotate
        activityIndicator.startAnimating()
        refreshControl.subviews[0].addSubview(activityIndicator)
    }
    
    @objc func refreshHome() {
        self.showNetworkOperation(true)
        requestAll()
        
        dispatchGroup.notify(queue: .main) {
            self.showNetworkOperation(false)
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.homeCollection.reloadData()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = HomeSections(rawValue: indexPath.section)
        switch section {
        case .nowPlaying:
            return collectionView.dequeueReusableCell(of: CarouselMovieCell.self, for: indexPath) { [weak self] cell in
                guard let nowPlayingMovies = self?.viewModel.nowPlayingMovies else { return }
                cell.setup(nowPlayingMovies)
            }
        case .topRated:
            return UICollectionViewCell()
            
        case .popular:
            return UICollectionViewCell()
        case .none:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = -scrollView.contentOffset.y
        if offset >= 0 {
            backgroundTop.transform = .init(translationX: 0, y: offset)
        } else {
            backgroundTop.transform = .init(translationX: 0, y: 0)
        }
    }
}
