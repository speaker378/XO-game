//
//  MenuViewController.swift
//  XO-game
//
//  Created by Сергей Черных on 09.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var gameModeControl: UISegmentedControl!
    @IBOutlet weak var newGameButton: UIButton!
    var gameMode: GameMode = .twoPlayers

    @IBAction func gameModeControlChange(_ sender: Any) {
        switch gameModeControl.selectedSegmentIndex {
        case 0:
            gameMode = .twoPlayers
        case 1:
            gameMode = .computer
        case 2:
            gameMode = .fiveMarks
        default:
            gameMode = .twoPlayers
        }
    }

    @IBAction func newGameButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "gameSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           switch segue.identifier {
           case "gameSegue":
               guard let gameVC = segue.destination as? GameViewController else { return }
               gameVC.gameMode = self.gameMode
           default:
               break
           }
       }
}
