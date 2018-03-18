//
//  BaseProvider.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Moya


protocol BaseProvider {}

extension BaseProvider {
    
    var baseURL: URL {
        return URL(string: K.ApiHost.poloniex)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
}

extension BaseProvider where Self: TargetType {
    
    var headers: [String: String]? {
        return nil
    }
    
    static func moyaProvider() -> BaseRxMoyaProvider<Self> {
        let provider = BaseRxMoyaProvider<Self>()
        return provider
    }
}
