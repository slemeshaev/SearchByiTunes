//
//  ITunesSearchResult.swift
//  SearchByiTunes
//
//  Created by Станислав Лемешаев on 02.07.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

struct ITunesSearchResult<Element: Codable>: Codable {
    let resultCount: Int
    let results: [Element]
}
