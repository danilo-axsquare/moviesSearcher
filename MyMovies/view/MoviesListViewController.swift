//
//  MoviesListViewController.swift
//  MyMovies
//
//  Created by Danilo on 20/09/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import UIKit

class MoviesListViewController: MovieBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    fileprivate var moviesCollectionView: UICollectionView!
    fileprivate var cellSize: CGSize!
    fileprivate var controller: MoviesListController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controller = MoviesListController(viewController: self)
        self.setUpNavigationBar()
        self.buildUI()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func showContent(){
        DispatchQueue.main.sync {
            self.hideLoader()
            self.moviesCollectionView.reloadData()
        }
    }
    
    //MARK: init UI methods
    
    private func buildUI() {
        let width = self.view.bounds.width/2
        self.cellSize = CGSize(width: width , height: ((width/2)*3) )
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.moviesCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        moviesCollectionView.register(PosterMovieCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        self.view.addSubview(moviesCollectionView)
    }
    
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: nil)
        let cancelButtonAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    //MARK: Collection view methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.controller?.countMovies() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.controller?.getMovie(withId: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! PosterMovieCollectionViewCell
        
        cell.setModel(movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.controller?.getMovie(withId: indexPath.row)
        let vc = DetailMovieViewController()
        vc.movie = movie
        vc.edgesForExtendedLayout = .bottom
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension MoviesListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let search = searchController.searchBar.text {
            self.controller.searchMoviesWith(query: search)
        }
    }
}

