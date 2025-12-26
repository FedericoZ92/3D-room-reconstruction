# Room Reconstruction

This MATLAB project implements 3D room reconstruction using Kinect depth data. It includes scripts for connecting to Kinect, processing depth frames, converting depth to 3D coordinates, and stitching multiple frames for complete room mapping.

## Features

- Kinect connection and depth frame acquisition
- Depth to XYZ coordinate conversion
- Image stitching algorithms
- Visualization tools
- Denoising capabilities

## Block Diagram

![Block Diagram](docs/block-diagram.PNG)

## Project Structure

- `KinectMLConnect/`: Kinect connection and data acquisition scripts
- `misc/`: Miscellaneous utilities and data files
- `snippets/`: Core processing scripts (stitching, depth conversion, etc.)
- `docs/`: Documentation and diagrams

## Requirements

- MATLAB
- DIPimage toolbox (for stitching)
- Kinect SDK (for data acquisition)

## Usage

1. Connect Kinect sensor
2. Run `connectKinect.m` to acquire depth frames
3. Use `DepthToXYZ.m` to convert depth data to 3D points
4. Apply stitching with `stitching_v2.m` for multiple frames
5. Visualize results with provided plotting scripts

## Data Files

The project includes sample depth frames (.MAT files) and processed data for testing.