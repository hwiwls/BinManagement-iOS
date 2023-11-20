//
//  SignInViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/17.
//

import UIKit
import SnapKit
import Then

class SignInViewController: UIViewController {
    var onConfirm: ((String) -> Void)?
    
    private lazy var logInLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 50)
        $0.text = "로그인"
    }
    
    let codeTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.textColor = .black
        $0.returnKeyType = .done
        $0.backgroundColor = UIColor.customColor.customSuperLightGray
        $0.placeHolder(string: "인증 코드를 입력해주세요", color: UIColor.darkGray)
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.borderStyle = .none
        $0.addLeftPadding()
        $0.isSecureTextEntry = true
        $0.textContentType = .oneTimeCode
        $0.layer.cornerRadius = 25
        $0.layer.masksToBounds = true
    }
    
    let confirmBtn = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = UIColor.customColor.customSkyBlue
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 25
        $0.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        config()
        setupActions()
        
    }
    
    private func config() {
        layout()
    }
    
    private func layout() {
        view.addSubviews([
            logInLabel,
            codeTextField,
            confirmBtn
        ])
        
        codeTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        logInLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(250)
        }
        
        confirmBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(codeTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupActions() {
        codeTextField.addTarget(self, action: #selector(codeTextFieldDidChange), for: .editingChanged)
        confirmBtn.addTarget(self, action: #selector(confirmBtnTapped), for: .touchUpInside)
    }
    
    @objc private func codeTextFieldDidChange() {
        if let code = codeTextField.text, !code.isEmpty {
            confirmBtn.isEnabled = true
        } else {
            confirmBtn.isEnabled = false
        }
    }
    
    @objc private func confirmBtnTapped() {
        if let code = codeTextField.text {
            onConfirm?(code)
        }
    }
}
