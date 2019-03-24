//
//  Node.swift
//  IndicesAndConstants
//
//  Created by Peter Bødskov on 10/03/2019.
//  Copyright © 2019 Peter Bødskov. All rights reserved.
//

import Foundation
import MetalKit

class Node {
    var name = "untitled"
    var children: [Node] = []
    
    func add(_ childNode: Node) {
        children.append(childNode)
    }
    
    func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        for child in children {
            child.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
        }
    }
}
