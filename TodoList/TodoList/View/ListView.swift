//
//  ListView.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/04.
//

import SwiftUI

struct ListView: View {
    @State var items : [ItemModel] = [
      ItemModel(title: "This is the frist  title!", isCompleted: false),
      ItemModel(title: "두번째 할일", isCompleted: true),
      ItemModel(title: "세번째 할일", isCompleted: false)
    ]
    var body: some View {
        List {
            ForEach(items) { items in
                ListRowView(item: items)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading:  EditButton()
                .foregroundColor(.gray),
            trailing:
                NavigationLink("Add", destination: AddView())
                .foregroundColor(.black)
        )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
    }
}
