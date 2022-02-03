//
//  GameState.swift
//  XO-game
//
//  Created by Сергей Черных on 03.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
  var isCompleted: Bool { get }
  func begin()
  func addMark(at position: GameboardPosition)
}
