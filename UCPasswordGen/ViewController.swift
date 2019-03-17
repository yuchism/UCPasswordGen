//
//  ViewController.swift
//  UCPasswordGen
//
//  Created by yuch on 17/3/19.
//  Copyright © 2019 Yuch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtLength: UITextField!
    @IBOutlet weak var swNumberRequired: UISwitch!
    @IBOutlet weak var swLowercaseRequired: UISwitch!
    @IBOutlet weak var swUppercaseRequired: UISwitch!
    @IBOutlet weak var swSpecialcharRequired: UISwitch!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet var lblTitles: [UILabel]!  {
        didSet {
            for lbl in lblTitles {
                lbl.font = UIFont.boldSystemFont(ofSize: 20)
            }
        }
    }
    @IBOutlet weak var btnGeneratePassword: UIButton! {
        didSet {
            btnGeneratePassword.backgroundColor = .blue
            btnGeneratePassword.setTitleColor(.white, for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        btnGeneratePassword.addTarget(self, action: #selector(self.actionTapBtnGeneratePassword(_:)), for: .touchUpInside)
    }
    
    @objc
    func actionTapBtnGeneratePassword(_ sender:UIButton) {
        
        let bNumberRequired = self.swNumberRequired.isOn ? true : false
        let bLowercaseRequired = self.swLowercaseRequired.isOn ? true : false
        let bUppercaseRequired = self.swUppercaseRequired.isOn ? true : false
        let bSpecialcharRequired = self.swSpecialcharRequired.isOn ? true : false
        let passwordLength = Int(txtLength.text ?? "8") ?? 8
        
        let pwdGen = UCPasswordGen()
        pwdGen.minimumLength = passwordLength
        pwdGen.requireNumbers = bNumberRequired
        pwdGen.requireLowercase = bLowercaseRequired
        pwdGen.requireUppercase = bUppercaseRequired
        pwdGen.requireSpecialChar = bSpecialcharRequired
        
        txtPassword.text = pwdGen.getPassword()
    }
}


