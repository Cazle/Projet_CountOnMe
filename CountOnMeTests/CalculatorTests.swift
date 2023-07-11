
import XCTest
@testable import CountOnMe

final class CountOnMeTests: XCTestCase {

    func test_whenTheUserTryAnAdditionAndWantToGetTheResult(){
        let sut = Calculator()
        sut.addingText(addText: "1 + 1")
    }
    
}
