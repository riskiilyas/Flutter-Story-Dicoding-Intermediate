import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
        GMSServices.provideAPIKey("AIzaSyDIOt9jiW_STyznE5J26ozYwaGCL4Zwqjs")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
