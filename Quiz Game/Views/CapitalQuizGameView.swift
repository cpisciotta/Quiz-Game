//
//  CapitalQuizGameView.swift
//  Quiz Game
//
//  Created by Charles Pisciotta on 6/18/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import SwiftUI

struct CapitalQuizGameView: View {

    @ObservedObject var capitalsGame: StateCapitalQuizGame
    @State private var selectedOption: String = ""

    var body: some View {

        Group {
            if capitalsGame.isOver {
                VStack {

                    Spacer()

                    VStack(spacing: 20) {
                        Group {
                            if capitalsGame.percentage <= 0.6 {
                                Text("Better luck next time!")
                            } else if capitalsGame.percentage <= 0.85 {
                                Text("Just a little more practice!")
                            } else {
                                Text("You're a geography wiz!")
                            }
                        }
                        Text(String(format: "%02d%%", Int(capitalsGame.percentage * 100)))
                    }
                    .font(.largeTitle)
                    .foregroundColor(Color.getColorFromPercentage(capitalsGame.percentage))

                    Spacer()

                    GameButton(buttonTitle: "Play Again?", buttonType: .callToAction) {
                        self.capitalsGame.startGame()
                    }

                    Spacer()

                }
            } else if capitalsGame.quizItem != nil {

                VStack(spacing: 30) {

                    Text("\(capitalsGame.questionNumber) of \(capitalsGame.numberOfQuestions)")
                        .font(.title)

                    Text(capitalsGame.quizItem!.question)
                        .font(.title)
                        .padding(.horizontal)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .frame(height: 100)

                    Image(capitalsGame.quizItem!.imageName)
                        .resizable()
                        .frame(width: 200, height: 200)

                    AnswerButtons(capitalsGame: capitalsGame, answers: capitalsGame.answerOptions, selectedOption: $selectedOption)

                }

            } else {
                Text("Error! Implement this scenario!")
            }
        }
    }
}

struct CapitalQuizGameView_Previews: PreviewProvider {
    static var previews: some View {
        let capitalsGame = StateCapitalQuizGame()
        return CapitalQuizGameView(capitalsGame: capitalsGame)
    }
}

struct AnswerButtons: View {

    @ObservedObject var capitalsGame: StateCapitalQuizGame

    let answers: [String]
    @Binding var selectedOption: String

    var body: some View {
        VStack(spacing: 10) {
            ForEach(answers, id: \.self) { answer in
                GameButton(buttonTitle: answer, buttonType: .answerOption) {
                    self.capitalsGame.selectAnswer(guess: answer)
                }
            }
        }
    }
}
