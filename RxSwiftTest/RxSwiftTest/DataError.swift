//
//  DataError.swift
//  RxSwiftTest
//
//  Created by LongMa on 2020/2/26.
//  Copyright © 2020 hautu. All rights reserved.
//

import Foundation

//解决了Use of unresolved identifier 'DataError' 报错问题
struct DataError {
    static var cantParseJSON: Error = NSError.init(domain: "fail,cantParseJSON", code: 400, userInfo: nil)
}

