//
//  PeopleVC.swift
//  RxSwiftBiliBili
//
//  Created by LongMa on 2020/3/3.
//  Copyright © 2020 hautu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class PeopleVC: UIViewController  {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
    }
    
    func addSubView() {
        let lView = PeopleView.viewFromXib()
        print(lView)
        
        view.addSubview(lView)
        lView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
