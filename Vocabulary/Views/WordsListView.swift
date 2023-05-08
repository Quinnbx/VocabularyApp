//
//  WordsListView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/8/23.
//

import SwiftUI

struct WordsListView: View {
    @EnvironmentObject var book: VocabularyBook
    @State private var search = ""
    
    private var sortedWords: [Word] {
        Array(book.words.keys).sorted { $0.name < $1.name }
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $search)
                    .padding(.horizontal)
                NavigationLink(destination: WordSearchView(searchText: search, book: book, sortedWords: sortedWords)) {
                    Text("Lookup")
                }
            }
           List {
                ForEach(sortedWords.indices, id: \.self) { index in
                    let word = sortedWords[index]
                    if let bookIndex = Array(book.words.keys).firstIndex(of: word) {
                        NavigationLink(destination: WordView(index: bookIndex).environmentObject(book)) {
                            Text(word.name)
                        }
                    }
                }
                .onDelete(perform: deleteWord)
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

//NavigationLink(destination: WordView(word: Binding(get: {
//    word
//}, set: { newValue in
//    book.words[newValue] = book.words.removeValue(forKey: word)
//}), info: Binding(get: {
//    info
//}, set: { newValue in
//    book.words[word] = newValue
//}))) {
//    Text(word.name)
//}
