import XCTest
@testable import SemanticVersion

class SemanticVersionTests: XCTestCase {
	
	override func setUp() { super.setUp() }
	override func tearDown() { super.tearDown() }
	
	func testSemanticVersion_Typical() {
		
		let sv = SemanticVersion(rawValue: "1.0.25")!
		
		XCTAssertEqual(sv.major, 1)
		XCTAssertEqual(sv.minor, 0)
		XCTAssertEqual(sv.build, 25)
		
	}
	
	func testSemanticVersion_Empty() {
		
		let sv = SemanticVersion(rawValue: "")!
		
		XCTAssertEqual(sv.major, nil)
		XCTAssertEqual(sv.minor, nil)
		XCTAssertEqual(sv.build, nil)
		
	}
	
	func testSemanticVersion_InvalidString() {
		
		let sv = SemanticVersion(rawValue: "text")!
		
		XCTAssertEqual(sv.major, nil)
		XCTAssertEqual(sv.minor, nil)
		XCTAssertEqual(sv.build, nil)
		
	}
	
	func testSemanticVersion_InvalidLongString() {
		
		let sv = SemanticVersion(rawValue: "Random text here. This would not be used typically.")!
		
		XCTAssertEqual(sv.major, nil)
		XCTAssertEqual(sv.minor, nil)
		XCTAssertEqual(sv.build, nil)
		
	}
	
	func testSemanticVersion_PartiallyValid() {
		
		let sv = SemanticVersion(rawValue: "X.2.4")!
		
		XCTAssertEqual(sv.major, nil)
		XCTAssertEqual(sv.minor, 2)
		XCTAssertEqual(sv.build, 4)
		
	}
	
	func testSemanticVersion_Major() {
		
		let sv = SemanticVersion(rawValue: "2")!
		
		XCTAssertEqual(sv.major, 2)
		XCTAssertEqual(sv.minor, nil)
		XCTAssertEqual(sv.build, nil)
		
	}
	
	func testSemanticVersion_MajorMinor() {
		
		let sv = SemanticVersion(rawValue: "2.4")!
		
		XCTAssertEqual(sv.major, 2)
		XCTAssertEqual(sv.minor, 4)
		XCTAssertEqual(sv.build, nil)
		
	}
	
	func testSemanticVersion_Typical_StringDescription() {
		
		let sv = SemanticVersion(rawValue: "1.0.25")!
		
		XCTAssertEqual("\(sv)", "1.0.25")
		
	}
	
	func testSemanticVersion_InvalidPartialOrdering_StringDescription() {
		
		let sv = SemanticVersion(rawValue: "X.2.4")!
		
		XCTAssertEqual("\(sv)", "")
		
	}
	
	func testSemanticVersion_Major_StringDescription() {
		
		let sv = SemanticVersion(rawValue: "2")!
		
		XCTAssertEqual("\(sv)", "2")
		
	}
	
	func testSemanticVersion_MajorMinor_StringDescription() {
		
		let sv = SemanticVersion(rawValue: "2.4")!
		
		XCTAssertEqual("\(sv)", "2.4")
		
	}
	
	func testSemanticVersion_InvalidString_StringDescription() {
		
		let sv = SemanticVersion(rawValue: "text")!
		
		XCTAssertEqual("\(sv)", "")
		
	}
	
	// extra
	
	func testSemanticVersion_MajorZero() {
		
		let sv = SemanticVersion(rawValue: "0.2")!
		
		XCTAssertEqual(sv.major, 0)
		XCTAssertEqual(sv.minor, 2)
		XCTAssertEqual(sv.build, nil)
		
	}
	
	func testCodable() {
		
		let sv = SemanticVersion(rawValue: "1.0.25")!
		
		// set up JSON coders with default settings
		
		let encoder = JSONEncoder()
		let decoder = JSONDecoder()
		
		// encode
		
		guard let encoded = try? encoder.encode(sv)
		else {
			XCTFail("JSON encode failed.") ; return
		}
		
		// ensure value is being stored as a string, and not multiple integers etc.
		
		XCTAssertEqual(String(data: encoded, encoding: .utf8),
					   "\"1.0.25\"")
		
		// decode
		
		guard let decoded = try? decoder.decode(SemanticVersion.self, from: encoded)
		else {
			XCTFail("JSON decode failed.") ; return
		}
		
		// compare original to reconstructed
		
		XCTAssertEqual(sv, decoded)
		
		XCTAssertEqual(sv.major, 1)
		XCTAssertEqual(sv.minor, 0)
		XCTAssertEqual(sv.build, 25)
		XCTAssertEqual(sv.rawValue, "1.0.25")
		
	}
	
}
