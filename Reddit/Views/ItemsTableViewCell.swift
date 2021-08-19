//
//  ItemsTableViewCell.swift
//  Reddit
//
//  Created by Rajesh Bandarupalli on 08/18/21.
//

import UIKit
import SDWebImage

class ItemsTableViewCell: UITableViewCell {

    static var identifer = "ItemsTableViewCell"
    
    var itemTitle:UILabel = UILabel()
    var itemImageView:UIImageView = UIImageView()
        
    var buttonsBgView = UIView()
    var scoreButton:CustomButtom = CustomButtom(type: .custom)
    var messageCountButton:CustomButtom = CustomButtom(type: .custom)
    var shareButton:CustomButtom = CustomButtom(type: .custom)
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        
    }
    fileprivate func configureView()  {
        self.contentView.addSubview(itemTitle)
        itemTitle.numberOfLines = 0
        itemTitle.font = UIFont.boldSystemFont(ofSize: 16)
    
        self.contentView.addSubview(itemImageView)
        self.contentView.addSubview(buttonsBgView)

        itemTitle.anchor(top: self.contentView.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: self.contentView.leadingAnchor, paddingLeft: 20, right: self.contentView.trailingAnchor, paddingRight: 20, centerX: nil, centerY: nil, width: 0, height: 0)
        itemTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        itemImageView.anchor(top: itemTitle.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: self.contentView.leadingAnchor, paddingLeft: 20, right: self.contentView.trailingAnchor, paddingRight: 20, centerX: nil, centerY: nil, width: 0, height: 0)
        itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor, multiplier: 1.0/2.0).isActive = true
        itemImageView.layer.cornerRadius = 6
        itemImageView.layer.masksToBounds = true
        
        
        buttonsBgView.anchor(top: itemImageView.bottomAnchor, paddingTop: 10, bottom: self.contentView.bottomAnchor, paddingBottom: 10, left: itemImageView.leadingAnchor, paddingLeft: 0, right: itemImageView.trailingAnchor, paddingRight: 0, centerX: nil, centerY: nil, width: 0, height: 40)
        
        buttonsBgView.addSubview(scoreButton)
        scoreButton.anchor(top: buttonsBgView.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: buttonsBgView.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, centerX: nil, centerY: nil, width: 80, height: 40)

        buttonsBgView.addSubview(messageCountButton)
        
        messageCountButton.anchor(top: buttonsBgView.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: scoreButton.trailingAnchor, paddingLeft: 20, right: nil, paddingRight: 0, centerX: nil, centerY: nil, width: 70, height: 40)

        buttonsBgView.addSubview(shareButton)
        shareButton.anchor(top: buttonsBgView.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: buttonsBgView.trailingAnchor, paddingRight: 0, centerX: nil, centerY: nil, width: 80, height: 40)

        scoreButton.setImage(UIImage(named: "uparrow"), for: .normal)

        messageCountButton.setImage(UIImage(named: "messages"), for: .normal)

        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.addTarget(self, action: #selector(shareContent), for: .touchUpInside)
        shareButton.setTitle("Share", for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(child:Child) {
        
        itemTitle.text = child.data?.title
        print("Title:\(child.data?.title)")
        itemImageView.sd_setImage(with: URL(string: child.data?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        
        scoreButton.setTitle("\(child.data?.score ?? 0)", for: .normal)
        messageCountButton.setTitle("\(child.data?.numComments ?? 0)", for: .normal)

        /*if child.data?.thumbnailWidth ?? 0 > child.data?.thumbnailHeight ?? 0 {
            itemImageView.contentMode = .scaleAspectFit
        } else {
            itemImageView.contentMode = .scaleAspectFill
        }*/
        
    }
    @objc func shareContent() {
        let ac = UIActivityViewController(activityItems: [itemTitle.text ?? ""], applicationActivities: nil)
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(ac, animated: true, completion: nil)
        }
    }
}
