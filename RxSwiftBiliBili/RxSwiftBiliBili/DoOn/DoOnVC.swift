//
//  DoOnVC.swift
//  RxSwiftBiliBili
//
//  Created by LongMa on 2020/3/6.
//  Copyright © 2020 hautu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DoOnVC: UIViewController {
    
    let ylDisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test()
    }
    
    deinit {
        //todo:why not come in?
        print("deinit")
    }
    
    
    /*
     警告：doOn要想生效，后面必须连写.subscribe！！！不能分开对同一个数据源对象进行订阅
     log:
     onSubscribe
     onSubscribed
     onNext 1
     1
     afterNext 1
     onNext 2
     2
     afterNext 2
     onNext 3
     3
     afterNext 3
     onCompleted
     completed
     disposed
     afterCompleted
     onDispose

     */
    func test() {
        let obs0 = Observable.of(1,2,3)
        
        _ = obs0.do(onNext: { (some) in
            print("onNext",some)
        }, afterNext: { (some) in
            print("afterNext",some)
        }, onError: { (err) in
            print("onError",err)
        }, afterError: { (err) in
            print("afterError",err)
        }, onCompleted: {
            print("onCompleted")
        }, afterCompleted: {
            print("afterCompleted")
        }, onSubscribe: {
            print("onSubscribe")
        }, onSubscribed: {
            print("onSubscribed")
        }, onDispose: {
            print("onDispose")
        })
        .subscribe(onNext: {
            obj in
            print(obj)
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("completed")
        }) {

            print("disposed")
        }.disposed(by: ylDisposeBag)
    }
}
