//
//  ModifyWordView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/14/23.
//

// isValid check
// Views shouldn’t communicate directly with the model.
import SwiftUI

struct CreateWordView: View {
    @EnvironmentObject var book: VocabularyBook
    @State private var word = Word()
    @State private var defs = [Definition(def: "")]
    @State private var poss = [POS(pos: "")]
    @State private var srcs = [Source(src: "")]
    @State private var isPresenting: Bool = false
    @State private var info = Information();
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            NavigationView{
                Form {
                    TextField("Word", text: $word.name)
                    
                    ForEach(defs.indices, id: \.self) { index in
                        let def = Binding<String>(
                            get: { self.defs[index].def },
                            set: { self.defs[index].def = $0 }
                        )
                        TextField("Enter definition", text: def)
                    }
                    Button("Add definition") {
                        self.defs.append(Definition(def: ""))
                    }
                    
                    ForEach(poss.indices, id: \.self) { index in
                        let pos = Binding<String>(
                            get: { self.poss[index].pos },
                            set: { self.poss[index].pos = $0 }
                        )
                        TextField("Enter part of speech", text: pos)
                    }
                    Button("Add Part of Speech") {
                        self.poss.append(POS(pos: ""))
                    }
                    
                    ForEach(srcs.indices, id: \.self) { index in
                        let src = Binding<String>(
                            get: { self.srcs[index].src },
                            set: { self.srcs[index].src = $0 }
                        )
                        TextField("Enter source", text: src)
                    }
                    Button("Add Source") {
                        self.srcs.append(Source(src: ""))
                    }
                    
                    //                ForEach(defs.indices, id: \.self) { index in
                    //                    TextField("Enter definition", text: self.$defs[index].def, onCommit: {
                    //                        info.addDef(def: defs[index])
                    //                    })
                    //                }

                    //                Spacer()
                    //                ForEach(poss.indices, id: \.self) { index in
                    //                    TextField("Enter part of speech", text: self.$poss[index].pos, onCommit: {
                    //                        info.addPOS(pos: poss[index])
                    //                    })
                    //                }
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
//                            NavigationLink(destination: VocabBookView(book: book)) {
                                Button("Save") {
                                    defs.forEach { def in
                                        info.addDef(def: def)
                                    }
                                    poss.forEach { pos in
                                        info.addPOS(pos: pos)
                                    }
                                    book[word] = info
                                    presentationMode.wrappedValue.dismiss()
                                }
//                            }
                        }
                    }
                }
            }
        }
        
    }
}

struct CreateWordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateWordView()
        }.environmentObject(VocabularyBook())
    }
}

//                Button(action: {
//                    isPresenting = true
//                }, label: {
//                    Image(systemName: "plus")
//                })
//                    .sheet(isPresented: $isPresenting) {
//                        NavigationView {
//                            VStack {
//                                TextField("Definition: ", text: $def.def)
//                                    .padding()
//                                Spacer()
//                            }
//                            .toolbar {
//                                ToolbarItem(placement: .cancellationAction) {
//                                    Button("Cancel") {
//                                        isPresenting = false // set isPresented to false to dismiss the sheet
//                                    }
//                                }
//                                ToolbarItem(placement: .confirmationAction) {
//                                    Button("Save") {
//                                        info.addDef(def: def)
//                                        isPresenting = false // set isPresented to false to dismiss the sheet
//                                    }
//                                }
//                            }
//                        }
                        
//                        NavigationView {
//                            VStack {
//                                TextField("Definition: ", text: $def.def)
//                                    .padding()
//                                Spacer()
//                            }
//                            .navigationBarItems(
//                                leading: Button("Cancel") {
//                                    isPresenting = false
//                                },
//                                trailing: Button("Save") {
//                                    info.addDef(def: def)
//                                    // book.add(word: word, info: info);
//                                }
//                            )
//                            .navigationBarTitle("New Definition")
//                        }
//                    }
