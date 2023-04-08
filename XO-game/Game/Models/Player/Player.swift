//
//  Player.swift
//  XO-game
//
//  Created by Кукоба Александр on 08/04/2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import Foundation

public enum Player: CaseIterable {
    case first
    case second
    
    var next: Player {
        switch self {
        case .first: return .second
        case .second: return .first
        }
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first: return XView()
        case .second: return OView()
        }
    }
}
