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
    
    var vertices: [Float] = [
        -1, 1, 0,
        -1, -1, 0,
        1, -1, 0,
        1, -1, 0,
        1, 1, 0,
        -1, 1, 0
    ]
    
    var pipelineState: MTLRenderPipelineState?
    var vertexBuffer: MTLBuffer?
    
    //var currentLoop: Int = 0
    
    init(device: MTLDevice) {
        self.device = device
        commandQueue = device.makeCommandQueue()
        super.init()
        buildModel()
        buildPipelineState()
    }
    
    private func buildModel() {
        vertexBuffer = device.makeBuffer(bytes: vertices,
                                         length: vertices.count * MemoryLayout<Float>.size,
                                         options: [])
    }
    
    private func buildPipelineState() {
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "fragment_shader")
        
        //create pipeline descriptor
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            print(error)
        }
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
            let pipelineState = pipelineState,
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
        
        commandEncoder?.setRenderPipelineState(pipelineState)
        commandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}


