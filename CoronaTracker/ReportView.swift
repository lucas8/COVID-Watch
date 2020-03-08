//
//  ReportView.swift
//  CoronaTracker
//
//  Created by Lucas Stettner on 3/7/20.
//  Copyright © 2020 Lucas Stettner. All rights reserved.
//

import SwiftUI

struct ReportView: View {
    @Binding var reportSheet: Bool
    
    @State var locationString: String = ""
    @State private var selectorIndex = 0
    @State private var numbers = ["Report","Confirmed Case"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                
                Picker("Type", selection: $selectorIndex) {
                    ForEach(0 ..< numbers.count) { index in
                        Text(self.numbers[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                
                Text("Location".uppercased())
                    .font(.caption)
                    .opacity(0.5)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                Divider()
                TextField("478 W. Aspen Rd.", text: $locationString)
                    .padding()
                    .background(Color.primary.opacity(0.1))
                Divider()
                
                Text("Description of Symptoms".uppercased())
                    .font(.caption)
                    .opacity(0.5)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                Divider()
                TextField("Feaver, Cough, Shortness of Breath...", text: $locationString)
                    .padding()
                    .padding(.bottom, 50)
                    .background(Color.primary.opacity(0.1))
                Divider()
                
                Spacer()
            }
            .navigationBarTitle("Create Report", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: { self.reportSheet.toggle() }){
                    Text("Cancel")
            }, trailing:
                Button(action: { self.reportSheet.toggle() }) {
                    Text("Submit")
                        .fontWeight(.semibold)
                }
            )
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView(reportSheet: .constant(true))
            .colorScheme(.dark)
    }
}
