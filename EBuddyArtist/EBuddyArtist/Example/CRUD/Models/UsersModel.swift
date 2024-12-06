//
//  UsersModel.swift
//  EBuddyArtist
//
//  Created by mac on 6/12/24.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var id: String? // Firestore document ID
    var uid: String
    var email: String
    var gender: String
    var phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case email
        case gender
        case phoneNumber = "phone_number"
    }
}
