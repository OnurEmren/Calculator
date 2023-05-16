//
//  ViewController.swift
//  Calculator
//
//  Created by Severus Snape on 8.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let calculateViewModel = CalculateViewModel()
    var total: Double = 0.0
    let buttonSpacing: CGFloat = 10.0
    var firstNumber = 0
    var resultNumber = 0
    var currentOperations: Operation?
    
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        getNumberButtons()
        
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 100)
        
        return label
    }()
    
    //MARK: - Number Buttons
    
    func getNumberButtons(){
        
        resultLabel.frame = CGRect(x: 20, y: 150, width: view.frame.size.width - 40, height: 100)
        
        view.addSubview(resultLabel)
        
        
        let buttonSize: CGFloat = view.frame.size.width / 4.8
        
        for i in 0...9 {
            
            let numberButton = NumberButtons(type: .system)
            numberButton.setTitle("\(i)", for: .normal)
            numberButton.backgroundColor = .systemGray
            numberButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            numberButton.setTitleColor(UIColor.white, for: .normal)
            numberButton.tag = i
            numberButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            
            if i == 0 {
                numberButton.frame = CGRect(
                    x: buttonSize/3,
                    y: view.frame.size.height-buttonSize-80,
                    width: buttonSize*3.2,
                    height: buttonSize)
                numberButton.layer.cornerRadius = 40
                numberButton.tag = 1
                numberButton.addTarget(self, action: #selector(zeroButtonTapped), for: .touchUpInside)
                
            } else {
                for x in 0..<3 {
                    let buttonX = buttonSize * (CGFloat(x) + 0.3) + CGFloat(x) * buttonSpacing
                    let buttonY = view.frame.size.height - (buttonSize * 3.1)
                    let button1 = NumberButtons(
                        frame: CGRect(x: buttonX,
                                      y: buttonY,
                                      width: buttonSize,
                                      height: buttonSize)
                    )
                    button1.setTitle("\(x+1)", for: .normal)
                    button1.tag = x+2
                    button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                    view.addSubview(button1)
                }
                
                for x in 0..<3 {
                    let buttonX = buttonSize * (CGFloat(x) + 0.3) + CGFloat(x) * buttonSpacing
                    let buttonY = view.frame.size.height - (buttonSize * 4.2)
                    let button2 = NumberButtons(
                        frame: CGRect(
                            x:buttonX,
                            y: buttonY,
                            width: buttonSize,
                            height: buttonSize)
                    )
                    button2.setTitle("\(x+4)", for: .normal)
                    button2.tag = x+5
                    button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                    view.addSubview(button2)
                }
                
                for x in 0..<3 {
                    let buttonX = buttonSize * (CGFloat(x) + 0.3) + CGFloat(x) * buttonSpacing
                    let buttonY = view.frame.size.height - (buttonSize * 5.3)
                    let button3 = NumberButtons(
                        frame: CGRect(
                            x: buttonX,
                            y: buttonY,
                            width: buttonSize,
                            height: buttonSize)
                    )
                    button3.setTitle("\(x+7)", for: .normal)
                    button3.tag = x+8
                    button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                    view.addSubview(button3)
                }
                
                let buttonX = buttonSize/3.5
                let clearButton = MyButton(
                    frame: CGRect(
                        x: buttonX,
                        y: view.frame.size.height-(buttonSize*6.4),
                        width: buttonSize,
                        height: buttonSize)
                )
                clearButton.setTitle("CA", for: .normal)
                clearButton.addTarget(self, action: #selector(clearCalculate), for: .touchUpInside)
                view.addSubview(clearButton)
                
                
                let operations = ["=","+", "-", "x", "/"]
                
                for x in 0..<5 {
                    let button4 = MyButton(
                        frame: CGRect(
                            x: buttonSize * 3.7,
                            y: view.frame.size.height-(buttonSize * CGFloat(x+2)) - (7.5 * CGFloat(x)) ,
                            width: buttonSize,
                            height: buttonSize)
                    )
                    button4.setTitle(operations[x], for: .normal)
                    button4.tag = x+1
                    button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
                    view.addSubview(button4)
                }
                
                let anotherOperations = ["+/-","%"]
                for x in 0..<2 {
                    let buttonX = buttonSize * (CGFloat(x) + 1.45) + CGFloat(x) * buttonSpacing
                    let button5 = MyButton(
                        frame: CGRect(
                            x: buttonX,
                            y: view.frame.size.height - (buttonSize * 6.4),
                            width: buttonSize,
                            height: buttonSize)
                    )
                    button5.setTitle(anotherOperations[x], for: .normal)
                    button5.tag = x+1
                    button5.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
                    view.addSubview(button5)
                }
                
                resultLabel.frame = CGRect(
                    x: 20,
                    y: clearButton.frame.origin.y - 110.0,
                    width: view.frame.size.width - 40,
                    height: 100
                )
                view.addSubview(resultLabel)
            }
            
            view.addSubview(numberButton)
        }
    }
    
    
    
    //MARK: - Operations and operations' Buttons.
    
    @objc
    private func operationPressed(_ sender: UIButton){
        let tag = sender.tag
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        
        //Equals Button
        if tag == 1 {
            if let operation = currentOperations {
                var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text) {
                    secondNumber = value
                }
                
                switch operation {
                case .add:
                    let result = calculateViewModel.add(firstNumber, secondNumber)
                    resultLabel.text = "\(result)"
                    break
                    
                case .subtract:
                    let result = calculateViewModel.minus(firstNumber, secondNumber)
                    resultLabel.text = "\(result)"
                    break
                    
                case .multiply:
                    let result = calculateViewModel.multiply(firstNumber, secondNumber)
                    resultLabel.text = "\(result)"
                    break
                    
                case .divide:
                    let result = calculateViewModel.divide(firstNumber, secondNumber)
                    resultLabel.text = "\(result)"
                    break
                    
                }
                animateLabel()
            }
        }
        
        else if tag == 2 {
            currentOperations = .add
        }
        else if tag == 3 {
            currentOperations = .subtract
        }
        else if tag == 4 {
            currentOperations = .multiply
        }
        else if tag == 5 {
            currentOperations = .divide
        }
        
        
    }
    
    //MARK: - Buttons Tapped Functions
    
    @objc
    private func clearCalculate(){
        resultLabel.text = "0"
        firstNumber = 0
        currentOperations = nil
        
    }
    
    @objc
    private func zeroButtonTapped(){
        if resultLabel.text != "0"{
            if let text = resultLabel.text{
                resultLabel.text = "\(text)"
            }
        }
    }
    
    @objc
    private func numberPressed(_ sender: UIButton) {
        
        let tag = sender.tag - 1
        
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
        
    }
    
    //MARK: - Animate
    
    private func animateLabel() {
        UIView.animate(withDuration: 0.3, animations: {
            self.resultLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (completed) in
            UIView.animate(withDuration: 0.3) {
                self.resultLabel.transform = CGAffineTransform.identity
            }
        }
    }
    
    
}



















