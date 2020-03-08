//
//  InfoView.swift
//  CoronaTracker
//
//  Created by Lucas Stettner on 3/8/20.
//  Copyright © 2020 Lucas Stettner. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName:"exclamationmark.triangle.fill")
                            Text("Call your doctor if you…")
                                .font(.headline)
                        }
                        Text(" • Develop symptoms, and have been in close contact with a person known to have COVID-19")
                            .padding(.leading, 8)
                            .font(.subheadline)
                        Text(" • Have recently traveled from an area with widespread or ongoing community spread of COVID-19.")
                        .padding(.leading, 8)
                        .font(.subheadline)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.red.opacity(0.3))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Image(systemName: "person.3.fill")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width:40, height: 40)
                            .background(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                            .clipShape(Circle())
                            .padding(.bottom, 8)
                        
                        Text("How to protect yourself")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.bottom, 8)
                        
                        Text(" • Avoid close contact with people who are sick.")
                            .font(.subheadline)
                        
                        Text(" • Avoid touching your eyes, nose, and mouth.")
                            .font(.subheadline)
                        
                        Text(" • Stay home when you are sick.")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.primary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Image(systemName: "person.fill")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width:35, height: 35)
                            .background(Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
                            .clipShape(Circle())
                            .padding(.bottom, 8)
                        
                        Text("What to do if you are sick")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.bottom, 8)
                        
                        Text(" • Stay Home.")
                            .font(.subheadline)
                        
                        Text(" • Avoid public areas.")
                            .font(.subheadline)
                        
                        Text(" • Avoid public transportation.")
                            .font(.subheadline)
                        
                        Text(" • Stay away from others.")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.primary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .navigationBarTitle("Info")
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .colorScheme(.dark)
    }
}
