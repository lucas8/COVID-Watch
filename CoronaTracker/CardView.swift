
//
//  CardView.swift
//  CoronaTracker
//
//  Created by Lucas Stettner on 3/7/20.
//  Copyright © 2020 Lucas Stettner. All rights reserved.
//

import SwiftUI
import MapKit

let defaultCoords = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)

struct CardView: View {
    @State var cardState = CGSize.zero
    @Binding var showFull: Bool
    @Binding var selectedPoint: MKAnnotation?
    @ObservedObject var hospitals = NearbyHospitalManager()
    @State var reportSheet = false
    
    var body: some View {
        let cardShown = selectedPoint != nil
        
        return VStack {
            Color.primary.opacity(0.35)
                .frame(width: 40, height: 5)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .offset(y: 10)
            
            CardHeaderView(selectedPoint: $selectedPoint)
            
            VStack(alignment: .leading) {
                Image(systemName: "info")
                    .foregroundColor(Color.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width:25, height: 25)
                    .background(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                    .clipShape(Circle())
                
                Text("Statistics")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.bottom, 8)
                
                StatRowView(color: #colorLiteral(red: 0.2431372549, green: 0.7411764706, blue: 0.5764705882, alpha: 1), number: 23, caption: "confirmed cases")
                StatRowView(color: #colorLiteral(red: 0.968627451, green: 0.7882352941, blue: 0.2823529412, alpha: 1), number: 72, caption: "user reported cases")
                StatRowView(color: #colorLiteral(red: 0.937254902, green: 0.3058823529, blue: 0.3058823529, alpha: 1), number: 2, caption: "confirmed deaths")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.primary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .padding(.horizontal, 16)
            
            VStack(alignment: .leading) {
                Image(systemName: "heart")
                    .foregroundColor(Color.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width:30, height: 30)
                    .background(Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
                    .clipShape(Circle())
                
                Text("Nearby Hospitals")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Color.primary.opacity(0.2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                
                ForEach(hospitals.hospitals, id: \.self) { hospital in
                    Text(hospital)
                        .font(.system(size: 18, weight: .medium))
                        .padding(.vertical, 2)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.primary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .padding(.horizontal, 16)
            
            Button(action: { self.reportSheet.toggle() }) {
                Text("Report a case")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .foregroundColor(Color.red)
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.top)
            }
            .sheet(isPresented: $reportSheet){
                ReportView(reportSheet: self.$reportSheet)
            }
            
            Button(action: {
                guard let number = URL(string: "tel://8002324636") else { return }
                
                UIApplication.shared.open(number)
            }) {
                Text("Call CDC Hotline")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .foregroundColor(Color.red)
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.top)
            }
            
            Spacer()
        }
        .frame(width: screen.width, height: 1000)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: -10)
        .offset(x: 0, y: cardShown ? 650 : 1000)
        .offset(y: cardState.height)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.6))
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.cardState = value.translation
                    
                    // Accounts for anchor change
                    if self.showFull {
                        self.cardState.height += -500
                    }
                    
                    // Blocks card from going beyond boundery
                    if self.cardState.height < -300 {
                        self.cardState.height = -500
                    }
            }
            .onEnded { value in
                // Makes card small
                if self.cardState.height > 100 {
                    self.selectedPoint = nil
                }
                
                if (self.cardState.height < -100 && !self.showFull) || (self.cardState.height < -250 && self.showFull) {
                    self.cardState.height = -500
                    self.showFull = true
                } else {
                    self.cardState = .zero
                    self.showFull = false
                }
            }
        )
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(showFull: .constant(false), selectedPoint: .constant(nil))
    }
}

struct CardHeaderView: View {
    @Binding var selectedPoint: MKAnnotation?
    @State var city: String?
    
    
    var body: some View {
        if selectedPoint != nil {
            let location = CLLocation(latitude: selectedPoint?.coordinate.latitude ?? 0, longitude: selectedPoint?.coordinate.longitude ?? 0)
            getCityLocation(location: location, completionHandler: { value in
                self.city = value?.thoroughfare
            })
        }
        return HStack {
            Text(String(city ?? "Nil"))
                .font(.system(size: 21, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: { self.selectedPoint = nil }) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .semibold))
                    .padding(8)
                    .background(Color.primary.opacity(0.1))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

struct StatRowView: View {
    let color: UIColor
    let number: Int
    let caption: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(String(number))
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(color))
            
            Text(caption)
                .font(.headline)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 4)
    }
}

func getCityLocation(location: CLLocation, completionHandler: @escaping (CLPlacemark?) -> Void ) {
    let geocoder = CLGeocoder()
        
    // Look up the location and pass it to the completion handler
    geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
        if error == nil {
            let firstLocation = placemarks?[0]
            completionHandler(firstLocation)
        }
        else {
            // An error occurred during geocoding.
            completionHandler(nil)
        }
    })
}
