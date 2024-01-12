/// @description Builds the initial world

// DEFINE THE GLOBAL VARIABLES
global.UV_BLOCK_TEXTURES = new InitializeBlockTextureActivity()


// INITIALIZE ANYTHING THAT IS REQUIRED TO RUN THE GAME
new Shape().initGpu()											// Initialize the GPU to draw graphics
global.UV_BLOCK_TEXTURES.initUvBlockTextures()					// Initialize the block textures

// GENERATE THE WORLD

var worldGenerator = new BasicWorldGenerator()
worldGenerator.buildWorld(true)


// CREATE THE CAMERA
camera = new Camera3()


/*
for (var i = 1; i < 5; i++) {
	for (var j = 1; j < 5; j++) {
		new Block(i, j, i, i).render()
	}
}
*/
