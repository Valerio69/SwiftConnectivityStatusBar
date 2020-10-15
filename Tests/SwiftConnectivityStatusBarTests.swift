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
  
  func testSCStatubBarheight() {
    let height: CGFloat = SCStatusBar.shared.deviceHasSensorHousing() ? 64.0 : 44.0
    XCTAssertEqual(SCStatusBar.shared.barHeight, height)
  }
  
  func testSCStatusBarStartMonitor() {
    SCStatusBar.shared.startMonitor()
    XCTAssert(SCStatusBar.shared.monitor != nil, "SCStatusBar.shared.monitor must be set")
  }
  
  func testSCSStatusBarStopMonitor() {
    
    // Initialize the monitor
    SCStatusBar.shared.startMonitor()
    XCTAssertNotNil(SCStatusBar.shared.monitor, "SCStatusBar.shared.monitor must be set")
    
    // Stop the monitor
    SCStatusBar.shared.stopMonitor()
    XCTAssertNil(SCStatusBar.shared.monitor, "SCStatusBar.shared.monitor must be nil after stopping the monitor")
  }
  
}

