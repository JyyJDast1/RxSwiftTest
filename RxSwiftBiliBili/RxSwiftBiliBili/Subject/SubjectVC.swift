//
//  SubjectVC.swift
//  RxSwiftBiliBili
//
//  Created by LongMa on 2020/3/10.
//  Copyright © 2020 hautu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SubjectVC: UIViewController {
    let ylDisBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //无需初始值的Subject
        testPublishSub()
        
        //todo:需要初始值的Subject
        testBehaviorSub()
    }
    
    func testPublishSub() {
        let lSub = PublishSubject<Int>()
        lSub.onNext(000)
        
        lSub.subscribe(onNext: {
            obj in
            print("1st订阅:",obj)
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("1st completed")
        }) {
            print("1st disposed")
        }.disposed(by: ylDisBag)
        
        lSub.onNext(111)
        
        lSub.subscribe(onNext: {
            obj in
            print("2st订阅:",obj)
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("2st completed")
        }) {
            print("2st disposed")
        }.disposed(by: ylDisBag)
        
        lSub.onNext(222)
        
        lSub.onCompleted()
        
        lSub.subscribe(onNext: {
            obj in
            print("3st订阅:",obj)
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("3st completed")
        }) {
            print("3st disposed")
        }.disposed(by: ylDisBag)
        
        lSub.onNext(333)
        
        /*
         log(发送completed后再订阅，居然也会收到completed和disposed信息):
         1st订阅 111
         1st订阅 222
         2st订阅 222
         1st completed
         1st disposed
         2st completed
         2st disposed
         3st completed
         3st disposed
         */
    }
    
    func testBehaviorSub() {
          
    }
    
    deinit{
        print("vc dead")
    }
}
