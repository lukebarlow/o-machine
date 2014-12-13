# define (require) ->

#     surfaceMapping = require('cs!surfaceMapping')
#     # given a camera and some surfaces, it will
#     # return a list of what surfaces are visible to the camera
#     return (camera, surfaces) ->

#         mapping = surfaceMapping()
#         [cameraX, cameraY, cameraDirection, cameraViewAngle] = camera


#         # copy surfaces and sort by distance from camera
#         surfaces = surfaces.slice().sort(midpointDistanceSort(camera))

#         console.log(surfaces)

#         return surfaces