//
//  QuizGame.swift
//  Quiz Game
//
//  Created by Charles Pisciotta on 6/18/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import Foundation

struct QuizGame<Content, T> where T: Equatable {

    private(set) var items: [QuizItem]

    private(set) var currentIndex: Int = -1
    private(set) var isOver: Bool = false


    // MARK: - Initializer

    init(gameContent: [Content], quizGameFactory: (Content) -> QuizItem) {
        var items = [QuizItem]()

        gameContent.forEach { items.append(quizGameFactory($0)) }

        self.items = items.shuffled()
    }


    // MARK: - Get next item in array

    /// Gets the next item from the quiz content array.
    mutating func getNext() -> QuizItem? {
        currentIndex += 1

        if items.indices.contains(currentIndex) {
            return items[currentIndex]
        } else {
            self.isOver = true
            return nil
        }
    }


    // MARK: - Set Answer

    mutating func setGuess(for item: QuizItem, as guess: T) {
        let index = items.index(of: item)
        self.items[index].setGuess(guess)
    }


    // MARK: - Get answer options

    func getAnswerOptions<T>(excluding item: QuizItem, numWrongOptions: Int, keyPath: KeyPath<QuizItem, T>) -> [T] {
        return items.nRandomWrongAnswersPlusCorrect(excludedElement: item, numWrongAnswers: numWrongOptions, keyPath: keyPath)
    }

}

extension QuizGame {

    struct QuizItem: Identifiable {

        private(set) var id: UUID = .init()

        let question: String
        let answer: T

        private(set) var guess: T? = nil

        var answeredCorrect: Bool? {
            if let guess = guess {
                return guess == answer
            } else {
                return nil
            }
        }

        let imageName: String

        init(question: String, answer: T, imageName: String) {
            self.question = question
            self.answer = answer
            self.imageName = imageName
        }

        mutating func setGuess(_ guess: T) {
            self.guess = guess
        }
    }
}

extension QuizGame.QuizItem: Equatable {

    static func ==(lhs: QuizGame.QuizItem, rhs: QuizGame.QuizItem) -> Bool {
        return lhs.id == rhs.id
    }

}

extension QuizGame.QuizItem: CustomDebugStringConvertible {

    var debugDescription: String {
        """
        Question: \(self.question)
        Correct Answer: \(self.answer)
        Guess: \(String(describing: self.guess))
        Answered Correct?: \(String(describing: self.answeredCorrect))
        """
    }

}
