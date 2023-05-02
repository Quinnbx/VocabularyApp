//
//  VocabularyBooksView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/7/23.
//

import SwiftUI

struct VocabBooksView: View {
    @StateObject private var vocabBookData = VocabBooksData()
    var body: some View {
        NavigationView {
            List(Array(books), id: \.self) { book in
                NavigationLink(
                    destination: VocabBookView().environmentObject(book),
                    label: {
                        Text(book.n)
                    }
                )
            }
            .navigationTitle(navigationTitle)
        }
        .environmentObject(vocabBookData)
    }
}

extension VocabBooksView {
    private var books: Set<VocabularyBook> {
        vocabBookData.vocabBooks
    }
    
    private var navigationTitle: String {
        "My Vocabulary Books"
    }
}

struct VocabBooksView_Previews: PreviewProvider {
    static var previews: some View {
        VocabBooksView()
    }
}
