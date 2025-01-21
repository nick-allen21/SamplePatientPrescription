//
//  Assignment1Tests.swift
//  Assignment1Tests
//
//  Created by Nick Allen on 1/12/25.
//
@testable import Assignment1
import XCTest
import SwiftUI
import Testing

final class Assignment1Tests : XCTestCase{
    
    // Makes vars for Tests
    var medications: [Medication]!
    var patients: [Patient]!
    
    override func setUp() {
            super.setUp()
            let now = Date()
            
            // Setup medications
            medications = [
                Medication(date: now, name: "Ozempic", dose: 0.5, route: .subcutaneous, frequency: 1, duration: 30, endDate: now.addingTimeInterval(30 * 24 * 60 * 60)),
                Medication(date: now, name: "Amoxicillin", dose: 500, route: .oral, frequency: 2, duration: 7, endDate: now.addingTimeInterval(7 * 24 * 60 * 60)),
                Medication(date: now, name: "Levothyroxine", dose: 75, route: .oral, frequency: 1, duration: 90, endDate: now.addingTimeInterval(90 * 24 * 60 * 60))
            ]
            
            // Setup patients
            patients = [
                Patient(name: "John", surname: "Doe", DOB: Calendar.current.date(byAdding: .year, value: -45, to: now)!, height: 60.0, weight: 210.0, bloodType: .APos, medications: medications)
            ]
        }
    
    func testPrescribeNewMedication() throws {
            // Prescribe a new medication
            let newMed = Medication(date: Date(), name: "Metformin", dose: 500, route: .oral, frequency: 1, duration: 60, endDate: Date().addingTimeInterval(60 * 24 * 60 * 60))
            try patients[0].prescribe(medication: newMed)
            // Make sure we properly assinged a medication
            XCTAssertTrue(patients[0].medications.contains(newMed))
        }
    
    func testPrescribeDuplicateMedicationThrowsError() throws {
            // Ensure that we cannot add the same medication twice and that the proper error is flagged
            XCTAssertThrowsError(try patients[0].prescribe(medication: medications[0])) { error in
                XCTAssertEqual(error as? Patient.prescriptionError, .medicationExists)
            }
        }
    
    func testPatientMedicationList() {
            let medicationList = patients[0].patientMedications()
            XCTAssertEqual(medicationList, ["Ozempic", "Amoxicillin", "Levothyroxine"])
        }
    
    func testBloodTypeCompatibility() {
            let patient = patients[0]
            
            // Test compatible blood types
            XCTAssertTrue(patient.receiveBlood(blood: .ONeg))
            XCTAssertTrue(patient.receiveBlood(blood: .OPos))
            XCTAssertTrue(patient.receiveBlood(blood: .APos))
            
            // Test incompatible blood types
            XCTAssertFalse(patient.receiveBlood(blood: .BNeg))
            XCTAssertFalse(patient.receiveBlood(blood: .BPos))
        }
    
    // very important in medical help applications to have simple unit tests that confirm your application is working correctly
//    @Test func PatientTests() async throws {
//        let medications = [
//            Medication(date : Date(), name: "Ozyempic", dose: 543, route: .subcutaneous, frequency: 5, duration: 720, endDate: Date()),
//            Medication(date : Date(), name: "Amoxicillin", dose: 100.0, route: .oral, frequency: 1, duration: 120, endDate: Date()),
//            Medication(date : Date(), name: "Levothyroxine", dose: 50, route: .topical, frequency: 3, duration: 35, endDate: Date())
//        ]
//        var patients = [
//            Patient(name: "Nicholas", surname: "Allen", DOB: Date(), height: 65.0, weight: 234.0, bloodType: .APos, medications: medications)
//        ]
//        #expect(throws : (any Error).self){
//            try patients[0].prescribe(medication: medications[0])
//        }
//        #expect(medications[1].name == "Amoxicillin")
//        #expect(medications[2].name == "Levothyroxine")
//        #expect(medications[2].duration == 35)
//        #expect(medications[0].name == "Ozyempic")
//        #expect(medications[0].frequency == 5)
//        #expect(patients[0].surname == "Allen")
//        
//    }

}
