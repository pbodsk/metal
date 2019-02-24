//
//  Shaders.metal
//  MetalBox
//
//  Created by Peter Bødskov on 21/02/2019.
//  Copyright © 2019 Peter Bødskov. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position;
    float4 color;
};

struct VertexOut {
    float4 position [[ position ]];
    float4 color;
};

vertex VertexOut basic_vertex(
                              const device VertexIn *vertices[[ buffer(0) ]],
                              unsigned int vertexID [[ vertex_id ]]) {
    VertexOut vOut;
    vOut.position = float4(vertices[vertexID].position, 1);
    vOut.color = vertices[vertexID].color;
    return vOut;
}

fragment float4 basic_fragment(VertexOut vIn [[ stage_in ]]) {
    return vIn.color;
}
