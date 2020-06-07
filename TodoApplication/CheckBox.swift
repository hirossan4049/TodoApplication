//
//  CheckBox.swift
//  TodoApplication
//
//  Created by linear on 2020/03/26.
//  Copyright © 2020 linear. All rights reserved.
//

import UIKit


class CheckBox:UIButton{

    let checkedImage = UIImage(named: "checkBoxCheck")! as UIImage
    let uncheckedImage = UIImage(named: "checkBoxUnCheck")! as UIImage

    var isChecked: Bool = false {
        didSet {
            if isChecked {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton){
        if sender == self{
            isChecked = !isChecked
        }
    }
    
    @objc func change_checkbox(check: Bool){
        print("CHECKED!!!!!",check)
        isChecked = check

    }
    
}
