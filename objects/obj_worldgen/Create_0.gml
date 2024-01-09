/// @description Builds the initial world

/*
var vectorOne = new Vector2(5, 6)
var vectorTwo = new Vector2(10, 11)
var vectorThree = vectorOne.add(vectorTwo)
show_debug_message(vectorThree.toString())

var cube = new Array3(3, 10, 3)
cube.set(1, 1, 1, 5)
show_debug_message(cube.toString())

var square = new Array2(10, 10)
square.set(4, 4, 5)
show_debug_message(square.toString())
*/
new Shape().initGpu()

var worldGenerator = new BasicWorldGenerator()
worldGenerator.buildWorld()

camera = new Camera3()
block = new Block(16, 16, 100)
