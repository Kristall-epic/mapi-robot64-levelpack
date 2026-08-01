-- name: [MAP] Robot 64 LevelPack
-- description: Includes the levels Turtle Tops and Knoddy's Resort from Robot 64 as playable MAPi hangouts!

LEVEL_KNODDY = level_register("level_LEVEL_KNODDY_entry", COURSE_NONE, "Knoddy's Resort", "knodresort", 28000, 0x00, 0x28, 0x28)
LEVEL_TURTLE = level_register("level_TURTLE_TOPS_entry", COURSE_NONE, "Turtle Tops", "Turtle Tops", 28000, 0x00, 0x28, 0x28)

r64_entry_sound = audio_sample_load("loadmapin.mp3")

TEX_PLATFORM1_VERT = get_texture_info("platform_vert")
TEX_PLATFORM1_HORIZ = get_texture_info("platform_horiz")

TEX_PLATFORM2 = get_texture_info("turtle-purple-tower-sky")

SKYBOX_TURTLE = {
      skytype = "box",
      up = get_texture_info("turtle_up"),
      down = get_texture_info("turtle_dn"),
      front = get_texture_info("turtle_ft"),
      back = get_texture_info("turtle_bk"),
      left = get_texture_info("turtle_lf"),
      right = get_texture_info("turtle_rt")
    }
    
SKYBOX_KNODDY = {
      skytype = "box",
      up = get_texture_info("knoddy_up"),
      down = get_texture_info("knoddy_dn"),
      front = get_texture_info("knoddy_ft"),
      back = get_texture_info("knoddy_bk"),
      left = get_texture_info("knoddy_lf"),
      right = get_texture_info("knoddy_rt")
    }
    
SKYBOX_PLATFORM1 = {
  skytype = "box",
  up = TEX_PLATFORM1_VERT,
  down = TEX_PLATFORM1_VERT,
  right = TEX_PLATFORM1_HORIZ,
  back = TEX_PLATFORM1_HORIZ,
  front = TEX_PLATFORM1_HORIZ,
  left = TEX_PLATFORM1_HORIZ
}

SKYBOX_PLATFORM2 = {
  skytype = "box",
  up = TEX_PLATFORM2,
  down = TEX_PLATFORM2,
  right = TEX_PLATFORM2,
  back = TEX_PLATFORM2,
  front = TEX_PLATFORM2,
  left = TEX_PLATFORM2
}

--Table with audio files for each of the areas
BGM_KNODDY = {
  --Outside hotel
  [1] = audio_stream_load("knoddy_bgm.ogg"),
  
  --Inside Hotel
  [2] = audio_stream_load("enjoyyourstay_bgm.ogg"),
  
  --Platform Zone
  [3] = audio_stream_load("platformzone_bgm.ogg")
}

BGM_TURTLE = {
  --Main island
  [1] = audio_stream_load("turtle_bgm.ogg"),
	
	--Underwater Cave
	[2] = audio_stream_load("turtle-bgm-water.ogg"),
	
	--Always Wash Your Hands obby
	[3] = audio_stream_load("platformzone_bgm.ogg"),
	
	--Purple Tower
	[4] = audio_stream_load("platformzone2.ogg"),
	
	--Beebo Wings Into The Sky
  [5] = audio_stream_load("turtle_bgm.ogg")
}

--Adds the 2D camera the purple tower has in Robot 64
function update_purple_tower_cam()
  m = gMarioStates[0]
  if gNetworkPlayers[0].currAreaIndex == 4 then
	  m.pos.x = 0
		
		camera_freeze()
    local c = gLakituState
    local focusPos = {
      x = 0,
      y = math.lerp(c.focus.y, m.pos.y, 0.1),
      z = m.pos.z
    }
    
    local camPos = {
      x = 2000,
      y = math.lerp(c.pos.y, m.pos.y + 150, 0.1),
      z = m.pos.z
    }

    vec3f_copy(c.focus, focusPos)
    vec3f_copy(c.pos, camPos)
	else
	  camera_unfreeze()
	end
	
end

function mapi_load()
  
  hangout_turtletops = MAPi.hangout_map_add(
    LEVEL_TURTLE, 
    "Turtle Tops",
    "An isle in the sky.",
    "zKevin",
    get_texture_info("prev-turtle"),
    BGM_TURTLE)
  
  --Adds the skybox from the original game to the main area
  MAPi.hangout_add_skybox(hangout_turtletops, 
    SKYBOX_TURTLE)
	
	--Skips area 2	
	MAPi.hangout_add_skybox(hangout_turtletops, nil)
			
	--Adds the platform zone skybox to the obby
	MAPi.hangout_add_skybox(hangout_turtletops, 
    SKYBOX_PLATFORM1)	
	
	--Adds the platform zone 2 skybox to the tower
	MAPi.hangout_add_skybox(hangout_turtletops, 
    SKYBOX_PLATFORM2)
		
	--Adds the turtle tops skybox to the beebo wings into the sky subarea	
	MAPi.hangout_add_skybox(hangout_turtletops, 
    SKYBOX_TURTLE)	
  
  --Makes the warp sound from robot 64 play when you warp to the level
  MAPi.hangout_add_entry_sound(hangout_turtletops, r64_entry_sound)
  
  --Adds a light blue environment tint to the main level
  MAPi.hangout_add_env_tint(hangout_turtletops, {r = 200, g = 200, b = 255}, {x = 0.5, y = 0.5, z = 0})
	
	--Adds a darker blue environment tint to the underwater cave
  MAPi.hangout_add_env_tint(hangout_turtletops, {r = 100, g = 125, b = 205}, {x = 0.5, y = 0.5, z = 0})
  
	--hooks a function that updates the 2D mechanic of purple tower to run in the hangout
	MAPi.hangout_hook_event(hangout_turtletops, HOOK_UPDATE, update_purple_tower_cam)
	
  hangout_knoddy = MAPi.hangout_map_add(
    LEVEL_KNODDY, 
    "Knoddy's Resort",
    "Tropical Getaway. /n /nThe hotel from the tiny funny looking bloyd, Knoddy.",
    "zKevin",
    get_texture_info("prev_knoddy"),
   BGM_KNODDY)

  --Makes first area (outside) have that one orange skybox
  MAPi.hangout_add_skybox(hangout_knoddy, SKYBOX_KNODDY)
  
  --makes the second area (inside) have no skybox
  MAPi.hangout_add_skybox(hangout_knoddy, 
    nil)
  
  --makes third area (platform zone) have the star skybox
  MAPi.hangout_add_skybox(hangout_knoddy, 
    SKYBOX_PLATFORM1)
  
  --makes the warp sound of robot 64 play when you enter the level
  MAPi.hangout_add_entry_sound(hangout_knoddy, r64_entry_sound)
  
  --makes it so if you warp to level 72 while in hangout_knoddy, you get sent to LEVEL_TURTLE, removing the need of prefixing levelnums to certain numbers to make warps work well
  MAPi.hangout_add_codewarp(hangout_knoddy, 72, LEVEL_TURTLE)
  
  --Adds an orange environment tint to the first area (outside)
  MAPi.hangout_add_env_tint(hangout_knoddy, {r = 255, g = 180, b = 160}, {x = -10,y = 1,z = 0
  })
	
end

hook_event(HOOK_ON_MODS_LOADED, mapi_load)