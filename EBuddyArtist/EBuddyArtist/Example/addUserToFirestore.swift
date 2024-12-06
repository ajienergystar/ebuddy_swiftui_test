//
//  addUserToFirestore.swift
//  EBuddyArtist
//
//  Created by mac on 6/12/24.
//

import Foundation
import FirebaseFirestore


func addUserToFirestore(uid: String, ge: String) {
    let db = Firestore.firestore()
    let userData: [String: Any] = [
        "ge": ge,
        "uid": uid
    ]
    
    db.collection("USERS").addDocument(data: userData) { error in
        if let error = error {
            print("Error adding document: \(error)")
        } else {
            print("User added successfully!")
        }
    }
}




