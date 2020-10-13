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
    if let window = self.getFirstWindow() {
      window.addSubview(self.statusBarView)
      
      self.statusBarView.pin.right().left().height(barHeight).top(-barHeight)
      
      UIView.animate(withDuration: 0.2) {
        window.subviews[0].pin.top(self.barHeight).height(UIScreen.main.bounds.size.height - self.barHeight)
        self.statusBarView.pin.top()
      }
    }
  }
  
  func hideStatusBar() {
    if let window = self.getFirstWindow() {
      UIView.animate(withDuration: 0.2, animations: {
        self.statusBarView.pin.top(-self.barHeight)
        window.subviews[0].pin.top().height(UIScreen.main.bounds.size.height)
      }) { (_) in
        self.statusBarView.removeFromSuperview()
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
