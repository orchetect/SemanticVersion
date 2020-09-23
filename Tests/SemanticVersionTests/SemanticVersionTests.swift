import XCTest
@testable import SemanticVersion

class SemanticVersionTests: XCTestCase {
	
	override func setUp() { super.setUp() }
	override func tearDown() { super.tearDown() }
	
	func testSemanticVersion_Typical() {
		
		let sv = SemanticVersion(from: "1.0.25")
		
		XCTAssertEqual(sv.major, 1)
		XCTAssertEqual(sv.minor, 0)
		XCTAssertEqual(sv.build, 25)
		
	}
	
	func testSemanticVersion_Empty() {
		
		let sv = SemanticVersion(from: "")
		
		XCTAssertEqual(sv.major, nil)
		XCTAssertEqual(sv.minor, nil)
		XCTAssertEqual(sv.build, nil)
		
	}
	
	func testSemanticVersion_InvalidString() {
		
		let sv = SemanticVersion(from: "text")
		
		XCTAssertEqual(sv.major, nil)
		XCTAssertEqual(sv.minor, nil)
		XCTAssertEqual(sv.build, nil)
		
	}
	
	func testSemanticVersion_InvalidLongString() {
		
		let sv = SemanticVersion(from: "Random text here. This would not be used typically.")
		
		XCTAssertEqual(sv.major, nil)
		XCTAssertEqual(sv.minor, nil)
		XCTAssertEqual(sv.build, nil)
		
	}
	
	func testSemanticVersion_PartiallyValid() {
		
		let sv = SemanticVersion(from: "X.2.4")
		
		XCTAssertEqual(sv.major, nil)
		XCTAssertEqual(sv.minor, 2)
		XCTAssertEqual(sv.build, 4)
		
	}
	
	func testSemanticVersion_Major() {
		
		let sv = SemanticVersion(from: "2")
		
		XCTAssertEqual(sv.major, 2)
		XCTAssertEqual(sv.minor, nil)
		XCTAssertEqual(sv.build, nil)
		
	}
	
	func testSemanticVersion_MajorMinor() {
		
		let sv = SemanticVersion(from: "2.4")
		
		XCTAssertEqual(sv.major, 2)
		XCTAssertEqual(sv.minor, 4)
		XCTAssertEqual(sv.build, nil)
		
	}
	
	func testSemanticVersion_Typical_StringDescription() {
		
		let sv = SemanticVersion(from: "1.0.25")
		
		XCTAssertEqual("\(sv)", "1.0.25")
		
	}
	
	func testSemanticVersion_InvalidPartialOrdering_StringDescription() {
		
		let sv = SemanticVersion(from: "X.2.4")
		
		XCTAssertEqual("\(sv)", "")
		
	}
	
	func testSemanticVersion_Major_StringDescription() {
		
		let sv = SemanticVersion(from: "2")
		
		XCTAssertEqual("\(sv)", "2")
		
	}
	
	func testSemanticVersion_MajorMinor_StringDescription() {
		
		let sv = SemanticVersion(from: "2.4")
		
		XCTAssertEqual("\(sv)", "2.4")
		
	}
	
	func testSemanticVersion_InvalidString_StringDescription() {
		
		let sv = SemanticVersion(from: "text")
		
		XCTAssertEqual("\(sv)", "")
		
	}
	
	// extra
	
	func testSemanticVersion_MajorZero() {
		
		let sv = SemanticVersion(from: "0.2")
		
		XCTAssertEqual(sv.major, 0)
		XCTAssertEqual(sv.minor, 2)
		XCTAssertEqual(sv.build, nil)
		
	}
	
}
