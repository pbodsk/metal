//
//  GameScene.swift
//  IndicesAndConstants
//
//  Created by Peter Bødskov on 10/03/2019.
//  Copyright © 2019 Peter Bødskov. All rights reserved.
//

import Foundation
import MetalKit

class GameScene: Scene {
    var quad: Plane
    
    override init(device: MTLDevice, size: CGSize) {
        quad = Plane(device: device)
        super.init(device: device, size: size)
        add(quad)
    }
}
