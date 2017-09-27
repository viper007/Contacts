//
//  LVdasdada.swift
//  Conact
//
//  Created by 满艺网 on 2017/9/27.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit
import Contacts

enum ContactType : Int {
    case all          //全部联系人
    case name        //根据名字查找 
}

class LVContactStore {
    // MARK: - 单例
    static let sharedInstance = LVContactStore()
    
    // MARK: - 所有属性
    
    fileprivate var store = CNContactStore()
    
    // MARK: - 属性
    
    // MArK: - 查找联系人
    /*
     *   type: 
     */
    func findContacts(with identifiers:String ,findType type:ContactType) -> [CNContact] {
        
        var result = [CNContact]()
        //
        let request = CNContactFetchRequest.init(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactOrganizationNameKey as CNKeyDescriptor,
                                                               CNContactPhoneNumbersKey as CNKeyDescriptor])
        switch type {
        case .name:
            request.predicate = CNContact.predicateForContacts(matchingName: identifiers)
        case .all: break
        }
        //
        do {
            try self.store.enumerateContacts(with: request) { (contact, status) -> Void in
                result.append(contact)
            }
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
        
        print("\(result)")
        return result
    }
}
