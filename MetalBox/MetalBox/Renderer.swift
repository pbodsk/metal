//
//  Renderer.swift
//  MetalBox
//
//  Created by Peter Bødskov on 21/02/2019.
//  Copyright © 2019 Peter Bødskov. All rights reserved.
//

import Cocoa

import MetalKit

struct Vertex {
    var position: float3
    var color: float4
}

class Renderer: NSObject {
    var commandQueue: MTLCommandQueue!
    var renderPipelineState: MTLRenderPipelineState!
    var vertexBuffer: MTLBuffer!
    var vertices: [Vertex] = [
        Vertex(position: float3(0, 1, 0), color: float4(1, 0, 0, 1)),
        Vertex(position: float3(-1, -1, 0), color: float4(0, 1, 0, 1)),
        Vertex(position: float3(1, -1, 0), color: float4(0, 0, 1, 1))
    ]
    
    init(device: MTLDevice) {
        super.init()
        createCommandQueue(device: device)
        createPipelineState(device: device)
        createBuffers(device: device)
    }
    
    private func createCommandQueue(device: MTLDevice) {
        commandQueue = device.makeCommandQueue()
    }
    
    private func createPipelineState(device: MTLDevice) {
        let defaultLibrary = device.makeDefaultLibrary()!
        let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex")
        let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment")
        
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            renderPipelineState = try device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func createBuffers(device: MTLDevice) {
        vertexBuffer = device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard
            let drawable = view.currentDrawable,
            let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        //create buffer
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        commandEncoder?.setRenderPipelineState(renderPipelineState)
        
        commandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        commandEncoder?.endEncoding()
        
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
