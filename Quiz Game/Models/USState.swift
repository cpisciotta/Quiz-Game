//
//  USState.swift
//  Quiz Game
//
//  Created by Charles Pisciotta on 6/21/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import Foundation

struct USState {
    let name: String
    let abbreviation: String
    let capital: String

    var imageName: String { name }

    init(name: String, abbreviation: String, capital: String) {
        self.name = name
        self.abbreviation = abbreviation
        self.capital = capital
    }
}


// MARK: - Decodable Conformance

extension USState: Decodable {

    enum CodingKeys: String, CodingKey {
        case name = "state", abbreviation, capital
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let name = try container.decode(String.self, forKey: .name)
        let abbreviation = try container.decode(String.self, forKey: .abbreviation)
        let capital = try container.decode(String.self, forKey: .capital)

        self.init(name: name, abbreviation: abbreviation, capital: capital)
    }

}


// MARK: - Custom Debug String Convertible Conformance

extension USState: CustomDebugStringConvertible {

    var debugDescription: String {
        """
        State: \(name)
        Abbreviation: \(abbreviation)
        Capital: \(capital)
        """
    }

}
