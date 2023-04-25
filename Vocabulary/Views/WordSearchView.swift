//
//  WordSearchView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/11/23.
//

import SwiftUI

struct WordSearchView: View {
    let searchText: String
    let book: VocabularyBook
    
    var filteredWords: [Word] {
        if searchText.isEmpty {
            return Array(book.words.keys)
        } else {
            return Array(book.words.keys).filter { word in
                word.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        Form {
            ForEach(filteredWords, id: \.self) { word in
                if let info = book.words[word] {
                    NavigationLink(destination: WordView(word: word, info: info)) {
                        Text(word.name)
                    }
                } else {
                    Text(word.name)
                }
            }
        }
    }
    
}

struct WordSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WordSearchView(searchText: "", book: VocabularyBook())
        }
    }
}
