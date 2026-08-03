E_MODEL_SOAP = smlua_model_util_get_id("r64soap_geo")
E_MODEL_PLANET = smlua_model_util_get_id("r64planet_geo")
E_MODEL_CYLINDER = smlua_model_util_get_id("r64cylinder_geo")
E_MODEL_PUSHPLAT = smlua_model_util_get_id("r64pushplat_geo")
E_MODEL_PT_ELEVATE = smlua_model_util_get_id("r64ptelevate_geo")
E_MODEL_R64_TURTLE_PLATFORM = smlua_model_util_get_id("r64turtleplat_geo")
E_MODEL_R64_CAVECUBE = smlua_model_util_get_id("r64cavecube_geo")
E_MODEL_R64_BREAKABLE = smlua_collision_util_get("r64breakable_geo")

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

  if o.oAction ~= SOAP_ACT_GONE then
	  load_object_collision_model()
	end
  
	if o.oAction == SOAP_ACT_IDLE then
	  obj_set_gfx_scale(o, 1, 1, 1)
		
		if cur_obj_is_mario_on_platform() ~= 0 then
		  o.oAction = SOAP_ACT_DIE
			o.oTimer = 0
		end
		
	end
	
	if o.oAction == SOAP_ACT_DIE then
	  local curSclZ = o.header.gfx.scale.z
		spawn_non_sync_object(id_bhvBubbleParticleSpawner, E_MODEL_NONE, o.oPosX + math.random(-100, 100), o.oPosY - 20 + math.random(-70, 70), o.oPosZ + math.random(-100, 100), nil)
		
		obj_set_gfx_scale(o, 1, 1, math.max(curSclZ - .025, 0.0001))
		
		if o.oTimer > 38 then
		  o.oAction = SOAP_ACT_GONE
			o.oTimer = 0
		end
	end
	
	if o.oAction == SOAP_ACT_GONE then
	  obj_set_gfx_scale(o, .00001, .00001, .00001)
	  if o.oTimer > 300 then
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

  o.oFaceAngleYaw = o.oFaceAngleYaw + ((o.oBehParams >> 24) == 0 and 1 or -1)*0x150
  o.oAngleVelYaw = ((o.oBehParams >> 24) == 0 and 1 or -1)*0x150
	
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


function r64_pushplat_init(o)
  o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.collisionData = smlua_collision_util_get("r64pushplat_collision")
	o.oHomeX = o.oPosX
	o.oHomeY = o.oPosY
	o.oHomeZ = o.oPosZ
	o.oForwardVel = 12.5
end

function r64_pushplat_loop(o)
  load_object_collision_model()
	
	o.oPosX = approach_f32(o.oPosX, o.oHomeX + (-280*sins(o.oFaceAngleYaw + 0x4000))*o.oAction, o.oForwardVel, o.oForwardVel)
	o.oPosZ = approach_f32(o.oPosZ, o.oHomeZ + (-280*coss(o.oFaceAngleYaw + 0x4000))*o.oAction, o.oForwardVel, o.oForwardVel)
	
	if o.oTimer > 50 then
	  o.oTimer = 0
		o.oAction = 1 - o.oAction
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

function r64_ptelevate_loop(o)
  load_object_collision_model()
	
	o.oPosY = approach_f32(o.oPosY, o.oHomeY + 500*o.oAction, o.oForwardVel, o.oForwardVel)
	
	if o.oTimer > 50 then
	  o.oTimer = 0
		o.oAction = 1 - o.oAction
	end

end

_G.id_bhvR64PtElevate = hook_behavior(nil, OBJ_LIST_SURFACE, true, r64_ptelevate_init, r64_ptelevate_loop)

function r64_pt_cylinder_elevate_init(o)
  o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.collisionData = smlua_collision_util_get("r64cylinder_collision")
	o.oHomeX = o.oPosX
	o.oHomeY = o.oPosY
	o.oHomeZ = o.oPosZ
	o.oForwardVel = 40
end

function r64_pt_cylinder_elevate_loop(o)
  load_object_collision_model()
	
	o.oPosY = approach_f32(o.oPosY, o.oHomeY + 1000*o.oAction, o.oForwardVel, o.oForwardVel)
	
	if o.oTimer > 60 then
	  o.oTimer = 0
		o.oAction = 1 - o.oAction
	end
	
	o.oFaceAnglePitch = o.oFaceAnglePitch + 0x100
  o.oAngleVelPitch = 0x100

end

_G.id_bhvR64CylinderElevate = hook_behavior(nil, OBJ_LIST_SURFACE, true, r64_pt_cylinder_elevate_init, r64_pt_cylinder_elevate_loop)

function r64_turtle_plat_init(o)
  o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.collisionData = smlua_collision_util_get("r64turtleplat_collision")
end

function r64_turtle_plat_loop(o)
  load_object_collision_model()

  o.oFaceAngleYaw = o.oFaceAngleYaw + ((o.oBehParams >> 24) == 0 and 1 or -1)*0x100
  o.oAngleVelYaw = ((o.oBehParams >> 24) == 0 and 1 or -1)*0x100
	
end

_G.id_bhvR64TurtlePlatform = hook_behavior(nil, OBJ_LIST_SURFACE, true, r64_turtle_plat_init, r64_turtle_plat_loop)


function r64_cavecube_init(o)
  o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.collisionData = smlua_collision_util_get("r64cavecube_collision")
end

function r64_cavecube_loop(o)
  load_object_collision_model()

  o.oFaceAngleYaw = o.oFaceAngleYaw + ((o.oBehParams >> 24) == 0 and 1 or -1)*0x100
  o.oAngleVelYaw = ((o.oBehParams >> 24) == 0 and 1 or -1)*0x100
	
	o.oFaceAnglePitch = o.oFaceAnglePitch + ((o.oBehParams >> 24) == 0 and 1 or -1)*0x100
  o.oAngleVelPitch = ((o.oBehParams >> 24) == 0 and 1 or -1)*0x100
	
end

_G.id_bhvR64Cavecube = hook_behavior(nil, OBJ_LIST_SURFACE, true, r64_cavecube_init, r64_cavecube_loop)
