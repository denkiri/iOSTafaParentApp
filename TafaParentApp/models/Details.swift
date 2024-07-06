//
//  Details.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 12/06/2024.
//

import Foundation
struct Details: Codable, Equatable {
    let access_token: String
    let expires_in: Int
    let jwt_token: String
    let refresh_token: String
    let token_type: String
}


