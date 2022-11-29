import Foundation
import Capacitor
import EstimoteUWB
 
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(sduwbPlugin)
public class sduwbPlugin: CAPPlugin {
    //private let implementation = sduwb()
    //let uwb = sduwb()
    var millisecondsSince1970: Int64 {
        Int64((Date().timeIntervalSince1970 * 1000.0).rounded())
    }
    @objc  func getMS() -> String {
        let currentTimeInMiliseconds: String = String(self.millisecondsSince1970);
        return currentTimeInMiliseconds;
    }
    var ManagerHandles:[String:EstimoteUWB.EstimoteUWBManager ] = [:];

    @objc func createManager(_ call: CAPPluginCall) {
        //let value = call.getString("value") ?? ""
        let timekey: String=self.getMS();
        ManagerHandles[timekey]=EstimoteUWBManager(
            positioningObserver: self,
            discoveryObserver: self,
            beaconRangingObserver: self)
        call.resolve(["handle":timekey])
    }
    @objc func startScanning(_ call: CAPPluginCall) {
        let Manager : String = call.getString("handle")!
        ManagerHandles[Manager]!.startScanning()
        call.resolve()
    }
}
extension sduwbPlugin:UWBPositioningObserver {
    public func didUpdatePosition(for device: UWBDevice) {
        print("position updated for device: \(device)")
    }
}
// OPTIONAL PROTOCOL FOR BEACON BLE RANGING
extension sduwbPlugin: BeaconRangingObserver {
    public func didRange(for beacon: BLEDevice) {
        print("beacon did range: \(beacon)")
    }
}

// OPTIONAL PROTOCOL FOR DISCOVERY AND CONNECTIVITY CONTROL
extension sduwbPlugin: UWBDiscoveryObserver {
    public var shouldConnectAutomatically: Bool {
        return true // set this to false if you want to manage when and what devices to connect to for positioning updates
    }
    
    public func didDiscover(device: UWBIdentifable, with rssi: NSNumber, from manager: EstimoteUWBManager) {
        print("Discovered Device: \(device.publicId) rssi: \(rssi)")
        
        // if shouldConnectAutomatically is set to false - then you could call manager.connect(to: device)
        // additionally you can globally call discoonect from the scope where you have inititated EstimoteUWBManager -> disconnect(from: device) or disconnect(from: publicId)
    }
    
    public func didConnect(to device: UWBIdentifable) {
        print("Successfully Connected to: \(device.publicId)")
    }
    
    public func didDisconnect(from device: UWBIdentifable, error: Error?) {
        print("Disconnected from device: \(device.publicId)- error: \(String(describing: error))")
    }
    
    public func didFailToConnect(to device: UWBIdentifable, error: Error?) {
        print("Failed to conenct to: \(device.publicId) - error: \(String(describing: error))")
    }
}
