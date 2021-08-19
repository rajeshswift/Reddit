//
//  CustomButtom.swift
//  Reddit
//
//  Created by Rajesh Bandarupalli on 08/18/21.
//

import UIKit

class CustomButtom: UIButton {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - titleRect.width
        return titleRect.offsetBy(dx: round(availableWidth / 2), dy: 0)
    }
}
