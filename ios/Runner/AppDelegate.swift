import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
        GMSServices.provideAPIKey("AIzaSyBPVgsEJL6Ntv20UlaIcoPx9W2zqWslOIU")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
