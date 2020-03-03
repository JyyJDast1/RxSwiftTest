//
//  PeopleVC.swift
//  RxSwiftBiliBili
//
//  Created by LongMa on 2020/3/3.
//  Copyright © 2020 hautu. All rights reserved.
//

import Foundation
import UIKit

class PeopleView: UITableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .orange
    }
    
  class func viewFromXib() -> PeopleView {
    let lV = Bundle.main.loadNibNamed(self.classForCoder().description(), owner: self, options: nil)?.last
        return lV as! PeopleView
    }
    
}
