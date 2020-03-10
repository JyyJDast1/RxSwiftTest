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
    var classType : UIViewController.Type?
    var title : String = "title"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var dataArr : [YLVCModel] = {
        return [
            YLVCModel(classType: PeopleVC.self, title: "tableV")
            ,YLVCModel(classType: ObservableVC.self, title: "Observable")
            ,YLVCModel(classType: DoOnVC.self, title: "DoOn")
            ,YLVCModel(classType: DisposeVC.self, title: "Dispose")
            ,YLVCModel(classType: BindToVC.self, title: "BindTo")
            ,YLVCModel(classType: ExtensionVC.self, title: "Extension")
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
//        cell.textLabel?.text = dataArr[indexPath.row].classType?.description()
        cell.textLabel?.text = dataArr[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lVCType = dataArr[indexPath.row].classType
        if let lVC = lVCType{
            let lVC = lVC.init()
            self.navigationController?.pushViewController(lVC, animated: true)
        }
    }
    
}
