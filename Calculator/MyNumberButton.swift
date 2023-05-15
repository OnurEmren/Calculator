//
//  MyNumberButton.swift
//  Calculator
//
//  Created by Severus Snape on 9.05.2023.
//

import Foundation
import UIKit

class MyNumberButton : UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(){
        backgroundColor = UIColor.systemGray
        setTitleColor(UIColor.white, for: .normal)
        layer.cornerRadius = 5
    }
}
