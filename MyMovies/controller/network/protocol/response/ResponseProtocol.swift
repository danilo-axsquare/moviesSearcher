//
//  ResponseProtocol.swift
//  MyMovies
//
//  Created by Danilo on 22/09/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import Foundation

@objc protocol ResponseProtocol {
    
    func noInternetConnection()
    
    func generalError()
    
    @objc optional func success()
    
    @objc optional func success(content: Any)
    
    @objc optional func resourceNotFound()
        
}
