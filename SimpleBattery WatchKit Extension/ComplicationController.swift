//
//  ComplicationController.swift
//  SimpleBattery WatchKit Extension
//
//  Created by Jordan Koch on 3/2/19.
//  Copyright © 2019 Jordan Koch. All rights reserved.
//

import WatchKit
import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        //handler([.forward, .backward])
        handler([])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry

        let device = WKInterfaceDevice.current()
        device.isBatteryMonitoringEnabled = true
        let battery = device.batteryLevel
        let theTemplate = CLKComplicationTemplateUtilitarianSmallFlat()
        theTemplate.textProvider = CLKSimpleTextProvider(text: String(format: "%.0f", (battery * 100))+"%")
        
        let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: theTemplate)
        
        handler(entry)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        
        switch complication.family {
        case .utilitarianSmall:
            let theTemplate = CLKComplicationTemplateUtilitarianSmallFlat()
            theTemplate.textProvider = CLKSimpleTextProvider(text: "50%")
            
            handler(theTemplate)
            
        default:
            handler(nil)
        }
    }
    
}
