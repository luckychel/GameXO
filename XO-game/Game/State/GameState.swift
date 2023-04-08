//
//  GameState.swift
//  XO-game
//
//  Created by Александр Кукоба on 08.04.2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import Foundation

public protocol GameState {
    var isCompleted: Bool { get }
    
    func begin()
    
    func addMark( at position: GameboardPosition )
}
