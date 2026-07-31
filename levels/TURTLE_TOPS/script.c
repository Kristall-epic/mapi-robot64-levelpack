#include <ultra64.h>
#include "sm64.h"
#include "behavior_data.h"
#include "model_ids.h"
#include "seq_ids.h"
#include "dialog_ids.h"
#include "segment_symbols.h"
#include "level_commands.h"

#include "game/level_update.h"

#include "levels/scripts.h"

#include "make_const_nonconst.h"
#include "levels/TURTLE_TOPS/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_TURTLE_TOPS_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _TURTLE_TOPS_segment_7SegmentRomStart, _TURTLE_TOPS_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xa, _water_skybox_mio0SegmentRomStart, _water_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario), 
	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, TURTLE_TOPS_area_1),
		WARP_NODE(0x0A, LEVEL_TURTLE, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x0B, 64, 0x02, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x0D, 64, 0x01, 0x0D, WARP_NO_CHECKPOINT),
		WARP_NODE(0x0E, 64, 0x03, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x11, 64, 0x01, 0x11, WARP_NO_CHECKPOINT),
		WARP_NODE(0x14, 64, 0x01, 0x14, WARP_NO_CHECKPOINT),
		WARP_NODE(0x15, 64, 0x04, 0x0A, WARP_NO_CHECKPOINT),
		OBJECT(MODEL_NONE, 6646, -916, 4667, 0, -180, 0, (0x0D << 16), id_bhvSwimmingWarp),
		OBJECT(MODEL_NONE, 5570, 106, -1023, 0, 93, 0, (0x11 << 16), id_bhvAirborneWarp),
		OBJECT(MODEL_NONE, 8529, 485, 7394, 0, 108, 0, (0x14 << 16), id_bhvAirborneWarp),
		OBJECT(MODEL_NONE, 6, 236, 0, 0, -135, 0, (10 << 16), id_bhvAirborneWarp),
		OBJECT(MODEL_NONE, 6604, -934, 5483, 0, -180, 0, (30 << 24) | (0x0B << 16), id_bhvWarp),
		OBJECT(MODEL_NONE, 5281, 49, -1016, 0, 93, 0, (0x0E << 16), id_bhvWarp),
		OBJECT(MODEL_NONE, 8179, 535, 7474, 0, 93, 0, (0x15 << 16), id_bhvWarp),
		TERRAIN(TURTLE_TOPS_area_1_collision),
		MACRO_OBJECTS(TURTLE_TOPS_area_1_macro_objs),
		STOP_MUSIC(0),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	AREA(2, TURTLE_TOPS_area_2),
		WARP_NODE(0x0A, 64, 0x02, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, 64, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x0C, 64, 0x01, 0x0D, WARP_NO_CHECKPOINT),
		OBJECT(MODEL_NONE, 4232, 487, 20920, 0, 0, 0, (10 << 24) | (0x0C << 16), id_bhvWarp),
		OBJECT(MODEL_NONE, 4374, 506, 21728, 0, 0, 0, (0x0A << 16), id_bhvSwimmingWarp),
		TERRAIN(TURTLE_TOPS_area_2_collision),
		MACRO_OBJECTS(TURTLE_TOPS_area_2_macro_objs),
		STOP_MUSIC(0),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	AREA(3, TURTLE_TOPS_area_3),
		WARP_NODE(0x0A, 64, 0x03, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, 64, 0x03, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x12, 64, 0x01, 0x11, WARP_NO_CHECKPOINT),
		OBJECT(MODEL_NONE, 10664, 2932, 12183, 0, 0, 0, (10 << 24) | (0x12 << 16), id_bhvWarp),
		OBJECT(MODEL_NONE, 5706, 1940, -1563, 0, 0, 0, (10 << 24) | (0x12 << 16), id_bhvWarp),
		OBJECT(MODEL_NONE, 5717, 1989, -1221, 0, 0, 0, (0x0A << 16), id_bhvAirborneWarp),
		TERRAIN(TURTLE_TOPS_area_3_collision),
		MACRO_OBJECTS(TURTLE_TOPS_area_3_macro_objs),
		STOP_MUSIC(0),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	AREA(4, TURTLE_TOPS_area_4),
		WARP_NODE(0x0A, 64, 0x04, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, 64, 0x04, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x13, 64, 0x01, 0x14, WARP_NO_CHECKPOINT),
		OBJECT(MODEL_NONE, 0, 2497, 6022, 0, 0, 0, (10 << 24) | (0x13 << 16), id_bhvWarp),
		OBJECT(MODEL_NONE, 0, 8813, 5896, 0, 0, 0, (10 << 24) | (0x13 << 16), id_bhvWarp),
		OBJECT(MODEL_NONE, 0, 2518, 5756, 0, -180, 0, (0x0A << 16), id_bhvAirborneWarp),
		TERRAIN(TURTLE_TOPS_area_4_collision),
		MACRO_OBJECTS(TURTLE_TOPS_area_4_macro_objs),
		STOP_MUSIC(0),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	FREE_LEVEL_POOL(),
	MARIO_POS(1, 0, 0, 0, 0),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};