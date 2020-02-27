//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by LongMa on 2020/2/26.
//  Copyright © 2020 hautu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testRx()
    }
    
    func testRx()  {
//        testSingle()
//        testAsynSub()
        
//        //同RACSubject
//        testPublishSub()
       
//        //同RACReplaySubject
//        testReplaySub()
        
        //当观察者对 BehaviorSubject 进行订阅时，它会将源 Observable 中最新的元素发送出来（如果不存在最新的元素，就发出默认元素）。然后将随后产生的元素发送出来
        //类似：replay()(bufferSize: 1) + 一手订阅者接默认值
        testBehaviorSub()
    }
    
    func testBehaviorSub(){
           let lS = BehaviorSubject<String>(value: "defalut")
           
           lS.subscribe(onNext: { (str) in
               print("sub1:" + "\(str)")
           }, onError: { (err) in
               print(err)
           }, onCompleted: {
               print("sub1 complete")
           })
               .disposed(by: disposeBag)
           
           //1
           lS.onNext("0")
           lS.onNext("1")
           
           //2
           let test = false
           if test {
               lS.onError(DataError.someErr)
               lS.onNext("6")
           }
           
           lS.subscribe(onNext: { (str) in
               print("sub2:" + "\(str)")
           }, onError: { (err) in
               print(err)
           }, onCompleted: {
               print("sub2 complete")
           })
               .disposed(by: disposeBag)
           
           lS.onNext("2")
           lS.onCompleted()
       }
    
      func testReplaySub(){
        let lS = ReplaySubject<String>.create(bufferSize: 1)
        
        lS.subscribe(onNext: { (str) in
            print("sub1:" + "\(str)")
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("sub1 complete")
        })
            .disposed(by: disposeBag)
        
        //1
        lS.onNext("0")
        lS.onNext("1")
        
        //2
        let test = false
        if test {
            lS.onError(DataError.someErr)
            lS.onNext("6")
        }
        
        lS.subscribe(onNext: { (str) in
            print("sub2:" + "\(str)")
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("sub2 complete")
        })
            .disposed(by: disposeBag)
        
        lS.onNext("2")
        lS.onCompleted()
        
        
    }
    
     func testPublishSub(){
            let lS = PublishSubject<String>()
            
            lS.subscribe(onNext: { (str) in
                print("sub1:" + "\(str)")
            }, onError: { (err) in
                print(err)
            }, onCompleted: {
                print("sub1 complete")
            })
            .disposed(by: disposeBag)
            
            //1
            lS.onNext("0")
            lS.onNext("1")
        
          //2
            let test = true
            if test {
                 lS.onError(DataError.someErr)
                 lS.onNext("6")
            }

            lS.subscribe(onNext: { (str) in
                print("sub2:" + "\(str)")
            }, onError: { (err) in
                print(err)
            }, onCompleted: {
                print("sub2 complete")
            })
            .disposed(by: disposeBag)
            
            lS.onNext("2")
            lS.onCompleted()
            
   
        }
    
    func testAsynSub(){
        let lS = AsyncSubject<String>()
        
        lS.subscribe(onNext: { (str) in
            print(str)
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("complete")
        })
        .disposed(by: disposeBag)
        
        //1
        lS.onNext("0")
        lS.onNext("1")
        lS.onNext("2")
        lS.onCompleted()
        
//        //2
//        lS.onNext("0")
//        lS.onNext("1")
//        lS.onError(DataError.someErr)
//
//        //3
//        lS.onCompleted()
    }
    
    func testSingle() -> Void {
        getRepo("ReactiveX/RxSwift")
        .subscribe(onSuccess: { json in
            print("JSON: ", json)
        }, onError: { error in
            print("Error: ", error)
        })
        .disposed(by: disposeBag)
    }
    
    func getRepo(_ repo: String) -> Single<[String: Any]> {

        return Single<[String: Any]>.create { single in
            let url = URL(string: "https://api.github.com/repos/\(repo)")!
            let task = URLSession.shared.dataTask(with: url) {
                data, _, error in

                if let error = error {
//                    single(.error(DataError.cantParseJSON))
                    single(.error(error))
                    return
                }

                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                      let result = json as? [String: Any] else {
                    single(.error(DataError.cantParseJSON))
                    return
                }

                single(.success(result))
            }

            task.resume()

            return Disposables.create { task.cancel() }
        }
    }


}

