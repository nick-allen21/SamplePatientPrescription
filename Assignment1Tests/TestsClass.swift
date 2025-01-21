////
////  Untitled.swift
////  Assignment1
////
////  Created by Nick Allen on 1/20/25.
////
//import XCTest
//import SwiftUI
//@testable import Assignment1
//
//final class Assignment1Tests: XCTestCase {
//    
//    // Shared test data
//    var medications: [Medication]!
//    var patients: [Patient]!
//    
//    override func setUp() {
//        super.setUp()
//        let now = Date()
//        
//        // Setup medications
//        medications = [
//            Medication(date: now, name: "Ozempic", dose: 0.5, route: .subcutaneous, frequency: 1, duration: 30, endDate: now.addingTimeInterval(30 * 24 * 60 * 60)),
//            Medication(date: now, name: "Amoxicillin", dose: 500, route: .oral, frequency: 2, duration: 7, endDate: now.addingTimeInterval(7 * 24 * 60 * 60)),
//            Medication(date: now, name: "Levothyroxine", dose: 75, route: .oral, frequency: 1, duration: 90, endDate: now.addingTimeInterval(90 * 24 * 60 * 60))
//        ]
//        
//        // Setup patients
//        patients = [
//            Patient(name: "John", surname: "Doe", DOB: Calendar.current.date(byAdding: .year, value: -45, to: now)!, height: 180.0, weight: 80.0, bloodType: .APos, medications: medications)
//        ]
//    }
