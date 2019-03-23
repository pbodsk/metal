//
//  ViewController.swift
//  Shaders
//
//  Created by Peter Bødskov on 23/03/2019.
//  Copyright © 2019 Peter Bødskov. All rights reserved.
//

import Cocoa

import MetalKit

enum Colors {
    static let backgroundColor = MTLClearColor(red: 0.0,
                                               green: 0.4,
                                               blue: 0.21,
                                               alpha: 1.0)
    static let anotherColor = MTLClearColor(red: 0.0,
                                            green: 0.21,
                                            blue: 0.4,
                                            alpha: 1.0)
}

class ViewController: NSViewController {
    var metalView: MTKView {
        return view as! MTKView
    }
    
    var renderer: Renderer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        metalView.device = MTLCreateSystemDefaultDevice()
        renderer = Renderer(device: metalView.device!)
        renderer.scene = GameScene(device: metalView.device!, size: view.bounds.size)
        
        metalView.clearColor = Colors.backgroundColor
        metalView.delegate = renderer
    }
}
