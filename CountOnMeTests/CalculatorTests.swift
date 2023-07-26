import XCTest
@testable import CountOnMe

final class SpyDelegate: FunctionsToDelegate {
    
    private(set) var alertIsLaunched = false
    private(set) var alertTitle: String?
    private(set) var alertMessage: String?
    
    func alertFunction(title: String, message: String) {
        alertIsLaunched = true
        alertTitle = title
        alertMessage = message
    }
    func updateDisplay(with: String) {}
}

final class CountOnMeTests: XCTestCase {
    func test_whenTheUserTryAnAdditionAndWantToGetTheResult() {
        let sut = Calculator()
        sut.addingNumberText(numbertext: "1")
        sut.addingOperand(operand: " + ")
        sut.addingNumberText(numbertext: "1")
        sut.calculate()
        XCTAssertEqual(sut.text, "2")
    }
    func test_whenUserTryASubstractionAndWantToGetResult() {
        let sut = Calculator()
        sut.addingNumberText(numbertext: "6")
        sut.addingOperand(operand: " - ")
        sut.addingNumberText(numbertext: "1")
        sut.calculate()
        XCTAssertEqual(sut.text, "5")
    }
    func test_whenUserTryADivisionAndWantToGetResult() {
        let sut = Calculator()
        sut.addingNumberText(numbertext: "10")
        sut.addingOperand(operand: " / ")
        sut.addingNumberText(numbertext: "2")
        sut.calculate()
        XCTAssertEqual(sut.text, "5")
    }
    func test_whenUserTryAMultiplicationAndWantToGetResult() {
        let sut = Calculator()
        sut.addingNumberText(numbertext: "4")
        sut.addingOperand(operand: " x ")
        sut.addingNumberText(numbertext: "4")
        sut.calculate()
        XCTAssertEqual(sut.text, "16")
    }
    func test_whenUserEnterACalculWithAMultiplicationPriorityInIt() {
        let sut = Calculator()
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: " + ")
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: " x ")
        sut.addingNumberText(numbertext: "2")
        sut.calculate()
        XCTAssertEqual(sut.text, "6")
    }
    func test_whenUserEnterACalculWithADivisionMultiplicationInIt() {
        let sut = Calculator()
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: " + ")
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: " / ")
        sut.addingNumberText(numbertext: "2")
        sut.calculate()
        XCTAssertEqual(sut.text, "3")
    }
    func test_whenUserDivideTheResultIsADecimal() {
        let sut = Calculator()
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: " / ")
        sut.addingNumberText(numbertext: "6")
        sut.calculate()
        XCTAssertEqual(sut.text, "0.33")
    }
    func test_preventingTheAppFromCrashWhenDividingByZero() {
        let delegateSpy = SpyDelegate()
        let sut = Calculator()
        sut.delegate = delegateSpy
        
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: "/")
        sut.addingNumberText(numbertext: "0")
        sut.calculate()
        
        XCTAssertTrue(delegateSpy.alertIsLaunched)
        XCTAssertEqual(delegateSpy.alertTitle, "Error")
        XCTAssertEqual(delegateSpy.alertMessage, "Can't divide by zero")
        XCTAssertEqual(sut.text, "0")
    }
    func test_preventingTheUserToStartWithAOperator() {
        let delegateSpy = SpyDelegate()
        let sut = Calculator()
        sut.delegate = delegateSpy
        
        sut.addingOperand(operand: "/")
        
        XCTAssertTrue(delegateSpy.alertIsLaunched)
        XCTAssertEqual(delegateSpy.alertTitle, "Error")
        XCTAssertEqual(delegateSpy.alertMessage, "You can't start with an operator, or having two operators following each others.")
        XCTAssertEqual(sut.text, "")
    }
    func test_resetingTheCalculatorToEmpty() {
        let sut = Calculator()
        sut.resetingCalculator()
        XCTAssertEqual(sut.text, "")
    }
}
