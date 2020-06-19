//
//  StateCapitalQuizGame.swift
//  Quiz Game
//
//  Created by Charles Pisciotta on 6/18/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import SwiftUI

class StateCapitalQuizGame: ObservableObject {
    
    // MARK: - Model
    
    @Published private var quizGame: QuizGame<USStateItem>
    
    
    // MARK: - View Properties
    
    @Published private(set) var stateItem: QuizGame<USStateItem>.Item?
    @Published private(set) var answerOptions = [String]()
    
    private static let filename = "states_array"
    
    var isOver: Bool { quizGame.isOver }

    var percentage: Float {
        Float(quizGame.items.filter { $0.answeredCorrect == true }.count) / Float(quizGame.items.count)
    }
    
    
    // MARK: - Initializer
    
    init() {
        self.quizGame = StateCapitalQuizGame.createStateCapitalQuizGame()
        getNext()
    }
    
    
    // MARK: - Start Game
    
    func startGame() {
        self.quizGame = StateCapitalQuizGame.createStateCapitalQuizGame()
        getNext()
    }
    
    
    // MARK: - Methods
    
    private func getNext() {
        if let item = quizGame.getNext() {
            self.stateItem = item
            self.answerOptions = quizGame.getAnswerOptions(excluding: item, numWrongOptions: 3, keyPath: \.content.capital)
        } else {
            self.stateItem = nil
        }
    }
    
    @discardableResult
    func selectAnswer(guess: String) -> Bool {
        guard let stateItem = stateItem else {
            fatalError("State should not be nil when checking answer")
        }
        
        let isCorrect = quizGame.checkAnswer(for: stateItem, answer: \.content.capital, withGuess: guess)
        
        print(isCorrect ? "Correct!" : "Incorrect: \(stateItem.content.capital)")
        
        getNext()
        
        return isCorrect
    }
    
}

extension StateCapitalQuizGame {
    
    private static func createStateCapitalQuizGame() -> QuizGame<USStateItem> {
        let fileLoader = FileLoader<[USStateItem]>()
        
        switch fileLoader.loadLocalJSON(named: filename) {
        case .failure(let error):
            fatalError(error.localizedDescription)
        case.success(let states):
            return QuizGame<USStateItem>(content: states) { .init(content: $0) }
        }
        
    }
    
}

extension StateCapitalQuizGame {
    
    struct USStateItem: Identifiable, Equatable {
        let id: UUID
        let name: String
        let abbreviation: String
        let capital: String
        
        var imageName: String { name }
        
        init(id: UUID = UUID(), name: String, abbreviation: String, capital: String) {
            self.id = id
            self.name = name
            self.abbreviation = abbreviation
            self.capital = capital
        }
    }
    
}

extension StateCapitalQuizGame.USStateItem: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case name = "state", abbreviation, capital, id
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = UUID()
        self.name = try values.decode(String.self, forKey: .name)
        self.abbreviation = try values.decode(String.self, forKey: .abbreviation)
        self.capital = try values.decode(String.self, forKey: .capital)
    }
    
}


extension StateCapitalQuizGame.USStateItem: CustomDebugStringConvertible {
    
    var debugDescription: String {
        """
        State: \(name)
        Abbreviation: \(abbreviation)
        Capital: \(capital)
        """
    }
    
}
