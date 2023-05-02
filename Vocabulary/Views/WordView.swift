//
//  WordView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/9/23.
//

import SwiftUI

struct WordView: View {
    @State var word: Word
    @State var info: Information
    @State var isEditing = false
    
    var body: some View {
        VStack {
            Text(word.name)
            displaySet(set: $info.definitions, title: "Definitions")
            displaySet(set: $info.POSs, title: "Parts of Speech")
            displaySet(set: $info.examples, title: "Examples")
            displaySet(set: $info.sources, title: "Sources")
            Button("Edit") {
                self.isEditing = true
            }
        }
    }
    
    func displaySet<T: Hashable>(set: Binding<Set<T>>, title: String) -> some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.top, 16)
            ForEach(Array(set.wrappedValue), id: \.self) { item in
                if let def = item as? Definition {
                    let textBinding = Binding(
                        get: { def.def },
                        set: { newValue in
                            var newSet = set.wrappedValue
                            let newDef = Definition(def: newValue)
                            newSet.remove(def as! T)
                            newSet.insert(newDef as! T)
                            set.wrappedValue = newSet
                        }
                    )
                    AnyView(EditableText(text: textBinding, isEditing: $isEditing, saveAction: {
                        let newDef = Definition(def: textBinding.wrappedValue)
                        var newSet = set.wrappedValue
                        newSet.remove(def as! T)
                        newSet.insert(newDef as! T)
                        set.wrappedValue = newSet
                    }))
                } else if let pos = item as? POS {
                    Text(pos.pos)
                } else if let ex = item as? Example {
                    Text(ex.ex)
                } else if let src = item as? Source {
                    Text(src.src)
                } else {
                    Text(String(describing: item))
                }
            }
        }
    }

}


struct EditableText: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    let saveAction: () -> Void
    
    var body: some View {
        Group {
            if isEditing {
                HStack {
                    TextField("", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .onAppear {
                            DispatchQueue.main.async {
                                UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
                        .onChange(of: text) { _ in
                            // Do nothing, but update the view to reflect the changed text
                        }
                    
                    Button(action: {
                        self.isEditing = false
                        saveAction() // Call the save action when the user taps the Save button
                    }, label: {
                        Text("Save")
                    })
                }
            } else {
                Text(text)
                    .onTapGesture {
                        self.isEditing = true
                    }
                    .padding(.horizontal)
            }
        }
    }
}


struct WordView_Previews: PreviewProvider {
    @State static var w = Word(name: "who")
    @State static var i = Information(
        definition: Definition(def: "used in questions to ask about the name, identity or function of one or more people"),
        pos: POS(pos: "pronoun"),
        example: Example(ex: "Who is that woman?"),
        source: Source(src: "oxfordlearnersdictionaries"))
    static var previews: some View {
        WordView(word: w, info: i)
    }
}
