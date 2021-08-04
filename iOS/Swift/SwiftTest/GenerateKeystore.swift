//
//  ViewController.swift
//  Swift
//
//  Created by Shilei Mao on 03/08/2021.
//

import UIKit
import HorizonFintexSDK

class GenerateKeystore: UIViewController {

    @IBOutlet weak var tfGenerateKeystorePwd: UITextField!
    
    @IBOutlet weak var btGenerateKeystore: UIButton!
    
    @IBOutlet weak var tvKeystore: UITextView!
    
    
    var ethOperator: HGEthereumOperator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsEvaluator = JSWebview(handlers: nil)
        self.ethOperator = HGEthereumOperator(jsEvaluator: jsEvaluator, attachedView: self.view)
    }
    
    @IBAction func btGeneratedKeystoreTapped(_ sender: Any) {
        if let pwd = self.tfGenerateKeystorePwd.text, !pwd.isEmpty {
            self.showProgress()
            self.ethOperator.generateKeystore(pwd: pwd) { keystore, error in
                self.tvKeystore.text = keystore?.keystoreStr
                self.dismissProgress()
            }
        } else {
            showError(message: "Please enter password")
        }
    }
    
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showProgress() {
        if let progressView = storyboard?.instantiateViewController(identifier: "ProgressView") {
            progressView.modalTransitionStyle = .crossDissolve
            progressView.modalPresentationStyle = .overCurrentContext
            
            self.present(progressView, animated: true, completion: nil)
        }
    }
    
    func dismissProgress() {
        self.dismiss(animated: true, completion: nil)
    }
}

