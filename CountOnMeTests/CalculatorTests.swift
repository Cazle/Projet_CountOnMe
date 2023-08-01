import XCTest
@testable import CountOnMe

final class CountOnMeTests: XCTestCase {
    func test_whenTheUserTryAnAdditionAndWantToGetTheResult() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "1")
        sut.addingOperand(operand: "+")
        sut.addingNumberText(numbertext: "1")
        sut.calculate()
        
        XCTAssertEqual(controller.text, "2")
    }
    func test_whenUserTryASubstractionAndWantToGetResult() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "6")
        sut.addingOperand(operand: "-")
        sut.addingNumberText(numbertext: "1")
        sut.calculate()
        
        XCTAssertEqual(controller.text, "5")
    }
    func test_whenUserTryADivisionAndWantToGetResult() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "10")
        sut.addingOperand(operand: "/")
        sut.addingNumberText(numbertext: "2")
        sut.calculate()
        
        XCTAssertEqual(controller.text, "5")
    }
    func test_whenUserTryAMultiplicationAndWantToGetResult() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "4")
        sut.addingOperand(operand: "x")
        sut.addingNumberText(numbertext: "4")
        sut.calculate()
        
        XCTAssertEqual(controller.text, "16")
    }
    func test_whenUserEnterACalculWithAMultiplicationPriorityInIt() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: "+")
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: "x")
        sut.addingNumberText(numbertext: "2")
        sut.calculate()
        
        XCTAssertEqual(controller.text, "6")
    }
    func test_whenUserEnterACalculWithADivisionMultiplicationInIt() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: "+")
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: "/")
        sut.addingNumberText(numbertext: "2")
        sut.calculate()
        
        XCTAssertEqual(controller.text, "3")
    }
    func test_whenUserDivideTheResultIsADecimal() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: "/")
        sut.addingNumberText(numbertext: "6")
        sut.calculate()
        
        XCTAssertEqual(controller.text, "0.33")
    }
    func test_preventingTheAppFromCrashWhenDividingByZero() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: "/")
        sut.addingNumberText(numbertext: "0")
        sut.calculate()
        
        XCTAssertEqual(controller.alertMessage, "Can't divide by zero")
        XCTAssertEqual(controller.text, "0")
    }
    func test_preventingTheUserToStartWithAOperator() {
        let (sut, controller) = makeSUT()
        
        sut.addingOperand(operand: "/")
        
        XCTAssertEqual(controller.alertMessage, "You can't start with an operator, or having two operators following each others.")
        XCTAssertEqual(controller.text, "")
    }
    func test_preventingHavingAnIssueWithTwoFollowingOperator() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: "/")
        sut.addingOperand(operand: "x")
        
        XCTAssertEqual(controller.alertMessage, "You can't start with an operator, or having two operators following each others.")
        XCTAssertEqual(controller.text, "2 / ")
    }
    func test_preventingIfTheCalculatorDoesntHaveEnoughNumberOrElements() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "2")
        sut.calculate()
        
        XCTAssertEqual(controller.alertMessage, "Invalid behavior. You must have at least 3 elements, and don't finish by an operator.")
        XCTAssertEqual(controller.text, "2")
    }
    func test_preventingTheUserToFinishWithAnOperator() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: "x")
        sut.addingNumberText(numbertext: "2")
        sut.addingOperand(operand: "/")
        sut.calculate()
        
        XCTAssertEqual(controller.alertMessage, "Invalid behavior. You must have at least 3 elements, and don't finish by an operator.")
        XCTAssertEqual(controller.text, "2 x 2 / ")
    }
    func test_resetingTheCalculatorToEmpty() {
        let (sut, controller) = makeSUT()
        
        sut.addingNumberText(numbertext: "1")
        sut.resetingCalculator()
        
        XCTAssertEqual(controller.text, "")
    }
   private func makeSUT() -> (sut: Calculator, controller: SpyDelegate){
        let controller = SpyDelegate()
        let sut = Calculator()
        sut.delegate = controller
        
        return (sut, controller)
    }
   private final class SpyDelegate: CalculatorDelegate {
        
        var alertMessage: String = ""
        var text: String = ""
        
        func alertFunction(message: String) {
            alertMessage = message
        }
        func updateDisplay(with text: String) {
            self.text = text
        }
    }
}
