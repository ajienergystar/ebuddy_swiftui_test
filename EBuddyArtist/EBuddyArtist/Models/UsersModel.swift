//
//  UsersModel.swift
//  EBuddyArtist
//
//  Created by mac on 6/12/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable, Identifiable {
    var id: String
    var uid: String
    var email: String
    var phoneNumber: String
    var gender: String
    var profileImageUrl: String?
    var rating: Int
    var last_active: Timestamp
    var service_price: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case uid
        case email
        case phoneNumber = "phone_number"
        case gender
        case profileImageUrl = "profile_image_url"
        case rating
        case last_active
        case service_price
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        email = try container.decode(String.self, forKey: .email)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        gender = try container.decode(String.self, forKey: .gender)
        profileImageUrl = try container.decode(String.self, forKey: .profileImageUrl)
        rating = try container.decode(Int.self, forKey: .rating)
        last_active = try container.decode(Timestamp.self, forKey: .last_active)
        service_price = try container.decode(Int.self, forKey: .service_price)
        
        
        // Handle uid being either an Int or a String
        if let uidInt = try? container.decode(Int.self, forKey: .uid) {
            uid = String(uidInt)
        } else {
            uid = try container.decode(String.self, forKey: .uid)
        }
    }
}
