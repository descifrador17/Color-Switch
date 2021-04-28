//
//  MenuViewController.swift
//  Color Switch
//
//  Created by Dayal, Utkarsh on 26/04/21.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var posOneUsernameLabel: UILabel!
    @IBOutlet weak var posTwoUsernameLabel: UILabel!
    @IBOutlet weak var posThreeUsernameLabel: UILabel!
    @IBOutlet weak var posOneScoreLabel: UILabel!
    @IBOutlet weak var posTwoScoreLabel: UILabel!
    @IBOutlet weak var posThreeScoreLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    
    var userID: UUID?
    var user: User?
    var scores: [Score]?
    
    override func viewWillAppear(_ animated: Bool) {
        //get Top Scorers
        getTopScorers()
        
        //Setting Labels
        setLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logging()
    }
}

//MARK:- Helper Functions
extension MenuViewController{
    
    //Get Top 3 Scorers
    private func getTopScorers(){
        let request = Score.fetchRequest() as NSFetchRequest<Score>
        let sort = NSSortDescriptor(key: "score", ascending: false)
        request.sortDescriptors = [sort]
        do{
            self.scores = try managedObjectContext.fetch(request)
        } catch {
            print("Records not found")
        }
    }
    
    //Set All Labels on Screen
    private func setLabels(){
        //For username at Top
        user = getCurrentUser()
        usernameLabel.text = user?.username?.capitalized
        
        //Top Scorer Position 1
        self.posOneScoreLabel.text = String(scores?[0].score ?? Int64(0))
        self.posOneUsernameLabel.text = String(scores?[0].user?.username ?? " ")
        
        //Top Scorer Position 2
        if scores!.count > 1{
            self.posTwoScoreLabel.text = String(scores?[1].score ?? Int64(0))
            self.posTwoUsernameLabel.text = String(scores?[1].user?.username ?? " ")
        }
        
        //Top Scorer Position 3
        if scores!.count > 2 {
            self.posThreeScoreLabel.text = String(scores?[2].score ?? Int64(0))
            self.posThreeUsernameLabel.text = String(scores?[2].user?.username ?? " ")
        }
        
        //Current User Previous Score
        let userScoresArray = (user?.scores!.array) as! [Score]
        currentScoreLabel.text = String( userScoresArray[userScoresArray.count-1].score )
    }
    
    //For Debugging Purposes Only
    private func logging(){
        var scores = [Score]()
        do{
            scores = try managedObjectContext.fetch(Score.fetchRequest())
        } catch {
            print("Records not found")
        }
        for score in scores{
            print("scoreID = \(score.id!.uuidString) score = \(score.score) userID = \(score.user!.id!.uuidString) username = \((score.user!.username)!) pass = \((score.user!.password)!) \n")
        }
    }
}
