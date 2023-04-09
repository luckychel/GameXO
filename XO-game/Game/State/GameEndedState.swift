//
//  GameEndedState.swift
//  XO-game
//
//  Created by Александр Кукоба on 08.04.2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import Foundation

public class GameEndedState: GameState {

    public let isCompleted = false
    public let winner: Player?
    private(set) weak var gameVC: GameViewController?
    
    init(winner: Player?, gameVC: GameViewController) {
        self.winner = winner
        self.gameVC = gameVC
    }
    
    public func begin() {
        
        self.gameVC?.winnerLabel.isHidden = false
        if let winner = winner {
            self.gameVC?.winnerLabel.text = self.getWinnerName(from: winner) + " win"
        } else {
            
            self.gameVC?.winnerLabel.text = "No winner"
        }
        //self.gameVC?.nextButton.isHidden = true
        self.gameVC?.firstPlayerTurnLabel.isHidden = true
        self.gameVC?.secondPlayerTurnLabel.isHidden = true
        log(.gameFinished(winner: self.winner))
    }
    
    private func getWinnerName( from winner: Player) -> String {
        switch winner {
        case .first: return "1st player"
        case .second: return "2nd player"
        }
    }
    
    public func addMark(at position: GameboardPosition) {}
}
