//
//  ListViewModel.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/05.
//

import Foundation

class ListViewModel: ObservableObject  {
    @Published var items: [ItemModel] = [ ] {
        didSet {
            saveItems()
        }
    }
    let itemskey: String = "items_list"
    init( ) {
        getItems()
    }
    
    func getItems() {
        guard let data = UserDefaults.standard.data(forKey: itemskey) , let savItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        self.items = savItems
        
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
    
    func saveItems() {
        if let encodeData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodeData, forKey: itemskey)
        }
    }
}
