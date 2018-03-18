//
//  BaseRxMoyaProvider.swift
//  Ticker
//
//  Created by Sergey Klimov on 18.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Moya
import RxSwift


class BaseRxMoyaProvider<Target>: MoyaProvider<Target> where Target: TargetType {
    
    final func request(_ token: Target) -> Observable<Response> {
        return super.rx.request(token)
            .flatMap({ PrimitiveSequence.just($0) })
            .asObservable()
    }
}
