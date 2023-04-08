//
//  LogAction.swift
//  XO-game
//
//  Created by Александр Кукоба on 08.04.2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import Foundation

public enum LogAction {
    case playerInput(player: Player, position: GameboardPosition)
    case gameFinished(winner: Player?)
    case restartGame
}

public func log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LogInvoker.shared.addLogCommand(command)
}
