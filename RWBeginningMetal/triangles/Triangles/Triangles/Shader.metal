//
//  Shader.metal
//  Triangles
//
//  Created by Peter Bødskov on 26/02/2019.
//  Copyright © 2019 Peter Bødskov. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

//vertex function, prefix with vertex
//parameters: vertices = vertex array, vertexId = id of current vertex being processed on the GPU
vertex float4 vertex_shader(const device packed_float3 *vertices [[ buffer(0) ]],
                            uint vertexId [[ vertex_id ]]) {
    return float4(vertices[vertexId], 1);
}

//rasterizer takes over and split triangle into fragments
//fragment function, returning color of each fragment

fragment half4 fragment_shader() {
    return half4(1, 0, 0, 1);
}
