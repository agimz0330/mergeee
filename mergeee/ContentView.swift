//
//  ContentView.swift
//  mergeee
//
//  Created by User23 on 2022/4/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game: Merge = Merge()
    
    var body: some View {
        ZStack{
            Image("bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Group{ // title: MERGE Number
                    Text("MER")
                        .foregroundColor(colorArr[1])
                    + Text("GE\t")
                        .foregroundColor(colorArr[7])
                    Text("\tNu")
                        .foregroundColor(colorArr[1])
                    + Text("mb")
                        .foregroundColor(colorArr[2])
                    + Text("er")
                        .foregroundColor(colorArr[7])
                }
                .font((.custom("ARTHISTORYBOOKRegular", size: 70)))
                
                Text("\n")
                
                HStack{
                    // restart
                    Button(action: {
                        game.initialGame()
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.largeTitle)
                            .foregroundColor(.pink)
                    })
                    
                    
                    Spacer()
                    
                    ZStack{ // score
                        Rectangle()
                            .fill(colorArr[0])
                            .frame(width: 120, height: 50)
                            .cornerRadius(35)
                        Text("\(game.score)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                    Spacer()
                }
                .padding([.leading, .trailing], 30)
                
                VStack{ // game grid
                    ForEach(0..<game.gridCount, id: \.self){ i in
                        HStack{
                            ForEach(0..<game.gridCount, id: \.self){ j in
                                // content
                                Button(action: {
                                    game.clickGrid(row: i, column: j)
                                }, label: {
                                    GridView(grid: $game.grids[i][j])
                                })
                                .disabled(game.disabledClick(row: i, column: j))
                            } // ForEach j End
                        } // HStack End
                    } // ForEach i End
                } // game grid End
                
                ZStack{
                    Rectangle()
                        .fill(colorArr[0])
                        .frame(width: 110, height: 90)
                        .cornerRadius(20)
                    Rectangle()
                        .frame(width: 65, height: 65)
                        .foregroundColor(colorArr[game.turnNum])
                        .cornerRadius(10)
                    Text("\(game.turnNum)")
                        .font((.custom("ARTHISTORYBOOKRegular", size: 70)))
                        .foregroundColor(.white)
                        .offset(y: 5)
                }
                .padding()
            } // VStack End
            if game.isWin || game.isLose{
                ZStack{
                    pink8
                        .opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    ResultView(game: game)
                }
            }
        }
        .onAppear{
            game.initialGame()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
