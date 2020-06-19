//
//  QuizGame.swift
//  Quiz Game
//
//  Created by Charles Pisciotta on 6/18/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import Foundation

struct QuizGame<Content: Equatable> {

    private(set) var items: [Item]
    private var currentIndex: Int = -1

    private(set) var isOver: Bool = false


    // MARK: - Initializer

    init(content: [Content], gameContentFactory: (Content) -> Item) {

        precondition(!content.isEmpty, "Quiz content must not be empty!")

        // Initialize an empty local array of quiz items.
        var items = [Item]()

        // Add each element from content array to the list of items.
        content.forEach { items.append(gameContentFactory($0)) }

        // Shuffle the order of the items and add them to the items property.
        self.items = items.shuffled()
    }


    // MARK: - Get next item in array

    /// Gets the next item from the quiz content array.
    mutating func getNext() -> Item? {
        currentIndex += 1

        if items.indices.contains(currentIndex) {
            return items[currentIndex]
        } else {
            self.isOver = true
            return nil
        }
    }


    // MARK: - Check if answer is correct

    @discardableResult
    mutating func checkAnswer(for item: Item, answer: KeyPath<Item, String>, withGuess guess: String) -> Bool {

        let answeredCorrect = item[keyPath: answer].lowercased() == guess.lowercased()
        let index = items.index(of: item)

        self.items[index].setAnsweredCorrect(to: answeredCorrect)

        return answeredCorrect
    }


    // MARK: - Get answer options

    func getAnswerOptions<T>(excluding item: Item, numWrongOptions: Int, keyPath: KeyPath<Item, T>) -> [T] {
        return items.nRandomWrongAnswersPlusCorrect(excludedElement: item, numWrongAnswers: numWrongOptions, keyPath: keyPath)
    }

}

extension QuizGame {

    struct Item: Identifiable {
        private(set) var id: UUID
        private(set) var content: Content
        private(set) var answeredCorrect: Bool?

        init(id: UUID = UUID(), content: Content, asked: Bool = false, answeredCorrect: Bool? = nil) {
            self.id = id
            self.content = content
            self.answeredCorrect = answeredCorrect
        }

        mutating func setAnsweredCorrect(to value: Bool) {
            self.answeredCorrect = value
        }
    }

}

extension QuizGame.Item: Equatable {

    static func ==(lhs: QuizGame.Item, rhs: QuizGame.Item) -> Bool {
        return lhs.id == rhs.id
    }

}

extension QuizGame.Item: CustomDebugStringConvertible {

    var debugDescription: String {
        """
        \(content)
        
        """
    }

}
