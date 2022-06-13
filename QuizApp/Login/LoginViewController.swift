//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Hà Hữu Hải on 12/06/2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var viewInput: UIView!

    @IBOutlet weak var fullNameTextField: DesignableUITextField!
    @IBOutlet weak var userNameTextField: DesignableUITextField!
    @IBOutlet weak var emailTextField: DesignableUITextField!
    @IBOutlet weak var passWordTextField: DesignableUITextField!
    @IBOutlet weak var rePassWordTextField: DesignableUITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginText: UILabel!
    @IBOutlet weak var signupText: UILabel!
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var signupImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        viewInput.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 5.0, opacity: 0.2)
        submitView.layer.cornerRadius = 40
        fullNameTextField.leftViewMode = .always
        
    }
    @IBAction func loginTap(_ sender: Any) {
        fullNameTextField.isHidden = true
        userNameTextField.isHidden = true
        rePassWordTextField.isHidden = true
        signupImage.isHidden = true
        
        loginImage.isHidden = false
        signupText.textColor = UIColor(named: "4E54C8")
        loginText.textColor = UIColor(named: "8F94FB")
    }
    @IBAction func signupTap(_ sender: Any) {
        fullNameTextField.isHidden = false
        userNameTextField.isHidden = false
        rePassWordTextField.isHidden = false
        signupImage.isHidden = false
        
        loginImage.isHidden = true
        loginText.textColor = UIColor(named: "4E54C8")
        signupText.textColor = UIColor(named: "8F94FB")
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
}

extension UIView {
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = 10.0
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
 
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
