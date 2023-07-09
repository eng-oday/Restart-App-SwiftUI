//
//  HomeView.swift
//  Restart-App
//
//  Created by 3rabApp-oday on 05/07/2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onBoarding") var isOnBoardingViewActive:Bool = false
    @State private var isAnimated :Bool = false
    
    var body: some View {
        VStack(spacing:20) {

            // MARK:  HEADER
            Spacer()
            ZStack {
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.13)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                // MARK:  APPLY ANIMATION ON CHARACTER
                
                    .offset(y:isAnimated ? 35 : -35)
                    .animation(
                        Animation
                            .easeOut(duration: 4)
                            .repeatForever()
                    )
                    
                    
            } //: HEADER
            
            // MARK:  BODY
            Text("the time that leads to mastery is dependent on the intensity of our focus. ")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            
            // MARK:  FOOTER
            Button {
                withAnimation {
                    isOnBoardingViewActive = true
                }
               
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3,design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
        }//: vStack
        .onAppear {
            isAnimated = true
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
