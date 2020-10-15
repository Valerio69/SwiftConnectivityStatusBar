import XCTest
@testable import SwiftConnectivityStatusBar

final class SwiftConnectivityStatusBarTests: XCTestCase {
  
  func testSCStatusBarStyleInit() {
    let style = SCStatusBarStyle(statusString: "Test", backgroundColor: UIColor.red)
    XCTAssertEqual(style.statusString, "Test")
    XCTAssertEqual(style.backgroundColor, UIColor.red)
  }
  
  func testSCStatusBarSetStyle() {
    let style = SCStatusBarStyle(statusString: "Test", backgroundColor: UIColor.red)
    SCStatusBar.shared.style = style
    XCTAssertEqual(SCStatusBar.shared.style.statusString, style.statusString)
    XCTAssertEqual(SCStatusBar.shared.style.backgroundColor, style.backgroundColor)
  }
  
  func testSCStatusBarStartMonitor() {
    
  }
  
}

