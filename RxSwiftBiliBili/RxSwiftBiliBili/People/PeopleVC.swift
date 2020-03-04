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
import RxSwift
import RxCocoa

class PeopleVC: UIViewController  {
    
    @IBOutlet weak var tableV: UITableView!
    
    let peopleVM = PeopleViewModel()
    let disposebag = DisposeBag()
    let reuseCellID = "PeopleViewCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: reuseCellID)
        
        //不加main.async时，会报警告：[TableView] Warning once only: UITableView was told to layout its visible cells and other contents without being in the view hierarchy
        DispatchQueue.main.async {
            self.bindData()
        }
    }

    func bindData()  {
        
        _ = peopleVM.data
            .bind(to: tableV.rx.items(cellIdentifier: reuseCellID)){ (row, element, cell) in
                cell.textLabel?.text =  "\(row)" + ":" + element.name
                
                //detailTextLabel不显示，因为register的是系统cell，默认没有detailTextLabel。如果需要显示，必须自定义cell。（想不registerCell？会导致程序崩溃！）
                cell.detailTextLabel?.text = "\(element.age)" + "岁"
        }
        .disposed(by: disposebag)
         
    }
}
