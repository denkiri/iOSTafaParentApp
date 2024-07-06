//
//  API.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 12/06/2024.
//

import Foundation
struct API {
    static let baseURL = "https://tafatalk.co.ke/api/v1/"
    static let loginEndpoint = "\(baseURL)auth/login"
    static let profileEndpoint = "\(baseURL)auth/users/user-profile"
    static let paymentsPackages = "\(baseURL)payments/packages"
    static let callLogs = "\(baseURL)communication/parent"
}
