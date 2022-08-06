//
//  ListView.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/04.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    //MARK: - Lifecycle
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                Text("리스트가 없어요 😰")
                    .font(.title)
                
                    .foregroundColor(Color(red: 45 / 255 , green: 57 / 255, blue:  93 / 255))
            } else {
                List {
                    ForEach(listViewModel.items) { items in
                        ListRowView(item: items)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: items)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem )
                    .onMove(perform: listViewModel.moveItem )
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
    }
}
//MARK: - Previews
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
