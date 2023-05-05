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
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $search)
                    .padding(.horizontal)
                NavigationLink(destination: WordSearchView(searchText: search, book: book)) {
                    Text("Lookup")
                }
            }
            List {
                ForEach(Array(book.words.keys.enumerated()), id: \.element) { index, word in
                    NavigationLink(destination: WordView(index: index, book: book).environmentObject(book)) {
                        Text(word.name)
                    }
                }

            }
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
