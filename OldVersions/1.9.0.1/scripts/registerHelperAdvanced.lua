-- 
-- Helper Advanced Vehicle Specilaization
-- by Blacky_BPG
-- 
-- Version: 1.9.0.1      |    14.01.2020    initial version for FS19
-- Version: 1.4.4.0 D    |    18.06.2017    fix fuelUsage after helper use #2
-- Version: 1.4.4.0 C    |    16.06.2017    fix fuelUsage after helper use
-- Version: 1.3.1.0 C    |    30.12.2016    added Courseplay and FollowMe functionality
-- Version: 1.3.1.0 B    |    27.12.2016    helper overview adjusted
-- Version: 1.3.1.0 A    |    26.12.2016    helper as employer feature integrated
-- Version: 1.3.1.0      |    24.12.2016    initial FS17 release
-- 

registerHelperAdvanced = {}
registerHelperAdvanced.version = "1.9.0.1  -  14.01.2020"

if g_specializationManager:getSpecializationByName("HelperAdvancedVehicle") == nil then
	g_specializationManager:addSpecialization("HelperAdvancedVehicle", "HelperAdvancedVehicle", Utils.getFilename("scripts/HelperAdvancedVehicle.lua",  g_currentModDirectory),true,nil)

	local numVehT = 0
	for typeName, typeEntry in pairs(g_vehicleTypeManager:getVehicleTypes()) do
		if SpecializationUtil.hasSpecialization(AIVehicle, typeEntry.specializations) then
			g_vehicleTypeManager:addSpecialization(typeName, "HelperAdvancedVehicle")
			numVehT = numVehT + 1
		end
	end
	print(" ++ loading HelperAdvancedVehicle V "..tostring(registerHelperAdvanced.version).." for "..tostring(numVehT).." AIVehicle Vehicletypes")
end
