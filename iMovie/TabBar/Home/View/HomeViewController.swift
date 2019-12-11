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
    
    var viewModel: HomeViewModel!
    var dispatchGroup: DispatchGroup!
    
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
        
        self.homeCollection.delegate = self
        registerCells()
        refreshHome()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func registerCells() {
        homeCollection.register(NowPlayingCarouselCell.self)
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
    
    @objc func refreshHome() {
        
        requestAll()
        
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.homeCollection.reloadData()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(of: NowPlayingCarouselCell.self, for: indexPath) { cell in
            guard let nowPlayingMovies = self.viewModel.nowPlayingMovies else { return }
            cell.setup(nowPlayingMovies)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}
