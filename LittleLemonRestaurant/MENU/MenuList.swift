//
//  MenuList.swift
//  LittleLemonRestaurant
//
//  Created by Guild Junior on 24/05/23.
//

import Foundation

struct MenuList: Decodable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}
