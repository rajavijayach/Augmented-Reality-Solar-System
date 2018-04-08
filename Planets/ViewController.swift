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

        // sun
        let sun = SCNNode(geometry: SCNSphere(radius: 0.4))
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun")
        sun.position = SCNVector3(0,0,-1)
        sun.runAction(celestialRotation(time:10))
        self.sceneView.scene.rootNode.addChildNode(sun)

        // mercury
        let mercuryOrbit = SCNNode(geometry: SCNTorus(ringRadius: 0.5,pipeRadius: 0.001))
        mercuryOrbit.geometry?.firstMaterial?.diffuse.contents=UIColor.gray
        mercuryOrbit.position = SCNVector3(0,0,-1)

        let mercury = planet(geometry: SCNSphere(radius: 0.03), diffuse: #imageLiteral(resourceName: "mercury"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.5,0,0))
        mercury.runAction(celestialRotation(time:6))

        let mercuryParent = SCNNode()
        mercuryParent.position = SCNVector3(0,0,-1)
        mercuryParent.runAction(celestialRotation(time:6))
        mercuryParent.addChildNode(mercury)

        self.sceneView.scene.rootNode.addChildNode(mercuryParent)
        self.sceneView.scene.rootNode.addChildNode(mercuryOrbit)

        // venus
        let venusOrbit = SCNNode(geometry: SCNTorus(ringRadius: 0.7,pipeRadius: 0.001))
        venusOrbit.geometry?.firstMaterial?.diffuse.contents=UIColor.gray
        venusOrbit.position = SCNVector3(0,0,-1)

        let venus = planet(geometry: SCNSphere(radius: 0.08), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7,0,0))
        venus.runAction(celestialRotation(time:6))

        let venusParent = SCNNode()
        venusParent.position = SCNVector3(0,0,-1)
        venusParent.runAction(celestialRotation(time:8))
        venusParent.addChildNode(venus)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        self.sceneView.scene.rootNode.addChildNode(venusOrbit)

        // earth and its moon
        let earthOrbit = SCNNode(geometry: SCNTorus(ringRadius: 1.2,pipeRadius: 0.001))
        earthOrbit.geometry?.firstMaterial?.diffuse.contents=UIColor.gray
        earthOrbit.position = SCNVector3(0,0,-1)

        let earth = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Earth day"), specular:#imageLiteral(resourceName: "Earth Specular"), emission:#imageLiteral(resourceName: "Earth Clouds"), normal:#imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2,0,0))
        earth.runAction(celestialRotation(time:6))

        let earthMoon = planet(geometry: SCNSphere(radius: 0.02), diffuse: #imageLiteral(resourceName: "Moon Surface"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.25,0.1,0))
        earthMoon.runAction(celestialRotation(time:4))

        let earthParent = SCNNode()
        earthParent.position = SCNVector3(0,0,-1)
        earthParent.runAction(celestialRotation(time:12))
        let moonParent = SCNNode()
        moonParent.position = SCNVector3(1.2,0,0)
        moonParent.runAction(celestialRotation(time: 1))

        moonParent.addChildNode(earthMoon)
        earth.addChildNode(moonParent)
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)       
        
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(earthOrbit)
        
        // mars
        let marsOrbit = SCNNode(geometry: SCNTorus(ringRadius: 1.8,pipeRadius: 0.001))
        marsOrbit.geometry?.firstMaterial?.diffuse.contents=UIColor.gray
        marsOrbit.position = SCNVector3(0,0,-1)
        
        let mars = planet(geometry: SCNSphere(radius: 0.08), diffuse: #imageLiteral(resourceName: "mars"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1.8,0,0))
        mars.runAction(celestialRotation(time:6))
        
        let marsParent = SCNNode()
        marsParent.position = SCNVector3(0,0,-1)
        marsParent.runAction(celestialRotation(time:16))
        marsParent.addChildNode(mars)
        self.sceneView.scene.rootNode.addChildNode(marsParent)
        self.sceneView.scene.rootNode.addChildNode(marsOrbit)
        
        // jupiter
        let jupiterOrbit = SCNNode(geometry: SCNTorus(ringRadius: 8,pipeRadius: 0.001))
        jupiterOrbit.geometry?.firstMaterial?.diffuse.contents=UIColor.gray
        jupiterOrbit.position = SCNVector3(0,0,-1)
        
        let jupiter = planet(geometry: SCNSphere(radius: 2), diffuse: #imageLiteral(resourceName: "jupiter"), specular: nil, emission: nil, normal: nil, position: SCNVector3(8,0,0))
        jupiter.runAction(celestialRotation(time:6))
        
        let jupiterParent = SCNNode()
        jupiterParent.position = SCNVector3(0,0,-1)
        jupiterParent.runAction(celestialRotation(time:20))
        jupiterParent.addChildNode(jupiter)
        self.sceneView.scene.rootNode.addChildNode(jupiterParent)
        self.sceneView.scene.rootNode.addChildNode(jupiterOrbit)
        
        // saturn
        let saturnOrbit = SCNNode(geometry: SCNTorus(ringRadius: 15,pipeRadius: 0.001))
        saturnOrbit.geometry?.firstMaterial?.diffuse.contents=UIColor.gray
        saturnOrbit.position = SCNVector3(0,0,-1)
        
        let saturn = planet(geometry: SCNSphere(radius: 0.8), diffuse: #imageLiteral(resourceName: "saturn"), specular: nil, emission: nil, normal: nil, position: SCNVector3(15,0,0))
        saturn.runAction(celestialRotation(time:6))
        
        let saturnRing = SCNNode()
        saturnRing.geometry =  SCNTube(innerRadius: 1,outerRadius: 2, height: 0.02)
        saturnRing.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "saturn ring")
        saturnRing.position = SCNVector3(0,0,0)
        saturnRing.rotation = SCNVector4(0,0,0,CGFloat(45.degreesToRadians))
        
        let ringParent = SCNNode()
        ringParent.position = SCNVector3(15,0,0)
        ringParent.runAction(celestialRotation(time: 1))
        
        let saturnParent = SCNNode()
        saturnParent.position = SCNVector3(0,0,-1)
        saturnParent.runAction(celestialRotation(time:24))
        
        ringParent.addChildNode(saturnRing)
        saturn.addChildNode(ringParent)
        saturnParent.addChildNode(saturn)
        saturnParent.addChildNode(ringParent)
        
        self.sceneView.scene.rootNode.addChildNode(saturnParent)
        self.sceneView.scene.rootNode.addChildNode(saturnOrbit)
        
        // uranus
        let uranusOrbit = SCNNode(geometry: SCNTorus(ringRadius: 24,pipeRadius: 0.001))
        uranusOrbit.geometry?.firstMaterial?.diffuse.contents=UIColor.gray
        uranusOrbit.position = SCNVector3(0,0,-1)
        
        let uranus = planet(geometry: SCNSphere(radius: 0.6), diffuse: #imageLiteral(resourceName: "uranus"), specular: nil, emission: nil, normal: nil, position: SCNVector3(24,0,0))
        uranus.runAction(celestialRotation(time:6))
        
        let uranusParent = SCNNode()
        uranusParent.position = SCNVector3(0,0,-1)
        uranusParent.runAction(celestialRotation(time:30))
        uranusParent.addChildNode(uranus)
        self.sceneView.scene.rootNode.addChildNode(uranusParent)
        self.sceneView.scene.rootNode.addChildNode(uranusOrbit)
        
        // neptune
        let neptuneOrbit = SCNNode(geometry: SCNTorus(ringRadius: 36,pipeRadius: 0.001))
        neptuneOrbit.geometry?.firstMaterial?.diffuse.contents=UIColor.gray
        neptuneOrbit.position = SCNVector3(0,0,-1)
        
        let neptune = planet(geometry: SCNSphere(radius: 0.4), diffuse: #imageLiteral(resourceName: "neptune"), specular: nil, emission: nil, normal: nil, position: SCNVector3(36,0,0))
        neptune.runAction(celestialRotation(time:6))
        
        let neptuneParent = SCNNode()
        neptuneParent.position = SCNVector3(0,0,-1)
        neptuneParent.runAction(celestialRotation(time:40))
        neptuneParent.addChildNode(neptune)
        self.sceneView.scene.rootNode.addChildNode(neptuneParent)
        self.sceneView.scene.rootNode.addChildNode(neptuneOrbit)
        
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
