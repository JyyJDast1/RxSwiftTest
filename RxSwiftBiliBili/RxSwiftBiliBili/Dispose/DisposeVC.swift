//
//  DisposeVC.swift
//  RxSwiftBiliBili
//
//  Created by LongMa on 2020/3/6.
//  Copyright © 2020 hautu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DisposeVC: UIViewController {
    
    let ylDisBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test()
    }
    
    func test(){
        let obs = Observable.of(1, 2, 3)
        
        let res = obs.subscribe(onNext: {
            obj in
            print(obj)
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }
        
        //销毁方法一：
//        res.dispose()
        
        //销毁方法二：
        res.disposed(by: ylDisBag)
    }
}
