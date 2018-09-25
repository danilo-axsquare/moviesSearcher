//
//  RequestHTTPExecutor.swift
//  MyMovies
//
//  Created by Danilo on 22/09/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import Foundation

class RequestHTTPExecutor {
    
    private var request: RequestBuilderProtocol
    private var delegate: ResponseProtocol
    
    init(request: RequestBuilderProtocol, delegate: ResponseProtocol) {
        self.request = request
        self.delegate = delegate
    }
    
    public func execute() {
        if Reachability.isConnectedToNetwork() {
            
            let url = URL(string: self.request.getUrl())!
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.getRequestMethod().rawValue
            
            DispatchQueue.global(qos: .background).async {
                let session = URLSession(configuration: .default)
                
                let task = session.dataTask(with: urlRequest) {(data, response, error) in
                    
                    guard error == nil else {
                        self.delegate.generalError()
                        return
                    }
                    
                    let httpResponse = response as! HTTPURLResponse
                    
                    switch httpResponse.statusCode {
                    case 200:
                        if let _data = data {
                            let result = self.convert(data: _data)
                            if (result.error) {
                                self.delegate.generalError()
                            } else {
                                if let resultDictionary = result.content as? [String : Any] {
                                    self.delegate.success?(content: resultDictionary["results"] ?? [])
                                }
                            }
                        }
                        return
                    case 201,202,204:
                        self.delegate.success?()
                        return
                    case 404:
                        self.delegate.resourceNotFound?()
                        return
                    default:
                        self.delegate.generalError()
                        
                    }
                }
                
                task.resume()
            }
        } else {
            self.delegate.noInternetConnection()
        }
        
    }
    
    private func convert(data: Data) -> (error: Bool,content:Any) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any]  {
                return (false,object)
            }
            if let object = json as? [Any] {
                return (false,object)
            }
        } catch {
            print("Invalid JSON received, description: \(error.localizedDescription)")
        }
        return (true,[:])
    }
}
