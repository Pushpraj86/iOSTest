//
//  ViewController.swift
//  iOSTest
//
//  Created by Apple on 07/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    weak var activeField: UITextField?
    
    var VeriDetails = [Customerdetail]()
    
    
    enum LoginError: Error {
        case incompleteForm
        case invalidEmail
        case incorrectPasswordLength
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        
        do {
            try login()
            // Transition to next screen
            
            if let url = Bundle.main.url(forResource: "collection", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Customerdetail.self, from: data)
                    
                    self.VeriDetails = [jsonData]
                    
                    let password = jsonData.included[0].attributes.msn ?? "n/a"
                    
                    if  txtPassword.text == password {
                        
                        DispatchQueue.main.async() {
                            [unowned self] in
                            self.performSegue(withIdentifier: "showDetail", sender: self)
                        }
                        
                    }
                    else
                    {
                        Alert.showBasic(title: "Invalid Password", message: "Please make sure you have entered valid password", vc: self)
                        
                    }
                    
                } catch {
                    print("error:\(error)")
                }
            }
            
        } catch LoginError.incompleteForm {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out both email and password fields", vc: self)
        } catch LoginError.invalidEmail {
            Alert.showBasic(title: "Invalid Email Format", message: "Please make sure you format your email correctly", vc: self)
        } catch LoginError.incorrectPasswordLength {
            Alert.showBasic(title: "Password Too Short", message: "Password should be at least 6 characters", vc: self)
        } catch {
            Alert.showBasic(title: "Unable To Login", message: "There was an error when attempting to login", vc: self)
        }
        
        
    }
    
    func login() throws {
        
        let email = self.txtEmail.text!
        let password = self.txtPassword.text!
        
        if email.isEmpty || password.isEmpty {
            throw LoginError.incompleteForm
        }
        
        if !email.isValidEmail {
            throw LoginError.invalidEmail
        }
        
        if password.count < 6 {
            throw LoginError.incorrectPasswordLength
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let controller = segue.destination as! CustomerDetail
            controller.CustomerEmail = self.VeriDetails[0].data.attributes.emailAddress
            let databal = VeriDetails[0].included[1].attributes.includedDataBalance
            controller.Databalance =  String (describing: databal)
            controller.price = String (describing: VeriDetails[0].included[2].attributes.price)
            controller.name =  self.VeriDetails[0].included[2].attributes.name ?? "n/a"
            controller.expirydate =  VeriDetails[0].included[1].attributes.expiryDate!
           
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeField = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        if let activeField = self.activeField, let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
            if (!aRect.contains(activeField.frame.origin)) {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

