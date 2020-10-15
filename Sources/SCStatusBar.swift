import UIKit
import DeviceKit
import Network


public final class SCStatusBar {
  
  public static let shared = SCStatusBar()
  
  let queue = DispatchQueue(label: "SCStatusBar-Monitor", qos: .default)
  var monitor: NWPathMonitor?
  
  // Our custom view
  lazy var statusBarView: SCStatusBarView = {
    return SCStatusBarView(style: self.style)
  }()
  
  // The Status bar height is 64 for Devices with Notch and 44 for Devices without Notch.
  lazy var barHeight: CGFloat = {
    return deviceHasSensorHousing() ? 64.0 : 44.0
  }()
  
  func deviceHasSensorHousing() -> Bool {
    return Device.current.hasSensorHousing
  }
  
  /// set the status bar label string. Default is ""Waiting for connection"
  public var style: SCStatusBarStyle = SCStatusBarStyle(statusString: "Waiting for connection",
                                                        backgroundColor: UIColor.red.withAlphaComponent(0.5)) {
    didSet {
      statusBarView.refreshStyle(style: style)
    }
  }
  
  /// Start monitoring the connection and show the View at the top if we are disconnected
  /// - Parameter statusString: set a custom Status bar label string.
  public func startMonitor() {
    // Make sure the previous NWPathMonitor is cancelled
    monitor?.cancel()
    
    // Initialize the monitor
    monitor = NWPathMonitor()
    monitor?.pathUpdateHandler = { [self] path in
      if path.status == .satisfied {
        print("We're connected!")
        hideStatusBar()
      }
      else {
        print("No connection.")
        showStatusBar()
      }
      print(path.isExpensive)
    }
    monitor?.start(queue: queue)
  }
  
  /// Stop receiving network updates
  public func stopMonitor() {
    monitor?.cancel()
    monitor = nil
  }
  
  func showStatusBar() {
    DispatchQueue.main.async { [self] in
      if let window = getFirstWindow() {
        window.addSubview(statusBarView)
        statusBarView.pin.horizontally().height(barHeight).top(-barHeight)
        UIView.animate(withDuration: 0.2) {
          window.subviews[0].pin.top(barHeight).height(UIScreen.main.bounds.size.height - self.barHeight)
          statusBarView.pin.top()
        }
      }
    }
  }
  
  func hideStatusBar() {
    DispatchQueue.main.async { [self] in
      if let window = getFirstWindow() {
        UIView.animate(withDuration: 0.2, animations: {
          statusBarView.pin.top(-barHeight)
          window.subviews[0].pin.top().height(UIScreen.main.bounds.size.height)
        }) { (_) in
          statusBarView.removeFromSuperview()
        }
      }
    }
  }
  
}

extension SCStatusBar {
  fileprivate func getFirstWindow() -> UIWindow? {
    if let window = UIApplication.shared.windows.first(where: { (window) -> Bool in
      return window.isKeyWindow
    }) {
      return window
    }
    return nil
  }
}

