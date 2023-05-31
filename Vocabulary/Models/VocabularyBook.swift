//
//  VocabularyBook.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/7/23.
//

import Foundation

class VocabularyBook: Identifiable, ObservableObject, Hashable, Codable {
    var id = UUID();
    
    var n = "Untitled Collection"
    
    @Published var words = [Word : Information]()
    
    init() {}
    
    init(words: [Word : Information]){
        self.words = words
    }
    
    enum CodingKeys: CodingKey {
        case id
        case n
        case words
    }

    /*
     Implementation of 'Decodable' for non-final class cannot be automatically synthesized in extension because initializer requirement 'init(from:)' can only be satisfied by a 'required' initializer in the class definition
     */
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        n = try values.decode(String.self, forKey: .n)
        words = try values.decode([Word: Information].self, forKey: .words)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(n, forKey: .n)
        try container.encode(words, forKey: .words)
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
    
    func rename(oldWord: Word, newWord: Word) {
        if let info = words.removeValue(forKey: oldWord) {
            words[newWord] = info
        }
    }
    
    
}

extension VocabularyBook {
    static let testVocabBook = VocabularyBook(words: [
        Word(name: "who"): Information(
            defs: "used in questions to ask about the name, identity or function of one or more people",
            poss: "pronoun",
            exs: "Who is that woman?"),
        Word(name: "ever"): Information(
            defs: "used in negative sentences and questions, or sentences with if to mean ‘at any time’",
            poss: "adverb",
            exs: "Nothing ever happens here."),
        Word(name: "loved"): Information(
            defs: "to have very strong feelings of liking and caring for somebody",
            poss: "verb",
            exs: "I love you."),
        Word(name: "that"): Information(
            defs: "used for referring to a person or thing that is not near the speaker or as near to the speaker as another",
            poss: "determiner",
            exs: "Look at that man over there."),
        Word(name: "not"): Information(
            defs: "used with be, do or have to form the negative of verbs; used to form the negative of modal verbs like can or must",
            poss: "adverb",
            exs: "used with be, do or have to form the negative of verbs; used to form the negative of modal verbs like can or must"),
        Word(name: "at"): Information(
            defs: "used to say where something/somebody is or where something happens",
            poss: "preposition",
            exs: "at the corner of the street"),
        Word(name: "first"): Information(
            defs: "happening or coming before all other similar things or people; 1st",
            poss: "determiner",
            exs: "I didn't take the first bus."),
        Word(name: "sight"): Information(
            defs: "the ability to see",
            poss: "noun",
            exs: "She has very good sight.")
        ])
}

class VocabularyBookSet: ObservableObject {
    @Published var books: Set<VocabularyBook>
    
    init(books: Set<VocabularyBook> = []) {
        self.books = books
    }
    
    func insert(_ book: VocabularyBook) {
        books.insert(book)
    }
}
