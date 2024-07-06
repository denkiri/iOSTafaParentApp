//
//  ErrorResponse.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 12/06/2024.
//

import Foundation
struct ErrorResponse: Codable {
    let details: String
}
enum HTTPErrorResponse: LocalizedError {
    case badRequest(String)
    case unauthorized(String)
    case forbidden(String)
    case serverError(String)
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .badRequest(let message):
            return message
        case .unauthorized(let message):
            return message
        case .forbidden(let message):
            return message
        case .serverError(let message):
            return message
        case .unknown(let message):
            return message
        }
    }
}
