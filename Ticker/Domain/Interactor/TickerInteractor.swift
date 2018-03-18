//
//  TickerInteractor.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import RxSwift
import Moya
import Moya_ObjectMapper


class TickerInteractor: Interactor<Void, [Quotation]> {
    
    private let provider = TickerProvider.moyaProvider()
    
    override func asObservable(params: Void) -> Observable<[Quotation]> {
        return provider
            .request(.returnTicker)
            .mapObject(QuotationList.self)
            .map({ $0.list })
    }
}
