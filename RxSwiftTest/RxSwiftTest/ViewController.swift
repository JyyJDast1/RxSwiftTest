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

