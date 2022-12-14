//
//  InitialView.swift
//  WrongSudoku
//
//  Created by Николай Никитин on 12.12.2022.
//

import SwiftUI

struct InitialView: View {

  @State private var isShowingGameView = false

  var body: some View {
    NavigationView {
      ZStack {
        Color("backgroundColor").ignoresSafeArea()
        VStack(spacing: 10) {


          Text("Wrong Sudoku!")
            .font(.largeTitle)
            .fontWeight(.light)
            .foregroundColor(Color("textColor"))
            .padding()



          Text("Welcome to a simple but exciting game \nWrong Sudoku! \nThe rules are very clear: \nto win, you need to fill in the cells so that the sum of the digits in the rows and columns corresponds to the number indicated on the edge. \nThat's It! \nHave fun!")
            .font(.body)
            .fontWeight(.light)
            .foregroundColor(Color("textColor"))
            .multilineTextAlignment(.center)
            .padding()


            NavigationLink(destination: GameView(), isActive: $isShowingGameView) { }

            Image("sample")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 200, maxHeight: 200)
            .padding(.bottom, 50)

            Button("Start") {
              isShowingGameView = true
            }
            .buttonStyle(MainGrowingButton())
        }
      }
    }
  }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
