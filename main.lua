-- name: [MAP] Robot 64 Level Pack
-- description: Includes the levels Turtle Tops and Knoddy's Resort from Robot 64 as playable MAPi hangouts!

LEVEL_KNODDY = level_register("level_LEVEL_KNODDY_entry", COURSE_NONE, "Knoddy's Resort", "knodresort", 28000, 0x00, 0x28, 0x28)
LEVEL_TURTLE = level_register("level_TURTLE_TOPS_entry", COURSE_NONE, "Turtle Tops", "Turtle Tops", 28000, 0x00, 0x28, 0x28)

r64_entry_sound = audio_sample_load("loadmapin.mp3")

TEX_PLATFORM1_VERT = get_texture_info("platform_vert")
TEX_PLATFORM1_HORIZ = get_texture_info("platform_horiz")

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

--Table with audio files for each of the areas
BGM_KNODDY = {
  --Outside hotel
  [1] = audio_stream_load("knoddy_bgm.ogg"),
  
  --Inside Hotel
  [2] = audio_stream_load("enjoyyourstay_bgm.ogg"),
  
  --Platform Zone
  [3] = audio_stream_load("platformzone_bgm.ogg")
}

if MAPi_Active then
  
  hangout_turtletops = MAPi.hangout_map_add(
    LEVEL_TURTLE, 
    "Turtle Tops",
    "An isle in the sky.",
    "zKevin",
    get_texture_info("prev-turtle"),
    audio_stream_load("turtle_bgm.ogg"))
  
  --Adds the skybox from the original game
  MAPi.hangout_add_skybox(hangout_turtletops, 
    SKYBOX_TURTLE)
  
  --Makes the warp sound from robot 64 play when you warp to the level
  MAPi.hangout_add_entry_sound(hangout_turtletops, r64_entry_sound)
  
  --Adds a light blue environment tint to the level
  MAPi.hangout_add_env_tint(hangout_turtletops, {r = 200, g = 200, b = 255}, {x = 0.5, y = 0.5, z = 0})
  
  
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
  
  else
    djui_popup_create("MAPi is not active! Activate to use this mod", 2)
end