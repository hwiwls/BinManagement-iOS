//
//  SignInViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/17.
//

import UIKit

class SignInViewController: UIViewController {
    
    private lazy var logInLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 50)
        $0.text = "로그인"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

}
