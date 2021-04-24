//
//  MenuScene.swift
//  Color Switch
//
//  Created by Dayal, Utkarsh on 24/04/21.
//

import SpriteKit

class MenuScene: SKScene {

    override func didMove(to view: SKView) {
        setupLogo()
        setupTitle()
        setupLabels()
    }
    
    //MARK: Setup Logo
    private func setupLogo(){
        let logo = SKSpriteNode(imageNamed: "ColorCircle")
        logo.size = CGSize(width: 100, height: 100)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.midY/2)
        addChild(logo)
    }
    
    //MARK: Setup Title
    private func setupTitle(){
        let title = SKLabelNode(text: "COLOR SWITCH!")
        title.fontName = "Avenir Next Bold"
        title.fontSize = 40.0
        title.fontColor = UIColor.white
        title.position = CGPoint(x: frame.midX, y: frame.midY + title.fontSize)
        addChild(title)
    }
    
    //MARK: Setup Labels
    private func setupLabels(){
        
        let highscore = SKLabelNode(text: "HighScore: \(UserDefaults.standard.integer(forKey: AppKeys.HIGHSCORE_KEY))")
        highscore.fontName = "Avenir Next Medium"
        highscore.fontSize = 35.0
        highscore.fontColor = UIColor.white
        highscore.position = CGPoint(x: frame.midX, y: frame.midY - frame.midY/3)
        addChild(highscore)
        
        let yourScore = SKLabelNode(text: "YourScore: \(UserDefaults.standard.integer(forKey: AppKeys.RECENT_SCORE_KEY))")
        yourScore.fontName = "Avenir Next Medium"
        yourScore.fontSize = 30.0
        yourScore.fontColor = UIColor.white
        yourScore.position = CGPoint(x: frame.midX, y: highscore.position.y - 50)
        addChild(yourScore)
        
        let tapToPlay = SKLabelNode(text: "Tap To Play!!")
        tapToPlay.fontName = "Avenir Next Medium"
        tapToPlay.fontSize = 30.0
        tapToPlay.fontColor = UIColor.darkGray
        tapToPlay.position = CGPoint(x: frame.midX, y: frame.minY + tapToPlay.fontSize)
        addChild(tapToPlay)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }
}
