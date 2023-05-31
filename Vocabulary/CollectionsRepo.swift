//
//  CollectionsRepo.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 5/30/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
 
struct CollectionRepository {
    static let wordsReference = Firestore.firestore().collection("words_default")
    static let infoReference = Firestore.firestore().collection("info_default")
 
    static func create(_ word: Word, _ info: Information) async throws {
        print("at Repo create")
        let docWord = wordsReference.document(word.id.uuidString)
        try await docWord.setData(from: word)
        let docInfo = infoReference.document(info.id.uuidString)
        try await docInfo.setData(from: info)
    }
}

private extension DocumentReference {
    func setData<T: Encodable>(from value: T) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            // Method only throws if there’s an encoding error, which indicates a problem with our model.
            // We handled this with a force try, while all other errors are passed to the completion handler.
            print("at repo")
            try! setData(from: value) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                    print("Error at Repo.")
                    return
                }
                continuation.resume()
            }
        }
    }
}
