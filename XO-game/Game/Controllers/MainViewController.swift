//
//  MainViewController.swift
//  XO-game
//
//  Created by Александр Кукоба on 09.04.2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {


    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if shouldPerformSegue(withIdentifier: identifier, sender: sender) {
            super.performSegue(withIdentifier: identifier, sender: sender)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "segaToGame" {
            guard let sender = sender, sender as? GameMode != nil, let mode = sender as? GameMode else {
                return false
            }
            let vc: GameViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            vc.gameMode = mode
            self.navigationController?.pushViewController(vc, animated: true)
            return false
        }
        return true
    }
    
    //MARK: Button Actions
    @IBAction func TwoHuman(_ sender: UIButton) {
        performSegue(withIdentifier: "segaToGame", sender: GameMode.withHuman)
    }
    
    @IBAction func HumanAi(_ sender: UIButton) {
        performSegue(withIdentifier: "segaToGame", sender: GameMode.withAI)
    }
    
    
    @IBAction func BlindGame(_ sender: UIButton) {
        performSegue(withIdentifier: "segaToGame", sender: GameMode.blindGame)
    }
}
