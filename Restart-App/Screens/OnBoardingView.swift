//
//  OnBoardingView.swift
//  Restart-App
//
//  Created by 3rabApp-oday on 05/07/2023.
//

import SwiftUI

struct OnBoardingView: View {
    
    
    @AppStorage("onBoarding") var isOnBoardingViewActive:Bool   = true
    @State private var buttonWidth:Double                       = UIScreen.main.bounds.width - 80
    @State private var buttonOffset:CGFloat                     = 0
    @State private var isAnimating:Bool                         = false
    @State private var imageOffest:CGSize                       = .zero
    @State private var indicatorOpacity:Double                  = 1.0
    @State private var textTittle:String                        = "SHARE"
    
    var hapticFeedback = UINotificationFeedbackGenerator()

    var body: some View {
        
        ZStack{
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing:20){
            
                
                //MARK: - HEADER
                VStack(spacing:0) {
                    Text(textTittle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTittle)
                        
                    
                    Text("""
                        it's not how much we give but how much love we put into giving.
                        """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,10)
                    
                }//: HEADER
                
                // MARK:  ANIMATION EFFECT ON HEDAER
                .opacity(isAnimating ? 1 : 0)
                .offset(y:isAnimating ? 0 : -35)
                .animation(.easeOut(duration: 1), value: isAnimating)
                Spacer()

                //MARK: - BODY
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x:imageOffest.width * -1)
                        .blur(radius: abs(imageOffest.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffest)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating  ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                    // MARK:  ANIMATION EFFECT ON CHARACTER
                        .rotationEffect(Angle(degrees: Double(imageOffest.width / 20)))
                        .offset(x:imageOffest.width * 1.2)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    
                                    if abs(imageOffest.width) <= 150 {
                                        imageOffest = gesture.translation
                                        
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTittle = "GIVE"
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffest = .zero
                                    
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTittle = "SHARE"
                                    }
                                })
                        )
                        .animation(.easeOut(duration: 1), value: imageOffest)
                    
                        .overlay(
                            Image(systemName: "arrow.left.and.right.circle")
                                .font(.system(size: 44,weight: .ultraLight))
                                .foregroundColor(.white)
                                .offset(y:20)
                                .opacity(isAnimating ? 1 : 0)
                                .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                                .opacity(indicatorOpacity)
                            , alignment: .bottom
                        )
                        
                        
                    
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
                                        // MARK:  TO APPLY ANIMATION WHEN MOVE TO NEXT VC
                                        withAnimation {
                                            //IF DRAG GREATER THAN HALF WIDTH OF VIEW (GO HOME)
                                            if buttonOffset > buttonWidth / 2 {
                                                hapticFeedback.notificationOccurred(.success)
                                                PlaySound(sound: "chimeup", type: "mp3")
                                                buttonOffset = buttonWidth - 80
                                                isOnBoardingViewActive = false
                                                
                                            }else {
                                                //BACK TO INITIAL POINT
                                                buttonOffset = 0
                                            }
                                        }
                                    })
                            )
                            Spacer()
                        }//: HSTACK
                        
                       
                        
                    }//: FOOTER
                
                    .frame(width:buttonWidth,height: 80,alignment: .center)
                    .padding()
                
                // MARK:  ANIMATION EFFECT ON FOOTER
                    .opacity(isAnimating ? 1 : 0)
                    .blur(radius: isAnimating ? 0 : 5)
                    .scaleEffect(isAnimating ? 1 : 0.50)
                    .offset(x:isAnimating ? 0 : 100)
                    .animation(.easeOut(duration: 1), value: isAnimating)
            }//: VSTACK

        } //: ZSTACK
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)

    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
