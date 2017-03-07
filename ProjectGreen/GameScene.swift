//
//  GameScene.swift
//  ProjectGreen
//
//  Created by Jacob Pashman on 2/21/17.
//  Copyright © 2017 Manzanita Labs. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    var landBackground:SKTileMapNode!
    var objectsTileMap:SKTileMapNode!
    
    // constants
    let waterMaxSpeed: CGFloat = 50
    let landMaxSpeed: CGFloat = 200
    
    // if within threshold range of the target, troop begins slowing
    let targetThreshold:CGFloat = 200
    
    var maxSpeed: CGFloat = 0
    var acceleration: CGFloat = 0
    
    // touch location
    var targetLocation: CGPoint = .zero
    
    // Scene Nodes
    var troop:SKSpriteNode!
    var troop1:SKSpriteNode!

    
    override func didMove(to view: SKView) {
        loadSceneNodes()
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        maxSpeed = landMaxSpeed
        
        //setupObjects()
    }
    
    func loadSceneNodes() {
        //troop = createNode1(imageNamed: "TankA", name: "troop", pos: targetLocation)
//        var circle = SKTexture(image: UIImage(named: "TankA")!)
//        var troop = SKSpriteNode(texture: circle)
//        troop.position = targetLocation
//        troop.size = CGSize(width: 75, height: 75)
//
        guard let troop = childNode(withName: "troop") as? SKSpriteNode else {
            fatalError("Sprite Nodes not loaded")
        }
        self.troop = troop
//        
        
        
        
//        guard let tileSet = SKTileSet(named: "Object Tiles") else { fatalError("Object itles set not found")
//        }
//        
//        
//        objectsTileMap = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: size)
//        
//        
//        addChild(objectsTileMap)
//        
//        let tileGroups = tileSet.tileGroups
//        
//        let duckTile = tileGroups.first(where: {$0.name == "Duck"})
//        let gascanTile = tileGroups.first(where: {$0.name == "Gas Can"})

        guard let landBackground = childNode(withName: "landBackground")
            as? SKTileMapNode else {
                fatalError("Background node not loaded")
        }
        self.landBackground = landBackground
    }
    var variable: String!
    func createNode1(imageNamed: String, name: String, pos: CGPoint) -> SKSpriteNode {
        let sprite = SKSpriteNode(imageNamed: imageNamed)
        sprite.position = pos
        sprite.zPosition = 3.0
        sprite.size = CGSize(width: 300, height: 300)
        
        addChild(sprite)
        return sprite
    }
    
    var selectedTroops = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if selectedTroops == true {
            targetLocation = touch.location(in: self)
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
        troop.texture = SKTexture(image: UIImage(named: "TankA")!)
        print(targetLocation)
        print("touches began")  
        selectedTroops = false
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        print(touch.location(in: self))
        //let touch:UITouch = touches.anyObject()! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        print(touchedNode.name)
        if let name = touchedNode.name{
            if name == "troop" {
                selectedTroops = true
                troop.texture = SKTexture(image: UIImage(named: "TankA_Selected")!)
            }
        }
        //print("touches moved")
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        let position = troop.position
        let column = landBackground.tileColumnIndex(fromPosition: position)
        let row = landBackground.tileRowIndex(fromPosition: position)
        let tile = landBackground.tileDefinition(atColumn: column, row: row)
        
//        if tile == nil {
//            maxSpeed = waterMaxSpeed
//            //print("water")
//        } else {
//            maxSpeed = landMaxSpeed
//            //print("grass")
//        }
    }
    override func didSimulatePhysics() {
        
        let offset = CGPoint(x: targetLocation.x - troop.position.x,
                             y: targetLocation.y - troop.position.y)
        let distance = sqrt(offset.x * offset.x + offset.y * offset.y)
        let troopDirection = CGPoint(x:offset.x / distance,
                                   y:offset.y / distance)
        let troopVelocity = CGPoint(x: troopDirection.x * acceleration,
                                  y: troopDirection.y * acceleration)
        
        troop.physicsBody?.velocity = CGVector(dx: troopVelocity.x, dy: troopVelocity.y)
        
        if acceleration > 5 {
            troop.zRotation = atan2(troopVelocity.y, troopVelocity.x)
        }
        
        // update acceleration
        // troop speeds up to maximum
        // if within threshold range of the target, troop begins slowing
        // if maxSpeed has reduced due to different tiles,
        // may need to decelerate slowly to the new maxSpeed
        
        if distance < targetThreshold {
            let delta = targetThreshold - distance
            acceleration = acceleration * ((targetThreshold - delta)/targetThreshold)
            if acceleration < 2 {
                acceleration = 0
            }
        } else {
            if acceleration > maxSpeed {
                acceleration -= min(acceleration - maxSpeed, 80)
            }
            if acceleration < maxSpeed {
                acceleration += min(maxSpeed - acceleration, 40)
            }
        }
        
    }
}
