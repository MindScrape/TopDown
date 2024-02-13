/// @description Builds the initial world

// DEFINE THE GLOBAL VARIABLES


// INITIALIZE ANYTHING ELSE THAT IS REQUIRED TO RUN THE GAME
new Shape().initGpu()					// Initialize the GPU to draw graphics				

blockMap = new MapMemManager().initMapManager()
blockDrawer = new BlockDrawer().initBlockModels()	

placeBlockAction = new PlaceBlock(blockMap, blockDrawer)

//genX = 0
//genY = 0

// GENERATE THE WORLD
//var worldGenerator = new BasicWorldGenerator(blockMap, blockDrawer)
//worldGenerator.buildWorld()


// CREATE THE CAMERA
camera = new Camera3(100, 100, 100)

placeBlockAction.placeBlock(0, 0, 0, 1)
placeBlockAction.placeBlock(1, 0, 0, 1)
