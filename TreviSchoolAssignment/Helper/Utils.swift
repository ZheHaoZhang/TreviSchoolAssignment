//
//  Utils.swift
//  TreviSchoolAssignment
//
//  Created by 張哲豪 on 2019/5/8.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    public class func delay(_ delay: Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    public class func makeTimerSource(interval: DispatchTimeInterval, handler:@escaping () -> Void)
        -> DispatchSourceTimer {
            let result = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            result.setEventHandler {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    handler()
                })
            }
            result.schedule(deadline: .now(), repeating: interval ,leeway:.milliseconds(0));
            result.resume()
            return result
    }
    
}
