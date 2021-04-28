//
//  GameViewController.swift
//  Color Switch
//
//  Created by Dayal, Utkarsh on 23/04/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var gameScene: GameScene!
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            //Create a Game Scene
            let scene = GameScene(size: view.bounds.size)
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            gameScene = scene as GameScene
            gameScene.gameViewController = self
            
            view.ignoresSiblingOrder = false
        }
    }
    
    //Moving back to the menu screen after game is over
    func goToMenu(){
        
        let user = getCurrentUser()
        
        let score = Score(context: managedObjectContext)
        score.id = UUID()
        score.score = Int64(self.score)
        
        user?.addToScores(score)
        
        do{
            try managedObjectContext.save()
        } catch {
            fatalError("Unable to Save")
        }
        
        performSegue(withIdentifier: "GameOver", sender: nil)
    }
}
