//
//  VocabularyBooksView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/7/23.
//

import SwiftUI

struct BooksView: View {
    @StateObject private var bookSet = VocabularyBookSet(books: Set([VocabularyBook.testVocabBook]))
    @State private var showingModal = false

    var body: some View {
        NavigationView {
            List(Array(bookSet.books), id: \.self) { book in
                NavigationLink(destination: ListView().environmentObject(book)) {
                    Text(book.n)
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarItems(trailing: Button(action: {
                showingModal = true
            }) {
                Text("Add")
            })
        }
        .sheet(isPresented: $showingModal) {
            NewVocabBookView { name in
                let newBook = VocabularyBook()
                newBook.n = name
                bookSet.insert(newBook)
                showingModal = false
            }
        }
        .environmentObject(bookSet)
    }
}

struct NewVocabBookView: View {
    @State private var name = ""
    @Environment(\.presentationMode) var presentationMode
    var completion: (String) -> ()

    var body: some View {
        NavigationView {
            Form {
                TextField("Book Name", text: $name)
            }
            .navigationBarItems(leading: Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add Book") {
                completion(name)
                presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitle("New Vocabulary Book")
        }
    }
}

extension BooksView {
//    private var books: Set<VocabularyBook> {
//        Set([VocabularyBook.testVocabBook])
//    }
    
    private var navigationTitle: String {
        "Collections"
    }
}

struct VocabBooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
