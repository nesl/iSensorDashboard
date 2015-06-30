//
//  InterfaceController.swift
//  iSensorDashboard WatchKit Extension
//
//  Created by Chenguang Shen on 6/28/15.
//  Copyright © 2015 UCLA NESL. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion
// import HealthKit


class InterfaceController: WKInterfaceController {
    
    let mCMMotionManager = CMMotionManager()
    var accCount = 0
    var startTs: NSTimeInterval?
    var lastTS: NSTimeInterval?
    
//    let healthStore = HKHealthStore()
//    let heartRateType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!

    @IBOutlet var labelAccX: WKInterfaceLabel!
    @IBOutlet var labelAccY: WKInterfaceLabel!
    @IBOutlet var labelAccZ: WKInterfaceLabel!
    @IBOutlet var labelGyroX: WKInterfaceLabel!
    @IBOutlet var labelGyroY: WKInterfaceLabel!
    @IBOutlet var labelGyroZ: WKInterfaceLabel!
    @IBOutlet var labelHeartRate: WKInterfaceLabel!
    @IBOutlet var accRateLabel: WKInterfaceLabel!
    @IBOutlet var accTSLabel: WKInterfaceLabel!
    
    @IBAction func startSensor() {
        // Acc
        self.accCount = 0
        mCMMotionManager.accelerometerUpdateInterval = 0
        if (mCMMotionManager.accelerometerAvailable == true) {
            let handler:CMAccelerometerHandler = {(data: CMAccelerometerData?, error: NSError?) -> Void in
//                self.labelAccX.setText(String(format: "%.6f", data!.acceleration.x))
//                self.labelAccY.setText(String(format: "%.6f", data!.acceleration.y))
//                self.labelAccZ.setText(String(format: "%.6f", data!.acceleration.z))
                if self.accCount == 0 {
                    self.startTs = data?.timestamp
                }
                self.lastTS = data?.timestamp
                self.accCount++
            }
            mCMMotionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: handler)
        }
        else {
            self.labelGyroX.setText("Acc N/A")
            self.labelGyroY.setText("Acc N/A")
            self.labelGyroZ.setText("Acc N/A")
        }
        
        // Gyro
        mCMMotionManager.gyroUpdateInterval = 0
        if (mCMMotionManager.gyroAvailable == true) {
            let handler:CMGyroHandler = {(data: CMGyroData?, error: NSError?) -> Void in
                self.labelGyroX.setText(String(format: "%.6f", data!.rotationRate.x))
                self.labelGyroY.setText(String(format: "%.6f", data!.rotationRate.y))
                self.labelGyroZ.setText(String(format: "%.6f", data!.rotationRate.z))
            }
            mCMMotionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: handler)
        }
        else {
            self.labelGyroX.setText("Gyro N/A")
            self.labelGyroY.setText("Gyro N/A")
            self.labelGyroZ.setText("Gyro N/A")
        }
        
//        // Heart rate
//        if HKHealthStore.isHealthDataAvailable() != true {
//            self.labelHeartRate.setText("HR not availabel")
//        }
//        
//        let dataTypes = NSSet(object: heartRateType) as! Set<HKObjectType>
//        healthStore.requestAuthorizationToShareTypes(nil, readTypes: dataTypes) { (success, error) -> Void in
//            if success != true {
//                self.labelHeartRate.setText("HR not allowed")
//            }
//        }
    }
    
    @IBAction func stopSensor() {
        mCMMotionManager.stopAccelerometerUpdates()
        mCMMotionManager.stopGyroUpdates()
        
        // let accFreq = self.accCount / (Int(self.lastTS!) % 60 - Int(self.startTs!) % 60)
        accRateLabel.setText(String(format: "%d", self.accCount))
        accTSLabel.setText(String(format: "%d", Int(self.lastTS!) - Int(self.startTs!)))
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
