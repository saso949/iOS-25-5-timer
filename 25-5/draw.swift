//
//  UIView.swift
//  25-5
//
//  Created by Aoba S on 2021/04/03.
//

import UIKit

class draw: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let line = UIBezierPath();
        // 起点
        line.move(to: CGPoint(x: 50, y: 160));
        // 帰着点
        line.addLine(to: CGPoint(x: 200, y: 600));
        line.addLine(to: CGPoint(x: 300, y: 280));
        // ラインを結ぶ
        line.close()
        // 色の設定
        UIColor.red.setStroke()
        // ライン幅
        line.lineWidth = 4
        // 描画
        line.stroke();
    }
    

}
