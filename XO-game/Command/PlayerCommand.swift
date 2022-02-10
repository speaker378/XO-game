//
//  PlayerCommand.swift
//  XO-game
//
//  Created by Сергей Черных on 10.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class PlayerCommand {
    private var gameboardView: GameboardView
    private var position: GameboardPosition
    private var gameboard: Gameboard
    private var player: Player

    init(gameboardView: GameboardView, gameboard: Gameboard, position: GameboardPosition, player: Player) {
        self.gameboardView = gameboardView
        self.gameboard = gameboard
        self.position = position
        self.player = player
    }

    func execute() {
        if gameboardView.canPlaceMarkView(at: position) {
            gameboard.setPlayer(player, at: position)
            gameboardView.placeMarkView(getMarkView(), at: position)
        }
    }

    private func getMarkView() -> MarkView {
        switch player {
        case .first:
            return XView()
        case .second:
            return OView()
        }
    }
}
