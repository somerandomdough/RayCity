package raycity


import rl "vendor:raylib"

//NOTE: -----------------------------------General Data--------------------------------- 

Sprites_Path :: "assets/sprites/"

Direction :: enum u32 {
	North = 270,
	East  = 0,
	South = 90,
	West  = 180,
}

Tank :: struct {
	position:       rl.Vector2,
	velocity:       rl.Vector2,
	texture_width:  f32,
	texture_height: f32,
	texture:        rl.Texture2D,
	direction:      uint,
	attacked:       bool,
	directions:     Direction,
	texture_src:    rl.Rectangle,
	texture_dest:   rl.Rectangle,
	origin:         rl.Vector2,
}
//NOTE:-------------------------------------Player-related data and procs-------------

Player :: struct {
	using params: Tank,
	lives:        i32,
}

spawn_player :: proc(using player: ^Player) {
	position = rl.Vector2{640.0, 480.0}
	velocity = 200
	texture = rl.LoadTexture("assets/sprites/Battle_City_Tank_Player1.png")
	texture_width = 61
	texture_height = 59
	directions = Direction.North
	player_width := (f32(rl.GetScreenWidth()) / 256.0) * 12.0
	player_height := (f32(rl.GetScreenHeight()) / 240.0) * 12.0

	texture_src = rl.Rectangle{0, 0, texture_width, texture_width}

	texture_dest = rl.Rectangle{position.x, position.y, player_width, player_height}

	origin = rl.Vector2{f32(texture.width) / 4, f32(texture.height) / 4}
}

draw_player :: proc(player: ^Tank) {
	using player
	rl.BeginDrawing()
	texture_dest.x = position.x
	texture_dest.y = position.y
	rl.DrawTexturePro(texture, texture_src, texture_dest, origin, f32(directions), rl.WHITE)
	//rl.DrawRectangle(i32(position.x), i32(position.y), i32(player_width), i32(player_height) , rl.RED)
	rl.EndDrawing()
}

control_player :: proc(player: ^Tank) {
	using player

	if rl.IsKeyDown(rl.KeyboardKey.W) || rl.IsKeyDown(rl.KeyboardKey.UP) {
		position.y -= rl.GetFrameTime() * velocity.y
		directions = Direction.North
	} else if rl.IsKeyDown(rl.KeyboardKey.S) || rl.IsKeyDown(rl.KeyboardKey.DOWN) {
		position.y += rl.GetFrameTime() * velocity.y
		directions = Direction.South
	} else if rl.IsKeyDown(rl.KeyboardKey.A) || rl.IsKeyDown(rl.KeyboardKey.LEFT) {
		position.x -= rl.GetFrameTime() * velocity.x
		directions = Direction.West
	} else if rl.IsKeyDown(rl.KeyboardKey.D) || rl.IsKeyDown(rl.KeyboardKey.RIGHT) {
		position.x += rl.GetFrameTime() * velocity.x
		directions = Direction.East
	}
}


//NOTE: --------------------------------------- Enemy-related data and procs --------------------------------------

Enemy_Type :: enum {
	Basic,
	Fast,
	Armor,
	Power,
}

Enemy_Textures :: [4]cstring {
	Sprites_Path + "Battle_City_Tank_Enemy1",
	Sprites_Path + "Battle_City_Tank_Enemy2",
	Sprites_Path + "Battle_City_Tank_Enemy3",
	Sprites_Path + "Battle_City_Tank_Enemy4",
}

spawn_enemy :: proc(type: Enemy_Type) -> (b_enemy: Tank) {
	using b_enemy

	velocity = 200
	switch type {
	case .Basic:
		rl.LoadTexture(Enemy_Textures[0])
	case .Fast:
		rl.LoadTexture(Enemy_Textures[1])
	case .Armor:
		rl.LoadTexture(Enemy_Textures[2])
	case .Power:
		rl.LoadTexture(Enemy_Textures[3])
	}

	texture_width = 61
	texture_height = 59
	directions = Direction.North
	enemy_width := (f32(rl.GetScreenWidth()) / 256.0) * 12.0
	enemy_height := (f32(rl.GetScreenHeight()) / 240.0) * 12.0

	texture_src = rl.Rectangle{0, 0, texture_width, texture_width}

	texture_dest = rl.Rectangle{position.x, position.y, enemy_width, enemy_height}

	origin = rl.Vector2{f32(texture.width) / 4, f32(texture.height) / 4}

	return
}
