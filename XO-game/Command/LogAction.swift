//
//  LogAction.swift
//  XO-game
//
//  Created by Сергей Черных on 03.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

public enum LogAction {
    case playerInput(player: Player, position: GameboardPosition)
    case gameFinished(winner: Player?)
    case restartGame
}

public func Log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addLogCommand(command)
}
