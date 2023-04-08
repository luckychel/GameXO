//
//  LogInvoker.swift
//  XO-game
//
//  Created by Александр Кукоба on 08.04.2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import Foundation

internal final class LogInvoker {
    internal static let shared = LogInvoker()
    
    private let logger = Logger()
    private let batchSize = 3
    private var commands: [LogCommand] = []
    
    internal func addLogCommand(_ command: LogCommand) {
        self.commands.append(command)
        self.executeCommandsIfNeeded()
    }
    
    private func executeCommandsIfNeeded() {
        guard self.commands.count >= batchSize else {
            return
        }
        self.commands.forEach { self.logger.writeMassageToLog($0.logMessage) }
        self.commands = []
    }
}
