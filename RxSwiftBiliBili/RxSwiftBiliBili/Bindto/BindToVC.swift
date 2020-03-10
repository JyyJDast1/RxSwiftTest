//
//  BindToVC.swift
//  RxSwiftBiliBili
//
//  Created by LongMa on 2020/3/6.
//  Copyright © 2020 hautu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BindToVC: UIViewController {
    
    
    @IBOutlet weak var textLbl: UILabel!
    
    let ylDisBag = DisposeBag()
    let gObserable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //The print() function is actually variadic, so you can pass it more than one parameter and it will print them all, like this:
//        print(1,"2", 3, 4)
        
//        testAnyOberver()
        testBinder()
    }
    
    deinit {
        print("dead")
    }
    
    func testAnyOberver(){
        let lObserver = AnyObserver<String>.init {[weak self] (event) in
            switch event{
            case .next(let text):
//                print(text)
                self?.textLbl.text = text
            case .error(let err):
                print(err)
            //                case .completed:
            default:
                return
            }
        }
        
        gObserable
        .map { "计数器:\($0)"}
        .bind(to: lObserver)
        .disposed(by: ylDisBag)
    }
    
    func testBinder(){
        let lBinder = Binder.init(self.textLbl) { (lbl, text) in
            lbl.text = text;
        }
        
        gObserable.map { (num) -> String in
            return "counter:\(num)"
        }.bind(to: lBinder)
        .disposed(by: ylDisBag)
    }
}
