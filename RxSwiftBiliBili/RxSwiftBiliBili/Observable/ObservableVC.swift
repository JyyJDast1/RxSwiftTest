//
//  ObservableVC.swift
//  RxSwiftBiliBili
//
//  Created by LongMa on 2020/3/4.
//  Copyright © 2020 hautu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ObservableVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testObserver()
    }
    
    func testObserver(){
        let obs0 = Observable.of("1", "2", "3")
        _ = obs0.subscribe(onNext: { (str) in
            print("obs0:" + str)
        })
        
        let obs1 = Observable.from(["1", "2", "3"])
        _ = obs1.subscribe(onNext: { (str) in
            print("obs1:" + str)
        })
        
        let obs2 = Observable.range(start: 1, count: 5)
        _ = obs2.subscribe(onNext: { (num) in
            print("obs2:" + "\(num)")
        })
        
        
        //1秒n次发送！！！
//        let obs3 = Observable.repeatElement("repeating")
//        _ = obs3.subscribe(onNext: { (num) in
//            print("obs3:" + "\(num)")
//        })
    }
}
