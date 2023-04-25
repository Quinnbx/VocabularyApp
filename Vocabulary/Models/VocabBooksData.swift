//
//  VocabBookData.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/7/23.
//

import Foundation

class VocabBooksData: ObservableObject {
    @Published var vocabBook = VocabularyBook.testVocabBook
    @Published var vocabBooks = Set([VocabularyBook.testVocabBook])
    
}


