//
//  AIInputState.swift
//  XO-game
//
//  Created by Александр Кукоба on 08.04.2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import Foundation

public class AIInputState: GameState {
    
    public private(set) var isCompleted: Bool = false
    public let markViewPrototype: MarkView
    public let player: Player
    private(set) weak var gameVC: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    init(isCompleted: Bool, markViewPrototype: MarkView, player: Player, gameVC: GameViewController? = nil, gameboard: Gameboard? = nil, gameboardView: GameboardView? = nil) {
        self.isCompleted = isCompleted
        self.markViewPrototype = markViewPrototype
        self.player = player
        self.gameVC = gameVC
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
   public func begin() {
       self.gameVC?.firstPlayerTurnLabel.isHidden = true
       self.gameVC?.secondPlayerTurnLabel.isHidden = false
       self.gameVC?.winnerLabel.isHidden = true

       var xIndex = Int.random(in: 0...2)
       var yIndex = Int.random(in: 0...2)
       
       while gameboard?.positions[xIndex][yIndex] != nil {
           xIndex = Int.random(in: 0...2)
           yIndex = Int.random(in: 0...2)
       }
       
       addMark(at: GameboardPosition(column: xIndex, row: yIndex))
       gameVC?.goToNextState()
    }
    
   public func addMark(at position: GameboardPosition) {
       guard let gameboardView = self.gameboardView,
             gameboardView.canPlaceMarkView(at: position) else {
           return
       }
       log(.playerInput(player: self.player, position: position))
       self.gameboard?.setPlayer(self.player, at: position)
       self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
       self.isCompleted = true
    }
}

