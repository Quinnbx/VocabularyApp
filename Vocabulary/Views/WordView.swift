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
    @State var editedName = ""
    @State var editedDef = ""
    @State var editedPos = ""
    @State var editedEx = ""

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
                if isEditing {
                    TextField("Parts of Speech", text: $editedPos)
                        .onAppear {
                            editedPos = book[word].getPOSs()
                        }
                } else {
                    Text(book[word].getPOSs())
                }
            }
            Section(header: Text("Examples")) {
                if isEditing {
                    TextField("Examples", text: $editedEx)
                        .onAppear {
                            editedPos = book[word].getExamples()
                        }
                } else {
                    Text(book[word].getExamples())
                }
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
                        newInfo.setPOSs(editedPos)
                        newInfo.setExamples(editedEx)
                        book[newWord] = newInfo
                        if let newIndex = Array(book.words.keys).firstIndex(of: newWord) {
                            index = newIndex
                        }
                    } else {
                        book[word].setDefinitions(editedDef)
                        book[word].setPOSs(editedPos)
                        book[word].setExamples(editedEx)
                    }
                    isEditing = false
                }) :
                Button("Edit", action: {
                    editedName = word.name
                    editedDef = book[word].getDefinitions()
                    editedPos = book[word].getPOSs()
                    editedEx = book[word].getExamples()
                    isEditing = true
                })
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                EmptyView()
            }
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
            WordView(index: 0)
                .environmentObject(sampleBook)
        }
    }
}


