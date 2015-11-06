//
//  LogInViewController.swift
//  horabella
//
//  Created by Erick Leal on 26/10/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - LogIn
    
    @IBAction func logIn(sender: AnyObject) {
        
        let email = emailTextField.text! as String
        let password = passwordTextField.text! as String
        
        SmokeUser().loginWithEmailAndPassword(email, password: password, successBlock: { (response) -> Void in
            
                print("login passou")
            
            }) { (response) -> Void in
                
                let alert = UIAlertController(title: "Erro!", message: "Email ou senha inválidos", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
                    alert .dismissViewControllerAnimated(true, completion: nil)
                }))
                
                self.presentViewController(alert, animated: true, completion: { () -> Void in
                    self.passwordTextField.text = nil
                })
                
        }
        
    }
    
    @IBAction func getCurrentUser(sender: AnyObject) {
        
        if (SmokeUser().currentUser() != nil) {
            print("usuario logado")
            print(SmokeUser.sharedInstance.firstName)
            print(SmokeUser.sharedInstance.lastName)
            print(SmokeUser.sharedInstance.email)
            print(SmokeUser.sharedInstance.gender)
            print(SmokeUser.sharedInstance.phone)
            //print(SmokeUser.sharedInstance.birthDate)
        }else{
            print("sem usuario")
        }
        
    }
    
    
    //MARK: - TextField
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == emailTextField{
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        
        return true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
