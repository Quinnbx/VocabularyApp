//
//  WordsListView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/8/23.
//

import SwiftUI

struct WordsListView: View {
    var book: VocabularyBook
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    TextField("Search", text: $search)
                        .padding(.horizontal)
                    NavigationLink(destination: WordSearchView(searchText: search, book: book)) {
                        Text("Search")
                    }
                }
                
            }
        }
    }
    
    func displayWordList() -> some View {
        List {
            ForEach(Array(book.words.keys), id: \.self) <#_#>{ word in
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

struct WordsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WordsListView(book: VocabularyBook())
        }
    }
}
