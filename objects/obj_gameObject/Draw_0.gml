// Game Objects are invisible by default
matrix_set(matrix_world, matrix_build(x, y, self.z, 0, 0, 0, 1, 1, 1));
vertex_submit(self.model, pr_trianglelist, sprite_get_texture(spr_textures, 0));
matrix_set(matrix_world, matrix_build_identity());
