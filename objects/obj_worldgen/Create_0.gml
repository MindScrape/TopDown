/// @description Builds the initial world

// DEFINE THE GLOBAL VARIABLES
global.BLOCK_DRAWER = new InitializeBlockModelsActivity()

// INITIALIZE ANYTHING THAT IS REQUIRED TO RUN THE GAME
new Shape().initGpu()											// Initialize the GPU to draw graphics
global.BLOCK_DRAWER.initBlockModels()							// Initialize the block models

// GENERATE THE WORLD

var worldGenerator = new BasicWorldGenerator()
worldGenerator.buildWorld(true)


// CREATE THE CAMERA
camera = new Camera3()
