//
//  CodeView.swift
//  VerificationCodeDemo
//
//  Created by 55it on 2018/12/24.
//  Copyright © 2018年 55it. All rights reserved.
//

import UIKit



class CodeView: UIView {
    typealias codeNumBlock = (_ codeNum:String) -> Void
    let  SCREEN_WIDTH  = UIScreen.main.bounds.size.width
    let  SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    let  K_W = 60
    let  K_H = 60
    let  PADDING = 10
    
    
    var textField : UITextField!
    var lines : [CAShapeLayer]!
    var lables : [UILabel]!
    var animation : CABasicAnimation!
    var inputNum : NSInteger!
    var codeNum : codeNumBlock?
    
    
    override init(frame: CGRect) {
    
    super .init(frame: frame)

        self.lables = Array.init()
        self.lines = Array.init()
        
        self.animation = CABasicAnimation.init()
        self.animation.keyPath = "opacity"
        self.animation.duration = 0.9
        self.animation.repeatCount = HUGE
        self.animation.fromValue = 0.1
        self.animation.toValue = 0.0
        self.animation.isRemovedOnCompletion = true
        self.animation.timingFunction = CAMediaTimingFunction .init(name: .easeIn)
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    override func layoutSubviews() {
        super .layoutSubviews()
       
        
        
        
    }
    
    
    func setupCodeView(inputNum: NSInteger )  {
        
        self.backgroundColor = UIColor.white
        
        let textField = UITextField.init()
        textField.frame = self.bounds;
        textField.tintColor = UIColor.clear
        textField.textColor = UIColor.clear
        textField.autocapitalizationType = .none
        textField.keyboardType = .numberPad
        textField .addTarget(self, action: #selector(tfdidChangeed), for: .editingChanged)
        self.addSubview(textField)
        self.textField = textField
        self.textField .becomeFirstResponder()
        let maskView = UIButton.init()
        maskView.backgroundColor = UIColor .white
        maskView .addTarget(self, action: #selector(clickMaskView), for: .touchUpInside)
        self .addSubview(maskView)
        self.inputNum = inputNum
        for _ in 0 ... (self.inputNum-1) {
            
            let  lable = UILabel.init()
            lable.textAlignment = .center
            lable.isUserInteractionEnabled = false
            lable.layer.borderWidth = 1
            lable.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            
            lable.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            lable.font = UIFont.systemFont(ofSize: 38)
            self .addSubview(lable)
            self.lables .append(lable)
            
        }
        
        
        let temp  = Int(self.bounds.size.width) - PADDING * (self.inputNum - 1)
        let w = temp / self.inputNum
        
        for _ in 0 ... (self.inputNum-1) {
            
            let path = UIBezierPath.init(rect: CGRect(x:(w-10)/2, y: 5, width: 2, height: K_H - 10))
            let line = CAShapeLayer.init()
            line.path = path.cgPath
//            line.fillColor = UIColor.clear.cgColor
//            if i == 0 {
//                 line.fillColor = UIColor.red.cgColor
//            }
            
            self.lines .append(line)
            
        }
       
      
        
        for i in 0 ... (self.lables.count-1) {
            let  x = i * w + PADDING
            let lable : UILabel = self.lables[i]
            
            lable.frame = CGRect(x:x, y: 10, width:w-10, height:K_H)
            let line :CAShapeLayer = self.lines[i]
//            lable.layer .addSublayer(line)
            line .add(self.animation, forKey: "kOpacityAnimation")
            
            
        }
    }
    
    @objc func tfdidChangeed(textField:UITextField)  {
        let verStr :NSString = NSString.init(string: textField.text!)
        self.textField.text = verStr as String
        print(verStr)
        if  verStr.length >= self.inputNum {
            let num = self.inputNum - 1
            
            textField.text = verStr .substring(to: self.inputNum)
            textField .resignFirstResponder()
            let label = self.lables[num]
            let line = self.lines[num]
            line.fillColor = UIColor.clear.cgColor
            label.text = verStr.substring(with: NSRange.init(location: num, length: 1))
            codeNum!(textField.text!)
            
        }else{
            for i in 0 ... (self.inputNum-1) {
                
                let label = self.lables[i]
                label.text = ""
              
                if i <  verStr.length  {
                label.text = verStr.substring(with: NSRange.init(location: i, length: 1))
//                    self .changeViewLayerIndex(index: i, lineHidden: true)
                }else{
//                    let line = self.lines![i]
//                    self.changeViewLayerIndex(index: i, lineHidden: false)
//                   line.fillColor = UIColor.red.cgColor
                }
                
                
            }
            
            
        }
       
    }
    
    func changeViewLayerIndex(index:NSInteger,lineHidden:Bool)  {
        let line = self.lines[index]
      line.fillColor = UIColor.red.cgColor
        if lineHidden {
          line .removeAnimation(forKey: "kOpacityAnimation")
        }
        UIView.animate(withDuration: 0.25) {
            line.isHidden = lineHidden
        }
        
    }
    @objc func clickMaskView(){
        self.textField .becomeFirstResponder()
        
    }

}
