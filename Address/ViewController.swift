// Info.plist 添加NSContactsUsageDescription
//Contact
//尝试着写swift代码
import UIKit
import ContactsUI

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
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
            //
            data = result
        }
    }
    // MARK: - init UI
    func setupBaseInfo() {
        tableView.backgroundColor = UIColor.gray
        tableView.dataSource = self
        tableView.delegate = self
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
        let cell : ContactCell = ContactCell.cellWith(tableView: tableView)
        let model : AddressBookModel = data[indexPath.row]
        cell.textLabel?.text = model.name+"---"+"\(model.chinese)"
        cell.detailTextLabel?.text = model.phone
        return cell
    }
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("\(indexPath.section)"+"---"+"\(indexPath.row)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

