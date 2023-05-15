//
//  ViewController.swift
//  Calculator
//
//  Created by Severus Snape on 8.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let calculateViewModel = CalculateViewModel()
    var pointButton = MyButton()
    var buttonsStackView: UIStackView!
    var trailingConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    
    var total: Double = 0.0
    var operation : Int? = 0
    var firstNumber : Double = 0.0
    var nextNumber : Double = 0.0
    
    var isMath : Bool = false
    var isMathResult : Bool = true
    
    var currentNumber: String = ""
    var label: MyLabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        //getNumberButton()
        getNumberButtons()
        getOperationsButtons()
    }
    
    //MARK: - Number Buttons' frames and methods
    
    func getNumberButtons(){
        
        let labelFrame = CGRect(x: 30, y: 80, width: 330, height: 150)
        label = MyLabel(frame: labelFrame, text: "0", labelColor: .black, fontSize: 40.0)
        view.addSubview(label)
        
        let buttonSize: CGFloat = 80.0
        let buttonSpacing: CGFloat = 10.0
        
        for i in 0...9 {
            let buttonWidth: CGFloat
            let buttonHeight: CGFloat
            if i == 0 {
                buttonWidth = 160
                buttonHeight = 80
            } else {
                buttonWidth = 80
                buttonHeight = 80
            }
            
            let numberButton = UIButton(type: .system)
            numberButton.setTitle("\(i)", for: .normal)
            numberButton.backgroundColor = .systemGray
            numberButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            numberButton.setTitleColor(UIColor.white, for: .normal)
            numberButton.tag = i
            numberButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

            if i == 0 {
                numberButton.frame = CGRect(x: 30, y: 690, width: 170, height: 80)
                numberButton.layer.cornerRadius = 30
                
            } else {
                numberButton.frame = CGRect(x: 30 + ((i - 1) % 3) * 90, y: 600 - ((i - 1) / 3) * 90, width: Int(buttonWidth), height: Int(buttonHeight))
                numberButton.layer.cornerRadius = numberButton.frame.width/2
                
            }
            
            view.addSubview(numberButton)
        }
        
        
    }
    
    
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        
        guard let buttonText = sender.title(for: .normal) else {
            return
        }
        
        if isMathResult {
            label.text = buttonText
            isMathResult = false
        } else {
            if label.text == "0" || isMath {
                label.text = buttonText
                isMath = false
            } else {
                label.text?.append(buttonText)
            }
        }
        
        if let labelText = label.text, let number = Double(labelText) {
            nextNumber = number
        } else {
            nextNumber = 0
        }
        
        pointButton.isEnabled = true
        
    }
    
    //MARK: - Operations and operations' Buttons.
    
    private func getOperationsButtons(){
        
        horizontalButtonSettings()
        verticalButtonsSettings()
        
        
        //Point Button
        pointButton = MyButton(frame: CGRect(x: 210, y: 690, width: 80, height: 80))
        pointButton.setTitle(".", for: .normal)
        pointButton.backgroundColor = .systemGray
        pointButton.addTarget(self, action: #selector(dotButtonTapped), for: .touchUpInside)
        pointButton.tag = 10
        view.addSubview(pointButton)
        
        
    }
    
    //MARK: - Number Buttons Settings


   
    //MARK: - Horizontal Button Settings
    
    private func horizontalButtonSettings(){
        var operationsButtons: [MyButton] = []
        
        let horizontalButtons: [(title: String, tag: Int)] = [
            ("AC", 11),
            ("%", 12),
            ("/", 13),
            ("+/-", 18)
            
            // Diğer butonlar için gerekli değerleri ekleyin
        ]
        
        let buttonWidthRatio: CGFloat = 0.2
        let screenWidth = UIScreen.main.bounds.width
        let buttonSize = screenWidth * buttonWidthRatio
        let buttonSpacing: CGFloat = 10.0
        let firstStackView = UIStackView()
        
        firstStackView.axis = .horizontal
        firstStackView.alignment = .fill
        firstStackView.spacing = buttonSpacing
        firstStackView.distribution = .equalSpacing
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstStackView)
        
        let horizontalCenterXConstraint = firstStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let horizontalCenterYConstraint = firstStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        horizontalCenterXConstraint.isActive = true
        horizontalCenterYConstraint.isActive = true

        
        let horizontalBottomConstraint: NSLayoutConstraint = {
            let buttonHeight: CGFloat = buttonSize
            let centerYOffset = (view.bounds.height - buttonHeight) * 1/8
            let constraint = firstStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -centerYOffset)
            return constraint
        }()
        horizontalBottomConstraint.isActive = true
        
        for buttonData in horizontalButtons {
            let button = MyButton()
            button.setTitle(buttonData.title, for: .normal)
            button.addTarget(self, action: #selector(operationsButtonTapped), for: .touchUpInside)
            button.tag = buttonData.tag
            button.translatesAutoresizingMaskIntoConstraints = false
            operationsButtons.append(button)
            firstStackView.addArrangedSubview(button)
            
            button.heightAnchor.constraint(equalToConstant: 80).isActive = true
            button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
            button.layer.cornerRadius = 40
        }
    }
    
    //MARK: - Vertical Button Settings
    
    private func verticalButtonsSettings(){
        var operationsButtons: [MyButton] = []
        let verticalButtons: [(title: String, tag: Int)] = [
            ("X", 14),
            ("-", 15),
            ("+", 16),
            ("=", 17)
        ]
        
        let buttonWidthRatio: CGFloat = 0.2
        let screenWidth = UIScreen.main.bounds.width
        let buttonSize = screenWidth * buttonWidthRatio
        let buttonSpacing: CGFloat = 10.0
        let verticalStackView = UIStackView()
        
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = buttonSpacing
        verticalStackView.distribution = .equalSpacing
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStackView)
        
        
        let verticalBottomConstraint: NSLayoutConstraint = {
            let buttonHeight: CGFloat = 80.0
            let trailingOffset = (view.bounds.width - buttonHeight) * 1/256
            let bottomOffset = (view.bounds.height - buttonHeight) * 1/24
            let verticalCenterXConstraint = verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 150)
            let verticalBottomConstraint = verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85)
            verticalCenterXConstraint.isActive = true
            verticalBottomConstraint.isActive = true

          

            return verticalBottomConstraint
        }()
        verticalBottomConstraint.isActive = true
        
        for buttonData in verticalButtons {
            let button = MyButton()
            button.setTitle(buttonData.title, for: .normal)
            button.addTarget(self, action: #selector(operationsButtonTapped), for: .touchUpInside)
            button.tag = buttonData.tag
            button.translatesAutoresizingMaskIntoConstraints = false
            operationsButtons.append(button)
            verticalStackView.addArrangedSubview(button)

            button.layer.cornerRadius = 40
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true

        }
    }
    
    @objc
    private func dotButtonTapped(_ sender: UIButton){
        guard let labelText = label.text else {
            return
        }
        
        if labelText.contains(".") || isMath {
            return
        }
        
        label.text?.append(".")
    }
    
    
    
    @objc
    private func operationsButtonTapped(_ sender: UIButton){
        
        if label.text != "" && sender.tag != 11 && sender.tag != 17{
            firstNumber = Double(label.text!)!
            if sender.tag == 12 {
                label.text = String(firstNumber) + "%"
            } else if sender.tag == 13 {
                label.text = String(firstNumber) + "/"
            } else if sender.tag == 14 {
                label.text = String(firstNumber) + "x"
            } else if sender.tag == 15 {
                label.text = String(firstNumber) + "-"
            } else if sender.tag == 16 {
                label.text = String(firstNumber) + "+"
            }
            operation = sender.tag
            isMath = true
            
        } else if sender.tag == 11 {
            clearCalculate()
            
        } else if sender.tag == 17 {
            
            // Clear before new operation start
            if let currentNumber = Double(label.text ?? "") {
                total = currentNumber
            }
            isMathResult = true
            
            if operation == 12 {
                label.text = String(firstNumber/100)
                
            } else if operation == 13 {
                label.text = String(calculateViewModel.divide(firstNumber, nextNumber))
                animateLabel()
            } else if operation == 14 {
                label.text = String(calculateViewModel.multiply(firstNumber, nextNumber))
                animateLabel()
            } else if operation == 15 {
                label.text = String(calculateViewModel.minus(firstNumber,nextNumber))
                animateLabel()
            } else if operation == 16 {
                label.text = String(calculateViewModel.add(firstNumber, nextNumber))
                animateLabel()
            } else if operation == 18 {
                label.text = String("")
            }
        }
    }
    
    private func clearCalculate(){
        firstNumber = 0
        nextNumber = 0
        operation = 0
        label.text = "0"
    }
    
    private func animateLabel() {
        UIView.animate(withDuration: 0.3, animations: {
            self.label.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (completed) in
            UIView.animate(withDuration: 0.3) {
                self.label.transform = CGAffineTransform.identity
            }
        }
    }
}










