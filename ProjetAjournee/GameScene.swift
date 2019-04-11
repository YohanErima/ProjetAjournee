//
//  GameScene.swift
//  ProjetAjournee
//
//  Created by etudiant on 10/04/2019.
//  Copyright © 2019 etudiant. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var minX:CGFloat!
    var minY:CGFloat!
    //declaration des des objets(joueur et les notes)
    var note:SKSpriteNode = SKSpriteNode()
    var player:SKSpriteNode = SKSpriteNode()
    // declaration des collision
    let collisionNote : UInt32 = 1
    let collisionPlayer : UInt32 = 2
    let collisionscene: UInt32 = 4
    // declaration de audioPlayer
    var audioPlayer = AVAudioPlayer()
    // vecteur pour le deplacement vers le haut du joueur
    var monter: CGVector = CGVector(dx: 0, dy: 200)
    // score et nombre de note pris
    var scoreLabel:SKLabelNode = SKLabelNode()
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    // intervalle de temps entre l'apparition des notes
    var noteTimer:Timer = Timer()
    // tableau de notes possible de 0 a 20
    var possibleNotes = ["zero"]
    // compte a rebours
    var startInt = 3
    var startTimer = Timer()
    
    // compte a rebours du jeu de 60 seconds
    var gameInt = 60
    var gameTimer = Timer()
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        minX=frame.minX
        minY=frame.minY
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: minX-10 , y: minY-10 , width: frame.width , height: frame.height))
        
        
        
        let audioFileURL = Bundle.main.url(forResource: "gamra", withExtension: "mp3")
        do {
            let sound = try AVAudioPlayer(contentsOf: audioFileURL!)
            audioPlayer = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
        
        let background = SKSpriteNode(imageNamed: "background")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.size.width = frame.size.width
        background.size.height = frame.size.height
        
        background.zPosition = -1
        
        self.addChild(background)
        
        player = SKSpriteNode(imageNamed : "fille")
        player.name = "player"
        player.zPosition = 0
        player.position = CGPoint(x: player.size.width/2, y: player.size.height/2 + 1000)
        player.anchorPoint = CGPoint(x: 0, y: 0)
        player.physicsBody?.isDynamic = true
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = collisionPlayer
        player.physicsBody?.collisionBitMask = collisionNote
        player.physicsBody?.contactTestBitMask = 0
        
        self.addChild(player)
        
        scoreLabel = SKLabelNode(text : "Score : 0")
        scoreLabel.position = CGPoint(x: 100, y: self.frame.size.height - 60)
        scoreLabel.fontColor = UIColor.darkGray
        score = 0
        
        self.addChild(scoreLabel)
 
        noteTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addNotes), userInfo: nil, repeats: true)

       
    }
    @objc func addNotes() {
        
        
        possibleNotes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleNotes) as! [String]
        let note = SKSpriteNode(imageNamed: possibleNotes[0])
        note.name = "note"
        
        let randomNotesPosition = GKRandomDistribution(lowestValue: 0, highestValue: 1334)
        let position = CGFloat(randomNotesPosition.nextInt())

        note.position = CGPoint(x: self.frame.size.width + note.size.width , y: position)

        note.physicsBody = SKPhysicsBody(rectangleOf: note.size)
        note.physicsBody?.isDynamic = true

        note.physicsBody?.categoryBitMask = collisionNote
        note.physicsBody?.contactTestBitMask = collisionPlayer
        note.physicsBody?.collisionBitMask = 0

        self.addChild(note)


        let dureeAnime:TimeInterval = 6

        var tableauAction = [SKAction]()
        tableauAction.append(SKAction.move(to: CGPoint(x: -note.size.width, y: position), duration: dureeAnime))
        tableauAction.append(SKAction.removeFromParent())

        note.run(SKAction.sequence(tableauAction))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var Premierobjet:SKPhysicsBody
        var Secondobjet:SKPhysicsBody

        if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "note")
        {
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                Premierobjet = contact.bodyA
                Secondobjet = contact.bodyB
                
            } else {
                Secondobjet = contact.bodyA
                Premierobjet = contact.bodyB
                
            }

            if (Premierobjet.categoryBitMask & collisionNote) != 0 && (Secondobjet.categoryBitMask & collisionPlayer) != 0{
                PlayerVsNote(Note20: Premierobjet.node as! SKSpriteNode )
            } else {
                PlayerVsNote(Note20: Secondobjet.node as! SKSpriteNode )            }
    }
    }


    func PlayerVsNote(Note20:SKSpriteNode){
        Note20.removeFromParent()

        score+=1

    }
    func moveDown(){
        let moveAction:SKAction = SKAction.moveBy(x: 0 ,y: -100, duration: 1)
        player.run(moveAction)
    }
    func moveUP(){
        let moveAction:SKAction = SKAction.moveBy(x: 0 ,y: +100, duration: 1)
        player.run(moveAction)
    }
    func touchDown(atPoint pos : CGPoint) {
        if (pos.y > self.frame.height/2){
           moveUP()
        }else {
            moveDown()
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
        for t in touches { self.touchDown(atPoint: t.location(in: self))
            break
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
         for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

