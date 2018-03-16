//
//  TickerProvider.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Moya


enum TickerProvider: BaseProvider {
    case returnTicker
}

extension TickerProvider: TargetType {
    
    var path: String {
        switch self {
        case .returnTicker:
            return K.ApiMethod.publicApi
        }
    }
    
    var task: Task {
        return .requestCompositeData(bodyData: Data(), urlParameters: parameters)
    }
    
    var parameters: [String: Any] {
        switch self {
        case .returnTicker:
            return ["command": "returnTicker"]
        }
    }
}
