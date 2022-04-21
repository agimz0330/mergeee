//
//  GridIView.swift
//  mergeee
//
//  Created by User23 on 2022/4/19.
//

import SwiftUI

struct GridView: View {
    @Binding var grid: Grid
    @State private var isUsed: Bool = false
    
    @State private var moveX: CGFloat = 0
    @State private var moveY: CGFloat = 0
    @State private var opacity: Double = 1
    
    @State private var scale: CGFloat = 0.5
    
    func appear(){
        if grid.isAppear{
            isUsed = true
            withAnimation(Animation.spring(dampingFraction: 0.3)){
                scale = 1
            }
        }
        else{
            withAnimation(Animation.easeOut(duration: 0.2)){
                opacity = 0.25
                moveX += CGFloat(70 * grid.moveX)
                moveY += CGFloat(70 * grid.moveY)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){ // 半秒後 回復初始值
                isUsed = false
                scale = 0.5
                opacity = 1
                moveX = 0
                moveY = 0
                grid.moveX = 0
                grid.moveY = 0
            }
        }
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 65, height: 65)
                .foregroundColor(colorArr[0])
                .cornerRadius(10)
            
            if isUsed{
                ZStack{
                    Rectangle()
                        .frame(width: 65, height: 65)
                        .foregroundColor(colorArr[grid.value])
                        .cornerRadius(10)
                    Text("\(grid.value)")
                        .font((.custom("ARTHISTORYBOOKRegular", size: 70)))
                        .foregroundColor(.white)
                        .offset(y: 5)
                }
                .scaleEffect(scale)
                .offset(x: moveX, y: moveY)
                .opacity(opacity)
            } // if End
        }
        .onChange(of: grid.isAppear, perform: { _ in
            appear()
        })
        
    }
}
