//
//  ViewController.swift
//  RxSwiftBiliBili
//
//  Created by LongMa on 2020/3/3.
//  Copyright © 2020 hautu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct YLVCModel {
    let vcObj : UIViewController
    let vcName : String
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var dataArr : [YLVCModel] = {
        return [
             YLVCModel(vcObj: PeopleVC.init(), vcName: "tableView")
            ,YLVCModel(vcObj: ObservableVC.init(), vcName: "Observable")
             ,YLVCModel(vcObj: DoOnVC.init(), vcName: "DoOn")
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "首页"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
//        tableView(tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row].vcName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lVC = dataArr[indexPath.row].vcObj
      self.navigationController?.pushViewController(lVC, animated: true)
    }
    
}
