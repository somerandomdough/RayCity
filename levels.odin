package raycity

import "core:encoding/json"
import "core:fmt"
import "core:os"
import rl "vendor:raylib"

Level :: struct {
	block_paths: [5]cstring,
	basic_tanks: [dynamic]Tank,
	fast_tanks:  [dynamic]Tank,
	armor_tanks: [dynamic]Tank,
	power_tanks: [dynamic]Tank,
	blocks:      [dynamic]i16,
}

parse_first_level :: proc() {
	data, ok := os.read_entire_file_from_filename(
		"/home/ok/Projects/Odin/RayCity/assets/levels/stage_1.json",
	)
	if !ok {
		fmt.eprint("Error loading level")
	}
	defer delete(data)

	json_data, err := json.parse(data)
	if err != .None {
		fmt.eprintln("Error parsing level")
		fmt.eprintln("Error: ", err)
	}
	defer json.destroy_value(json_data)

	root := json_data.(json.Object)
	fmt.println(root["brick"])
	fmt.println(root["steel"])
}

init_stage_one :: proc() -> (stage_one: Level) {


	return {
		block_paths = {
			"assets/sprites/Battle_City_bricks.png",
			"assets/sprites/Battle_City_wall.png",
			"assets/sprites/Battle_City_ice.png",
			"assets/sprites/Battle_City_water.png",
			"assets/sprites/Battle_City_trees.png",
		},
	}

}
