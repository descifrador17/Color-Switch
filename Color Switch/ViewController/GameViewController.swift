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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameScene(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            gameScene = scene as GameScene
            gameScene.gameViewController = self
            
            view.ignoresSiblingOrder = false
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func goToMenu(){
        performSegue(withIdentifier: "GameOver", sender: nil)
    }
}
