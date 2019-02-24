# Getting Started Notes

## Parts

### Once
- `MTLDevice` - device object, object that represents the GPU
- `MTLCommandQueue` - GPU must accept a list of commands, those are fed to the command queue
- `MTLRenderPipelineState` -  can tell the GPU which shader functions to use
- `MTLBuffer` - Memory areas that will hold the models and textures

### For Each Frame
Create a list of commands for the GPU to render
- `MTLCommandBuffer` - holds commands to render in this frame
- `MTLRenderCommandEncoder` - holds command

## Metal Pipeline
1. setup
2. vertex processing
3. primitive assembly
4. rasterization
5. fragment processing
6. present

## Gotchas in project
- Remember to change view to be of type `MTKView`
- Remember to set `delegate`
