//
//  MazeScene.swift
//  RollingLabyrinth
//
// Lukas Vatistas (lvatista@iu.edu)
// Connor Hands(cahands@iu.edu)
// Project Name: MarbleMazeMobile
// A04 submission date: 4/12/24
// A05 submission date: 4/19/24

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let manager = CMMotionManager()
    var ball = SKSpriteNode()
    var endNode = SKSpriteNode()
    var initialPlayerPosition = CGPoint(x: 2, y: 160)
    var appDelegate: AppDelegate?
    var myModel: RollingLabyrinthModel?
    var ballTexture: SKTexture?
    var ballSize = CGSize(width: 12, height: 12)
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self

        /// Create Ball
        ballTexture = getBallTexture()
        ball = SKSpriteNode(texture: ballTexture, size: ballSize)
        ball.name = "Ball"
        
        // Assign a physics body to the ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballSize.width / 2)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.categoryBitMask = 1

        self.addChild(ball)

        // Initiate end node
        if let endNode = self.childNode(withName: "EndNode") as? SKSpriteNode {
            self.endNode = endNode
        } else {
            print("EndNode not found in the scene.")
        }

        // Motion start
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main) {
            [weak self] (data, error) in
            guard let strongSelf = self, let data = data else { return }
            strongSelf.physicsWorld.gravity = CGVector(dx: CGFloat(data.acceleration.x) * 10, dy: CGFloat(data.acceleration.y) * 10)
        }
    }
    
    // UPDATE SCENE
    override func didFinishUpdate() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModel = self.appDelegate?.myModel
        
        // Update color
        if let tmpModel = myModel {
            ///Ball Color
            let currentTexture = getBallTexture()
            if ball.texture != currentTexture { // Check if texture needs updating
                ball.texture = currentTexture
            }
            ///Background color
            if self.backgroundColor != tmpModel.backgroundColor{
                self.backgroundColor = tmpModel.backgroundColor
            }
        }
        
        // Reset player to starting point
        if let tmpModel = myModel, !tmpModel.timerCounting {
            resetPlayer()
            ball.physicsBody?.affectedByGravity = false
        } else {
            ball.physicsBody?.affectedByGravity = true
        }
    }
    
    // COLLISION
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
       
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2 || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 1{
            // Won Game
            print("Game Won")
            resetPlayer()
            // Update stats
            if let tmpModel = myModel{
                tmpModel.updateHighScore = true
                tmpModel.gamesWon += 1
                
                tmpModel.resetTimer = true
            }
        }
    }
    
    // Reset player position
    func resetPlayer() {
        let moveAction = SKAction.move(to: initialPlayerPosition, duration: 0)
        ball.run(moveAction)
    }
    
    func getBallTexture() -> SKTexture {
        var texture: SKTexture
        if let color = myModel?.ballColor {
            switch color {
            case "red":
                texture = SKTexture(imageNamed: "RedBall")
            case "green":
                texture = SKTexture(imageNamed: "GreenBall")
            case "blue":
                texture = SKTexture(imageNamed: "BlueBall")
            default:
                texture = SKTexture(imageNamed: "BlackBall")
            }
        } else {
            texture = SKTexture(imageNamed: "BlackBall")
        }
        return texture
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        // This method might be used for time-based updates if needed
    }
}
