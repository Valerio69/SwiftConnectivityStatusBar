import UIKit
import DeviceKit
import Network


public final class SCStatusBar {
  
  public static let shared = SCStatusBar()
  
  private let monitor = NWPathMonitor()
  private let queue = DispatchQueue(label: "SCStatusBar-Monitor", qos: .default)
  
  // Our custom view
  private lazy var statusBarView: SCStatusBarView = {
    return SCStatusBarView(statusString: statusBarString)
  }()
  
  // The Status bar height is 64 for Devices with Notch and 44 for Devices without Notch.
  private let barHeight: CGFloat = Device.current.hasSensorHousing ? 64 : 44
  
  /// set the status bar label string. Default is ""Waiting for connection"
  public var statusBarString: String = "Waiting for connection" {
    didSet {
      statusBarView.setStatusLabelString(statusBarString)
    }
  }
  
  /// Start monitoring the connection and show the View at the top if we are disconnected
  /// - Parameter statusString: set a custom Status bar label string.
  public func startMonitor(statusString: String?) {
    // Set a custom status if provided.
    if let text = statusString {
      statusBarString = text
    }
    monitor.pathUpdateHandler = { [self] path in
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
    monitor.start(queue: queue)
  }
  
  /// Stop receiving network updates
  public func stopMonitor() {
    monitor.cancel()
  }
  
  private func showStatusBar() {
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
  
  private func hideStatusBar() {
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

