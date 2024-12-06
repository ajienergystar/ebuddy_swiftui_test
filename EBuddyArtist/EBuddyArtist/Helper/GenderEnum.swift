//
//  GenderEnum.swift
//  EBuddyArtist
//
//  Created by mac on 6/12/24.
//

import Foundation

import Foundation

// Gender Enum
enum GenderEnum: Int, Codable {
    case female = 0
    case male = 1
}

// UserJSON Struct
struct UserJSON: Codable {
    var uid: String?
    var email: String?
    var phoneNumber: String?
    var gender: GenderEnum?
}


