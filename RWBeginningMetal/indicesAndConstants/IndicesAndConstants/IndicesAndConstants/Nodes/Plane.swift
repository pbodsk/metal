//
//  Plane.swift
//  IndicesAndConstants
//
//  Created by Peter Bødskov on 10/03/2019.
//  Copyright © 2019 Peter Bødskov. All rights reserved.
//

import Foundation
import MetalKit

class Plane: Node {
    
    var vertices: [Float] = [
        -1,  1, 0,
        -1, -1, 0,
         1, -1, 0,
         1,  1, 0
    ]
    
    //Instead of having duplicate entries in the vertices array we now indicate which
    //indices to use for the two triangles by this array.
    var indices: [UInt16] = [
        0, 1, 2,
        2, 3, 0
    ]
    
    var vertexBuffer: MTLBuffer?
    var indexBuffer: MTLBuffer?
    var time: Float = 0
    
    struct Constants {
        var animateBy: Float = 0.0
    }
    
    var constants = Constants()
    
    init(device: MTLDevice) {
        super.init()
        buildBuffers(device: device)
    }
    
    private func buildBuffers(device: MTLDevice) {
        vertexBuffer = device.makeBuffer(bytes: vertices,
                                         length: vertices.count * MemoryLayout<Float>.size,
                                         options: [])
        indexBuffer = device.makeBuffer(bytes: indices,
                                        length: indices.count * MemoryLayout<UInt16>.size,
                                        options: [])
    }
    
    override func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        super.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
        
        guard let indexBuffer = indexBuffer else { return }
        
        time += deltaTime
        let animateBy = abs(sin(time) / 2 + 0.5)
        constants.animateBy = animateBy

        commandEncoder.setVertexBuffer(vertexBuffer,
                                        offset: 0,
                                        index: 0)
        
        commandEncoder.setVertexBytes(&constants,
                                       length: MemoryLayout<Constants>.stride,
                                       index: 1)

        commandEncoder.drawIndexedPrimitives(type: .triangle,
                                              indexCount: indices.count,
                                              indexType: .uint16,
                                              indexBuffer: indexBuffer,
                                              indexBufferOffset: 0)

    }

}
