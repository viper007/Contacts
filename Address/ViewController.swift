// Info.plist 添加NSContactsUsageDescription
//Contact
//尝试着写swift代码
import UIKit
import ContactsUI

class ViewController: UIViewController,UITableViewDataSource {
    
    // MARK: - 属性
    fileprivate var store = CNContactStore()
    
    var tableView : UITableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style:UITableViewStyle.plain)
    
    var data = [AddressBookModel](){
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseInfo()
        //这个只是简单的获取联系人
        let result = LVContactStore.sharedInstance.findContacts(with: "bell",findType: .all)
        if result.count > 0 {
            data = result
        }
    }
    
    func setupBaseInfo() {
        tableView.backgroundColor = UIColor.gray
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
    }
    
    // MARK: - UITableDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
            cell?.textLabel?.numberOfLines = 0
        }
        let model : AddressBookModel = data[indexPath.row]
        cell?.textLabel?.text = "\(String(describing: model.name))" + "\(model.chinese)"
        cell?.detailTextLabel?.text = model.phone
        return cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

