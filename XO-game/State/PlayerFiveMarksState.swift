//
//  PlayerFiveMarksState.swift
//  XO-game
//
//  Created by Сергей Черных on 09.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class PlayerFiveMarksState: GameState {
    public private(set) var isCompleted = false
    public let player: Player
    public let markViewPrototype: MarkView
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    private let maxMark = 5
    static var playerMarks: [Player: [GameboardPosition]] = [:]

    init(player: Player, markViewPrototype: MarkView, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
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
    }

    public func addMark(at position: GameboardPosition) {
        Log(.playerInput(player: player, position: position))
        guard let gameboardView = self.gameboardView,
              gameboardView.canPlaceMarkView(at: position) else { return }

        self.gameboard?.setPlayer(self.player, at: position)
        self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)

        if PlayerFiveMarksState.playerMarks[player] == nil {
            PlayerFiveMarksState.playerMarks[player] = [position]
        } else {
            PlayerFiveMarksState.playerMarks[player]?.append(position)
        }

        if PlayerFiveMarksState.playerMarks[player]?.count == maxMark {
            isCompleted = true
            runGame()
            return
        }
    }

    private func runGame() {
        guard
            let gameboardView = self.gameboardView,
            let gameboard = self.gameboard
        else { return }

        gameboard.clear()
        gameboardView.clear()

        guard
            PlayerFiveMarksState.playerMarks.count == 2,
            let positionsFirstPlayer = PlayerFiveMarksState.playerMarks[.first],
            let positionsSecondPlayer = PlayerFiveMarksState.playerMarks[.second]
        else { return }

        let now = DispatchTime.now()

        for i in 0 ..< maxMark {
            gameboard.setPlayer(.first, at: positionsFirstPlayer[i])
            gameboard.setPlayer(.second, at: positionsSecondPlayer[i])

            DispatchQueue.main.asyncAfter(deadline: now + 0.53 + Double(i)) {
                gameboardView.placeMarkView(XView(), at: positionsFirstPlayer[i])
            }
            DispatchQueue.main.asyncAfter(deadline: now + 0.89 + Double(i)) {
                gameboardView.placeMarkView(OView(), at: positionsSecondPlayer[i])
            }
        }
        PlayerFiveMarksState.playerMarks = [:]
    }
}
