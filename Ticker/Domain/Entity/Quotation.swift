//
//  Quotation.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import ObjectMapper
import RxDataSources


struct Quotation {
    var id: Int = 0
    var name: String = ""
    var last: String = ""
    var lowestAsk: String = ""
    var highestBid: String = ""
    var percentChange: String = ""
    var baseBolume: String = ""
    var quoteVolume: String = ""
    var isFrozen: String = ""
    var hight24hr: String = ""
    var low24hr: String = ""
}


extension Quotation: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        last <- map["last"]
        lowestAsk <- map["lowestAsk"]
        highestBid <- map["highestBid"]
        percentChange <- map["percentChange"]
        baseBolume <- map["baseBolume"]
        quoteVolume <- map["quoteVolume"]
        isFrozen <- map["isFrozen"]
        hight24hr <- map["hight24hr"]
        low24hr <- map["low24hr"]
    }
}

extension Quotation: Equatable, IdentifiableType {
    
    static func ==(lhs: Quotation, rhs: Quotation) -> Bool {
        return lhs.name == rhs.name
            && lhs.last == rhs.last
            && lhs.highestBid == rhs.highestBid
            && lhs.percentChange == rhs.percentChange
    }
    
    var identity: String {
        return name + last + highestBid + percentChange
    }
}
