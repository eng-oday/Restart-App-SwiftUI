//
//  CircleGroupView.swift
//  Restart-App
//
//  Created by 3rabApp-oday on 05/07/2023.
//

import SwiftUI

struct CircleGroupView: View {
    
    @State var shapeColor:Color
    @State var shapeOpacity:CGFloat
    @State private var isAnimated:Bool = false
    
    
    var body: some View {
        
            ZStack{
                Circle()
                    .stroke(shapeColor.opacity(shapeOpacity),lineWidth: 40)
                    .frame(width: 260,height: 260,alignment: .center)
                
                Circle()
                    .stroke(shapeColor.opacity(shapeOpacity),lineWidth: 80)
                    .frame(width: 260,height: 260,alignment: .center)
            }//: ZSTACK
        
        // MARK:  ANIMATION EFFECT
            .blur(radius: isAnimated ? 0 : 20)
            .opacity(isAnimated ? 1 : 0)
            .scaleEffect(isAnimated ? 1 : 0.50)
            .animation(.easeOut(duration: 2), value: isAnimated)
        
            .onAppear {
                isAnimated = true
            }

    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            
            CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
        }
    }
}
