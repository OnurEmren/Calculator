//
//  NumberButtons.swift
//  Calculator
//
//  Created by Severus Snape on 16.05.2023.
//

import Foundation
import UIKit

class NumberButtons : UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNumberButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNumberButtons()
    }
    
    private func setupNumberButtons(){
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.layer.cornerRadius = self.frame.width / 2
        self.backgroundColor = .systemGray
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
    }
}
