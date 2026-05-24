//
//  ContentView.swift
//  LoginCalculatorClass
//
//  Created by Kit Sitou on 5/21/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username:String = ""
    @State private var password:String = ""
    @State private var message:String = ""
    @State private var isLoggedIn:Bool = false
    
    @State private var showCalculator:Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack (spacing: 20){
                Image(systemName: "person.circle.fill").font(.system(size: 72))
                    .foregroundStyle(.blue)
                    .accessibilityIdentifier("appIcon")
                
                Text("UI Testing Demo")
                    .font(.largeTitle.bold())
                
                
                //--INPUT area
                VStack(spacing: 10){
                    
                    TextField("Username", text: $username)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .accessibilityIdentifier("usernameField")
                    
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityIdentifier("passwordField")
                    
                }.padding(.horizontal)
                
                Button{
                    //action
                    // login logic
                    handleLogin()
              
                } label: {
                    Text("Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.white)
                        .background( isFormValid ? .blue: .gray)
                        .cornerRadius(10)
                       
                }.disabled(!isFormValid)
                .padding()
                .accessibilityIdentifier("loginButton")
                
                if !message.isEmpty{
                    Text(message)
                        .font(.headline)
                        .foregroundStyle(isLoggedIn ? .green: .red)
                        .multilineTextAlignment(.center).padding(.horizontal)
                        .accessibilityIdentifier("resultLabel")
                        .transition(.opacity)
                }
                
                if isLoggedIn{
                    NavigationLink("Go to calculator", destination: CalculatorView())
                        .buttonStyle(.borderedProminent)
                        .accessibilityIdentifier("goToCalculatorButton")
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    
                    
                }
                Spacer()
                
                
            }
            .padding(.top ,40)
            .navigationTitle("")
            .animation(.easeInOut, value: message)
            .animation(.easeInOut, value: isLoggedIn)

        }
    }
    //MARK: Helpers
    var isFormValid: Bool {
        username.count >= 3 && password.count >= 3
    }
    
    func handleLogin(){
        if username == "admin" && password == "secret123"{
            message = "Welcome \(username)!"
            isLoggedIn = true
            
        }
        else {
            message = "Wrong credentials"
            isLoggedIn = false
        }
    }
    
}

#Preview {
    ContentView()
}
