//
//  LogInViewController.swift
//  horabella
//
//  Created by Erick Leal on 26/10/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self

    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBarHidden = false
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
    
    //MARK: - Facebook
    
    @IBAction func signUpWithFacebook(sender: AnyObject) {
        
        //loading
        IJProgressView.shared.showProgressView(view)
        //facebook login
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["email", "public_profile", "user_birthday"], fromViewController: self, handler: { (result, error) -> Void in
            if ((error) != nil) {
                print("Process error");
                IJProgressView.shared.hideProgressView()
                
                let alert = UIAlertController(title: "Falha", message: "Falha durante autenticação, tente novamente", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                    alert.dismissViewControllerAnimated(true, completion: nil)
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            } else if (result.isCancelled) {
                print("Cancelled");
                IJProgressView.shared.hideProgressView()
            } else {
                print("Logged in");
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if fbloginresult.grantedPermissions.contains("email")
                {
                    self.returnUserData()
                }
            }
        })
        
    }
    
    //Captura informações do usuário do facebook
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "gender, email, name, birthday"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                
                if let userName = result.valueForKey("name") as? String {
                    
                    let nameArray = userName.componentsSeparatedByString(" ")
                    
                    SmokeUser.sharedInstance.firstName = nameArray[0]
                    SmokeUser.sharedInstance.lastName = nameArray[1]
                    print("Nome: \(SmokeUser.sharedInstance.firstName) \(SmokeUser.sharedInstance.lastName)")
                }
                
                if let userEmail = result.valueForKey("email") as? String {
                    SmokeUser.sharedInstance.email = userEmail
                    print("Email obtido com sucesso: \(SmokeUser.sharedInstance.email)")
                }
                
                if let userGender = result.valueForKey("gender") as? String {
                    SmokeUser.sharedInstance.gender = userGender
                    print("Sexo obtido com sucesso: \(SmokeUser.sharedInstance.gender)")
                }
                
                if let userDobDate = result.valueForKey("birthday") as? String {
                    //formatando a data
                    var userDob = String()
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MM-dd-yyyy"
                    let userDobString = dateFormatter.dateFromString(userDobDate)
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    userDob = dateFormatter.stringFromDate(userDobString!)
                    
                    SmokeUser.sharedInstance.birthDate = userDob
                    print("Nascimento obtido com sucesso! : \(SmokeUser.sharedInstance.birthDate)")
                }
                
                IJProgressView.shared.hideProgressView()
                
                self.performSegueWithIdentifier("signUpFacebookSegue", sender: self)
                
            }
        })
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
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//    }

}
