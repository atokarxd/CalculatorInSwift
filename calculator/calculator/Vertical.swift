//
//  Vertical.swift
//  calculator
//
//  Created by Atokarxd on 2022. 09. 22..
//

import SwiftUI

struct GrayButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .foregroundColor(.primary)
            //.frame(width: 5, height: 5)
            .frame(width: 75, height: 75)
            .background(.gray.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
extension View {
    func GbuttonStyle() -> some View {
        self.modifier(GrayButtonStyle())
    }
}

struct OrangeButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .frame(width: 75, height: 75)
            .foregroundColor(.primary)
            //.frame(width: 5, height: 5)
            .background(.orange)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
extension View {
    func ObuttonStyle() -> some View {
        self.modifier(OrangeButtonStyle())
    }
}


struct Vertical: View {
    @State private var DisplayText: String = ""
    @State private var first_number: Float = 0.0
    @State private var second_number: Float  = 0.0
    @State private var first_row_icon = ["plus.forwardslash.minus","percent" , "divide"]
    @State private var operations = ""
    @State private var ResetQuery = false
    
    var body: some View {
        VStack {
            Text("\(DisplayWriteTheText(number: 0))")
                .font(.largeTitle.bold())
                .padding()
                .frame(width: 340, height: 60, alignment: .trailing)
                .background(.gray.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            HStack(spacing: 15) {
                Group {
                    Button("AC") { AC() }

                    Button {
                        plus_minus()
                    } label: {
                        Image(systemName: "plus.forwardslash.minus")
                    }

                    Button {
                        nextDisplayText("%")
                    } label: {
                        Image(systemName: "percent")
                    }

                    Button {
                        nextDisplayText("/")
                    } label: {
                        Image(systemName: "divide")
                    }
                    
                }
                .ObuttonStyle()
            }
            
            HStack(spacing: 15) {
                ForEach(7..<10, id: \.self) { num in
                    Button("\(num)") { DisplayWriteTheText(number: num) }
                        .GbuttonStyle()
                }
                Button { nextDisplayText("*") } label: {
                    Image(systemName: "multiply")
                }
                .ObuttonStyle()
            }
            HStack(spacing: 15) {
                ForEach(4..<7, id: \.self) { num in
                    Button("\(num)") { DisplayWriteTheText(number: num) }
                        .GbuttonStyle()
                }
                Button { nextDisplayText("-") } label: {
                    Image(systemName: "minus")
                }
                .ObuttonStyle()
            }
            HStack(spacing: 15) {
                ForEach(1..<4, id: \.self) { num in
                    Button("\(num)") { DisplayWriteTheText(number: num) }
                        .GbuttonStyle()
                }
                Button { nextDisplayText("+") } label: {
                    Image(systemName: "plus")
                }
                .ObuttonStyle()
            }
            HStack(spacing: 15) {
                Button("0") { DisplayWriteTheText(number: 0) }
                    .padding()
                    .font(.title.bold())
                    .foregroundColor(.primary)
                    .frame(width: 165, height: 75, alignment: .leading)
                    .background(.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Button(",") { comma() }
                    .GbuttonStyle()
                Button { equal() } label: {
                    Image(systemName: "equal")
                }
                .ObuttonStyle()
            }
        }
    }
    func AC() {
        first_number = 0
        second_number = 0
        DisplayText = ""
    }
    
    func DisplayWriteTheText(number: Int) -> String {
        if ResetQuery {
            ResetQuery = false
            DisplayText = ""
        }
        
        if number == 0 && DisplayText == "" {
            DisplayText = ""
        } else {
            DisplayText += String(number)
        }
        return DisplayText == "" ? "0" : DisplayText
    }
    
    func equal() -> String {
        second_number = Float(DisplayText) ?? 0
        
        if operations == "+" {
            first_number += second_number
        } else if operations == "*" {
            first_number *= second_number
        } else if operations == "-" {
            first_number -= second_number
        } /*else if operations == "%" {
            first_number %= second_number
        }*/ else if operations == "/" {
            first_number /= second_number
        }
        
        if Int(first_number * 10) % 10 == 0 {
            DisplayText = String(Int(first_number))
        } else {
            DisplayText = String(first_number)
        }
        ResetQuery = true
        return DisplayText
    }
    
    func nextDisplayText(_ operation: String) {
        first_number = Float(DisplayText) ?? 0
        DisplayText = ""
        operations = operation
    }
    
    func plus_minus() {
        if DisplayText == "" {
            
        } else if DisplayText != "" && (Int(DisplayText) ?? 0) != abs(Int(DisplayText) ?? 0) {
            DisplayText = String(abs((Int(DisplayText) ?? 0)))
        }
        else {
            DisplayText = "-" + DisplayText
        }
    }
    
    func comma() {
        if DisplayText == "" {
            DisplayText += "0."
        } else if DisplayText.count < 2 {
            DisplayText += "."
        }
    }
}

struct Vertical_Previews: PreviewProvider {
    static var previews: some View {
        Vertical()
    }
}
