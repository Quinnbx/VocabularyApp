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
    var initial = ""
    var definitions = Set<Definition>()
    var POSs = Set<POS>()
    var examples = Set<Example>()
    var sources = Set<Source>()
    
    init() {
        initial = "No more information"
    }
    init(definition: Definition, pos: POS, example: Example, source: Source) {
        self.definitions.insert(definition)
        self.POSs.insert(pos)
        self.examples.insert(example)
        self.sources.insert(source)
    }
    
    mutating func addDef(def: Definition) {
        self.definitions.insert(def)
    }
    
    mutating func addPOS(pos: POS) {
        self.POSs.insert(pos)
    }
    
}

/**a definition of a word**/
struct Definition: Hashable {
    var def: String
}

/**a tense of a word**/
struct POS: Hashable {
    var pos: String
}

/**an example of using a word**/
struct Example: Hashable {
    var ex: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ex)
    }
    
    static func ==(lhs: Example, rhs: Example) -> Bool {
        return lhs.ex == rhs.ex
    }
}

/**a source (reference) of a word**/
struct Source: Hashable {
    var src: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(src)
    }
    
    static func ==(lhs: Source, rhs: Source) -> Bool {
        return lhs.src == rhs.src
    }
}
