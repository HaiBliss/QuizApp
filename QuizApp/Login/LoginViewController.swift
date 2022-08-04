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

class LoginViewController: UIViewController {

    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var viewInput: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    var activeField: UITextField?
    var lastOffset: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        bindData()
    }
    
    
    //keyboard
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        
        self.activeField = UITextField()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        fullNameTextField.delegate = self
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passWordTextField.delegate = self
        rePassWordTextField.delegate = self
        
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
        view.setNeedsLayout()
        isLogin = false
        fullNameTextField.isHidden = false
        userNameTextField.isHidden = false
        rePassWordTextField.isHidden = false
        signupImage.isHidden = false
        
        loginImage.isHidden = true
        loginText.textColor = UIColor(named: "4E54C8")
        signupText.textColor = UIColor(named: "8F94FB")
        view.setNeedsLayout()
    }
    
    @IBAction func submitAction(_ sender: Any) {
        guard let email = emailTextField.text, let pass = passWordTextField.text else {
            alertView(title: "Lỗi", message: "Email và Mật khẩu không được để trống")
            return
        }
        if isLogin {
            if email.isValidEmail() {
                if pass.count >= 6 {
                    self.loadingView(isRuning: true)
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
                self?.loadingView(isRuning: false)
                if let errorCode = loginInfo.code {
                    switch errorCode {
                    case 200:
                        print(":Đăng nhập thành công!")
                        ProjectManager.sharedInstance.userInfo = loginInfo
                       
                        
//                        guard let vc = R.storyboard.homeViewController.homeViewController() else {
//                            return
//                        }
//                        let rootVC = vc
//                        let navVC = UINavigationController(rootViewController: rootVC)
//                        navVC.modalPresentationStyle = .fullScreen
//                        self?.present(navVC, animated: true)
                        
//                        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
//                        App.shared.swipeLoginToHome()
//                        window.rootViewController = loginViewController
                        self?.pushBaseRoot()
                        
                        
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
        
        viewModel.errorAPI.subscribe{ [weak self] data in
            self?.loadingView(isRuning: false)
            switch data.element {
            case .networkError:
                self?.alertView(title: "Đăng nhập thất bại", message: "Không có Internet" )
            case .commonError(code: _, messages: let messages):
                self?.alertView(title: "Đăng nhập thất bại", message: messages )
            case .invalidJson:
                break
            case .unknow(code: _):
               break
            case .none:
                break
            }
        }.disposed(by: bag)
    }
}

extension LoginViewController: UITextFieldDelegate {
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardInfo = notification.userInfo else { return }
        if let keyboardSize = (keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            let keyboardHeight = keyboardSize.height + 10
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self.scrollView.contentInset = contentInsets
            var viewRect = self.view.frame
            viewRect.size.height -= keyboardHeight
            guard let activeField = activeField else {
                return
            }
            if (!viewRect.contains(activeField.frame.origin)){
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y - keyboardHeight)
                self.scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.activeField = nil
        return true
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
