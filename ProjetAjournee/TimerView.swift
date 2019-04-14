//
//  TimerView.swift
//  ProjetAjournee
//
//  Created by etudiant on 11/04/2019.
//  Copyright © 2019 etudiant. All rights reserved.
//

import UIKit

class TimerView: UIViewController {
    
    var startInt = 3
    var startTimer = Timer()

    @IBOutlet weak var CompteRebours: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CompteRebours.text = String(startInt)
        // intervale a laquelle decrement le timer 
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerView.startGameTimer), userInfo: nil, repeats: true)

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func startGameTimer() {
        // compte a rebours avant lancement de la partie commençant a 3 et la fonction decrement de 1 a chaque fois
        startInt -= 1
        CompteRebours.text = String(startInt)
        if startInt == 0 {
            performSegue(withIdentifier: "Jouer", sender: nil)
    }
   
}
}
