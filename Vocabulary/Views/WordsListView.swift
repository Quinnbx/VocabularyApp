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

    private var sortedWords: [Word] {
        Array(book.words.keys).sorted { $0.name < $1.name }
    }
    
    private var filteredWords: [Word] {
        sortedWords.filter { searchText.isEmpty ? true : $0.name.contains(searchText) }
    }

    var body: some View {
        NavigationView {
            //            VStack {}
            //            .searchable(text: $searchText)
            //            .navigationTitle("Words")
            //        }
            //        VStack {
            List {
                ForEach(filteredWords.indices, id: \.self) { index in
                    let word = filteredWords[index]
                    if let bookIndex = Array(book.words.keys).firstIndex(of: word) {
                        NavigationLink(destination: WordView(index: bookIndex).environmentObject(book)) {
                            Text(word.name)
                        }
                    }
                }
                .onDelete(perform: deleteWord)
                //            }
                //            .searchable(text: $searchText)
                //            .navigationTitle("Words")
            }
            .searchable(text: $searchText)
            .navigationTitle("Words")
        }

    }

    private func deleteWord(at offsets: IndexSet) {
        for index in offsets {
            let word = filteredWords[index]
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
