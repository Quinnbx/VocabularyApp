//
//  WordView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/9/23.
//

import SwiftUI

struct EditableField: View {
    var label: String
    var value: String
    @Binding var editedValue: String
    @Binding var isEditing: Bool

    var body: some View {
        Section(header: Text(label)) {
            if isEditing {
                TextField(label, text: $editedValue)
            } else {
                Text(value)
            }
        }
    }
}

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
            EditableField(label: "Word", value: word.name, editedValue: $editedName, isEditing: $isEditing)
            EditableField(label: "Definitions", value: book[word].getDefinitions(), editedValue: $editedDef, isEditing: $isEditing)
            EditableField(label: "Part of Speech", value: book[word].getPOSs(), editedValue: $editedPos, isEditing: $isEditing)
            EditableField(label: "Examples", value: book[word].getExamples(), editedValue: $editedEx, isEditing: $isEditing)
        }
        .navigationBarItems(trailing:
            isEditing ?
                Button("Save", action: saveAction) :
                Button("Edit", action: editAction)
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                EmptyView()
            }
        }
        .onAppear(perform: setupEditedValues)
    }
    
    private func setupEditedValues() {
        editedName = word.name
        editedDef = book[word].getDefinitions()
        editedPos = book[word].getPOSs()
        editedEx = book[word].getExamples()
    }

    private func saveAction() {
        let newWord = Word(name: editedName)
        var newInfo = book[word]
        newInfo.setDefinitions(editedDef)
        newInfo.setPOSs(editedPos)
        newInfo.setExamples(editedEx)

        if editedName != word.name {
            book.words.removeValue(forKey: word)
            book[newWord] = newInfo
            if let newIndex = Array(book.words.keys).firstIndex(of: newWord) {
                index = newIndex
            }
        } else {
            book[word] = newInfo
        }

        isEditing = false
    }


    private func editAction() {
        isEditing = true
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


