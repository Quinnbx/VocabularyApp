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
    let sortedWords: [Word]
    
    private var filteredWords: [Word] {
        sortedWords.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    private func indexForWord(_ word: Word) -> Int? {
        return Array(book.words.keys).firstIndex(of: word)
    }
    
    var body: some View {
        VStack {
            Text("Search results for \"\(searchText)\"")
                .font(.headline)
                .padding(.top)
            
            List {
                ForEach(filteredWords, id: \.self) { word in
                    if let index = indexForWord(word) {
                        NavigationLink(destination: WordView(index: index).environmentObject(book)) {
                            Text(word.name)
                        }
                    }
                }
            }
        }
    }
}




struct WordSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WordSearchView(searchText: "", book: VocabularyBook(), sortedWords: [Word()])
        }
    }
}

//var filteredWords: [Word] {
//    if searchText.isEmpty {
//        return Array(book.words.keys)
//    } else {
//        return Array(book.words.keys).filter { word in
//            word.name.localizedCaseInsensitiveContains(searchText)
//        }
//    }
//}

//            List(Array(filteredWords), id: \.self) { word in
//                NavigationLink(
//                    destination: WordView(word: word, info: book.words[word] ?? Information()),
//                    label: {
//                        Text(word.name)
//                    }
//                )
//            }
