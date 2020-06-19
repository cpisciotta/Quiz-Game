//
//  FileLoader.swift
//  Quiz Game
//
//  Created by Charles Pisciotta on 6/18/20.
//  Copyright © 2020 Charles Pisciotta. All rights reserved.
//

import Foundation

struct FileLoader<Content> where Content: Decodable {

    func loadLocalJSON(named fileName: String) -> Result<Content, FileLoaderError> {

        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return .failure(.fileNotFound)
        }


        let data: Data

        do {
            data = try Data(contentsOf: fileURL)
        } catch {
            return .failure(.dataInvalid)
        }

        let value: Content

        do {
            value = try JSONDecoder().decode(Content.self, from: data)
        } catch {
            return .failure(.decodingFailure)
        }

        return .success(value)
    }

}

extension FileLoader {

    enum FileLoaderError: Error {
        case fileNotFound
        case dataInvalid
        case decodingFailure

        var localizedDescription: String {
            switch self {
            case .fileNotFound: return "File name likely incorrect."
            case .dataInvalid: return "File contents not decodable."
            case .decodingFailure: return "File contents cannot be converted to specified type."
            }
        }
    }

}
