//
//  VocabBookView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/10/23.
//

import SwiftUI

struct VocabBookView: View {
    @EnvironmentObject var book: VocabularyBook
    
    var body: some View {
        VStack {
                NavigationLink(destination: CreateWordView().environmentObject(book)) {
                    Text("Add a word")
                }
                NavigationLink(destination: WordsListView().environmentObject(book)) {
                    Text("All Vocabulary")
                }
            
        }.navigationTitle(book.n)
    }
}

struct VocabBookView_Previews: PreviewProvider {
    static var previews: some View {
        VocabBookView()
    }
}
