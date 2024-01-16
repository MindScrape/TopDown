/// @description Builds the initial world

// DEFINE THE GLOBAL VARIABLES
global.BLOCK_DRAWER = new InitializeBlockModelsActivity().initBlockModels()	 // Initialize the block models
global.MEM_MANAGER = new MapMemManager().initMapManager()					 // Initialize where we store object instances in memory within the gameworld


// INITIALIZE ANYTHING ELSE THAT IS REQUIRED TO RUN THE GAME
new Shape().initGpu()														// Initialize the GPU to draw graphics				

// GENERATE THE WORLD

global.BLOCK_DRAWER.drawBlock(0,0,0,1)


var mmm = new MapMemManager().initMapManager()

// var worldGenerator = new BasicWorldGenerator()
// worldGenerator.buildWorld(true)









// CREATE THE CAMERA
camera = new Camera3(100, 100, 100)
