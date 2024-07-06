//
//  CallLogs.swift
//  TafaParentApp
//  Created by Macbook Pro on 23/05/2024.
//
import Foundation
struct CommunicationResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Communication]
}

struct Communication: Codable {
    let id: Int
    let mobile_number: String
    let duration: Double
    let tokens_consumed: Double
    let timestamp: String
}

