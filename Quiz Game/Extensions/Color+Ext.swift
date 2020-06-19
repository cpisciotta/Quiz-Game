//
//  Color+Ext.swift
//  Quiz Game
//
//  Created by Charles Pisciotta on 6/19/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import SwiftUI

extension Color {

    static func getColorFromPercentage(_ value: Float) -> Self {
        switch value {
        case _ where value >= 0.0 && value <= 0.6: return .red
        case _ where value > 0.6 && value <= 0.85: return .yellow
        case _ where value > 0.85 && value <= 1.0: return .green
        default: fatalError("\(value) is not considered a valid value.")
        }
    }

}
