package raycity
import rl "vendor:raylib"

Window_State :: enum {
	Menu,
	Game,
}

Game_State :: enum {
	Won,
	Lost,
	Playing,
}

Game :: struct {
	width:  i32,
	height: i32,
	title:  cstring,
	font:   rl.Font,
	music:  rl.Music,
	time:   f32,
	camera: rl.Camera2D,
}


init_window :: proc(game: ^Game) {
	using game
	//Window params
	{
		width = 768
		height = 720
		title = "RayCity"
		rl.SetTargetFPS(60)
		rl.SetTraceLogLevel(.ERROR)
		rl.SetConfigFlags({.MSAA_4X_HINT, .WINDOW_HIGHDPI, .VSYNC_HINT})

	}

	rl.InitWindow(width, height, title)
	font = rl.LoadFont("assets/fonts/PixeloidSansBold.ttf")

}

draw_game :: proc(game: ^Game) {
	using game
	player: Player
	audio: Audio_system
	rl.InitAudioDevice()
	spawn_player(&player)
	camera = {0, 0, 0, 0}
	files := []cstring{"assets/sounds/main_menu.mp3"}
	music_system := init_audio(files)
	for !rl.WindowShouldClose() {
		control_player(&player)
		rl.ClearBackground(rl.BLACK)
		rl.BeginDrawing()
		rl.BeginMode2D(camera)
		draw_player(&player)
		start_track(&audio, 0)
		rl.DrawGrid(26, 8.0)
		rl.EndMode2D()
		rl.EndDrawing()
	}


	defer rl.CloseWindow()
}
