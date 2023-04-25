//
//  WordView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/9/23.
//

import SwiftUI

struct WordView: View {
    @Binding var word: Word
    @Binding var info: Information
    @State var isEditing: [String: Bool] = [:]
    
    var body: some View {
        VStack {
            Text(word.name)
            displaySet(set: $info.definitions, title: "Definitions")
            displaySet(set: $info.POSs, title: "Parts of Speech")
            displaySet(set: $info.examples, title: "Examples")
            displaySet(set: $info.sources, title: "Sources")
        }
    }
    
    func displaySet<T: Hashable>(set: Binding<Set<T>>, title: String) -> some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.top, 16)
            ForEach(Array(set.wrappedValue), id: \.self) { item in
                if let def = item as? Definition {
                    let textBinding = Binding<String>(
                        get: { def.def },
                        set: { newValue in
                            let newDef = Definition(def: newValue)
                            set.wrappedValue.insert(newDef as! T)
                        }
                    )
                    AnyView(EditableText(text: textBinding))
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
    @State private var isEditing = false
    @Binding var text: String
    
    var body: some View {
        Group {
            if isEditing {
                TextField("", text: $text, onEditingChanged: { isEditing in
                    self.isEditing = isEditing
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .onAppear {
                        DispatchQueue.main.async {
                            UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                        }
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
        WordView(word: $w, info: $i)
    }
}
