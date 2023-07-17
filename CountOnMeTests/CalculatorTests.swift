
import XCTest
@testable import CountOnMe

final class CountOnMeTests: XCTestCase {
    
    func test_whenTheUserTryAnAdditionAndWantToGetTheResult(){
        let sut = Calculator()
        sut.addingNumberText(numbertext: "1")
        sut.addingOperand(operand: " + ")
        sut.addingNumberText(numbertext: "1")
        sut.calculate()
        
        XCTAssertEqual(sut.text, "2.0")
    }
    func test_whenUserTryASubstractionAndWantToGetResult(){
        let sut = Calculator()
        sut.addingNumberText(numbertext: "6")
        sut.addingOperand(operand: " - ")
        sut.addingNumberText(numbertext: "1")
        sut.calculate()
        
        XCTAssertEqual(sut.text, "5.0")
    }
    func test_whenUserTryADivisionAndWantToGetResult(){
        let sut = Calculator()
        sut.addingNumberText(numbertext: "10")
        sut.addingOperand(operand: " / ")
        sut.addingNumberText(numbertext: "2")
        sut.calculate()
        
        XCTAssertEqual(sut.text, "5.0")
    }
    func test_whenUserTryAMultiplicationAndWantToGetResult(){
        let sut = Calculator()
        sut.addingNumberText(numbertext: "4")
        sut.addingOperand(operand: " x ")
        sut.addingNumberText(numbertext: "4")
        sut.calculate()
        
        XCTAssertEqual(sut.text, "16.0")
    }
    func test_forResetingTheCalculatorButOnlyTheTextPartAndNotTheView(){
        let sut = Calculator()
        sut.resetingCalculator()
        XCTAssertEqual(sut.text, "")
    }
}
