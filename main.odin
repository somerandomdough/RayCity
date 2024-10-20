package raycity
import "core:fmt"
import rl "vendor:raylib"


main :: proc() {
	game: Game
	init_window(&game)
	draw_game(&game)
}
