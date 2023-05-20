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
        sortedWords.filter { searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }
    }

    var body: some View {
        VStack {
            // Custom Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search words...", text: $searchText)
                    .foregroundColor(.primary)
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // List of Words
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
            }
            .navigationTitle(book.n)
            .navigationBarItems(trailing:
                NavigationLink(destination: CreateWordView().environmentObject(book)) {
                    Image(systemName: "plus")
                }
            )
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
