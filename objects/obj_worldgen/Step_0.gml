/// @description Temp step event until 
// This is pretty much all movement code from 3D in older versions of Game Maker.

camera.freeRoam()


if keyboard_check(vk_enter) {
	
	var heightGen = round(perlin_noise_2d(genX, genY) * 10.0 + 60)
	placeBlockAction.placeBlock(genX, genY, heightGen, 1)
	for (z = 0; z < heightGen; z++) {
		placeBlockAction.placeBlock(genX, genY, z, 3)
	}
	
	genX += 1
	if genX == 10 {
		genX = 0
		genY += 1
	}
}
