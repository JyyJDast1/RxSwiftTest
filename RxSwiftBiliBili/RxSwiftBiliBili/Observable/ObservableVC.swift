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

enum YLError:Error{
    case someErr(String)
    case netErr
}

class ObservableVC: UIViewController {
    
    let ylDisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testObserver()
    }
    
    //13种操作符
    //基本：creat, just, of, from, range, generate, repeat
    //时间相关：deferred, interval, timer
    //特殊：error, never, empty
    func testObserver(){
        let obs0 = Observable.of("1", "2", "3")
        obs0.subscribe(onNext: { (str) in
            print("obs0:" + str)
        }).disposed(by: ylDisposeBag)
        
        obs0.subscribe(onNext: { (str) in
            print("obs0_1:" + str)
        }).disposed(by: ylDisposeBag)
        
        let obs1 = Observable.from(["1", "2", "3"])
        obs1.subscribe(onNext: { (str) in
            print("obs1:" + str)
        }).disposed(by: ylDisposeBag)
        
        let obs2 = Observable.range(start: 1, count: 5)
        obs2.subscribe(onNext: { (num) in
            print("obs2:" + "\(num)")
        }).disposed(by: ylDisposeBag)
        
        let obsGnrt = Observable.generate(initialState: 1, condition: { $0 < 10
        }) { (b) -> Float in
            b + 2
        }
        obsGnrt.subscribe(onNext: { (num) in
            print("obsGnrt:" + "\(num)")
        }).disposed(by: ylDisposeBag)
        
        
        //1秒n次发送！！！
        //        let obs3 = Observable.repeatElement("repeating")
        //        obs3.subscribe(onNext: { (num) in
        //            print("obs3:" + "\(num)")
        //        })
        
        
        let obsErr = Observable<Any>.error(YLError.someErr("obs sended err"))
        obsErr.subscribe(onNext: { (next) in
            print("next:" + next)
            } as? ((Any) -> Void),
                         onError: {
                            err in
                            print(err)
        }).disposed(by: ylDisposeBag)
        
        //creat
        let obsCreat = Observable<String>.create { (subsribe) -> Disposable in
            subsribe.onNext("obsCreat0")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                subsribe.onNext("obsCreat1")
                subsribe.onCompleted()
            }
            
            return Disposables.create {
            }
        }
        
        let lDisp =
            obsCreat.subscribe(onNext:{
                str in
                print(str)
            })
        //            .disposed(by: ylDisposeBag)
        
        //手动取消订阅时：1.lDisp不能加自动丢弃包 2.因取消订阅，被订阅闭包中延迟发送的消息不再被接收。故无相关log
        lDisp.dispose()
        
        //deferred, 工厂模式：直到订阅发生，才创建 Observable，并且为每位订阅者创建全新的 Observable
        var lIsOdd = true
        let obser11 = Observable.deferred { () -> Observable<Int> in
            lIsOdd = !lIsOdd
            if lIsOdd{
                return Observable.of(1, 3, 5, 7)
            }else{
                return Observable.of(2, 4, 6, 8)
            }
        }
        
        obser11.subscribe({event in
            print(event)
        }).disposed(by: ylDisposeBag)
        obser11.subscribe({event in
            print(event)
        }).disposed(by: ylDisposeBag)
        
        //interval,每隔x秒，发送从0开始不停+1递增的数字
        let obs12 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.init())
        obs12.subscribe({
            event in
            print(event)
        }).disposed(by: ylDisposeBag)
        
        //timer
        let obs13 = Observable<Int>.timer(.seconds(1), scheduler: MainScheduler())
        obs13.subscribe({
            eve in
            print("obs13:" + "\(eve)")
        }).disposed(by: ylDisposeBag)
        
        //参数必须用DispatchTimeInterval类型包装！否则会有警告。
        let obs13_1 = Observable<Int>.timer(.seconds(3), period: .seconds(1), scheduler: MainScheduler())
        obs13_1.subscribe({
            eve in
            print("obs13_1:" + "\(eve)")
        }).disposed(by: ylDisposeBag)
        
    }
}
