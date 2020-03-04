//
//  PeopleViewModel.swift
//  RxSwiftBiliBili
//
//  Created by LongMa on 2020/3/3.
//  Copyright © 2020 hautu. All rights reserved.
//

import Foundation
import RxSwift

struct PeopleViewModel {

    let data = Observable.just(
        [People(name: "name0", age: 10)
        ,People(name: "name1", age: 11)
        ,People(name: "name2", age: 12)
        ,People(name: "name3", age: 13)
    ])
}
