//
//  OnBoardingView.swift
//  Restart-App
//
//  Created by 3rabApp-oday on 05/07/2023.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("onBoarding") var isOnBoardingViewActive:Bool = true
    @State private var buttonWidth:Double  = UIScreen.main.bounds.width - 80
    @State private var buttonOffset:CGFloat = 0

    var body: some View {
        
        ZStack{
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing:20){
            
                
                //MARK: - HEADER
                VStack(spacing:0) {
                    Text("SHARE")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                        it's not how much we give but how much love we put into giving.
                        """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,10)
                    
                }//: HEADER
                Spacer()

                //MARK: - BODY
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                } //: BODY
                Spacer()
                
                //MARK: - FOOTER
                    ZStack{
                        
                        // 1. BACKGROUND (STATIC)
                        Capsule()
                            .fill(.white.opacity(0.2))
                        
                        Capsule()
                            .fill(.white.opacity(0.2))
                            .padding(8)
                        
                        // 2. CALL TO ACTION
                         Text("Get Started")
                            .font(.system(.title3,design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(x:20)
                            
                        
                        // 3. CAPSULE (DYNAMIC WIDTH)
                        HStack {
                            Capsule()
                                .fill(Color("ColorRed").opacity(0.9))
                                .frame(width: buttonOffset + 80) //UPDATE WIDTH WITH DRAG VALUES
                            
                            Spacer()
                        }//: HSTACK

                        // 4. CIRCLE (DRAGGABLE)
                        HStack {
                            ZStack{
                                Circle()
                                    .fill(Color("ColorRed").opacity(0.6))
                                    
                                Circle()
                                    .fill(.black.opacity(0.15))
                                    .padding(8)
                                
                                Image(systemName: "chevron.right.2")
                                    .font(.system(size: 24,weight: .bold))
                            }//: ZSTACK
                            .foregroundColor(.white)
                            .frame(width: 80,height: 80,alignment: .center)
                            .offset(x:buttonOffset)
                            
                            // DRAG GESTURE
                            .gesture(
                                DragGesture()
                                    .onChanged({ gesture in
                                        if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                            buttonOffset = gesture.translation.width
                                        }
                                    })
                                    .onEnded({ _ in
                                        //IF DRAG GREATER THAN HALF WIDTH OF VIEW (GO HOME)
                                        if buttonOffset > buttonWidth / 2 {
                                            buttonOffset = buttonWidth - 80
                                            isOnBoardingViewActive = false
                                        }else {
                                            //BACK TO INITIAL POINT
                                            buttonOffset = 0
                                        }
                                    })
                            )
                            Spacer()
                        }//: HSTACK
                        
                       
                        
                    }//: FOOTER
            
                    .frame(width:buttonWidth,height: 80,alignment: .center)
                    .padding()

            }//: VSTACK

        } //: ZSTACK

    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
