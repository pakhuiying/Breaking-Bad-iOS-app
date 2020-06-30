//
//  BreakingBad.swift
//  Breaking_bad
//
//  Created by HUI YING on 28/6/20.
//  Copyright © 2020 HUI YING. All rights reserved.
//

import Foundation

struct Character: Codable {
    let name: String
    let char_id: Int
    let nickname: String
    let img: String
}

struct CharacterQuotes: Codable {
    let quote: String
}
