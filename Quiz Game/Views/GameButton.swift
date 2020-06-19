//
//  GameButton.swift
//  Quiz Game
//
//  Created by Charles Pisciotta on 6/19/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import SwiftUI

struct GameButton: View {

    let id: UUID = UUID()
    let buttonTitle: String
    let buttonType: ButtonType
    let action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(self.buttonTitle)
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: 75)
        .foregroundColor(.white)
        .background(buttonType.color)
        .cornerRadius(10.0)
    }
}

struct GameButton_Previews: PreviewProvider {
    static var previews: some View {

        VStack(spacing: 10) {
            ForEach(1..<5) { _ in
                GameButton(buttonTitle: "Check", buttonType: .answerOption) {
                    print("Check")
                }
            }
        }
    }
}

extension GameButton {

    enum ButtonType {
        case answerOption
        case callToAction

        var color: Color {
            switch self {
            case .answerOption: return .green
            case .callToAction: return .blue
            }
        }
    }

}
