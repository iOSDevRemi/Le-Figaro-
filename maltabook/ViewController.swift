//
//  ViewController.swift
//  maltabook
//
//  Created by daniel.d4 on 06/01/2019.
//  Copyright © 2019 daniel.d4. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var lefigaroNode: SCNNode?
    var bravoNode: SCNNode?
    var etoileNode: SCNNode?
    var etoileeNode: SCNNode?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        let lefigaroScene = SCNScene(named: "art.scnassets/lefigaro.scn")
        let bravoScene = SCNScene(named: "art.scnassets/bravo.scn")
        let etoileScene = SCNScene(named: "art.scnassets/etoile.scn")
        let etoileeScene = SCNScene(named: "art.scnassets/etoile.scn")
        lefigaroNode = lefigaroScene?.rootNode
        bravoNode = bravoScene?.rootNode
        etoileNode = etoileScene?.rootNode
        etoileeNode = etoileeScene?.rootNode
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()

        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "Figaro", bundle: Bundle.main) {
            
            configuration.trackingImages = trackedImages
            configuration.maximumNumberOfTrackedImages = 4
        }
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let size = imageAnchor.referenceImage.physicalSize
            
            var videoNode = SKVideoNode()
            var shapeNode : SCNNode?
            var shapeeNode : SCNNode?
            
            switch imageAnchor.referenceImage.name {
            case "lejourdegloire":
                videoNode = SKVideoNode(fileNamed: "LeJourDeGloire1.mov")
            case "lalegende":
                videoNode = SKVideoNode(fileNamed: "LesBleusDansLaLegende.mov")
            case "didier":
                videoNode = SKVideoNode(fileNamed: "DidierDeschamp.mov")
            case "supporteur":
                videoNode = SKVideoNode(fileNamed: "SuporterAuStade.mov")
            case "poutin":
                videoNode = SKVideoNode(fileNamed: "UneCoupeDuMondeReussie.mov")
            case "lyon":
                videoNode = SKVideoNode(fileNamed: "LaJoieALyon.mov")
            case "leschamps":
                videoNode = SKVideoNode(fileNamed: "ChampsRempli.mov")
            case "newyork":
                videoNode = SKVideoNode(fileNamed: "SuporterNewYork.mov")
            case "breitling":
                videoNode = SKVideoNode(fileNamed: "breitlingPUB.mov")
            case "lidl":
                videoNode = SKVideoNode(fileNamed: "LidlPUB.mov")
            case "lv":
                videoNode = SKVideoNode(fileNamed: "LouisVuittonPUB.mov")
            case "amazon":
                videoNode = SKVideoNode(fileNamed: "AmazonPUB.mov")
            case TextType.titre.rawValue :
                shapeNode = lefigaroNode
            case TextType.etoiledroite.rawValue :
                shapeeNode = etoileNode
            case TextType.etoilegauche.rawValue :
                shapeeNode = etoileeNode
                
            default:
                break
            }
                if let shapee = shapeeNode{
                    node.addChildNode(shapee)
            }else {
                videoNode.play()
            }
                if let shape = shapeNode{
                  node.addChildNode(shape)
                }else{
                    }
            
            
            
            
            let shapeeSpin = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 00, duration: 10)
            let repeatSpin = SCNAction.repeatForever(shapeeSpin)
            shapeeNode?.runAction(repeatSpin)
         
            
            let videoScene = SKScene(size: CGSize(width: 640, height: 360))
            videoScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            videoScene.addChild(videoNode)
            
            
            
            let plane = SCNPlane(width: size.width, height: size.height)
            plane.firstMaterial?.diffuse.contents = videoScene
            plane.cornerRadius = 0.009
            let planeNode = SCNNode(geometry: plane)
            plane.firstMaterial?.isDoubleSided = true
            planeNode.eulerAngles.x = .pi / 2
            
            node.addChildNode(planeNode)
            //return node
            
            
            let planee = SCNPlane(width: size.width, height: size.height)
            planee.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(1.0)
            
            
            planee.cornerRadius = 0.009
            let planeeNode = SCNNode(geometry: plane)
            planee.firstMaterial?.isDoubleSided = true
            planeeNode.eulerAngles.x = .pi / 2
            
            node.addChildNode(planeeNode)
            return node
            
        }
        
      return nil
    }
    
      enum TextType : String {
        case titre = "titre"
        case etoiledroite = "etoiledroite"
        case etoilegauche = "etoilegauche"
    
    
    }
    
    
    
    


}
