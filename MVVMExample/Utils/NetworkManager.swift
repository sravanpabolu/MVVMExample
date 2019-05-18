//
//  NetworkManager.swift
//  MVVMExample
//
//  Created by Sravan on 06/05/19.
//  Copyright © 2019 Sravan. All rights reserved.
//

import Foundation

class NetworkManager {
    typealias successHandler = (_ successResponse: [Product]) -> ()
    typealias failureHandler = (_ failureMessage: String) -> ()
    
    let apiURLString = "https://api.myjson.com/bins/9asku"
    
    func performGetRequest(successHandler: @escaping successHandler, failureHandler: @escaping failureHandler) {
        guard let apiURL: URL = URL(string: apiURLString) else { return }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: apiURL) { (data, response, error) in
            guard error == nil else {
                failureHandler("API Error")
                return
            }
            
            if let jsonData = data {
                //parse json
                let decoder = JSONDecoder()
                if let jsonResponse = try? decoder.decode([Product].self, from: jsonData) {
                    successHandler(jsonResponse)
                } else {
                    failureHandler("Parse Error")
                }
            }
        }
        task.resume()
    }
}
