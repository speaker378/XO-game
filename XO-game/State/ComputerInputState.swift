//
//  ComputerInputState.swift
//  XO-game
//
//  Created by Сергей Черных on 09.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation


class ComputerInputState: GameState {
    public private(set) var isCompleted = false
    public let player: Player
    public let markViewPrototype: MarkView
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?

    init(player: Player, markViewPrototype: MarkView, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }

    private func getFreePosition() -> GameboardPosition? {
        guard let gameboardView = gameboardView else { return nil }
        var freePositions: [GameboardPosition] = []

        for col in 0...GameboardSize.columns - 1 {
            for row in 0...GameboardSize.rows - 1 {
                let position = GameboardPosition(column: col, row: row)
                if gameboardView.canPlaceMarkView(at: position) {
                    freePositions.append(position)
                }
            }
        }
        return freePositions.randomElement()
    }

    public func begin() {
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true

        guard let position = getFreePosition() else { return }
        gameboardView?.onSelectPosition?(position)
    }

    public func addMark(at position: GameboardPosition) {
        Log(.playerInput(player: self.player, position: position))

        self.gameboard?.setPlayer(self.player, at: position)
        self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        self.isCompleted = true
    }
}
