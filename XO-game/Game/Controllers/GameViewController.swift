//
//  GameViewController.swift
//  XO-game
//
//  Created by Кукоба Александр on 08/04/2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    //MARK: Properties
    var gameMode: GameMode = .withHuman
    private lazy var gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    private lazy var referee = Referee(gameboard: self.gameboard)
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }
    
    //MARK: Button Actions
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        log(.restartGame)
        gameboard.clear()
        self.gameboardView.clear()
        //rootView.nextButton.isHidden = true
        gameboard.firstPlayerpositions = []
        gameboard.secondPlayerpositions = []
        self.goToFirstState()
    }
    
    //MARK: Private functions
    private func goToFirstState() {
        let player = Player.first
        switch gameMode {
        case .withHuman, .withAI:
            self.currentState = PlayerInputState(player: .first, markViewPrototype: player.markViewPrototype , gameVC: self, gameboard: gameboard, gameboardView: self.gameboardView)
        case .blindGame:
            self.currentState = PlayerInputBGState(player: .first, markViewPrototype: player.markViewPrototype , gameVC: self, gameboard: gameboard, count: 0, gameboardView: self.gameboardView)
        }
    }
    
    public func goToNextState() {
     
        switch gameMode {
        case .withHuman:
            guard !isEndGame() else {return}
            
            if let playerInputState = currentState as? PlayerInputState {
             let player = playerInputState.player.next
             self.currentState = PlayerInputState(player: player, markViewPrototype: player.markViewPrototype, gameVC: self, gameboard: gameboard, gameboardView: self.gameboardView)
            }
        case .withAI:
            guard !isEndGame() else {return}
        
          if let playerInputState = currentState as? PlayerInputState {
               let player = playerInputState.player.next
               self.currentState = AIInputState(isCompleted: false, markViewPrototype: player.markViewPrototype, player: player, gameVC: self, gameboard: gameboard, gameboardView: self.gameboardView)
           }
           if let playerInputState = currentState as? AIInputState {
               let player = playerInputState.player.next
               self.currentState = PlayerInputState( player: player, markViewPrototype: player.markViewPrototype, gameVC: self, gameboard: gameboard, gameboardView: self.gameboardView)
           }
        case .blindGame:
            if let playerInputState = currentState as? PlayerInputBGState {
                var player = playerInputState.player
                var prototype = player.markViewPrototype
                if playerInputState.count < 5 {
                    self.currentState = PlayerInputBGState(player: player, markViewPrototype: prototype, gameVC: self, gameboard: gameboard, count: playerInputState.count, gameboardView: self.gameboardView)
                    
                } else {
                    self.gameboardView.clear()
                    player = player.next
                    prototype = player.markViewPrototype
                    if playerInputState.player == .second {
                        self.currentState = BlindGameState(player: player, markViewPrototype: prototype, gameVC: self, gameboard: gameboard, gameboardView: self.gameboardView)
                    }
                    else {
                        self.currentState = PlayerInputBGState(player: player, markViewPrototype: prototype, gameVC: self, gameboard: gameboard, count: 0, gameboardView: self.gameboardView)
                    }
                }
            } else if let playerInputState = currentState as? BlindGameState {
                guard !isEndGame() else {return}
                
                let player = playerInputState.player.next
                self.currentState = BlindGameState(player: player, markViewPrototype: player.markViewPrototype, gameVC: self, gameboard: gameboard, gameboardView: self.gameboardView)
            }
        }
    }
    
    private func isEndGame() -> Bool {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameVC: self)
            return true
        } else  if gameboard.friendshipCase() {
            self.currentState = GameEndedState(winner: nil, gameVC: self)
            return true
        }
        return false
    }
}

