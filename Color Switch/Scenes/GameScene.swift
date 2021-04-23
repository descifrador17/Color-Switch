//
//  GameScene.swift
//  Color Switch
//
//  Created by Dayal, Utkarsh on 23/04/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene{
    
    //MARK: Variables
    var colorSwitch: SKSpriteNode!
    let ballRadius:CGFloat = 20.0
    var currentSwitchState = SwitchState.red
    var currentColorIndex: Int?
    let scoreLabel = SKLabelNode(text: "0")
    var score = 0
    
    //MARK: Overriden Functions
    override func didMove(to view: SKView) {
        setupPhysics()
        layoutScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
    
    //MARK: Setup Physics
    private func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        physicsWorld.contactDelegate = self
    }
    
    //MARK: Layout Scene
    private func layoutScene(){
        
        //colorSwitch
        setupColorSwitch()
        
        //scoreLabel
        setupScoreLabel()

        //spawnBall
        spawnBall()
    }
    
    //MARK: Setup Color Switch
    private func setupColorSwitch(){
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        colorSwitch.size = CGSize(width: frame.width/3, height: frame.width/3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.frame.height)
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.height/2)
        colorSwitch.physicsBody?.categoryBitMask = Physicsategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        addChild(colorSwitch)
    }
    
    //MARK: Setup Score Label
    private func setupScoreLabel(){
        scoreLabel.fontName = "Rockwell Bold"
        scoreLabel.fontSize = 60.0
        scoreLabel.fontColor = UIColor.darkGray
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(scoreLabel)
    }
    
    private func updateScoreLabel(){
        scoreLabel.text = "\(score)"
    }
    
    //MARK: Spawn Ball
    private func spawnBall(){
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColours.colors[currentColorIndex!], size: CGSize(width: ballRadius*2, height: ballRadius*2))
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        ball.size = CGSize(width: ballRadius * 2, height: ballRadius * 2)
        ball.position = CGPoint(x: frame.midX, y: frame.maxY + (ballRadius * 2))
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ball.physicsBody?.categoryBitMask = Physicsategories.ballCategory
        ball.physicsBody?.contactTestBitMask = Physicsategories.switchCategory
        ball.physicsBody?.collisionBitMask = Physicsategories.none
        addChild(ball)
    }
    
    //MARK: Turn Wheel
    private func turnWheel(){
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.2))
        if let newState = SwitchState(rawValue: currentSwitchState.rawValue + 1){
            currentSwitchState = newState
        } else {
            currentSwitchState = .red
        }
    }
    
    //MARK: Game Over
    private func gameOver(){
        scoreLabel.text = "Game Over"
    }
    
}

//MARK: Extensions
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
        
        //checking collision
        case Physicsategories.ballCategory | Physicsategories.switchCategory:
            
            //getting ball in collision
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                
                //Ball Colour Matches the Switch Color or not
                if currentColorIndex == currentSwitchState.rawValue{
                    score += 1
                    updateScoreLabel()
                    ball.run(SKAction.fadeOut(withDuration: 0.0),completion: {
                        ball.removeFromParent()
                        self.spawnBall()
                    })
                }
                else{
                    self.gameOver()
                }
            }
            
        default:
            print("No Contact")
        }
    }
}
