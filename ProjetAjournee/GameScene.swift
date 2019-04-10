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
    
    
    //declaration des des objets(joueur et les notes)
    var note:SKSpriteNode = SKSpriteNode()
    var player:SKSpriteNode = SKSpriteNode()
    // declaration des collision
    let collisionNote : UInt32 = 1
    let collisionWal : UInt32 = 2
    let collisionPlayer : UInt32 = 4
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
    var gameTimer:Timer = Timer()
    
    var possibleNotes = [""]
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: frame.minX , y: frame.minY , width: frame.width , height: frame.height))
        self.physicsBody?.collisionBitMask = collisionWal
        
        
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
        player.zPosition = 0
        player.position = CGPoint(x: player.size.width/2, y: player.size.height/2 + 1000)
        player.anchorPoint = CGPoint(x: 0, y: 0)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = collisionPlayer
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = 0
        
        self.addChild(player)
        
        scoreLabel = SKLabelNode(text : "Score : 0")
        scoreLabel.position = CGPoint(x: 100, y: self.frame.size.height - 60)
        scoreLabel.fontName = "AmeriacanTypewriter-Bold"
        scoreLabel.fontColor = UIColor.darkGray
        score = 0
        
        self.addChild(scoreLabel)
 
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addNotes), userInfo: nil, repeats: true)
        
       
    }
    func addNotes() {
        possibleNotes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleNotes) as! [String]
        let note = SKSpriteNode(imageNamed: possibleNotes[0])
        
        let randomNotesPosition = GKRandomDistribution(lowestValue: 0, highestValue: 1334)
        let position = CGFloat(randomNotesPosition.nextInt())
        
        note.position = CGPoint(x: self.frame.size.width + note.size.width , y: position)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
