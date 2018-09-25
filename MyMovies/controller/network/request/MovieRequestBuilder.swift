//
//  MovieRequestBuilder.swift
//  MyMovies
//
//  Created by Danilo on 22/09/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import Foundation

enum RequestType {
    case detail,now_playing,search
}

class MovieRequestBuilder: RequestBuilderProtocol {
    
    private static let IMAGE_BASE_PATH = "https://image.tmdb.org/t/p/"
    public static let POSTER_BASE_PATH = IMAGE_BASE_PATH + "w154/"
    public static let BACKGROUND_BASE_PATH = IMAGE_BASE_PATH + "w300/"
    
    private let MOVIE_BASE_PATH = "https://api.themoviedb.org/3/"
    private let API_KEY = "api_key=b4a57259ca070dadb4f01b00fbd9d203"
    
    
    private var queryString: String?
    private let requestType: RequestType
    
    init(_ requestType:RequestType) {
        self.requestType = requestType
    }
    
    func setQueryString(_ qs:String) {
        self.queryString = qs
    }
    
    func getRequestMethod() -> RequestMethods {
        return RequestMethods.GET
    }
    
    func getUrl() -> String {
        switch (self.requestType) {
            case RequestType.now_playing:
                return MOVIE_BASE_PATH + "movie/now_playing?" + API_KEY
        case RequestType.search:
            return MOVIE_BASE_PATH + "search/movie?page=1&include_adult=false&" + API_KEY + "&query=\(queryString!)"
            default:
            return ""
        }
    }
    
}
