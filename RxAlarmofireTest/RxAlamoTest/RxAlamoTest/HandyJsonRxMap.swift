//
//  HandyJsonRxMap.swift
//  RxAlamoTest
//
//  Created by LongMa on 2020/3/2.
//  Copyright © 2020 hautu. All rights reserved.
//

import HandyJSON
import RxSwift

public enum RxMapModelError: Error {
    case parsingElementError
    case parsingEleArrayError
}

public extension Observable
//where Element:Any//似乎不需要
{

    /*转模型。注意：传进来的数据应该是json数据，不是response
        obser0.map({ (arg) -> Any in
                    let (_, json) = arg
                    print(json)
                    return json
                })
                .mapModel(type: MYMusicResM.self)
                ...
     */
    func mapModel<T>(type:T.Type) -> Observable<T> where T:HandyJSON {
        return self.map { (element) -> T in
            guard let parsedElement = T.deserialize(from: element as? Dictionary) else{
                throw RxMapModelError.parsingElementError
            }
            return parsedElement
        }
    }
    
    //转模型数组
    func mapModelArray<T>(type:T.Type) -> Observable<[T]> where T:HandyJSON {
        return self.map { (element) -> [T] in
            guard let parsedArray = [T].deserialize(from: element as? [Any]) else{
                throw RxMapModelError.parsingEleArrayError
            }
            return parsedArray as! [T]
        }
    }
}
