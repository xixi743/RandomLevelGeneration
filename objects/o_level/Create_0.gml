randomize() // will create a different result every time we run the game

// Get the tile layer map id
var _wall_map_id = layer_tilemap_get_id("WallTiles");

// Set up the grid
width_ = room_width div CELL_WIDTH;
height_ = room_height div CELL_HEIGHT;
grid_ = ds_grid_create(width_, height_);
ds_grid_set_region(grid_, 0, 0, width_, height_, VOID);

// Create the controller
// A single controller that steps around in our grid and sets floor tiles everywhere it goes

// creating variables that store the controllers position
var _controller_x = width_ div 2 
var _controller_y = height_ div 2
var _controller_direction = irandom(3);
// 0 to the right, 1 up, 2 to the left, 3 will be down
var _steps = 400; //how many steps our controller is going to walk around our level
// the smaller our steps the smaller our level

var _direction_change_odds = 1;

repeat (_steps) {
	// takes our curruent controller position and sets that tile to a floor
	grid_[# _controller_x, _controller_y] = FLOOR; 
	
	// Randomize the direction
	if (irandom(_direction_change_odds) == _direction_change_odds) {
		_controller_direction = irandom(3);
	}
	
	// Move the controller
	var _x_direction = lengthdir_x(1, _controller_direction * 90); // need to multiple it by 90 to get an angle
	var _y_direction = lengthdir_y(1, _controller_direction * 90);
	_controller_x += _x_direction;
	_controller_y += _y_direction;
	
	// make sure that our controller didn't go outside of the bounds of the room
	// (make sure that we don't go outside of the grid)
	if (_controller_x < 2 || _controller_x >= width_ - 2) {
		_controller_x += -_x_direction * 2;
		// jumps us back to the square before that we were on
	}
	if (_controller_y < 2 || _controller_y >= height_ - 2) {
		_controller_y += -_y_direction * 2;
	}
}

// need to create a for loop to loop through our grid
for (var _y = 1; _y < height_-1; _y++) {
	// need one extra square around our grid
	// that's why we need to make sure our floors never go past 2
	for (var _x = 1; _x < width_=1; _x++) {
		if (grid_[# _x, _y] != FLOOR) {
			// check if we are not a floor tile
			// then check each cardinal direction
			var _north_tile = grid_[# _x, _y-1] == VOID;
			var _west_tile = grid_[# _x-1, _y] == VOID;
			var _east_tile = grid_[# _x+1, _y] == VOID;
			var _south_tile = grid_[# _x, _y+1] == VOID;
			
			// now do some fancing math
			// bitmasking method
			var _tile_index = NORTH * _north_tile + WEST* _west_tile + EAST* _east_tile + SOUTH* _south_tile + 1 
			// have to add one to the end because GMS starts counting tiles at 1
			if (_tile_index == 1) { //this is a wall in our tile set
				grid_ [# _x, _y] = FLOOR //removing all of the single wall tiles
			}
		}
	}
}

for (var _y = 1; _y < height_-1; _y++) {
	// need one extra square around our grid
	// that's why we need to make sure our floors never go past 2
	for (var _x = 1; _x < width_=1; _x++) {
		if (grid_[# _x, _y] != FLOOR) {
			// check if we are not a floor tile
			// then check each cardinal direction
			var _north_tile = grid_[# _x, _y-1] == VOID;
			var _west_tile = grid_[# _x-1, _y] == VOID;
			var _east_tile = grid_[# _x+1, _y] == VOID;
			var _south_tile = grid_[# _x, _y+1] == VOID;
			
			// now do some fancing math
			// bitmasking method
			var _tile_index = NORTH * _north_tile + WEST* _west_tile + EAST* _east_tile + SOUTH* _south_tile + 1 
			// have to add one to the end because GMS starts counting tiles at 1
			tilemap_set(_wall_map_id, _tile_index, _x, _y);
		}
	}
}