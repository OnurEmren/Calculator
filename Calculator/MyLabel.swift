//
//  MyLabel.swift
//  Calculator
//
//  Created by Severus Snape on 9.05.2023.
//

import Foundation
import UIKit

class MyLabel : UILabel{
    
    private var labelColor: UIColor
       
       init(frame: CGRect, text: String, labelColor: UIColor, fontSize: CGFloat) {
           self.labelColor = labelColor
           super.init(frame: frame)
           self.text = text
           self.textColor = .white // label rengi ayarlanıyor
           self.backgroundColor = .black
           self.font = UIFont.systemFont(ofSize: fontSize)
           self.textAlignment = .right
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       func setLabelText(_ text: String) {
           self.text = text
       }
       
    
}
