//
//  Logger.swift
//  XO-game
//
//  Created by Сергей Черных on 03.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

// MARK: - Receiver

final class Logger {
    func writeMessageToLog(_ message: String) {
        /// Здесь должна быть реализация записи сообщения в лог.
        /// Для простоты примера паттерна не вдаемся в эту реализацию,
        /// а просто печатаем текст в консоль.
        print(message)
    }
}
