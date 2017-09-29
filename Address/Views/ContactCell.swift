//
//  ContactCell.swift
//  Address
//
//  Created by 满艺网 on 2017/9/29.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    static let cellIdentifier = "cell"
    
    // MARK: - 属性
    var nameLabel: UILabel?
    var timeLabel: UILabel?
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10/2
            newFrame.size.width -= 10
            newFrame.origin.y += 10
            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }
    
    // MARK: - 类方法
    class func cellWith(tableView:UITableView) -> ContactCell {
        let cell : ContactCell = ContactCell.init(style: .value1, reuseIdentifier: cellIdentifier)
        return cell
    }
    // MARK: - 初始化方法
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupBaseInfo()
        
    }
    
    //
    func setupBaseInfo() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
