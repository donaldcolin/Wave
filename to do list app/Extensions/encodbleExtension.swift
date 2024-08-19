//
//  encodbleExtension.swift
//  to do list app
//
//  Created by Donald Colin on 14/08/24.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            print("Error: Failed to encode object to JSON")
            return [:]
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
            return json ?? [:]
        } catch {
            print("Error: Failed to convert JSON to dictionary - \(error.localizedDescription)")
            return [:]
        }
    }
}
