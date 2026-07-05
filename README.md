# ShaderToy2Unity

Port GLSL shaders from ShaderToy into Unity ShaderLab.

## What

ShaderToy shaders are written in GLSL. Unity uses ShaderLab with HLSL/Cg. This tool automates the translation — parsing ShaderToy's conventions and generating Unity-compatible shader files, handling the signal conversion while minimizing the noise introduced in porting.

## Why

Manual shader porting is tedious and error-prone. ShaderToy is an incredible resource for learning and prototyping GPU effects, but the gap between ShaderToy GLSL and Unity ShaderLab is wide enough that most developers port by hand — or don't port at all.

## Tech

`C#` `Unity` `ShaderLab` `GLSL` `HLSL`

## Usage

1. Copy a ShaderToy GLSL shader
2. Run the porting tool
3. Import the generated `.shader` file into Unity

```bash
# Example (adjust based on your project structure)
dotnet run -- --input shader.glsl --output MyShader.shader
```

## Status

Active development. See issues for planned features and known limitations.
