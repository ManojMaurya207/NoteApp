//
//  EmptyItemView.swift
//  NoteApp
//
//  Created by Manoj on 03/10/25.
//

import SwiftUI

struct EmptyItemView: View {
    @State var animate : Bool = false
    let secondaryColor = Color("SecondaryColor")
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10){
                Text("Let get Started!!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom,30)
                NavigationLink(destination: AddNoteScreen(), label: {
                    Text("Add Something")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity )
                        .background(animate ? secondaryColor : Color.accentColor)
                        .cornerRadius(15)
                })
                .padding(.horizontal,animate ? 30:40)
                .shadow(
                    color: animate ? secondaryColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30:10,
                    x: 0,
                    y: animate ? 50:30
                )
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
            }
            .padding(40)
            .onAppear(perform: addAnimation)
            .animation(.easeInOut(duration: 2).repeatForever(), value: animate)
        }
    }
    
    func addAnimation(){
        guard !animate else{return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            withAnimation(
                Animation.easeInOut(duration: 2).repeatForever()
            ){
                animate.toggle()
            }
        }
    }
}

#Preview {
    NavigationView{
        EmptyItemView()
    }.navigationTitle("Todo List")
}
