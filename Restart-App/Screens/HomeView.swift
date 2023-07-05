//
//  HomeView.swift
//  Restart-App
//
//  Created by 3rabApp-oday on 05/07/2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onBoarding") var isOnBoardingViewActive:Bool = false
    
    var body: some View {
        VStack(spacing:20) {
            Text("Home")
                .font(.largeTitle)
            
            Button {
                isOnBoardingViewActive = true
            } label: {
                Text("Restart")
            }
            
        }//: vStack
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
