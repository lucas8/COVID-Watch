//
//  Test.swift
//  CoronaTracker
//
//  Created by Lucas Stettner on 3/8/20.
//  Copyright © 2020 Lucas Stettner. All rights reserved.
//

import SwiftUI

struct Test: View {
    @ObservedObject var rp = ReportsFetcher()
    
    private var stateContent: AnyView {
        switch rp.state {
        case .loading:
            return AnyView(
                ActivityIndicator(style: .medium)
            )
        case .fetched(let result):
            switch result {
            case .failure(let error):
                return AnyView(
                    Text(error.localizedDescription)
                )
            case .success(let root):
                return AnyView(
                    ForEach(root.reports) { report in
                        Text("resport : \(report.description)")
                    }
                )
            }
        }
    }
    
    var body: some View {
        stateContent
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
