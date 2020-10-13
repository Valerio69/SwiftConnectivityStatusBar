import UIKit
import DeviceKit
import Network


public final class SCStatusBar {
  
  public static let shared = SCStatusBar()
  
  private let monitor = NWPathMonitor()
  let queue = DispatchQueue(label: "SCStatusBar-Monitor", qos: .default)
  
  private let statusBarView = SCStatusBarView()
  private let barHeight: CGFloat = Device.current.hasSensorHousing ? 64 : 44
  
  
  public func startMonitor() {
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
  
  func showStatusBar() {
    DispatchQueue.main.async { [self] in
      if let window = getFirstWindow() {
        window.addSubview(statusBarView)
        statusBarView.pin.right().left().height(barHeight).top(-barHeight)
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

