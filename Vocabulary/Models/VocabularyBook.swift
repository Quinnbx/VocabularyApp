//
//  VocabularyBook.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/7/23.
//

import Foundation

class VocabularyBook: Identifiable, ObservableObject, Hashable {
    var id = UUID();
    
    var n = "My Vocab Book"
    
    var words = [Word : Information]()
    
    init() {}
    
    init(words: [Word : Information]){
        self.words = words
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(n)
    }
    
    static func == (lhs: VocabularyBook, rhs: VocabularyBook) -> Bool {
        return lhs.n == rhs.n
    }
    
    subscript(word: Word) -> Information {
        get {
            words[word, default: Information()]
        }
        set {
            words[word] = newValue
        }
    }
    
    func add(word : Word, info: Information) {
        if words[word] == nil {
            words[word] = info
        }
    }
    
    
}

extension VocabularyBook {
    static let testVocabBook = VocabularyBook(words: [
        Word(name: "who"): Information(
            definition: Definition(def: "used in questions to ask about the name, identity or function of one or more people"),
            pos: POS(pos: "pronoun"),
            example: Example(ex: "Who is that woman?"),
            source: Source(src: "oxfordlearnersdictionaries")),
        Word(name: "ever"): Information(
            definition: Definition(def: "used in negative sentences and questions, or sentences with if to mean ‘at any time’"),
            pos: POS(pos: "adverb"),
            example: Example(ex: "Nothing ever happens here."),
            source: Source(src: "oxfordlearnersdictionaries")),
        Word(name: "loved"): Information(
            definition: Definition(def: "to have very strong feelings of liking and caring for somebody"),
            pos: POS(pos: "verb"),
            example: Example(ex: "I love you."),
            source: Source(src: "oxfordlearnersdictionaries")),
        Word(name: "that"): Information(
            definition: Definition(def: "used for referring to a person or thing that is not near the speaker or as near to the speaker as another"),
            pos: POS(pos: "determiner"),
            example: Example(ex: "Look at that man over there."),
            source: Source(src: "oxfordlearnersdictionaries")),
        Word(name: "not"): Information(
            definition: Definition(def: "used with be, do or have to form the negative of verbs; used to form the negative of modal verbs like can or must"),
            pos: POS(pos: "adverb"),
            example: Example(ex: "used with be, do or have to form the negative of verbs; used to form the negative of modal verbs like can or must"),
            source: Source(src: "oxfordlearnersdictionaries")),
        Word(name: "at"): Information(
            definition: Definition(def: "used to say where something/somebody is or where something happens"),
            pos: POS(pos: "preposition"),
            example: Example(ex: "at the corner of the street"),
            source: Source(src: "oxfordlearnersdictionaries")),
        Word(name: "first"): Information(
            definition: Definition(def: "happening or coming before all other similar things or people; 1st"),
            pos: POS(pos: "determiner"),
            example: Example(ex: "I didn't take the first bus."),
            source: Source(src: "oxfordlearnersdictionaries")),
        Word(name: "sight"): Information(
            definition: Definition(def: "the ability to see"),
            pos: POS(pos: "noun"),
            example: Example(ex: "She has very good sight."),
            source: Source(src: "oxfordlearnersdictionaries"))
        ])
}
