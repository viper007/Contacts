//
//  ContactModel.swift
//  Conact
//
//  Created by 满艺网 on 2017/9/27.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

class ContactModel: NSObject {
    var name = String()
    var address = String()
    init(name:String , address:String ) {
        self.name = name
        self.address = address
    }
}
