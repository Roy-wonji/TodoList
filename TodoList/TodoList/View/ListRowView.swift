//
//  ListRowView.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/04.
//

import SwiftUI

struct ListRowView: View {
     let item : ItemModel
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var items = ItemModel(title: "This is the First Title", isCompleted: false)
    static var items1 = ItemModel(title: "This is the Second Title", isCompleted: true)
    
    static var previews: some View {
        Group {
            ListRowView(item: items)
            ListRowView(item: items1)
        }
        .previewLayout(.sizeThatFits)
    }
}
