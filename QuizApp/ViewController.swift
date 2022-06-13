//
//  ViewController.swift
//  QuizApp
//
//  Created by Hà Hữu Hải on 11/06/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginViewAction(_ sender: Any) {
        let vc = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(vc, animated: true)
    }
    
}

