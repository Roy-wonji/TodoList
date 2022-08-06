//
//  NoListItemView.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/06.
//

import SwiftUI

struct NoListItemView: View {
    @State var animate: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 10) {
                    Text("리스트가 없어요 😰")
                        .fontWeight(.black)
                        .foregroundColor(ColorAsset.fontColor.opacity(1.0))
                        .font(.title)
                        .padding()
                    Text("혹시 오늘 할일이 없어요 ☹️?")
                        .fontWeight(.semibold)
                        .font(.custom("나눔손글씨 둥근인연", size: 15))
                    Text("만약에 할일이  있으면  Todo 리스트에 추가 버튼을 눌러서 오늘의 할일을 추가 하는게 어떨까 😝")
                        .fontWeight(.semibold)
                        .font(.custom("나눔손글씨 둥근인연", size: 15))
                        Spacer()
                    NavigationLink (destination: AddView(), label: {
                        Text("할일 추가 하러 가기 🥳")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: geometry.size.height / 15)
                            .frame(maxWidth: .infinity)
                            .background(animate ? ColorAsset.mainColor : ColorAsset.changeColor)
                            .cornerRadius(12)
                    })
                    .padding(.horizontal, animate ? 30 : 50)
                    .shadow(color:  animate ? ColorAsset.mainColor.opacity(0.7) :
                                ColorAsset.changeColor.opacity(0.7)
                            , radius: animate ? 30 : 10,
                            x: .zero,
                            y:  animate ? 50 : 30 )
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
                    
                }
                .frame(maxWidth: 400)
                .multilineTextAlignment(.center)
                .padding(40)
                .onAppear(perform: addAnimation)
            }
            .frame( maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation (
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever() ) {
                        animate.toggle()
                    }
        }
    }
}


struct NoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoListItemView()
                .navigationTitle("ToDo List")
        }
    }
}
