//
//  LoginCalculatorClassUITests.swift
//  LoginCalculatorClassUITests
//
//  Created by Kit Sitou on 5/21/26.
//

import XCTest

@testable import LoginCalculatorClass

final class LoginCalculatorClassUITests: XCTestCase {
    // MARK: setup and Teardown
    
    var app: XCUIApplication!
    override func setUpWithError() throws {
        
        //stp immediately when a failure occurs
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        
        app.launch()

    }
    
    override func tearDownWithError() throws {
        //reset state of the application
        //rus after every test. Good place to take screenshot on failure, reset state, etc.
        app = nil
    }
   /*
    app.textFields["id"]
    app.secureTextFields["id"]
    app.buttons["id"]
    app.statcTexts["id"] ->UILabel / Text view
    */
    
    
    //all test are function
    func test_01_elementsExists() throws {
        //XCTAsset* functions are how you make assertions in XCTest.
        
        //check for the username input on screen
        XCTAssertTrue(app.textFields["usernameField"].exists ,"Username field should be visible")
        XCTAssertTrue(app.secureTextFields["passwordField"].exists, "Password field should be visible")
        XCTAssertTrue(app.buttons["loginButton"].exists, "Login Button should be visible")
    }
    
    
    //type into Text Fields
    func test_02_canTypeIntoField() throws {
        let usernameField = app.textFields["usernameField"]
        
        //.tap() --> focuses the element (bring up the keyboard, etc)
        usernameField.tap()
        
        // .typeText() --> Simulated keyboard input character by character
        
        usernameField.typeText("admin")
        
        let passwordField = app.secureTextFields["passwordField"]
        passwordField.tap()
        passwordField.typeText("secret123")
        
        //verify the username field has the correct value. waht we want the value equal to
        XCTAssertEqual(usernameField.value as? String, "admin")

        
    }
    
    //tapping button
    
    func test_03_loginButtonDisabledWhenFieldsEmpty() throws{
        let loginButton = app.buttons["loginButton"]
        
        //.isEnabled
        XCTAssertFalse(loginButton.isEnabled, "Login button should be disabled with empty fields")
    }
    
    func test_04_loginButtonEnabledWithInputFilled() throws{
        let usernameField = app.textFields["usernameField"]
        let passwordField = app.secureTextFields["passwordField"]
        
        usernameField.tap()
        usernameField.typeText("Mary")
        
        passwordField.tap()
        passwordField.typeText("ABCHK")
        
        let loginButton = app.buttons["loginButton"]
        
        XCTAssertTrue(loginButton.isEnabled, "Login button should be enabled with input filled")
        
        
        
    }
    
    
    
    //login function
    func logInCalculator() {
        let usernameField = app.textFields["usernameField"]
        
        //.tap() --> focuses the element (bring up the keyboard, etc)
        usernameField.tap()
        
        // .typeText() --> Simulated keyboard input character by character
        
        usernameField.typeText("admin")
        
        let passwordField = app.secureTextFields["passwordField"]
        passwordField.tap()
        passwordField.typeText("secret123")
        
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        
        let goToCalculatorButton = app.buttons["goToCalculatorButton"]
        goToCalculatorButton.tap()
        
        
   
    }
    
    
    
//    5 tests for the calculators--Assignment 3
    //1.func go to the calculator tap visibilty
    
    func test_05_goToCalculatorButtonExists() throws{
        let usernameField = app.textFields["usernameField"]
        
        //.tap() --> focuses the element (bring up the keyboard, etc)
        usernameField.tap()
        
        // .typeText() --> Simulated keyboard input character by character
        
        usernameField.typeText("admin")
        
        let passwordField = app.secureTextFields["passwordField"]
        passwordField.tap()
        passwordField.typeText("secret123")
        
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        
//        let goToCalculatorButton = app.buttons["goToCalculatorButton"]
        XCTAssertTrue(app.buttons["goToCalculatorButton"].exists, "goToCalculator Button should be visible")
        
    }
    
    
    
    //2.
    func test_06_firstNumberSecondNumberFieldExist() throws{
        logInCalculator()
 
        XCTAssertTrue(app.textFields["firstNumberField"].exists ,"First number field should be visible")
        XCTAssertTrue(app.textFields["secondNumberField"].exists, "Second number field should be visible")
        
    }
    
    //3.addButtonExists
    func test_07_addButtonExists() throws{
        logInCalculator()
        XCTAssertTrue(app.buttons["addButton"].exists, "add Button should be visible")
        
    }
    
    
    //4.with destination empty input result exist, need to disabled autofill password in setting
    func test_06_firstNumberSecondNumberWithEmptyResult() throws{
        logInCalculator()

        let addButton = app.buttons["addButton"]
        let calculatorResult = app.staticTexts["calculatorResult"]
        
        addButton.tap()
        XCTAssertTrue(calculatorResult.waitForExistence(timeout: 5))

        XCTAssertEqual(calculatorResult.label, "Result: Enter a valid nubmer")

    }
    
    
    
    //5.add with input, need to disabled autofill password in setting
    func test_07_firstNumberSecondNumberWithInputResult() throws{
        logInCalculator()
        let firstNumberField = app.textFields["firstNumberField"]
        let secondNumberField = app.textFields["secondNumberField"]
        let addButton = app.buttons["addButton"]
        let calculatorResult = app.staticTexts["calculatorResult"]

        firstNumberField.tap()
        firstNumberField.typeText("2")
        
        secondNumberField .tap()
        secondNumberField .typeText("5")
        
        addButton.tap()
        XCTAssertEqual(calculatorResult.label, "Result: 7")
        
        
        
        
    }
    
    

    
    
}
