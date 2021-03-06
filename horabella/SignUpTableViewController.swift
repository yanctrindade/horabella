//
//  SignUpTableViewController.swift
//  horabella
//
//  Created by Erick Leal on 26/10/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import VMaskTextField

class SignUpTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: VMaskTextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    var birthdate: NSDate!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var genderSegControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        phoneTextField.mask = "(##)####-####"
        birthdateTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        firstNameTextField.text = SmokeUser.sharedInstance.firstName
        lastNameTextField.text = SmokeUser.sharedInstance.lastName
        emailTextField.text = SmokeUser.sharedInstance.email
        birthdateTextField.text = SmokeUser.sharedInstance.birthDate
        if let userGender = SmokeUser.sharedInstance.gender {
            if userGender == "female"{
                genderSegControl.selectedSegmentIndex = 1
            }else{
                genderSegControl.selectedSegmentIndex = 0
            }
        }else{
            genderSegControl.selectedSegmentIndex = 2
        }
        
    }
    
    // MARK: - SignUp
    
    @IBAction func signUp(sender: AnyObject) {
        
        //validaçao dos campos
        if firstNameTextField.text!.characters.count < 3 {
            
            let alert = UIAlertController(title: "Erro", message: "Nome muito curto!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                self.firstNameTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }else if lastNameTextField.text!.characters.count < 3 {
            
            let alert = UIAlertController(title: "Erro", message: "Sobrenome muito curto!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                self.lastNameTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }else if emailTextField.text!.characters.count < 6 {
            
            let alert = UIAlertController(title: "Erro", message: "Email muito curto!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                self.emailTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }else if phoneTextField.text!.characters.count < 8 {
            
            let alert = UIAlertController(title: "Erro", message: "Telefone muito curto!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                self.phoneTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        /*}else if birthdateTextField.text!.characters.count < 1 {
            
            let alert = UIAlertController(title: "Erro", message: "Insira sua data de nascimento!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                self.birthdateTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        */}else if passwordTextField.text!.characters.count < 6 {
            
            let alert = UIAlertController(title: "Erro", message: "Senha muito curta!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                self.passwordTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }else{
            
            let newUser = SmokeUser()
            newUser.firstName = firstNameTextField.text
            newUser.lastName = lastNameTextField.text
            newUser.email = emailTextField.text
            newUser.password = passwordTextField.text
            if genderSegControl.selectedSegmentIndex == 0{
                newUser.gender = "male"
            }else if genderSegControl.selectedSegmentIndex == 1 {
                newUser.gender = "female"
            }else{
                newUser.gender = "n/a"
            }
            
            newUser.signUp({ (response) -> Void in
                
                let alert = UIAlertController(title: "Sucesso", message: "Cadastro realizado com sucesso!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                    //try to loggin after signup
                    SmokeUser().loginWithEmailAndPassword(newUser.email, password: newUser.password, successBlock: { (response) -> Void in
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewControllerWithIdentifier("initialView") as! HBTabBarViewController
                        self.presentViewController(vc, animated: true, completion: nil)
                        
                        }) { (response) -> Void in
                            
                            let alert = UIAlertController(title: "Erro!", message: "Email ou senha inválidos", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
                                alert .dismissViewControllerAnimated(true, completion: nil)
                            }))
                            
                            self.presentViewController(alert, animated: true, completion: { () -> Void in
                                self.passwordTextField.text = nil
                            })
                            
                    }
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
                }, errorBlock: { (response) -> Void in
                    
                    //tratar os erros
                    let alert = UIAlertController(title: "Erro", message: "Falha na realização do cadastro!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                        alert.dismissViewControllerAnimated(true, completion: nil)
                    }))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
            })
            
            print("faz cadastro")
            
        }
        
    }
    
    
    // MARK: - DatePicker
    
    @IBAction func dateEditing(sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()

        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.maximumDate = NSDate()
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
//        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
//        
//        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        birthdateTextField.text = dateFormatter.stringFromDate(sender.date)
        birthdate = sender.date
        
    }
    
    // MARK: - TextField
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        }else if textField == lastNameTextField {
            emailTextField.becomeFirstResponder()
        }else if textField == emailTextField {
            phoneTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField == phoneTextField {
            return phoneTextField.shouldChangeCharactersInRange(range, replacementString: string)
        }else{
            return true
        }
    
    }
    
}
