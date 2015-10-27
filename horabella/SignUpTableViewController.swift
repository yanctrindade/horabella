//
//  SignUpTableViewController.swift
//  horabella
//
//  Created by Erick Leal on 26/10/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    var birthdate: NSDate!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        birthdateTextField.delegate = self
        passwordTextField.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - SignUp
    
    
    @IBAction func facebookSignUp(sender: AnyObject) {
        
        print("cadastro com facebook")
        
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
        if firstNameTextField.text!.characters.count < 3 {
            
            let alert = UIAlertController(title: "Erro", message: "Nome muito curto!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction) -> Void in
                self.firstNameTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }else if lastNameTextField.text!.characters.count < 3 {
            
            let alert = UIAlertController(title: "Erro", message: "Sobrenome muito curto!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction) -> Void in
                self.lastNameTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }else if emailTextField.text!.characters.count < 6 {
            
            let alert = UIAlertController(title: "Erro", message: "Email muito curto!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction) -> Void in
                self.emailTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }else if phoneTextField.text!.characters.count < 8 {
            
            let alert = UIAlertController(title: "Erro", message: "Telefone muito curto!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction) -> Void in
                self.phoneTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }else if birthdateTextField.text!.characters.count < 1 {
            
            let alert = UIAlertController(title: "Erro", message: "Insira sua data de nascimento!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction) -> Void in
                self.birthdateTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }else if passwordTextField.text!.characters.count < 6 {
            
            let alert = UIAlertController(title: "Erro", message: "Senha muito curta!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction) -> Void in
                self.passwordTextField.becomeFirstResponder()
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }else{
            
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
        
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
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
    

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
