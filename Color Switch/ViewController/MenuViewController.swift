//
//  MenuViewController.swift
//  Color Switch
//
//  Created by Dayal, Utkarsh on 26/04/21.
//

import UIKit

class MenuViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        viewWillDisappear(true)
        performSegue(withIdentifier: "logout", sender: nil)
        viewDidDisappear(true)
    }
    

}
