//
//  ExtensionVC.swift
//  RxSwiftBiliBili
//
//  Created by LongMa on 2020/3/10.
//  Copyright © 2020 hautu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ExtensionVC: UIViewController {
    
    @IBOutlet weak var gLbl: UILabel!
    let ylDisbag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }
    
    func test() {
        
        let lSig = Observable<Int>.interval(.milliseconds(500), scheduler: MainScheduler.init())
        
        lSig.map{
            CGFloat($0)
        }
            //        .bind(to: self.gLbl.fontSize)
            .bind(to: self.gLbl.rx.fontSize)
            .disposed(by: ylDisbag)
        
        //Rx自带text
        lSig.map{
            "\($0)"
        }
        .bind(to: self.gLbl.rx.text)
        .disposed(by: ylDisbag)
        
    }
    
    deinit{
        print("vc dead")
    }
}

extension UILabel{
    public var fontSize:Binder<CGFloat>{
        return Binder.init(self) { (lbl, size) in
            lbl.font = UIFont.systemFont(ofSize: size)
        }
    }
}

//推荐使用
extension Reactive where Base: UILabel{
    public var fontSize:Binder<CGFloat>{
        return Binder.init(self.base) { (lbl, size) in
            lbl.font = UIFont.systemFont(ofSize: size)
        }
    }
}



