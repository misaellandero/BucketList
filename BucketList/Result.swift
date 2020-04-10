
//
//  Result.swift
//  BucketList
//
//  Created by Francisco Misael Landero Ychante on 10/04/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages : [Int: Page]
}

struct Page: Codable, Comparable {
    
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "Sin detalles"
    }
    
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
