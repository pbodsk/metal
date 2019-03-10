//
//  Shader.metal
//  IndicesAndConstants
//
//  Created by Peter Bødskov on 10/03/2019.
//  Copyright © 2019 Peter Bødskov. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct Constants {
    float animateBy;
};

//vertex function, prefix with vertex
//parameters: vertices = vertex array, vertexId = id of current vertex being processed on the GPU
vertex float4 vertex_shader(const device packed_float3 *vertices [[ buffer(0) ]],
                            constant Constants &constants [[ buffer(1) ]],
                            uint vertexId [[ vertex_id ]]) {
    float4 position = float4(vertices[vertexId], 1);
    position.x += constants.animateBy;
    return position;
}

//rasterizer takes over and split triangle into fragments
//fragment function, returning color of each fragment

fragment half4 fragment_shader() {
    return half4(0.7, 0.5, 0.2, 1);
}

