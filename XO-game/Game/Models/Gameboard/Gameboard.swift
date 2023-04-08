//
//  Gameboard.swift
//  XO-game
//
//  Created by Кукоба Александр on 08/04/2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import Foundation

public final class Gameboard {
    
    // MARK: - Properties
    
    public lazy var positions: [[Player?]] = initialPositions()
    
    public lazy var firstPlayerpositions: [GameboardPosition] = []
    public lazy var secondPlayerpositions: [GameboardPosition] = []
    
    // MARK: - public
    
    public func setPlayer(_ player: Player, at position: GameboardPosition) {
        positions[position.column][position.row] = player
    }
    
    public func clear() {
        self.positions = initialPositions()
    }
    
    public func contains(player: Player, at positions: [GameboardPosition]) -> Bool {
        for position in positions {
            guard contains(player: player, at: position) else {
                return false
            }
        }
        return true
    }
    
    public func contains(player: Player, at position: GameboardPosition) -> Bool {
        let (column, row) = (position.column, position.row)
        return positions[column][row] == player
    }
    
    public func friendshipCase() -> Bool {
        for i in 0 ..< GameboardSize.columns {
            for j in 0 ..< GameboardSize.rows {
                if positions[i][j] == nil {
                    return false
                }
            }
        }
        return true
    }
    
    // MARK: - Private
    
    private func initialPositions() -> [[Player?]] {
        var positions: [[Player?]] = []
        for _ in 0 ..< GameboardSize.columns {
            let rows = Array<Player?>(repeating: nil, count: GameboardSize.rows)
            positions.append(rows)
        }
        return positions
    }
}
