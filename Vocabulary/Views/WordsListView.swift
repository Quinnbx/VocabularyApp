//
//  WordsListView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/8/23.
//

import SwiftUI

struct WordsListView: View {
    @EnvironmentObject var book: VocabularyBook
    @State private var searchText = ""
    @State private var isShowingWordView: Bool = false
    @State private var selectedWordIndex: Int? = nil
    
    private var sortedWords: [Word] {
        Array(book.words.keys).sorted { $0.name < $1.name }
    }
    
    var body: some View {
        NavigationView {
            List {
                 ForEach(sortedWords.indices, id: \.self) { index in
                     let word = sortedWords[index]
                     if (searchText.isEmpty || word.name.contains(searchText)) {
                         if let bookIndex = Array(book.words.keys).firstIndex(of: word) {
                             Button(action: {
                                 selectedWordIndex = bookIndex
                                 isShowingWordView = true
                             }) {
                                Text(word.name)
                             }
                         }
                     }
                 }
                 .onDelete(perform: deleteWord)
             }
            .searchable(text: $searchText)
            .fullScreenCover(isPresented: $isShowingWordView) {
                WordView(index: $selectedWordIndex).environmentObject(book)
            }
        }
    }
    
    private func deleteWord(at offsets: IndexSet) {
        for index in offsets {
            let word = sortedWords[index]
            book.words.removeValue(forKey: word)
        }
    }
}


struct WordsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WordsListView()
        }
    }
}
