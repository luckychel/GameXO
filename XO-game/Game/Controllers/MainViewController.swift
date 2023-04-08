//
//  MainViewController.swift
//  XO-game
//
//  Created by Александр Кукоба on 09.04.2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private let vc: GameViewController = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: Button Actions
    @IBAction func TwoHuman(_ sender: UIButton) {
        vc.gameMode = .withHuman
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func HumanAi(_ sender: UIButton) {
        vc.gameMode = .withAI
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func BlindGame(_ sender: UIButton) {
        vc.gameMode = .blindGame
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
