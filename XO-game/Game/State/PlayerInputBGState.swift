//
//  PlayerInputBGState.swift
//  XO-game
//
//  Created by Александр Кукоба on 08.04.2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import Foundation

class PlayerInputBGState: GameState {
    
    public private(set) var isCompleted = false
    public let markViewPrototype: MarkView
    public let player: Player
    public var count: Int!
    private(set) weak var gameVC: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    init(player: Player, markViewPrototype: MarkView, gameVC: GameViewController, gameboard: Gameboard, count: Int, gameboardView: GameboardView) {
        self.player = player
        self.count = count
        self.markViewPrototype = markViewPrototype
        self.gameVC = gameVC
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    public func begin() {
            switch self.player {
            case .first:
                self.gameVC?.firstPlayerTurnLabel.isHidden = false
                self.gameVC?.secondPlayerTurnLabel.isHidden = true
            case .second:
                self.gameVC?.firstPlayerTurnLabel.isHidden = true
                self.gameVC?.secondPlayerTurnLabel.isHidden = false
            }
        self.gameVC?.winnerLabel.isHidden = true

    }
    
    public func addMark(at position: GameboardPosition) {
        guard let gameboardView = self.gameboardView,
              gameboardView.canPlaceMarkView(at: position) else {
            return
        }
        switch self.player{
        case .first:
            self.gameboard?.firstPlayerpositions.append(position)
        case .second:
            self.gameboard?.secondPlayerpositions.append(position)
        }
        
        self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        count += 1
        self.isCompleted = true
    }
    
}
