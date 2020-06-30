//
//  TimeLeftView.swift
//  Quiz Game
//
//  Created by Charles Pisciotta on 6/22/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import SwiftUI

struct TimeLeftView: View {

    @Binding var timeLeft: Int

    func getFillColor(for index: Int) -> Color {
        if timeLeft >= index {
            return currentColor
        } else {
            return .clear
        }
    }

    func getStrokeColor() -> Color {
        return currentColor
    }

    var currentColor: Color {
        switch timeLeft {
        case 0...1: return .red
        case 2...3: return .yellow
        case 4...5: return .green
        default: fatalError()
        }
    }

    var body: some View {

        HStack(spacing: 15) {
            ForEach(1..<6) { index in
                Circle()
                    .foregroundColor(self.getFillColor(for: index))
                    .overlay(
                        Circle().stroke(self.currentColor, lineWidth: 1)
                )
                    .frame(width: 30, height: 30)
            }
        }

    }
}

struct TimeLeftView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLeftView(timeLeft: .constant(3))
    }
}
