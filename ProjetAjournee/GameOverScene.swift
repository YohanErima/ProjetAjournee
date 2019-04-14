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
        
    }

}
