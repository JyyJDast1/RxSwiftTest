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
        
        //无需初始值的Subject:类似直播
        //        testPublishSub()
        
        //需要初始值的Subject:订阅时可以收到订阅前上一次发送的消息（默认值底层也是消息，上一次无发送消息时，会收到默认值的消息）；
        //        testBehaviorSub()
        
        //如果源 Observable 因为产生了一个 error 事件而中止， BehaviorSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
        //        testBehaviorSubError()
        
        testReplaySub()
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
        let lSub = BehaviorSubject.init(value: 999)
        
        //        lSub.onNext(000)
        
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
         log:
         1st订阅: 999
         1st订阅: 111
         2st订阅: 111
         1st订阅: 222
         2st订阅: 222
         1st completed
         1st disposed
         2st completed
         2st disposed
         3st completed
         3st disposed
         */
    }
    
    func testBehaviorSubError(){
        let lSub = BehaviorSubject.init(value: 999)
        
        //        lSub.onNext(000)
        
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
        lSub.onError(YLError.someErr("test"))
        
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
        
        /*log:
         1st订阅: 999
         1st订阅: 111
         someErr("test")
         1st disposed
         someErr("test")
         2st disposed
         someErr("test")
         3st disposed
         */
    }
    
    func testReplaySub(){
        let lReSub = ReplaySubject<Int>.create(bufferSize: 2)
        
        lReSub.onNext(1)
        lReSub.onNext(2)
        lReSub.onNext(3)
        
        lReSub.subscribe { (event) in
            print("1st ",event)
        }.disposed(by: ylDisBag)
        
        lReSub.onNext(4)
        
        lReSub.subscribe { (event) in
            print("2st ",event)
        }.disposed(by: ylDisBag)
        
        lReSub.onCompleted()
        
        lReSub.subscribe { (event) in
            print("3st ",event)
        }.disposed(by: ylDisBag)
        
        /*log:
         1st  next(2)
         1st  next(3)
         1st  next(4)
         2st  next(3)
         2st  next(4)
         1st  completed
         2st  completed
         3st  next(3)
         3st  next(4)
         3st  completed
         */
    }
    deinit{
        print("vc dead")
    }
}
