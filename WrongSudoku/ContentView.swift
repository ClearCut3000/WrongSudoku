//
//  ContentView.swift
//  WrongSudoku
//
//  Created by Николай Никитин on 08.12.2022.
//

import SwiftUI

struct ContentView: View {

  @StateObject private var board = Board(.medium)

    var body: some View {

      NavigationStack {
        VStack {
          Spacer()
          Grid(horizontalSpacing: 2, verticalSpacing: 2) {
            ForEach(0..<board.exampleCells.count, id: \.self) { row in
              GridRow {
                let userRow = board.userCells[row]
                ForEach(0..<userRow.count, id: \.self) { column in
                  let selected = row == board.selectedRow && column == board.selectedColumn

                  CellView(number: userRow[column], isSelected: selected) {
                    board.selectedRow = row
                    board.selectedColumn = column
                  }
                }
              }
            }
          }
          .padding(.horizontal)
          Spacer()
        }
        .navigationTitle("Wrong Sudoku!")
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
