//
//  AddView.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/04.
//

import SwiftUI

struct AddView: View {
    @State var textFieldText: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    TextField( "할일을 입력해주세요 ... " , text: $textFieldText)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color.white)
                    .cornerRadius(10)
                    Button(action : {
                    },  label: {
                        Text("Save".uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: geometry.size.height / 12 )
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    })
                }
                .padding(14)
            }
            .navigationTitle("할일 추가하기 🖊")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
    }
}
