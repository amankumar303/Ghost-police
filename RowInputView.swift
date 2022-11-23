//
//  RowInputView.swift
//  money
//
//  Created by Aman Kumar on 23/11/22.
//

import SwiftUI

struct RowInputView: View {
    @State var row: Int = 4
    @State var col: Int = 4
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Row:", value: $row, format: .number)
                    .padding()
                
                TextField("Col:", value: $col, format: .number)
                    .padding()
                    .navigationDestination(for: String.self) { value in
                        if value == "proceed" {
                            Boardview(rows: row, columns: col)
                        }
                    }
                Spacer()
                
                NavigationLink("Proceed", value: "proceed")
                    .buttonStyle(.borderedProminent)
                    .padding(50)
                
            }
            .textFieldStyle(.roundedBorder)
            .buttonStyle(.bordered)
            .background(Color.green.opacity(0.3))
            .cornerRadius(10)
            .padding()
        }
    }
}

struct RowInputView_Previews: PreviewProvider {
    static var previews: some View {
        RowInputView()
    }
}
