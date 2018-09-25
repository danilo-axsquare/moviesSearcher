//
//  MoviesListController.swift
//  MyMovies
//
//  Created by Danilo on 22/09/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import Foundation

class MoviesListController {
    
    fileprivate let TIME_BUFFER_BEFORE_REQUEST = 1000
    fileprivate var view: MoviesListViewController!
    fileprivate var movies: [Movie]?
    fileprivate var lastSearchString = ""
    fileprivate var lastTypedQuery = (query: "",date: Date())
    
    init(viewController: MoviesListViewController) {
        self.view = viewController
        self.retrieveNowPlayingMovies()
    }
    
    public func retrieveNowPlayingMovies() {
        self.fireRequestWith(requestType: RequestType.now_playing)
    }
    
    public func searchMoviesWith(query: String) {
        let cleanQuery = self.cleanQueryString(query)
        if (self.lastTypedQuery.query != cleanQuery) {
            self.view?.showLoader()
            self.lastTypedQuery = (query: cleanQuery, date: Date())
            self.filterRequestsAndFire()
        }
    }
    
    public func countMovies() -> Int {
        return self.movies?.count ?? 0
    }
    
    public func getMovie(withId id: Int) -> Movie? {
        if (id < self.movies?.count ?? 0) {
            return self.movies?[id]
        }
        return nil
    }
    
    // MARK: private methods
    
    private func cleanQueryString(_ queryString: String) -> String {
        let clean = queryString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if let _clean = clean {
            return _clean
        } else {
            let okayChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
            return queryString.filter {okayChars.contains($0) }

        }
    }
    
    private func filterRequestsAndFire() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(TIME_BUFFER_BEFORE_REQUEST)) {
            if (!Date().timeIntervalSince(self.lastTypedQuery.date).isLessThanOrEqualTo(Double(self.TIME_BUFFER_BEFORE_REQUEST/1000))) {
                if (self.lastSearchString != self.lastTypedQuery.query) {
                    self.lastSearchString = self.lastTypedQuery.query
                    print(" I will search for : \(self.lastSearchString)")
                    if (self.lastSearchString.count > 0) {
                        self.fireRequestWith(requestType: RequestType.search,andQueryString: self.lastSearchString)
                    } else {
                        self.retrieveNowPlayingMovies()
                    }
                } else {
                    self.view?.hideLoader()
                }
            }
        }
    }
    
    private func fireRequestWith(requestType: RequestType, andQueryString queryString: String = "") {
        self.view?.showLoader()
        let request = MovieRequestBuilder(requestType)
        request.setQueryString(queryString)
        let requestExecutor = RequestHTTPExecutor(request: request, delegate: self)
        requestExecutor.execute()
    }
}

extension MoviesListController : ResponseProtocol {
    
    func noInternetConnection() {
        self.view?.showAlert(withMessage: "Hey man! You are offline")
    }
    
    func generalError() {
        self.view?.showAlert(withMessage: "Uuups! Something went wrong :/")
    }
    
    func success(content: Any) {
        self.movies = []
        if let _content = content as? Array<[String:Any]> {
            if (_content.count > 0) {
                for dictionary in _content {
                    let movie = Movie(dictionary: dictionary)
                    if let _movie = movie {
                        self.movies?.append(_movie)
                    }
                }
            } else {
                self.success()
            }
        }
        self.view?.showContent()
    }
    
    func success() {
        self.view?.showAlert(withMessage: "No movies found! :|")
    }
    
    func resourceNotFound() {
        self.success()
    }

}
