//
//  Renderer.swift
//  IndicesAndConstants
//
//  Created by Peter Bødskov on 10/03/2019.
//  Copyright © 2019 Peter Bødskov. All rights reserved.
//

import Cocoa

import MetalKit

class Renderer: NSObject {
    //Device and command queue
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    
    var scene: Scene?
    
    //var currentLoop: Int = 0
    
    init(device: MTLDevice) {
        self.device = device
        commandQueue = device.makeCommandQueue()
        super.init()
    }
    
    
}

extension Renderer: MTKViewDelegate {
    //Called when view size changes
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    //called every frame
    func draw(in view: MTKView) {
        guard
            let drawable = view.currentDrawable,
            let descriptor = view.currentRenderPassDescriptor
        else { return }
        
        
        guard
            //create a buffer to hold commands
            let commandBuffer = commandQueue.makeCommandBuffer(),
            //and command encoder which will holds the commands
            let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor)
        else { return }
        
        let deltaTime = 1/Float(view.preferredFramesPerSecond)
        
        scene?.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
        
        commandEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
