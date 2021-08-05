//
//  SignMessage.swift
//  SwiftTest
//
//  Created by Shilei Mao on 04/08/2021.
//

import UIKit
import HorizonFintexSDK


class SignMessage: UIViewController {
    
    @IBOutlet weak var tfKeystore: UITextField!
    
    @IBOutlet weak var tfPwd: UITextField!
    
    @IBOutlet weak var tfContractAddr: UITextField!
    @IBOutlet weak var tfMessage: UITextField!
    
    
    var ethOperator: HGEthereumOperator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsEvaluator = JSWebview(handlers: nil)
        self.ethOperator = HGEthereumOperator(jsEvaluator: jsEvaluator, attachedView: self.view)
        
    }
    
    @IBAction func btSignMessageTapped(_ sender: Any) {
        guard let keystoreStr = self.tfKeystore.text?.trimmingCharacters(in: .whitespacesAndNewlines), !keystoreStr.isEmpty else {
            self.showMessage(title: "Error", message: "Please enter keystore")
            return
        }
        
        guard let pwdStr = self.tfPwd.text, !pwdStr.isEmpty else {
            self.showMessage(title: "Error", message: "Please enter password")
            return
        }
        
        guard let messageToSign = self.tfMessage.text, !messageToSign.isEmpty else {
            self.showMessage(title: "Error", message: "Please enter message")
            return
        }
        
        guard let contractAddress = self.tfContractAddr.text?.trimmingCharacters(in: .whitespacesAndNewlines), !contractAddress.isEmpty else {
            self.showMessage(title: "Error", message: "Please enter contract addr")
            return
        }
        
        guard let keystore = EthereumKeystore(jsonStr: keystoreStr) else {
            self.showMessage(title: "Error", message: "You've entered invalid keystore, please try again")
            return
        }
        
        self.showProgress()
        
        self.ethOperator.signMessage(contractAddr: contractAddress, keystore: keystore, password: pwdStr, signOriginal: messageToSign) { result, error in
            self.dismissProgress()
            
            if let error = error {
                self.showMessage(title: "Error", message: error.localizedDescription)
                return
            }
            
            guard let result = result else {
                self.showMessage(title: "Error", message: "failed to sign message, reason unknown")
                return
            }
            
            self.showMessage(title: "Signed message", message: result)
        }
        
    }
    
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
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
