//
//  WordView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/9/23.
//

import SwiftUI

struct WordView: View {
    @EnvironmentObject var book: VocabularyBook
    @State private var index: Int

    private var word: Word {
        Array(book.words.keys)[index]
    }

    @State var isEditing = false
    @State var editedDef = ""
    @State var editedName = ""

    init(index: Int) {
        _index = State(initialValue: index)
    }

    var body: some View {
        Form {
            Section {
                if isEditing {
                    TextField("Word", text: $editedName)
                        .onAppear {
                            editedName = word.name
                        }
                } else {
                    Text(word.name)
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
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
        .navigationBarItems(trailing:
            isEditing ?
                Button("Save", action: {
                    if !editedName.isEmpty {
                        book.words.removeValue(forKey: word)
                        let newWord = Word(name: editedName)
                        var newInfo = book[word]
                        newInfo.setDefinitions(editedDef)
                        book[newWord] = newInfo
                        if let newIndex = Array(book.words.keys).firstIndex(of: newWord) {
                            index = newIndex
                        }
                    } else {
                        book[word].setDefinitions(editedDef)
                    }
                    isEditing = false
                }) :
                Button("Edit", action: {
                    editedName = word.name
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


