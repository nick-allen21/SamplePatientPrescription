//
//  Assignment1Tests.swift
//  Assignment1Tests
//
//  Created by Nick Allen on 1/12/25.
//
@testable import Assignment1
import SwiftUI
import Testing

struct Assignment1Tests {

    @Test func PatientTests() async throws {
        let medications = [
            Medication(date : Date(), name: "Ozyempic", dose: 543, route: "Oral", frequency: 5, duration: 720, endDate: Date()),
            Medication(date : Date(), name: "Amoxicillin", dose: 100.0, route: "Anal", frequency: 1, duration: 120, endDate: Date()),
            Medication(date : Date(), name: "Levothyroxine", dose: 50, route: "Topical", frequency: 3, duration: 35, endDate: Date())
        ]
        var patients = [
            Patient(MRN: "62633", name: "Nicholas", surname: "Allen", DOB: Date(), height: 65.0, weight: 234.0, bloodType: .APos, medications: medications, age: 45)
        ]
        #expect(throws : (any Error).self){
            try patients[0].prescribe(medication: medications[0])
        }
        #expect(medications[1].name == "Amoxicillin")
        #expect(medications[2].name == "Levothyroxine")
        #expect(medications[2].duration == 35)
        #expect(patients[0].MRN == "62633")
        #expect(medications[0].name == "Ozyempic")
        #expect(medications[1].route == "Anal")
        #expect(medications[0].frequency == 5)
        #expect(patients[0].surname == "Allen")
        
    }

}
