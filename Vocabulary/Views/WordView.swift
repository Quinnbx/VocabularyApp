//
//  WordView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/9/23.
//

import SwiftUI

struct WordView: View {
    @EnvironmentObject var book: VocabularyBook
    var index: Int

    private var word: Word {
        Array(book.words.keys)[index]
    }

    @State var isEditing = false
    @State var editedDef = ""

    var body: some View {
        Form {
            Section {
                Text(word.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
            Section(header: Text("Definitions")) {
                if isEditing {
                    TextField("Definitions", text: $editedDef)
                        .onAppear {
                            editedDef = book[word].getDefinitions()
                        }
                } else {
                    Text(book[word].getDefinitions())
                }
            }
            Section(header: Text("Part of Speech")) {
                Text(book[word].getPOSs())
                    .disabled(!isEditing)
            }
            Section(header: Text("Examples")) {
                Text(book[word].getExamples())
                    .disabled(!isEditing)
            }
        }
        .navigationTitle(word.name)
        .navigationBarItems(trailing:
            isEditing ?
                Button("Save", action: {
                    book[word].setDefinitions(editedDef)
                    isEditing = false
                }) :
                Button("Edit", action: {
                    editedDef = book[word].getDefinitions()
                    isEditing = true
                })
        )
    }
}



struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleWord = Word(name: "example")
        let sampleInfo = Information(defs: "a representative or illustrative instance", poss: "noun", exs: "This is an example of a sentence.")
        let sampleBook = VocabularyBook()
        sampleBook.add(word: sampleWord, info: sampleInfo)
        return NavigationView {
            WordView(index: 0)
                .environmentObject(sampleBook)
        }
    }
}


