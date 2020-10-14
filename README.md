# SwiftConnectivityStatusBar

A simple UIView that will appear on top of your Screen when the there is no Internet Connection.


<img src="/Design/SwiftConnectivityStatusBar.gif" width="300" height="533"/>


# Usage
One Simple usage could be within the SceneDelegate class where you can start the monitor when the app is in Foreground and stop it when in Background.
```swift
import SwiftConnectivityStatusBar

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func sceneWillEnterForeground(_ scene: UIScene) {
        SCStatusBar.shared.startMonitor()
        // OR pass the string that you want to be diplayed
        SCStatusBar.shared.startMonitor(statusString: "No Connection")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        SCStatusBar.shared.stopMonitor()
    }
}
```

