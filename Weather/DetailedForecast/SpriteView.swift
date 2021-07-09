//
//  SpriteView.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.07.2021.
//

import Foundation

import SpriteKit

class GameScene: SKScene {

    override func didMove(to view: SKView) {

        let effect = SKEffectNode()
        addChild(effect)

        let rect = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 400, height: 200))
        rect.fillColor = .green
        effect.addChild(rect)


        let hole = SKShapeNode(circleOfRadius: 40)
        hole.position = CGPoint(x: 200, y: 100)
        hole.fillColor = .white
        hole.blendMode = .subtract
        rect.addChild(hole)

    }
}
