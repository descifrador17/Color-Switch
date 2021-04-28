//
//  LoginViewController.swift
//  Color Switch
//
//  Created by Dayal, Utkarsh on 26/04/21.
//

//MARK:- Login Flow
/*
 Flow of Login
 
 All steps done before performing segue
 -----------Sign Up Button Clicked-----------
 1. Check Validity  of Username and Password
 2. Check Uniqueness of Uername
 
 
 -----------Login Button Clicked-------------
 1. Check Validity of Username and Password
 2. If the user is in DataBase
 
 After 1 and 2 of Both Actions WRITE TO DATABASE
 */

//MARK:- Login View Controller
import UIKit
import CoreData

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //All the required Operations Before Performing Segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    
        //Check if the Fields are Valid (Not Empty, no spaces, matches the Criteria)
        if !fieldsAreValid(){
            showAlert(withTitle: "INCORRECT CREDENTIALS", withMessage: "Please enter valid Username and Password")
            return false
        }
        
        //Should __Login Segue__ should be initiated
        //Checks 1. Username found in Database | 2. Password Matches
        if identifier == "loginSegue" {
            let segueShouldOccur = foundInDatabase() && didPasswordMatch()
            if !segueShouldOccur {
                if !foundInDatabase(){
                    showAlert(withTitle: "USER NOT FOUND", withMessage: "Please Signup")
                }
                else if !didPasswordMatch(){
                    showAlert(withTitle: "MHMMMMMMM!!!", withMessage: "Your Password Doesn't Match")
                }
                    
                return false
            }
            
            let user = getUserfromUsername()
            appDelegate.currentUserID = user!.id
            
        }
        
        //Should Signup Segue should be initiated
        //Checks 1. Username found in Database
        if identifier == "signupSegue"{
            let segueShouldOccur = foundInDatabase()
            if segueShouldOccur {
                showAlert(withTitle: "AHHHH!!!", withMessage: "Username Already Taken")
                return false
            }
            
            let newUser = User(context: managedObjectContext)
            appDelegate.currentUserID = UUID()
            newUser.id = appDelegate.currentUserID
            newUser.username = usernameField.text!
            newUser.password = passwordField.text!
            let defaultScore = Score(context: managedObjectContext)
            defaultScore.id = UUID()
            defaultScore.score = Int64(0)
            defaultScore.user = newUser
            
            do{
                try managedObjectContext.save()
            } catch {
                fatalError("Unable to Save")
            }
        }

        // by default perform the segue transition
        
        return true
    }
}

//MARK: - Helper Functions
extension LoginViewController{
    
    //MARK: Logical Helpers
    
    func validateName(_ name: String) -> Bool{
        let nameRegEx = "[A-Za-z]{1,}"
        let namePred = NSPredicate(format:"SELF MATCHES [c] %@", nameRegEx)
        return namePred.evaluate(with: name)
    }
    
    private func fieldsAreValid() -> Bool{
        return validateName(self.usernameField.text!) && validateName(self.passwordField.text!)
    }
    
    private func didPasswordMatch() -> Bool{
        var listOfUsers = [User]()
        let request = User.fetchRequest() as NSFetchRequest<User>
        let pred = NSPredicate(format: "username == %@", usernameField.text!)
        request.predicate = pred
        
        do{
            listOfUsers = try managedObjectContext.fetch(request)
        } catch {
            print("Error Fetching Data")
        }
        if (listOfUsers.isEmpty){
            return false
        }
        return listOfUsers[0].password == passwordField.text
    }
    
    //MARK: Database Helpers
    private func foundInDatabase() -> Bool{
        var listOfUsers = [User]()
        let request = User.fetchRequest() as NSFetchRequest<User>
        let pred = NSPredicate(format: "username == %@", usernameField.text!)
        request.predicate = pred
        
        do{
            listOfUsers = try managedObjectContext.fetch(request)
        } catch {
            print("Error Fetching Data")
        }
        if (listOfUsers.isEmpty){
            return false
        }
        print(listOfUsers[0].username == usernameField.text!)
        return listOfUsers[0].username == usernameField.text!
    }
    
    private func getUserfromUsername() -> User?{
        var listOfUsers = [User]()
        let request = User.fetchRequest() as NSFetchRequest<User>
        let pred = NSPredicate(format: "username == %@", usernameField.text!)
        request.predicate = pred
        
        do{
            listOfUsers = try managedObjectContext.fetch(request)
        } catch {
            print("Error Fetching Data")
        }
        return listOfUsers[0]
    }
    
    //MARK: Other Helpers
    private func showAlert(withTitle title: String, withMessage message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "CLOSE", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}



