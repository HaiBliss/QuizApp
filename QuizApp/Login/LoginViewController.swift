//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Hà Hữu Hải on 12/06/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NVActivityIndicatorView

class LoginViewController: UIViewController {

    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var viewInput: UIView!
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    
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
    private let viewModel = LoginViewModel()
    private let bag = DisposeBag()
    var isLogin: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        
        viewInput.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 5.0, opacity: 0.2)
        submitView.layer.cornerRadius = 40
        fullNameTextField.isHidden = true
        userNameTextField.isHidden = true
        rePassWordTextField.isHidden = true
        signupImage.isHidden = true
        
        loginImage.isHidden = false
        signupText.textColor = UIColor(named: "4E54C8")
        loginText.textColor = UIColor(named: "8F94FB")
        
    }
    @IBAction func loginTap(_ sender: Any) {
        isLogin = true
        fullNameTextField.isHidden = true
        userNameTextField.isHidden = true
        rePassWordTextField.isHidden = true
        signupImage.isHidden = true
        
        loginImage.isHidden = false
        signupText.textColor = UIColor(named: "4E54C8")
        loginText.textColor = UIColor(named: "8F94FB")
    }
    @IBAction func signupTap(_ sender: Any) {
        isLogin = false
        fullNameTextField.isHidden = false
        userNameTextField.isHidden = false
        rePassWordTextField.isHidden = false
        signupImage.isHidden = false
        
        loginImage.isHidden = true
        loginText.textColor = UIColor(named: "4E54C8")
        signupText.textColor = UIColor(named: "8F94FB")
    }
    
    @IBAction func submitAction(_ sender: Any) {
        guard let email = emailTextField.text, let pass = passWordTextField.text else {
            alertView(title: "Lỗi", message: "Email và Mật khẩu không được để trống")
            return
        }
        if isLogin {
            if email.isValidEmail() {
                if pass.count >= 6 {
                    loadingView.startAnimating()
                    viewModel.login(email: email, password: pass)
                } else {
                    alertView(title: "Lỗi", message: "Nhập mật khẩu từ 6 ký tự")
                }
            } else {
                alertView(title: "Lỗi", message: "Email không đúng định dạng")
            }
        }
    }
    
    
    func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
