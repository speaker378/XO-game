//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!

    var gameMode: GameMode!
    private let gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    private lazy var referee = Referee(gameboard: self.gameboard)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }

    private func goToFirstState() {
        let player = Player.first

        switch gameMode {
        case .twoPlayers, .computer:
            currentState = PlayerInputState(player: .first,
                                            markViewPrototype: player.markViewPrototype,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView)
        default: break
        }
    }

    private func goToNextState() {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        if self.referee.noWinners() {
            self.currentState = GameEndedState(winner: nil, gameViewController: self)
            return
        }

        var player = Player.first
        if let playerInputState = currentState as? PlayerInputState {
            player = playerInputState.player.next
        }
        if let playerComputerState = currentState as? ComputerInputState {
            player = playerComputerState.player.next
        }

        switch gameMode {
        case .twoPlayers:
            currentState = PlayerInputState(player: player,
                                            markViewPrototype: player.markViewPrototype,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView)
        case .computer:
            switch player {
            case .first:
                currentState = PlayerInputState(player: .first,
                                                markViewPrototype: player.markViewPrototype,
                                                gameViewController: self,
                                                gameboard: gameboard,
                                                gameboardView: gameboardView)
            case .second:
                currentState = ComputerInputState(player: .second,
                                                  markViewPrototype: player.markViewPrototype,
                                                  gameViewController: self,
                                                  gameboard: gameboard,
                                                  gameboardView: gameboardView)
            }
        default: break
        }
    }

    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(.restartGame)
        self.dismiss(animated: true, completion: nil)
    }
}

