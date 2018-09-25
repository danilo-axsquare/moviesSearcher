//
//  Movie.swift
//  MyMovies
//
//  Created by Danilo on 22/09/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import Foundation

struct Movie {
    
    private static let TITLE_KEY = "title"
    private static let OVERVIEW_KEY = "overview"
    private static let POSTER_KEY = "poster_path"
    private static let BACKDROP_KEY = "backdrop_path"
    
    let title: String!
    let overview: String!
    private let idPoster: String?
    private let idBackground: String?
    
    init(title: String, overview: String, idPoster: String, idBackground: String) {
        self.title = title
        self.overview = overview
        self.idPoster = idPoster
        self.idBackground = idBackground
    }
    
    init?(dictionary: [String:Any]) {
        if (dictionary[Movie.TITLE_KEY] != nil && dictionary[Movie.OVERVIEW_KEY] != nil) {
            self.title = dictionary[Movie.TITLE_KEY] as! String
            self.overview = dictionary[Movie.OVERVIEW_KEY] as! String
            self.idPoster = dictionary[Movie.POSTER_KEY] as? String
            self.idBackground = dictionary[Movie.BACKDROP_KEY] as? String
        } else {
            return nil
        }
    }
    
    public func retrievePosterUrl() -> URL? {
        if let _idPoster = self.idPoster {
            return URL(string: MovieRequestBuilder.POSTER_BASE_PATH + _idPoster)
        }
        return nil
    }
    
    public func retrieveBackgroundUrl() -> URL? {
        if let _idBackground = self.idBackground {
            return URL(string: MovieRequestBuilder.BACKGROUND_BASE_PATH + _idBackground)
        }
        return nil
    }
}
