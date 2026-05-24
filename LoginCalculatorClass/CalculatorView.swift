//
//  CalculatorView.swift
//  LoginCalculatorClass
//
//  Created by Kit Sitou on 5/21/26.
//

import SwiftUI

struct CalculatorView: View{
    @State private var firstNubmer: String = ""
    @State private var secondNubmer: String = ""
    @State private var result: String = ""
    
    var body: some View {
        VStack(spacing: 20){
           Image(systemName: "plus.forwardslash.minus")
                .font(.system(size:60))
                .foregroundStyle(.indigo)
            
            Text("Simple Calculator")
                .font(.title.bold())
            
            VStack(spacing: 20){
                TextField("first number", text: $firstNubmer)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("firstNumberField")
                
                TextField("second number", text: $secondNubmer)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("secondNumberField")
            }
            .padding()
            
            HStack(spacing:16){
                OperationButton(label: "+", id: "addButton", action: {calculate(.add)})
                    .accessibilityIdentifier("addButton")
                
                OperationButton(label: "-", id: "substractButton", action: {calculate(.substract)})
                    .accessibilityIdentifier("substractButton")
                
                OperationButton(label: "x", id: "multiplyButton", action: {calculate(.multiply)})
                    .accessibilityIdentifier("multiplyButton")
                
                OperationButton(label: "/", id: "divideButton", action: {calculate(.divide)})
                    .accessibilityIdentifier("divideButton")
                
                
            }.padding(.horizontal)
            
            //passing parent to child
//            OperationButton(label: "Click me", id: "minus", action: {calculate(.add)})
            if !result.isEmpty{
                Text("Result: \(result)")
                    .font(.title2.bold())
                    .padding()
                    .background(.indigo.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .accessibilityIdentifier("calculatorResult")
                    .transition(.scale.combined(with: .opacity))
            }
            Spacer()
            
        }
        .padding(.top)
        .navigationTitle("Calculator")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.spring, value: result)
    }
    
    //MARK: functions
    enum OperationType{
        case add, substract, multiply, divide
    }
    
    func calculate(_ operation: OperationType){
        guard let a = Double(firstNubmer), let b = Double(secondNubmer) else{
            result = "Enter a valid nubmer"
            return
        }
        
        let value:Double
        switch operation {
        case .add: value = a + b
        case .substract: value = a - b
        case .multiply: value = a * b
        case .divide: guard b != 0
            else { result = "Cannot divide by 0" ;return }
            value = a / b
            
            
        }
        result = value.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(value)) : String (format: "%.2f" ,value)
    }
}





struct OperationButton: View{
    
    let label: String
    let id: String
    let action: () -> Void
    
    var body: some View {
        Button{
            //action :code tp execute
            action()
        } label: {
            //label: how does the butto look
            Text(label)
                .font(.title.bold())
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.indigo)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
        }.accessibilityIdentifier(id)
    }
}

#Preview {
    NavigationStack{
        CalculatorView()
    }
}
