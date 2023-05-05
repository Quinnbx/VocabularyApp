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

    @State private var info: Information

    init(index: Int, book: VocabularyBook) {
        self.index = index
        let word = Array(book.words.keys)[index]
        _info = State(initialValue: book[word])
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
                    TextField("Definitions", text: $editedDef, onCommit: {
                        info.setDefinitions(editedDef)
                    })
                    .onAppear {
                        editedDef = info.getDefinitions()
                    }
                } else {
                    Text(info.getDefinitions())
                }
            }
            Section(header: Text("Part of Speech")) {
                Text(info.getPOSs())
                    .disabled(!isEditing)
            }
            Section(header: Text("Examples")) {
                Text(info.getExamples())
                    .disabled(!isEditing)
            }
        }
        .navigationTitle(word.name)
        .navigationBarItems(trailing:
            isEditing ?
                Button("Save", action: {
                    info.setDefinitions(editedDef)
                    isEditing = false
                    book[word] = info
                }) :
                Button("Edit", action: {
                    editedDef = info.getDefinitions()
                    isEditing = true
                })
        )
        .onDisappear {
            book[word] = info
        }
    }
}


struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleWord = Word(name: "example")
        let sampleInfo = Information(defs: "a representative or illustrative instance", poss: "noun", exs: "This is an example of a sentence.")
        let sampleBook = VocabularyBook()
        sampleBook.add(word: sampleWord, info: sampleInfo)

        return NavigationView {
            WordView(index: 0, book: sampleBook)
                .environmentObject(sampleBook)
        }
    }
}


