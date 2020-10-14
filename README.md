# SwiftConnectivityStatusBar

A simple UIView that will appear on top of your Screen when the there is no Internet Connection.


<img src="/Design/SwiftConnectivityStatusBar.gif" width="300" height="533"/>

# Installation



# Usage

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/Valerio69/SwiftConnectivityStatusBar.git", .upToNextMajor(from: "1.0.2"))
]
```

### Example

Within the SceneDelegate class you can start the monitor when the app is in Foreground and stop it when in Background.
```swift
import SwiftConnectivityStatusBar

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func sceneWillEnterForeground(_ scene: UIScene) {
        SCStatusBar.shared.startMonitor()
        // OR using a custom style
        SCStatusBar.shared.style = SCStatusBarStyle(statusString: "Custom String",
                                                    backgroundColor: UIColor.green.withAlphaComponent(0.5))
        SCStatusBar.shared.startMonitor()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        SCStatusBar.shared.stopMonitor()
    }
}
```

