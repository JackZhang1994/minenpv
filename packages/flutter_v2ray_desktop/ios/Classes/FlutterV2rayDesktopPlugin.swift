import Flutter
import UIKit

public class FlutterV2rayDesktopPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_v2ray_desktop", binaryMessenger: registrar.messenger())
        let instance = FlutterV2rayDesktopPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "start":
            handleStart(call: call, result: result)
        case "stop":
            handleStop(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    // MARK: - VPN Control Methods

    private func handleStart(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: "INVALID_ARGS", message: "Missing arguments", details: nil))
            return
        }


        let crypto = args["crypto"]
        var cryint = VPNManager.Crypto.AES256CFB
        if(crypto as! String == "aes-256-cfb"){
            cryint = VPNManager.Crypto.AES256CFB
        }else if(crypto as! String == "aes-128-cfb"){
            cryint = VPNManager.Crypto.AES128CFB
        }else if(crypto as! String == "aes-192-cfb"){
            cryint = VPNManager.Crypto.AES192CFB
        }

        let config = VPNManager.Config.init(
            name: args["name"] as! String,
            address: args["address"] as! String,
            port: args["port"] as! Int,
            crypto: cryint,
            password: args["password"] as! String
          )

        let status = args["status"] as! Bool
        if(status==false){
            VPNManager.shared.connect(with: config)
        }else{
            VPNManager.shared.disconnect()
        }

    }

    private func handleStop(result: @escaping FlutterResult) {
        VPNManager.shared.disconnect()

    }



}
