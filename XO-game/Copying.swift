//
//  Copying.swift
//  XO-game
//
//  Created by Сергей Черных on 03.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol Copying {
    init(_ prototype: Self)
}

extension Copying {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}
