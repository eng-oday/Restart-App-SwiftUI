//
//  ContentView.swift
//  Restart-App
//
//  Created by 3rabApp-oday on 05/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onBoarding") var isOnBoardingViewActive:Bool = true
    
    var body: some View {

        ZStack{
            if isOnBoardingViewActive {
                OnBoardingView()
            }else{
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
