E_MODEL_SOAP = smlua_model_util_get_id("r64soap_geo")
E_MODEL_PLANET = smlua_model_util_get_id("r64planet_geo")

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

--[[ i test the thing

function load_bhvs_to_ame()
	AmeTools64.add_object_to_list("R64_SOAP", id_bhvR64Soap, E_MODEL_SOAP)
	AmeTools64.add_object_to_list("R64_PLANET", id_bhvR64Planet, E_MODEL_PLANET)

end

hook_event(HOOK_ON_MODS_LOADED, load_bhvs_to_ame)
]]