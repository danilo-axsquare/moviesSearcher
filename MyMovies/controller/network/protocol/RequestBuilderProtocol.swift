//
//  RequestBuilderProtocol.swift
//  MyMovies
//
//  Created by Danilo on 22/09/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import Foundation

protocol RequestBuilderProtocol {
    
    func getRequestMethod() -> RequestMethods
        
    func getUrl() -> String
    
}
