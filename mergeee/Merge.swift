//
//  Merge.swift
//  mergeee
//
//  Created by User23 on 2022/4/19.
//

import Foundation
import SwiftUI

let notUsedColor = Color(red: 200/255, green: 175/255, blue: 215/255, opacity: 0.75)
let red1 = Color(red: 249/255, green: 65/255, blue: 68/255)
let orange2 = Color(red: 249/255, green: 132/255, blue: 74/255)
let yellow3 = Color(red: 249/255, green: 199/255, blue: 79/255)
let green4 = Color(red: 144/255, green: 190/255, blue: 109/255)
let greenBlue5 = Color(red: 67/255, green: 170/255, blue: 139/255)
let brown6 = Color(red: 205/255, green: 151/255, blue: 119/255)
let blue7 = Color(red: 39/255, green: 125/255, blue: 161/255)
let pink8 = Color(red: 244/255, green: 151/255, blue: 142/255)
let purple9 = Color(red: 179/255, green: 146/255, blue: 172/255)
let black10 = Color(red: 73/255, green: 80/255, blue: 87/255)

let colorArr: [Color] = [notUsedColor, red1, orange2, yellow3, green4, greenBlue5, brown6, blue7, pink8, purple9, black10]

struct Grid{
    var value: Int = 0
    var isAppear: Bool = false // animition when appear & disappear
    var moveX: Int = 0
    var moveY: Int = 0
}

class Merge: ObservableObject{
    @Published var grids: [[Grid]] = Array(repeating: Array(repeating: Grid(),
                                                            count: 5),
                                          count: 5)
    @Published var turnNum: Int = 1 // 下一輪要出的數字
    @Published var score: Int = 0
    @Published var highestScore: Int = 0
    
    let gridCount: Int = 5 // 5X5
    var highestNum = 1
    var comboTimes: Int = 1
    var moveX: Int = 0
    var moveY: Int = 0
    
    init(){
        // 從UserDefaults存取最高分
        if let data = UserDefaults.standard.data(forKey: "highestScore"){
            let decoder = JSONDecoder()
            if let decodeData = try? decoder.decode(Int.self, from: data){
                highestScore = decodeData
            }
        }
    }
    
    func saveHighestScore(){ // 將最高分存入UserDefaults
        let encoder = JSONEncoder()
        if let encodeData = try? encoder.encode(highestScore){
            UserDefaults.standard.set(encodeData, forKey: "highestScore")
        }
    }
    
    func initialGame(){
        grids = Array(repeating: Array(repeating: Grid(), count: gridCount), count: gridCount)
        turnNum = 1 // 下一輪要出的數字
        score = 0
        comboTimes = 1
    }
    
    func clickGrid(row: Int, column: Int){
        appearNum(row: row, column: column, value: turnNum)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            self.mergeNum(row: row, column: column)
        }
    }
    
    func appearNum(row: Int, column: Int, value: Int){
        grids[row][column].value = value
        grids[row][column].isAppear = true
    }
    
    func disappearNum(row: Int, column: Int) {
        grids[row][column].isAppear = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            self.grids[row][column].value = 0
        }
    }
    
    func mergeNum(row: Int, column: Int){
        var canMerge = false
        let value = grids[row][column].value
        let addValue = grids[row][column].value + 1
        // up
        if row-1 >= 0 && value == grids[row-1][column].value{
            grids[row-1][column].moveX = 0
            grids[row-1][column].moveY = 1
            disappearNum(row: row-1, column: column)
            
            canMerge = true
        }
        // down
        if row+1 < gridCount && value == grids[row+1][column].value{
            grids[row+1][column].moveX = 0
            grids[row+1][column].moveY = -1
            disappearNum(row: row+1, column: column)
            
            canMerge = true
        }
        // left
        if column-1 >= 0 && value == grids[row][column-1].value{
            grids[row][column-1].moveX = 1
            grids[row][column].moveY = 0
            disappearNum(row: row, column: column-1)
            
            canMerge = true
        }
        // right
        if column+1 < gridCount && value == grids[row][column+1].value{
            grids[row][column+1].moveX = -1
            grids[row][column+1].moveY = 0
            disappearNum(row: row, column: column+1)
            
            canMerge = true
        }
        
        if canMerge{
            disappearNum(row: row, column: column)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.appearNum(row: row, column: column, value: addValue)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.mergeNum(row: row, column: column)
            }
        }
    }
}
