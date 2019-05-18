//
//  Product.swift
//  MVVMExample
//
//  Created by Sravan on 06/05/19.
//  Copyright © 2019 Sravan. All rights reserved.
//

import Foundation

//    {
//        "pId": "318104931-X",
//        "productName": "Titanium Dioxide and Zinc Oxide",
//        "price": {
//            "currency": "USD",
//            "amount": {
//                "rate": "$7.77"
//            }
//        },
//        "descr": "generate visionary functionalities",
//        "mfgDate": "2018-02-28T00:57:36Z"
//    },

enum ProductKeys: String, CodingKey {
    case productID = "pId"
    case productName = "productName"
    case description = "descr"
    case manufacturingDate = "mfgDate"
    case price = "price"
}

enum PriceKeys: String, CodingKey {
    case currency = "currency"
    case amount = "amount"
}

enum AmountKeys: String, CodingKey {
    case rate = "rate"
}

struct Product: Codable {
    var productID: String?
    var productName: String?
    var description: String?
    var manufacturingDate: String?
    var currency: String?
    var rate: String?
}

extension Product {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ProductKeys.self)
        self.productID = try values.decode(String.self, forKey: .productID)
        self.productName = try values.decode(String.self, forKey: .productName)
        self.description = try values.decode(String.self, forKey: .description)
        self.manufacturingDate = try values.decode(String.self, forKey: .manufacturingDate)

        let priceValues = try values.nestedContainer(keyedBy: PriceKeys.self, forKey: .price)
        self.currency = try priceValues.decodeIfPresent(String.self, forKey: .currency) //.decode(String.self, forKey: .currency)

        let amountValues = try priceValues.nestedContainer(keyedBy: AmountKeys.self, forKey: .amount)
        self.rate = try amountValues.decode(String.self, forKey: .rate)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductKeys.self)
        try container.encode(self.productID, forKey: .productID)
        try container.encode(self.productName, forKey: .productName)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.manufacturingDate, forKey: .manufacturingDate)

        var priceContainer = container.nestedContainer(keyedBy: PriceKeys.self, forKey: .price)
        try priceContainer.encodeIfPresent(self.currency, forKey: .currency)
        
        var amountContainer = priceContainer.nestedContainer(keyedBy: AmountKeys.self, forKey: .amount)
        try amountContainer.encode(self.rate, forKey: .rate)
    }
}
