//
//  GameOverScene.swift
//  ProjetAjournee
//
//  Created by Lola RAOUX  on 14/04/2019.
//  Copyright © 2019 etudiant. All rights reserved.
//

import UIKit
import SpriteKit 

class GameOverScene: SKScene {
    
    var score :Int = 0
    
    var ButtonReplay:SKSpriteNode!
    var ButtonSave:SKSpriteNode!
    var ButtonAcceuil:SKSpriteNode!
    
    var ScoreLabel:SKLabelNode!
    var Moyenne:SKLabelNode!
    
    override func didMove(to view: SKView) {
        ScoreLabel = self.childNode(withName: "ScoreLabel") as! SKLabelNode
        ScoreLabel.text = "\(score)"
        
        ButtonReplay = self.childNode(withName: "ButtonReplay") as! SKSpriteNode
        
        ButtonSave = self.childNode(withName: "SaveButton") as! SKSpriteNode
        
        ButtonAcceuil = self.childNode(withName: "ButtonAcceuil") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            let node = self.nodes(at: location)
            
            if node[0].name == "ButtonReplay" {
                let transition = SKTransition.flipVertical(withDuration: 0.6)
                let gameScene = GameScene(size: self.size)
                self.view!.presentScene(gameScene, transition: transition)
            }
            if node[0].name == "ButtonSave" {
                let transition = SKTransition.flipVertical(withDuration: 0.6)
                let gameScene = GameScene(size: self.size)
                self.view!.presentScene(gameScene, transition: transition)
                
            }
            if node[0].name == "ButtonAcceuil" {
                let transition = SKTransition.flipVertical(withDuration: 0.6)
                let gameScene = GameScene(size: self.size)
                self.view!.presentScene(gameScene, transition: transition)
                
            }
        }
    }

}
