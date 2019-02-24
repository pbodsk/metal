//
//  Renderer.swift
//  GettingStarted
//
//  Created by Peter Bødskov on 24/02/2019.
//  Copyright © 2019 Peter Bødskov. All rights reserved.
//

import Foundation
import MetalKit

class Renderer: NSObject {
    //Device and command queue
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    
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
        
        /*
         currentLoop += 1
         if currentLoop % 2 == 0 {
         view.clearColor = Colors.backgroundColor
         } else {
         view.clearColor = Colors.anotherColor
         }
        */
        
        //create a buffer to hold commands
        let commandBuffer = commandQueue.makeCommandBuffer()
        
        //and command encoder which will holds the commands
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
        
        //no commands yet so end encoding and commit
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}


