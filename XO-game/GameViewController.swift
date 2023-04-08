//
//  GameViewController.swift
//  XO-game
//
//  Created by Кукоба Александр on 08/04/2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.gameboardView.placeMarkView(XView(), at: position)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        
    }
}

