# A rear camera case for the Tanmatsu

This repository contains the parts for a rear case for the Tanmatsu handheld computer, designed to hold a Raspberry Pi camera module.

There are three parts, the case, which comes in two versions for older and newer Tanmatsu versions, the camera back with mounting for a Pi camera module, and a camera bracket which sits behind the module in order for the module mounting screws to have something to screw into. They fit together with small self-tapping screws.

The idea is that future versions for different cameras can be made as only the back, allowing the same case to be used.

So far it’s only been tested with the original 5 megapixel Pi camera, and clones, because afaik at the moment that’s the only one supported in software.

## Files

- **assembly-closeup.jpg** A close-up picture showing how the camera bracket works.
- **LICENSE** CERN OHL as per the Tanmatsu case.
- **source STL files.zip** Original case files. Unzip if you want to build in OpenSCAD.
- **tanmatsu camera back for Pi camera.stl** The camera back, that takes the Pi module.
- **tanmatsu camera bracket for Pi camera.stl** The bracket to hold the module in place.
- **tanmatsu camera case early versions.stl** Use this if you have a very early Tanmatsu.
- **tanmatsu camera case later versions.stl** Everyone else use this.
- **tanmatsu camera case parts.png** A render of how it all goes together.
- **tanmatsu camera case.scad** The OpenSCAD file to make it for yourself.
