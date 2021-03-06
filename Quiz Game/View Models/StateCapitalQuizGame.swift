//
//  StateCapitalQuizGame.swift
//  Quiz Game
//
//  Created by Charles Pisciotta on 6/18/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import SwiftUI
import Combine

class StateCapitalQuizGame: ObservableObject {

    // MARK: - Model

    @Published private var quizGame: QuizGame<USState, String>


    // MARK: - View Properties

    @Published private(set) var quizItem: QuizGame<USState, String>.QuizItem?
    @Published private(set) var answerOptions = [String]()

    var isOver: Bool { quizGame.isOver }
    
    var questionNumber: Int { quizGame.currentIndex + 1 }
    lazy var numberOfQuestions: Int = self.quizGame.items.count

    var percentage: Float {
        Float(quizGame.items.filter { $0.answeredCorrect == true }.count) / Float(quizGame.items.count)
    }

    // MARK: - File Constants

    private static let filename: String = "states_array"


    // MARK: - Initializer

    init() {
        self.quizGame = StateCapitalQuizGame.createStateCapitalQuizGame()
        self.getNext()
        self.start()
    }


    // MARK: - Start Game

    func startGame() {
        self.quizGame = StateCapitalQuizGame.createStateCapitalQuizGame()
        getNext()
        self.start()
    }


    // MARK: - Methods

    private func getNext() {
        if let item = quizGame.getNext() {
            self.quizItem = item
            self.answerOptions = quizGame.getAnswerOptions(excluding: item, numWrongOptions: 3, keyPath: \.answer)
            self.timeLeft = 5
        } else {
            self.quizItem = nil
            self.timer?.cancel()
        }
    }

    func selectAnswer(guess: String) {
        quizGame.setGuess(for: quizItem!, as: guess)
        getNext()
    }

    private(set) var timer: AnyCancellable?

    @Published var timeLeft: Int = 5

    private func start() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                if self.timeLeft > 0 {
                    self.timeLeft -= 1
                } else {
                    self.getNext()
                }
            })
    }
}

extension StateCapitalQuizGame {

    private static func createStateCapitalQuizGame() -> QuizGame<USState, String> {
        let fileLoader = FileLoader<[USState]>()

        switch fileLoader.loadLocalJSON(named: filename) {
        case .failure(let error):
            fatalError(error.localizedDescription)
        case.success(let states):
            return QuizGame<USState, String>(gameContent: states) {
                .init(question: "What is the capital of \($0.name)?",
                    answer: $0.capital,
                    imageName: $0.imageName)
            }
        }

    }

}
