//
//  ItemModel.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/04.
//

import Foundation

struct ItemModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let isCompleted: Bool
}
