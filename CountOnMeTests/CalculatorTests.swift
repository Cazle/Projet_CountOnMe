
import XCTest
@testable import CountOnMe

final class CountOnMeTests: XCTestCase {
    
    func test_whenTheUserTryAnAdditionAndWantToGetTheResult(){
        let sut = Calculator()
        sut.addingNumberText(numbertext: "1")
        sut.addingOperand(operand: " + ")
        sut.addingNumberText(numbertext: "1")
        sut.calculate()
        
        XCTAssertEqual(sut.text, "2")
    }
}
