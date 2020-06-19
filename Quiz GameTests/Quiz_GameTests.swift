//
//  Quiz_GameTests.swift
//  Quiz GameTests
//
//  Created by Charles Pisciotta on 6/19/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import XCTest
@testable import Quiz_Game

class Quiz_GameTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let one = StateCapitalQuizGame.USStateItem.init(name: "One", abbreviation: "ABC", capital: "AJK")
        let two = StateCapitalQuizGame.USStateItem.init(name: "TWO", abbreviation: "DEF", capital: "ALOS")
        let three = StateCapitalQuizGame.USStateItem.init(name: "THE", abbreviation: "GFI", capital: "SOME")
        let four = StateCapitalQuizGame.USStateItem.init(name: "FOUR", abbreviation: "XCY", capital: "DNDJ")

        let x = [one, two, three, four]

        let vals = x.nRandomWrongAnswersPlusCorrect(excludedElement: one, numWrongAnswers: 2, keyPath: \.capital)
        print(vals)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
