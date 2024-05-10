# Rectangles-MacOS

Welcome to the Rectangle Intersection Calculator repository! This project is an Xcode project written in Swift that allows users to upload a JSON file containing rectangles and calculates all the intersection rectangles.

## Features
* **Upload JSON file**: Users can upload a JSON file containing rectangles.
* **Calculate intersections**: The program calculates all the intersection rectangles based on the input JSON file.
* **Visualize results**: Users can visualize the intersection rectangles in the user interface.

## Requirements
* macOS 14.4 or later
* Xcode 15.3 or later

## Installation
1. Clone this repository to your local machine.
2. Open the Xcode project file `Rectangles.xcodeproj` in Xcode.
3. Build and run the project.
   
## Usage
1. Launch the application.
2. Use the interface to upload a JSON file containing rectangles.
3. View the calculated intersection rectangles in the user interface.

## JSON File Format
The JSON file should have the following format:
```json
{
    "rects": [
        {"x": 100, "y": 100, "w": 250, "h": 80 },
        {"x": 120, "y": 200, "w": 250, "h": 150 },
        {"x": 140, "y": 160, "w": 250, "h": 100 },
        {"x": 160, "y": 140, "w": 350, "h": 190 }
    ]
}

```
Each object in the array represents a rectangle with properties **x**, **y**, **w**, and **h**.

## JSON Examples
Two example JSON files are provided in the repository to demonstrate the format:

1. `inputFile_example.json`: Contains a set of rectangles for testing purposes.
2. `inputFile_example10.json`: Contains a big set of rectangles with similar dimensions.
