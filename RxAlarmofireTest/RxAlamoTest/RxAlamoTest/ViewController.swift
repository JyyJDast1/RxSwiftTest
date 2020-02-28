//
//  ViewController.swift
//  RxAlamoTest
//
//  Created by LongMa on 2020/2/28.
//  Copyright © 2020 hautu. All rights reserved.
//

import UIKit


import RxAlamofire
import Alamofire
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let mnger = SessionManager.default
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(btn)
       _ = btn.rx.tap.asControlEvent()
            .subscribe { (eve) in
                self.downTest0()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }

    /*返回eg：
     {"channels":[{"name_en":"Personal Radio","seq_id":0,"abbr_en":"My","name":"私人兆赫","channel_id":0},{"name":"华语","seq_id":0,"abbr_en":"","channel_id":"1","name_en":""},{"name":"欧美","seq_id":1,"abbr_en":"","channel_id":"2","name_en":""}]}
     */
    func downTest0() {
     _ = mnger.rx
            .responseJSON(.get, "https://www.douban.com/j/app/radio/channels")
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {
//            (res) in
//            print(res)
            //$1 <=> res.1
            let lDic = $1 as? [String : Any]
            if let lD = lDic{
                let lArr = lD["channels"] as? Array<[String : Any]>
                if let lA = lArr{
                    print(lA)
                }
                print(lD["messagedfadfasf"] as? String ?? "defalut str" )
            }
           
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("complete")
        }, onDisposed: {
             print("disposed")
        })
    }
    
    
    lazy var btn:UIButton = {
        let lBtn = UIButton()
        lBtn.backgroundColor = .yellow
        lBtn.frame = CGRect.init(x: 100, y: 100, width: 100, height: 60)
        lBtn.setTitle("btn", for: .normal)
        return lBtn
    }()

}

