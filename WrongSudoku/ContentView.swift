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
              let exampleRow = board.exampleCells[row]
              let userRow = board.userCells[row]

              ForEach(0..<userRow.count, id: \.self) { column in
                let selected = row == board.selectedRow && column == board.selectedColumn

                CellView(number: userRow[column], isSelected: selected) {
                  board.selectedRow = row
                  board.selectedColumn = column
                }
              }
              let exampleSum = sum(forRow: exampleRow)
              let userSum = sum(forRow: userRow)
              SumView(number: exampleSum)
                .foregroundColor(exampleSum == userSum ? .primary : .red)
            }
          }
          GridRow {
            ForEach(0..<board.exampleCells[0].count, id: \.self) { column in
              let exampleSum = sum(forColumn: column, in: board.exampleCells)
              let userSum = sum(forColumn: column, in: board.userCells)
              SumView(number: exampleSum)
                .foregroundColor(exampleSum == userSum ? .primary : .red)
            }
          }
        }
        .padding(.horizontal)

        Spacer()

        HStack {
          ForEach(1..<10) { i in
            Button(String(i)) {
              board.enter(i)
            }
            .frame(maxWidth: .infinity)
            .font(.largeTitle)
          }
        }
        .padding()
      }
      .navigationTitle("Wrong Sudoku!")
    }

  }

  func sum(forRow row: [Int]) -> Int {
    row.reduce(0, +)
  }

  func sum(forColumn column: Int, in cells: [[Int]]) -> Int {
    cells.reduce(0) { $0 + $1[column] }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
