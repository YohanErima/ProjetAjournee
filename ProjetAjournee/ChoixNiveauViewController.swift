//
//  ChoixNiveauViewController.swift
//  ProjetAjournee
//
//  Created by Lola RAOUX  on 14/04/2019.
//  Copyright © 2019 etudiant. All rights reserved.
//

struct variableNote {
    static var intervale: Float = 0
    static var deplacement : Int = 0
    static var temps: Int = 0
}

import UIKit

class ChoixNiveauViewController: UIViewController {

    @IBOutlet weak var L1: UIButton!
    @IBOutlet weak var L2: UIButton!
    @IBOutlet weak var L3: UIButton!
    @IBOutlet weak var M1: UIButton!
    @IBOutlet weak var M2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AcL1(_ sender: Any) {
        variableNote.intervale = 1
        variableNote.deplacement = 60

        variableNote.temps = 6
    }
    @IBAction func AcL2(_ sender: Any) {
        variableNote.intervale = 0.75
        variableNote.deplacement = 60
        variableNote.temps = 6
    }
    
    @IBAction func acL3(_ sender: Any) {
        variableNote.intervale = 0.75
        variableNote.deplacement = 80
        variableNote.temps = 4
        
    }
    
    @IBAction func acM1(_ sender: Any) {
        variableNote.deplacement = 60
        variableNote.intervale = 0.75
        variableNote.temps = 4
    }
    
    @IBAction func ACM2(_ sender: Any) {
        variableNote.deplacement = 60
        variableNote.intervale = 0.75
        variableNote.temps = 3
        


        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
