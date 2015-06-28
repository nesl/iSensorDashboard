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


class InterfaceController: WKInterfaceController {
    
    let mCMMotionManager = CMMotionManager()

    @IBOutlet var labelAccX: WKInterfaceLabel!
    @IBOutlet var labelAccY: WKInterfaceLabel!
    @IBOutlet var labelAccZ: WKInterfaceLabel!
    @IBOutlet var labelGyroX: WKInterfaceLabel!
    @IBOutlet var labelGyroY: WKInterfaceLabel!
    @IBOutlet var labelGyroZ: WKInterfaceLabel!
    
    
    @IBAction func startSensor() {
        if (mCMMotionManager.accelerometerAvailable == true) {
            let handler:CMAccelerometerHandler = {(data: CMAccelerometerData?, error: NSError?) -> Void in
                self.labelAccX.setText(String(format: "%.6f", data!.acceleration.x))
                self.labelAccY.setText(String(format: "%.6f", data!.acceleration.y))
                self.labelAccZ.setText(String(format: "%.6f", data!.acceleration.z))
            }
            mCMMotionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: handler)
        }
        
        if (mCMMotionManager.gyroAvailable == true) {
            let handler:CMGyroHandler = {(data: CMGyroData?, error: NSError?) -> Void in
                self.labelGyroX.setText(String(format: "%.6f", data!.rotationRate.x))
                self.labelGyroY.setText(String(format: "%.6f", data!.rotationRate.y))
                self.labelGyroZ.setText(String(format: "%.6f", data!.rotationRate.z))
            }
            mCMMotionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: handler)
        }
    }
    
    @IBAction func stopSensor() {
        mCMMotionManager.stopGyroUpdates()
        mCMMotionManager.stopGyroUpdates()
        
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
