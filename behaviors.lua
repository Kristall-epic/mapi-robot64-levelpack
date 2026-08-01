E_MODEL_SOAP = smlua_model_util_get_id("r64soap_geo")
E_MODEL_PLANET = smlua_model_util_get_id("r64planet_geo")
E_MODEL_CYLINDER = smlua_model_util_get_id("r64cylinder_geo")
E_MODEL_PUSHPLAT = smlua_model_util_get_id("r64pushplat_geo")
E_MODEL_PT_ELEVATE = smlua_model_util_get_id("r64ptelevate_geo")

SOAP_ACT_IDLE = 0
SOAP_ACT_DIE = 1
SOAP_ACT_GONE = 2

function r64_soap_init(o)
  o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
  o.oAction = SOAP_ACT_IDLE
	o.oFaceAnglePitch = -0x4000
	o.collisionData = smlua_collision_util_get("r64soap_collision")
end

function r64_soap_loop(o)
  
	if o.oAction == SOAP_ACT_IDLE then
	  load_object_collision_model()
	  obj_set_gfx_scale(o, 1, 1, 1)
		
		if cur_obj_is_mario_on_platform() ~= 0 then
		  o.oAction = SOAP_ACT_DIE
			o.oTimer = 0
		end
		
	end
	
	if o.oAction == SOAP_ACT_DIE then
	  load_object_collision_model()
	  local curSclY = o.header.gfx.scale.z
		spawn_non_sync_object(id_bhvBubbleParticleSpawner, E_MODEL_NONE, o.oPosX + math.random(-100, 100), o.oPosY - 20 + math.random(-70, 70), o.oPosZ + math.random(-100, 100), nil)
		
		obj_set_gfx_scale(o, 1, 1, math.max(curSclY - .025, 0.0001))
		
		if o.oTimer > 38 then
		  o.oAction = SOAP_ACT_GONE
			o.oTimer = 0
		end
	end
	
	if o.oAction == SOAP_ACT_GONE then
	  obj_set_gfx_scale(o, .00001, .00001, .00001)
	  if o.oTimer > 300 then
		  o.activeFlags = o.activeFlags | ACTIVE_FLAG_ACTIVE
		  obj_set_gfx_scale(o, 1, 1, 1)
			o.oAction = SOAP_ACT_IDLE
			o.oTimer = 0
		end
	end
	
end

_G.id_bhvR64Soap = hook_behavior(nil, OBJ_LIST_SURFACE, true, r64_soap_init, r64_soap_loop)


function r64_planet_init(o)
  o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.collisionData = smlua_collision_util_get("r64planet_collision")
end

function r64_planet_loop(o)
  load_object_collision_model()

  o.oFaceAngleYaw = o.oFaceAngleYaw + 0x300
  o.oAngleVelYaw = 0x300
	
end

_G.id_bhvR64Planet = hook_behavior(nil, OBJ_LIST_SURFACE, true, r64_planet_init, r64_planet_loop)

function r64_cylinder_init(o)
  o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.collisionData = smlua_collision_util_get("r64cylinder_collision")
end

function r64_cylinder_loop(o)
  load_object_collision_model()

  o.oFaceAnglePitch = o.oFaceAnglePitch + 0x100
  o.oAngleVelPitch = 0x100
	
end

_G.id_bhvR64Cylinder = hook_behavior(nil, OBJ_LIST_SURFACE, true, r64_cylinder_init, r64_cylinder_loop)


PLATFORM_ACT_HIDDEN = 0
PLATFORM_ACT_EXTEND = 1

function r64_pushplat_init(o)
  o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.collisionData = smlua_collision_util_get("r64pushplat_collision")
	o.oHomeX = o.oPosX
	o.oHomeY = o.oPosY
	o.oHomeZ = o.oPosZ
	o.oForwardVel = 12.5
end

--  -280 X
function r64_pushplat_loop(o)
  load_object_collision_model()
	
	if o.oAction == PLATFORM_ACT_HIDDEN then
	  o.oPosX = approach_f32(o.oPosX, o.oHomeX, o.oForwardVel, o.oForwardVel)
		o.oPosY = approach_f32(o.oPosY, o.oHomeY, o.oForwardVel, o.oForwardVel)
		o.oPosZ = approach_f32(o.oPosZ, o.oHomeZ, o.oForwardVel, o.oForwardVel)
		
		if o.oTimer > 50 then
		  o.oAction = PLATFORM_ACT_EXTEND
			o.oTimer = 0
		end
	end
	
	if o.oAction == PLATFORM_ACT_EXTEND then
	  o.oPosX = approach_f32(o.oPosX, o.oHomeX + (-280*sins(o.oFaceAngleYaw + 0x4000)), o.oForwardVel, o.oForwardVel)
		o.oPosY = approach_f32(o.oPosY, o.oHomeY, o.oForwardVel, o.oForwardVel)
		o.oPosZ = approach_f32(o.oPosZ, o.oHomeZ + (-280*coss(o.oFaceAngleYaw + 0x4000)), o.oForwardVel, o.oForwardVel)
		
		if o.oTimer > 50 then
		  o.oAction = PLATFORM_ACT_HIDDEN
			o.oTimer = 0
		end
		
	end
	
end

_G.id_bhvR64PushPlat = hook_behavior(nil, OBJ_LIST_SURFACE, true, r64_pushplat_init, r64_pushplat_loop)

function r64_ptelevate_init(o)
  o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.collisionData = smlua_collision_util_get("r64ptelevate_collision")
	o.oHomeX = o.oPosX
	o.oHomeY = o.oPosY
	o.oHomeZ = o.oPosZ
	o.oForwardVel = 20
end

-- +400 Y
function r64_ptelevate_loop(o)
  load_object_collision_model()
	
	if o.oAction == PLATFORM_ACT_HIDDEN then
		o.oPosY = approach_f32(o.oPosY, o.oHomeY, o.oForwardVel, o.oForwardVel)
		
		if o.oTimer > 50 then
		  o.oAction = PLATFORM_ACT_EXTEND
			o.oTimer = 0
		end
	end
	
	if o.oAction == PLATFORM_ACT_EXTEND then
		o.oPosY = approach_f32(o.oPosY, o.oHomeY + 500, o.oForwardVel, o.oForwardVel)
		
		if o.oTimer > 50 then
		  o.oAction = PLATFORM_ACT_HIDDEN
			o.oTimer = 0
		end
		
	end
end

_G.id_bhvR64PtElevate = hook_behavior(nil, OBJ_LIST_SURFACE, true, r64_ptelevate_init, r64_ptelevate_loop)




function load_bhvs_to_ame()
	AmeTools64.add_object_to_list("R64_SOAP", id_bhvR64Soap, E_MODEL_SOAP)
	AmeTools64.add_object_to_list("R64_PLANET", id_bhvR64Planet, E_MODEL_PLANET)
  AmeTools64.add_object_to_list("R64_CYLINDER", id_bhvR64Cylinder, E_MODEL_CYLINDER)
  AmeTools64.add_object_to_list("R64_PUSHPLAT", id_bhvR64PushPlat, E_MODEL_PUSHPLAT)
  AmeTools64.add_object_to_list("R64_PT_ELEVATE", id_bhvR64PtElevate, E_MODEL_PT_ELEVATE)

end

hook_event(HOOK_ON_MODS_LOADED, load_bhvs_to_ame)