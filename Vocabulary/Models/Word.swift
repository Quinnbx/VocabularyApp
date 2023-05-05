//
//  Word.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/7/23.
//

import Foundation

struct Word: Identifiable, Hashable {
    var id = UUID()
    
    var name: String
    
    init(){
        self.init(name: "")
    }
    
    init(name: String) {
        self.name = name.lowercased()
    }
    
    var isValid: Bool {
        name.count != 0
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func ==(lhs: Word, rhs: Word) -> Bool {
        return lhs.name == rhs.name
    }
    
    
}

struct Information {
    private var definitions: String
    private var POSs: String
    private var examples: String

    init() {
        self.definitions = ""
        self.POSs = ""
        self.examples = ""
    }

    init(defs: String, poss: String, exs: String) {
        self.definitions = defs
        self.POSs = poss
        self.examples = exs
    }
    

    // Getter and setter for definitions
    func getDefinitions() -> String {
        return definitions
    }

    mutating func setDefinitions(_ newValue: String) {
        definitions = newValue
    }

    // Getter and setter for POSs
    func getPOSs() -> String {
        return POSs
    }

    mutating func setPOSs(_ newValue: String) {
        POSs = newValue
    }

    // Getter and setter for examples
    func getExamples() -> String {
        return examples
    }

    mutating func setExamples(_ newValue: String) {
        examples = newValue
    }
    
}
