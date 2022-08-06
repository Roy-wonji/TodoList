//
//  AddView.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/04.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTile: String = ""
    @State var showAlert: Bool = false
    
    //MARK:  - Lifecycle
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    TextField( "할일을 입력해주세요 ... " , text: $textFieldText)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                    Button(action :  saveButtonPressed, label: {
                        Text("저장하기".uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: geometry.size.height / 12 )
                            .frame(maxWidth: .infinity)
                            .background(ColorAsset.mainColor)
                            .cornerRadius(12)
                    })
                }
                .padding(14)
            }
            .navigationTitle("할일 추가하기 🖊")
            .alert(isPresented: $showAlert, content:  getAlert)
        }
    }
    
    //MARK:  - 저장 버튼을 누를때
    func saveButtonPressed() {
        if textIsAppropriate() == true {
            listViewModel.addItems(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTile = "오늘의 할일 추가하기를 3글자 이상 써주세요 😨😰😱 "
            showAlert.toggle()
            
            return false
        }
        return true
    }

    //MARK:  - 알림창
    func getAlert() -> Alert {
        let okayButton = Alert.Button.default(Text("확인"))
        let cancelButton = Alert.Button.destructive(Text("취소"))
        return Alert(title: Text(alertTile),
                     primaryButton: okayButton, secondaryButton: cancelButton)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
