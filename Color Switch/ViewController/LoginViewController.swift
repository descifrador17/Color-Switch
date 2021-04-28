//
//  LoginViewController.swift
//  Color Switch
//
//  Created by Dayal, Utkarsh on 26/04/21.
//

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

import UIKit
import CoreData

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if !fieldsAreValid(){
            let alert = UIAlertController(title: "INCORRECT DATA", message: "Please check the filled data", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "CLOSE", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

             // prevent segue from occurring
            return false
        }
        
        
        if identifier == "loginSegue" {
            let segueShouldOccur = foundInDatabase() && didPasswordMatch()
            if !segueShouldOccur {
                let alert = UIAlertController(title: "LOGIN FAILED", message: "Pass not match | no username", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "CLOSE", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                 // prevent segue from occurring
                return false
            }
        }
        
        if identifier == "signupSegue"{
            let segueShouldOccur = foundInDatabase()
            if segueShouldOccur {
                let alert = UIAlertController(title: "AAAHHHHHH!!!!", message: "Username already taken", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "CLOSE", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                 // prevent segue from occurring
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
    func validateName(_ name: String) -> Bool{
        let nameRegEx = "[A-Za-z]{1,}"
        let namePred = NSPredicate(format:"SELF MATCHES [c] %@", nameRegEx)
        return namePred.evaluate(with: name)
    }
    
    private func fieldsAreValid() -> Bool{
        return validateName(self.usernameField.text!) && validateName(self.passwordField.text!)
    }
    
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
}



