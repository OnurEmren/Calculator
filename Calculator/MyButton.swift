//
//  NumberButton.swift
//  Calculator
//
//  Created by Severus Snape on 9.05.2023.
//


import UIKit

class MyButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupOperationButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupOperationButton()
       
    }
    
    private func setupOperationButton() {
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.layer.cornerRadius = self.frame.width / 2
        self.backgroundColor = .systemOrange
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)

    }
    

   
}
    
    


