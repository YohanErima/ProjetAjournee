//
//  GameO.swift
//  ProjetAjournee
//
//  Created by Lola RAOUX  on 14/04/2019.
//  Copyright © 2019 etudiant. All rights reserved.
//

import UIKit
import SpriteKit

class GameO: SKScene {
    var scoreLabel:SKLabelNode = SKLabelNode()
    var MoyenneLabel:SKLabelNode = SKLabelNode()
    var LabelTime : SKLabelNode = SKLabelNode()
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.white
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.zPosition = 0
        
        LabelTime.zPosition = 1
        LabelTime.fontSize = 42
        LabelTime.text = String("Temps imparti terminer ")
        LabelTime.position = CGPoint(x: frame.size.width / 2, y: self.frame.size.height - 200)
        LabelTime.fontColor = UIColor.black
        self.addChild(LabelTime)
        
        // recupération du score stocker dans la strucScore et l'affichage en l'ajoutant a la scene
        scoreLabel.text = String("Score : \(StrucScore.ScoreduJeu)")
        scoreLabel.position = CGPoint(x: 100, y: self.frame.size.height/2)
        scoreLabel.fontSize = 42
        scoreLabel.fontColor = UIColor.black
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        
         // recupération du score stocker dans la strucScore et l'affichage en l'ajoutant a la scene
        MoyenneLabel.text = String("Moyenne : \(StrucScore.MoyenneduJeu)")
        MoyenneLabel.position = CGPoint(x: self.frame.size.width - 200, y: self.frame.size.height/2)
        MoyenneLabel.fontSize = 42
        MoyenneLabel.fontColor = UIColor.black
        MoyenneLabel.zPosition = 1
        
        self.addChild(MoyenneLabel)
        
        let NewGame:SKSpriteNode = SKSpriteNode(imageNamed: "replay")
        NewGame.anchorPoint = CGPoint(x: 0, y: 0)
        NewGame.name = "NewGame"
        NewGame.position = CGPoint(x: 100, y: 100)
        NewGame.zPosition = 1
        self.addChild(NewGame)
        
//        let Acceuil:SKSpriteNode = SKSpriteNode(imageNamed: "acceuil")
//        Acceuil.anchorPoint = CGPoint(x: 0, y: 0)
//        Acceuil.name = "acceuil"
//        Acceuil.position = CGPoint(x: 100, y: 200)
//        Acceuil.zPosition = 1
//        self.addChild(Acceuil)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            let node = self.nodes(at: location)
            
            if node[0].name == "NewGame" {
                let transition = SKTransition.doorsCloseVertical(withDuration: 0.5)
                let gamescene = GameScene(size: self.size)
                self.view!.presentScene(gamescene, transition: transition)
            }
//            if node[0].name == "acceuil" {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "AcceuilViewController")
//
//                vc.view.frame = (self.view?.frame)!
//                vc.view.layoutIfNeeded()
//
//                UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
//                {
//                    self.view?.window?.rootViewController = vc
//                    }, completion: { completed in
//
//                })
//            }
        }
        
    }

}
