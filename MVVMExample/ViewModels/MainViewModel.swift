//
//  MainViewModel.swift
//  MVVMExample
//
//  Created by Sravan on 06/05/19.
//  Copyright © 2019 Sravan. All rights reserved.
//

import Foundation

class MainViewModel {
    var products : [Product] = [Product]()
    
    var responseReceived : (() -> ())?
    
    func callAPIService() {
        let manager = NetworkManager()
        manager.performGetRequest(successHandler: { [weak self] (responseData) in
            guard let weakSelf = self else { return }
            weakSelf.products = responseData
            weakSelf.responseReceived?()
        }) { (errorDescription) in
            print(errorDescription)
        }
    }
    
    func numberOfRows() -> Int {
        return self.products.count
    }
    
    func cellData(for index: Int) -> Product {
        return self.products[index]
    }
}
