//
//  ContentView.swift
//  Assignment1
//
//  Created by Nick Allen on 1/12/25.
//

import SwiftUI

// The body of our program
// We bring the other two forms into view here
struct ContentView: View {
    // Init the patients & medications arrays and selected patients & meds
    @State var patients : [Patient] = []
    @State var selectedPatient : Patient?
    @State var medications : [Medication] = []
    @State var selectedMedication : Medication?
    @State var errorMessage : String?
    @State var searchPatient : String = ""
    
    // Links to forms for these two sections
    var body: some View {
        NavigationStack {
            // Work with a non-binding version of patients for filtering
            if patients.isEmpty {
                Text("Click Button Below to add Patients!")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .init(horizontal: .center, vertical: .center))
            }
            // Create a navigation link for each patient, we pass in the selected patients and the medications array
            // Existing medications, not the patients medications
            List(filteredPatients, id: \.MRN) { patient in
                NavigationLink(destination: DetailedPatientView(selectedPatient: $patients[getPatientIndex(for: patient)], medications : $medications)) {
                    PatientView(patient: patient)
                }
            }
            .navigationTitle("Patient Manager")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .center)
            
            // Links to form that allows us to add new patients
            NavigationLink("Add New Patient") {
                CreatePatientForm(patients: $patients)
            }
            .padding()
            .background(Color(.systemGray6)) // Light background color
            .cornerRadius(12) // Rounded corners
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
            
        }
        .searchable(text: $searchPatient)
        
    }
    
   
    // Computed property that filters the patients
    var filteredPatients: [Patient] {
        if searchPatient.isEmpty {
            return patients
        } else {
            return patients.filter { $0.surname.localizedCaseInsensitiveContains(searchPatient) }
        }
    }
    
    // Helper function to get the index of a patient in the original array
    // Need this in order to pass a binding object through navigation
    // Cannot just pass filtered patients as it isnt bound to patient array
    private func getPatientIndex(for patient: Patient) -> Int {
        patients.firstIndex { $0.MRN == patient.MRN } ?? 0
    }
}

#Preview {
    ContentView()
}
