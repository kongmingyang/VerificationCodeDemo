//
//  ViewController.swift
//  VerificationCodeDemo
//
//  Created by 55it on 2018/12/24.
//  Copyright © 2018年 55it. All rights reserved.
//

import UIKit


class ViewController: UIViewController {


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let codeView  = CodeView.init(frame: CGRect(x: 10, y: 30, width: 300, height: 70))
        codeView.setupCodeView(inputNum: 6)
        codeView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view .addSubview(codeView)
        codeView.codeNum = { element in
            
            print("这就是回调\(element)")
            
        }
        
      
    }


}

