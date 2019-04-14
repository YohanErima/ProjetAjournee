//
//  FinView.swift
//  ProjetAjournee
//
//  Created by etudiant on 11/04/2019.
//  Copyright © 2019 etudiant. All rights reserved.
//

import UIKit

class FinView: UIViewController {

    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var ButtonSave: UIButton!
    @IBOutlet weak var Accueil: UIButton!
    @IBOutlet weak var Moyenne: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreLabel.text = String(StrucScore.ScoreduJeu)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Save(_ sender: Any) {
    }
    @IBAction func RetourAccueil(_ sender: Any) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
