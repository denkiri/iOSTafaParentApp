//
//  InvoiceStatus.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 09/07/2024.
//

import Foundation
struct InvoiceStatus: Codable {
    let invoice: String
    let status: String
}
struct InvoiceStatusData: Codable {
    let details: InvoiceStatus
}
