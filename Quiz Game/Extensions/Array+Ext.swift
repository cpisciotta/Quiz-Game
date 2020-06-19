//
//  Array+Ext.swift
//  Quiz Game
//
//  Created by Charles Pisciotta on 6/19/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    func index(of item: Element) -> Int {
        self.firstIndex { $0 == item }!
    }

    func nRandomWrongAnswersPlusCorrect<T>(excludedElement: Element, numWrongAnswers: Int, keyPath: KeyPath<Element, T>) -> [T] {

        precondition(numWrongAnswers < self.count - 1, "numWrongAnswers must be less than the count of array.")

        let possibleElements = self.filter { $0 != excludedElement }

        var possibleAnswers = possibleElements.shuffled().prefix(numWrongAnswers).map { $0[keyPath: keyPath] }
        possibleAnswers.append(excludedElement[keyPath: keyPath])
        return possibleAnswers.shuffled()
    }

}
