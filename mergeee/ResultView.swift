//
//  ResultView.swift
//  mergeee
//
//  Created by User23 on 2022/4/17.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var game: Merge
    
    var body: some View {
        let bgColor = Color(red: 245/255, green: 235/255, blue: 235/255)
        
        ZStack{
            Rectangle()
                .frame(width: 265, height: 160)
                .foregroundColor(notUsedColor)
                .cornerRadius(50)
            
            Image("board")
                .resizable()
                .scaledToFit()
                .offset(x: -10)
            
            VStack{
                if game.isWin{
                    Text("You Win")
                        .font((.custom("ARTHISTORYBOOKRegular", size: 50)))
                        .foregroundColor(orange2)
                }
                else{
                    Text("GameOver")
                        .font((.custom("ARTHISTORYBOOKRegular", size: 50)))
                        .foregroundColor(black10)
                }
                Text("\(game.score)") // 這輪分數
                    .font((.custom("ARTHISTORYBOOKRegular", size: 65)))
                    .foregroundColor(red1)
                Text("\n\nHighest Score: ") // 最高分
                    .font((.custom("ARTHISTORYBOOKRegular", size: 25)))
                    .foregroundColor(blue7)
                    + Text("\(game.highestScore)\t")
                    .italic()
                    .font((.custom("", size: 22)))
                    .foregroundColor(blue7)
                    
                ZStack{
                    Circle()
                        .frame(width: 90, height: 90)
                        .foregroundColor(bgColor)
                    Circle()
                        .frame(width: 80, height: 80)
                        .foregroundColor(pink8)
                        .opacity(0.5)
                    Button(action: {
                        if game.isWin{
                            game.isWin = false
                        }else{
                            game.isLose = false
                        }
                    }, label: {
                        ZStack{
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(pink8)
                            Text("👌")
                                .font(.largeTitle)
                        }
                    })
                }
            }
            .offset(y: 80)
        }
    }
}
