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
    func findContacts(with identifiers:String ,findType type:ContactType) -> [AddressBookModel] {
        
//        let status = checkContactuthorization()
//        if status == false {
//            return []
//        }
        var result = [AddressBookModel]()
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
                //在这里需要去中文转换拼音
                let pinyin : String = self.formatChinese(with: contact.familyName)
                let abModel = AddressBookModel()
                abModel.name = contact.familyName
                abModel.chinese = pinyin
                abModel.phone = contact.phoneNumbers.first?.value.stringValue
                result.append(abModel)
            }
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
        print("\(result)")
        return result
    }
    
    // MARK: - 检查访问通讯录的权限
    func checkContactuthorization() -> Bool {
        let status : CNAuthorizationStatus  = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        switch status {
        case .authorized:do{
             return true
            }
        case .denied:
            let result  = UIApplication.shared.canOpenURL(NSURL.init(string: UIApplicationOpenSettingsURLString)! as URL)
            if result {
                UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: { (stop) in
                     return stop
                })
            }
        default:do {}
        }
        return false
    }
    
    //
    func formatChinese(with chinese:String) -> String {
        let outputFormat = HanyuPinyinOutputFormat()
        outputFormat?.toneType = ToneTypeWithoutTone
        outputFormat?.vCharType = VCharTypeWithV
        outputFormat?.caseType = CaseTypeUppercase
        return PinyinHelper.toHanyuPinyinString(with: chinese, with: outputFormat, with: "-")
    }
}
