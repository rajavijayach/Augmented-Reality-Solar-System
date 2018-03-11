//
//  ViewController.swift
//  Planets
//
//  Created by Vara Prasada Gopi Srinath Samudrala on 3/11/18.
//  Copyright © 2018 Vara Prasada Gopi Srinath Samudrala. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {
    let configuration = ARWorldTrackingConfiguration()
    
    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.showsStatistics=true
        self.sceneView.session.run(configuration)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let venusParent = SCNNode()
        let earthParent = SCNNode()
        let moonParent = SCNNode()
        
        let venusOrbit = SCNNode(geometry: SCNTorus(ringRadius: 0.7,pipeRadius: 0.005))
        venusOrbit.geometry?.firstMaterial?.diffuse.contents=UIColor.orange
        venusOrbit.position = SCNVector3(0,0,-1)
        
        let earthOrbit = SCNNode(geometry: SCNTorus(ringRadius: 1.2,pipeRadius: 0.005))
        earthOrbit.geometry?.firstMaterial?.diffuse.contents=UIColor.blue
        earthOrbit.position = SCNVector3(0,0,-1)
        
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun")
        sun.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        earthParent.position = SCNVector3(0,0,-1)
        moonParent.position = SCNVector3(1.2,0,0)
        
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7,0,0))
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular:#imageLiteral(resourceName: "Earth Specular"), emission:#imageLiteral(resourceName: "Earth Clouds"), normal:#imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2,0,0))
        let earthMoon = planet(geometry: SCNSphere(radius: 0.025), diffuse: #imageLiteral(resourceName: "Moon Surface"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.25,0.1,0))

        
        
        venusParent.runAction(celestialRotation(time:8))
        earthParent.runAction(celestialRotation(time:14))
        earthMoon.runAction(celestialRotation(time:4))
        venus.runAction(celestialRotation(time:6))
        earth.runAction(celestialRotation(time:6))
        sun.runAction(celestialRotation(time:10))
        moonParent.runAction(celestialRotation(time: 1))
        
        moonParent.addChildNode(earthMoon)
        earth.addChildNode(moonParent)
        venusParent.addChildNode(venus)
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusOrbit)
        self.sceneView.scene.rootNode.addChildNode(earthOrbit)

    }
    
    func celestialRotation(time:TimeInterval) -> SCNAction {
        return SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time))
    }
    
    func  planet(geometry:SCNGeometry, diffuse: UIImage, specular: UIImage?, emission:UIImage?, normal: UIImage?, position:SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry:geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Int{
    var degreesToRadians: Double {
        return Double(self) * .pi/180
    }
}
