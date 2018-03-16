//
//  QuotationList.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import ObjectMapper


struct QuotationList {
    
    var list: [Quotation] = []
}

extension QuotationList: Mappable {
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        let dictionary = map.JSON
        let mapper = Mapper<Quotation>()
        
        list = dictionary.flatMap { (pair) in
            var item = mapper.map(JSONObject: pair.value)
            item?.name = pair.key
            return item
        }
    }
}
