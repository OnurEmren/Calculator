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
        self.addSubview(resultLabel)
        addConstrains()
        setupButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
        addConstrains()
    }
    
    private let operationsButtons : UIButton = {
        let button = UIButton()
        let buttonWidthRatio: CGFloat = 0.2
        let screenWidth = UIScreen.main.bounds.width
        let buttonSize = screenWidth * buttonWidthRatio
        let buttonSpacing: CGFloat = 10.0
        
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true

        return button
    }()
    
    private func setupButton() {
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.layer.cornerRadius = self.frame.width / 2
        self.backgroundColor = .systemOrange
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        
     

    }
    
    private let resultLabel : UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(
            ofSize: 20,
            weight: .medium
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func addConstrains(){
        NSLayoutConstraint.activate([
            resultLabel.heightAnchor.constraint(equalToConstant: 40),
            resultLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7),
            resultLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -7),
            resultLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
            
        ])
    }
   
}
    
    


