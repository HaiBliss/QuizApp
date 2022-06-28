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
    let background = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        animation()
        bindData()
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
                    background.isHidden = false
                    viewModel.login(email: email, password: pass)
                } else {
                    alertView(title: "Lỗi", message: "Nhập mật khẩu từ 6 ký tự")
                }
            } else {
                alertView(title: "Lỗi", message: "Email không đúng định dạng")
            }
        }
    }
    
    func bindData() {
        viewModel.loginInfo.subscribe { [weak self] data in
            if let loginInfo = data.element {
                self?.background.isHidden = true
                if let errorCode = loginInfo.code {
                    switch errorCode {
                    case 200:
                        print(":Đăng nhập thành công!")
                        break
                    case 400:
                        self?.alertView(title: "Đăng nhập thất bại", message: loginInfo.message ?? "")
                        break
                    default:
                        self?.alertView(title: "Đăng nhập thất bại", message: loginInfo.message ?? "")
                        break
                    }
                }
            }
        }.disposed(by: bag)
    }
    
    
    func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func animation() {
        let loading = NVActivityIndicatorView(frame: .zero, type: .ballClipRotatePulse, color: UIColor(named: "8F94FB"), padding: 0)
        background.backgroundColor = UIColor(named: "trangmo")
        view.addSubview(background)
        background.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.widthAnchor.constraint(equalToConstant: 40),
            loading.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
        loading.startAnimating()
        background.isHidden = true
    }
    
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
