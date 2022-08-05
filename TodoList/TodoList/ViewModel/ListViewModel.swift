//
//  ListViewModel.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/05.
//

import Foundation

class ListViewModel: ObservableObject  {
    @Published var items: [ItemModel] = [ ]
    init( ) {
        getItems()
    }
    
    func getItems() {
        let newItems = [
            ItemModel(title: "This is the frist  title!", isCompleted: false),
            ItemModel(title: "두번째 할일", isCompleted: true),
            ItemModel(title: "세번째 할일", isCompleted: false)
        ]
        items.append(contentsOf:  newItems)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItems(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
}
