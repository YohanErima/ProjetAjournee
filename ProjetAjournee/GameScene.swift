//
//  GameScene.swift
//  ProjetAjournee
//
//  Created by etudiant on 10/04/2019.
//  Copyright © 2019 etudiant. All rights reserved.
//
import UIKit
import SpriteKit
import GameplayKit
import AVFoundation


struct StrucScore {
    static var ScoreduJeu:Int = 0
    static var MoyenneduJeu:Float = 0
}

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
    var monter: CGPoint = CGPoint(x: 0, y: 1334)
    var descendre: CGPoint = CGPoint(x: 0, y: 0)
    // score et nombre de note pris
    var scoreLabel:SKLabelNode = SKLabelNode()
    var nombreNotePris: Int = 0
    var Moyenne:Float = 0
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var marks:String = ""
    // intervalle de temps entre l'apparition des notes
    var noteTimer:Timer = Timer()
    // tableau de notes possible de 0 a 20
    var possibleNotes = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

    // compte a rebours du jeu de 60 seconds
    var TimerLabel:SKLabelNode = SKLabelNode()
    var gameInt: Int = 0 {
        didSet{
            TimerLabel.text = " Timer: \(gameInt)"
        }

    }
    var gameTimer = Timer()
    
    override func didMove(to view: SKView) {
        // initialisation des variables physics de la scene
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        minX=frame.minX
        minY=frame.minY
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: minX-10 , y: minY-10 , width: frame.width , height: frame.height))   // création d'un rectangle qui sera le contour de la scene
        
        
        
        let audioFileURL = Bundle.main.url(forResource: "gamra", withExtension: "mp3")  // importation de la musique de font
        do {
            let sound = try AVAudioPlayer(contentsOf: audioFileURL!) //récupération de l'url de la musique
            audioPlayer = sound
            sound.play() //  lancement de la musique
        } catch {
            // couldn't load file :(
        }
        
        let background = SKSpriteNode(imageNamed: "backgroung")  // image de fond , sa position et sa taille
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.size.width = frame.size.width
        background.size.height = frame.size.height
        
        background.zPosition = -1
        
        self.addChild(background) // ajoute du background dans la scene
        //  création SKSpriteNode player qui sera notre joueur
        // Sa position initial et sa physic
        // ajoute des variable de collision
        player = SKSpriteNode(imageNamed : "repose")
        player.name = "player"
        player.zPosition = 0
        player.position = CGPoint(x: player.size.width/2, y: player.size.height/2 + 1000)
        player.anchorPoint = CGPoint(x: 0, y: 0)
        player.physicsBody?.isDynamic = false
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = collisionPlayer
        player.physicsBody?.collisionBitMask = collisionNote
        player.physicsBody?.contactTestBitMask = 0
        
        //ajoute du joueur a la scene
        self.addChild(player)
        
        // cration de du label score qui sera afficher sur la scene
        scoreLabel = SKLabelNode(text : "Score : 0")
        scoreLabel.fontName = "Helvetica Neue"
        scoreLabel.position = CGPoint(x: 100, y: self.frame.size.height - 60)
        scoreLabel.fontColor = UIColor.red
        scoreLabel.fontSize = 42
        score = 0
        
        
        self.addChild(scoreLabel)
        TimerLabel = SKLabelNode(text : "Timer : 0")
        TimerLabel.fontName = "Helvetica Neue"
        TimerLabel.position = CGPoint(x: self.frame.size.width - 100 , y: self.frame.size.height - 60)
        TimerLabel.fontColor = UIColor.yellow
        TimerLabel.fontSize = 42
        gameInt = variableNote.temps
        
        self.addChild(TimerLabel)
 
        noteTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addNotes), userInfo: nil, repeats: true)
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Timegame), userInfo: nil, repeats: true)
       
    }
    @objc func addNotes() {
        
        // valeur ramdom dans le tableau de valeur de 0 a 20
        possibleNotes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleNotes) as! [Int]
        let note = SKSpriteNode(imageNamed: "\(possibleNotes[0])")
        note.name = "\(possibleNotes[0])"
        
        // valeur aleatoire pour la position en Y
        let randomNotesPosition = GKRandomDistribution(lowestValue: 0, highestValue: 1334)
        let position = CGFloat(randomNotesPosition.nextInt())
        

        // initialisation des variable des notes : position , la physics et la position en Z
        note.position = CGPoint(x: self.frame.size.width + note.size.width , y: position)

        note.physicsBody = SKPhysicsBody(rectangleOf: note.size)
        note.physicsBody?.isDynamic = true
        note.zPosition = 1

        // variables pour detecter la collision
        note.physicsBody?.categoryBitMask = collisionNote
        note.physicsBody?.contactTestBitMask = collisionPlayer
        note.physicsBody?.collisionBitMask = 0

        
        //ajoute de la note a la scene
        self.addChild(note)


        let dureeAnime:TimeInterval = 6
        

        // creation de la  table d'action de la note
        var tableauAction = [SKAction]()
        tableauAction.append(SKAction.move(to: CGPoint(x: -note.size.width, y: position), duration: dureeAnime))
        tableauAction.append(SKAction.removeFromParent())

        note.run(SKAction.sequence(tableauAction))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // fonction pour la detection de la collision entre la note et le joueur ou bien  avec le mur
        // la verification est fait grace a contact au valeur attribuer au mur , joueur et la note
        var Premierobjet:SKPhysicsBody
        var Secondobjet:SKPhysicsBody

        if ((contact.bodyA.categoryBitMask == collisionNote && contact.bodyB.categoryBitMask == collisionPlayer) || (contact.bodyB.categoryBitMask == collisionNote && contact.bodyA.categoryBitMask == collisionPlayer) )
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
        if ((contact.bodyA.categoryBitMask == collisionNote && contact.bodyB.categoryBitMask == collisionscene) || (contact.bodyB.categoryBitMask == collisionNote && contact.bodyA.categoryBitMask == collisionscene) )
        {
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                Premierobjet = contact.bodyA
                Secondobjet = contact.bodyB
                
            } else {
                Secondobjet = contact.bodyA
                Premierobjet = contact.bodyB
                
            }
            
            if (Premierobjet.categoryBitMask & collisionNote) != 0 && (Secondobjet.categoryBitMask & collisionPlayer) != 0{
                WallVsNote(Note20: Premierobjet.node as! SKSpriteNode )
            } else {
                WallVsNote(Note20: Secondobjet.node as! SKSpriteNode )            }
        }
    }
    
    
    // fonction qui lors d'une collision recupère la valeur de la note et l'incrémente au score
    // incrémente le nombre de note récupérer
    // et supprime l'image de la scene


    func PlayerVsNote(Note20:SKSpriteNode){
        let nameNote:String = Note20.name!
        Note20.removeFromParent()

        score+=Int(nameNote)!
        if (Int(nameNote)! > 15){
            gameInt = gameInt + 2
        }else if(Int(nameNote)! < 10) { gameInt = gameInt - 2 }
        
        nombreNotePris += 1

    }
    func WallVsNote(Note20:SKSpriteNode){
        Note20.removeFromParent()
        
        
    }
    
    
    @objc func Timegame() {
        // timer il decrement de 1 la valeur gameInt qui est notre timer
        gameInt -= 1
        
        // test si le timer est arriver a zéro si oui il récupère les donnée dans la struct StrucScore et transite vers GameO qui est la vue du temps terminer
        if gameInt <= 0 {
            self.audioPlayer.pause()
            Moyenne = Float(score) / Float(nombreNotePris)
            StrucScore.ScoreduJeu = score
            StrucScore.MoyenneduJeu = Moyenne
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "FinView")
//            
//            vc.view.frame = (self.view?.frame)!
//            vc.view.layoutIfNeeded()
//
//            UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
//                {
//                    self.view?.window?.rootViewController = vc
//            }, completion: { completed in
//
//            })
            let reveal = SKTransition.doorsCloseHorizontal(withDuration: 0.6)
            let GameOver = GameO(size: self.size)
            GameOver.scoreLabel.text = String(score)
            self.view?.presentScene(GameOver, transition: reveal)
        }
        
    }
    func moveDown(){
        // action de deplacement verticale (descendre)
        // let wait:SKAction = SKAction.wait(duration:0.2)
        let descendreAnime:SKAction = SKAction(named: "descendre")!
        let moveAction:SKAction = SKAction.move(by: CGVector(dx:0,dy:-100), duration: 1)
        
        let group:SKAction = SKAction.group([descendreAnime,moveAction])
        player.run(group)
    }
    func moveUP(){
        // action de deplacement verticale (monter)
        let monterAnime:SKAction = SKAction(named: "monter")!
        let moveAction:SKAction = SKAction.move(by: CGVector(dx:0,dy:100), duration: 1)
        
        let group:SKAction = SKAction.group([monterAnime,moveAction])
        player.run(group)
    }
    func touchDown(atPoint pos : CGPoint) {
        
        //dectection de l'endroit ou clique la souris
        //dans la moitier haute de l'écran il monte
        // moitier bas il descend
//        if (pos.y > self.frame.height/2){
//           moveUP()
//        }else {
//            moveDown()
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
        for t in touches { self.touchDown(atPoint: t.location(in: self))
            if (t.location(in: self).y > self.frame.height/2){
                moveUP()
            }else {
                moveDown()
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
         for t in touches { self.touchMoved(toPoint: t.location(in: self))
            break
        }
        
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

