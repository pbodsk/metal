//
//  MetalView.swift
//  MetalStart
//
//  Created by Peter Bødskov on 21/02/2019.
//  Copyright © 2019 Peter Bødskov. All rights reserved.
//

import MetalKit

class MetalView: MTKView {
    var renderer: Renderer!

    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        guard let defaultDevice = MTLCreateSystemDefaultDevice() else {
            fatalError("Device loading error")
        }
        device = defaultDevice
        colorPixelFormat = .bgra8Unorm
        clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1)
        createRenderer(device: device!)
    }
    
    private func createRenderer(device: MTLDevice) {
        renderer = Renderer(device: device)
        delegate = renderer
    }
}
