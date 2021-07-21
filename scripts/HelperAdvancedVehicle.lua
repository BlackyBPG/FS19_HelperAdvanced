-- 
-- Helper Advanced for Vehicles for FS17
-- by Blacky_BPG
-- 
-- Version 1.9.0.13     |    20.07.2021    fix missing sowingMachine synchroisation in multiplayer
-- Version 1.9.0.12     |    10.07.2021    fix wrong dismiss helper after ending loan works
-- Version 1.9.0.11     |    19.06.2021    fix wrong (negativ) employment time, fix MP to SP farmId change error
-- Version 1.9.0.10     |    13.03.2020    fix addMoney error
-- Version 1.9.0.9      |    01.03.2020    fix helper hiring for farmmanagers, fixed the error when ending/cancel/close the game
-- Version 1.9.0.8      |    20.02.2020    fixed the error when ending/cancel/close the game
-- Version 1.9.0.7      |    12.02.2020    fix for the calculation of experience-based consumption/harvest values, fix sprayer function for experience-based consumption/harvest values
-- Version 1.9.0.6      |    09.02.2020    fix specialized learning while working
-- Version 1.9.0.5      |    20.01.2020    from theorist to practitioner: learned skills are slowly being converted into practical knowledge if the helper is active in the task, add InGame changable Tablet buttons, fix sprayer usage, fix calculation for various usages, fix helper fuel and def usage, fix combine error without helper
-- Version 1.9.0.4      |    18.01.2020    fix sprayer functionality
-- Version 1.9.0.3      |    18.01.2020    Courseplay and AutoDrive hired several new helpers on the dedicated server, FollowMe did not start on the dedicated server, DedicatedServer and players had different helpers active on the same vehicle
-- Version 1.9.0.2      |    17.01.2020    correct function with Courseplay, FollowMe and AutoDrive
-- Version 1.9.0.1 A    |    15.01.2020    fix not working save function
-- Version 1.9.0.1      |    14.01.2020    initial version for FS19
-- Version 1.4.4.0 D    |    18.06.2017    fix fuelUsage after helper use #2
-- Version 1.4.4.0 C    |    16.06.2017    fix fuelUsage after helper use
-- Version 1.3.1.0 A    |    30.12.2016    added Courseplay and FollowMe functionality
-- Version 1.3.1.0      |    10.11.2016    initial Version for FS17
-- 

HelperAdvancedVehicle = {}
local HelperAdvancedVehicleDir = g_currentModDirectory
function HelperAdvancedVehicle.prerequisitesPresent(specializations)
	return true
end

function HelperAdvancedVehicle.registerFunctions(vehicleType)
	SpecializationUtil.registerFunction(vehicleType, "onUpdateFuel", HelperAdvancedVehicle.onUpdateFuel)
end

function HelperAdvancedVehicle.registerEventListeners(vehicleType)
	local specFunctions = {	"onPostLoad", "onLoad", "onUpdate" }
	
	for _, specFunction in ipairs(specFunctions) do
		SpecializationUtil.registerEventListener(vehicleType, specFunction, HelperAdvancedVehicle)
	end
end

function HelperAdvancedVehicle:onLoad(savegame)
	self.setname = false
	self.ownVehicleName = " "
	self.wasLastHired = false
	self.firstLoadCheck = false
end

function HelperAdvancedVehicle:onPostLoad(savegame)
	if savegame ~= nil then
		self.spec_aiVehicle.lastHelper = Utils.getNoNil(getXMLInt(savegame.xmlFile, savegame.key.."#lastHelper"),0)
	end
end

function HelperAdvancedVehicle:saveToXMLFile(xmlFile, key)
	setXMLInt(xmlFile, key.."#lastHelper", Utils.getNoNil(self.spec_aiVehicle.lastHelper,0))
end


function HelperAdvancedVehicle:onUpdate(dt)
	if self.setName == false then
		local storeItem = g_storeManager:getItemByXMLFilename(self.configFileName)
		if storeItem ~= nil then
			self.ownVehicleName = storeItem.name
			if g_brandManager:getBrandByIndex(storeItem.brandIndex) ~= "" then
				self.ownVehicleName = g_brandManager:getBrandByIndex(storeItem.brandIndex).title.." "..self.currentVehicleName
			end
			self.ownVehicleName = string.upper(self.currentVehicleName)
		end
		if self.ownVehicleName ~= nil then
			if self.spec_aiVehicle.lastHelper ~= nil and self.spec_aiVehicle.lastHelper > 0 then
				g_helperManager.indexToHelper[self.spec_aiVehicle.lastHelper].lastVehicle = self
				g_helperManager.indexToHelper[self.spec_aiVehicle.lastHelper].lastVehicleName = self.ownVehicleName
			end
		end
	end
	if self.firstLoadCheck == false then
		self.firstLoadCheck = true
	end
	if self:getIsAIActive() and self.spec_aiVehicle.currentHelper ~= nil then
		local helper = self.spec_aiVehicle.currentHelper
		if self.spec_aiVehicle.currentHelper ~= nil and self.spec_aiVehicle.currentHelper.isHired ~= self:getIsAIActive() then
			g_helperManager.useHelper(self.spec_aiVehicle.currentHelper)
			if g_helperManager.showAutoEmployed == true then
				g_helperManager.showAutoEmployed = false
				if self.cp ~= nil and self.cp.isDriving ~= nil and self.cp.isDriving == true then
					g_helperManager.showCourseplayHasEmployed = true
				elseif self.spec_followMe ~= nil and self.spec_aiVehicle.mod_ForcedDrivingStrategyName == "FollowMe" then
					g_helperManager.showFollowMeHasEmployed = true
				else
					g_helperManager.showAutoDriveHasEmployed = true
				end
			end
			g_HelperAdvanced:activateHelperWorks(self.spec_aiVehicle.currentHelper, self)
		end
		self.wasLastHired = true
		g_helperManager:getHelperByIndex(helper.index).lastVehicleName = self.ownVehicleName
		self.spec_aiVehicle.lastHelper = helper.index
		if g_dedicatedServerInfo ~= nil then
			if g_helperManager:getHelperByIndex(helper.index).ownerFarmId ~= self:getOwnerFarmId() and not g_currentMission.accessHandler:canFarmAccessOtherId(g_helperManager:getHelperByIndex(helper.index).ownerFarmId, self:getOwnerFarmId()) then
				g_helperManager:releaseHelper(self.spec_aiVehicle.currentHelper,nil,true)
				g_helperManager.indexToHelper[helper.index].isEmployed = false
				g_helperManager.indexToHelper[helper.index].isHired = false
				g_HelperAdvanced:hireHelper(helper.index,false,g_helperManager.indexToHelper[helper.index].isLearning,g_helperManager.indexToHelper[helper.index].isLearnSpec,g_helperManager:getHelperByIndex(helper.index).ownerFarmId)
				local newHelper = g_helperManager:getRandomHelper(nil,false,self:getOwnerFarmId())
				if newHelper ~= nil and newHelper.ownerFarmId == self:getOwnerFarmId() then
					self.spec_aiVehicle.currentHelper = newHelper
					self.currentHelper = newHelper
					self.spec_aiVehicle.lastHelper = newHelper.index
					self.lastHelper = newHelper.index
					g_helperManager:useHelper(newHelper)
				end
			end
		end

		if self.cp ~= nil and self.cp.isDriving ~= nil and self.cp.isDriving == true then
			helper.lastVehicleAiStarted = false
			self.courseplayDrive = true
			self.followMeDrive = false
			self.autoDriveDrive = false
		elseif self.spec_followMe ~= nil and self.spec_aiVehicle.mod_ForcedDrivingStrategyName == "FollowMe" then
			helper.lastVehicleAiStarted = false
			self.courseplayDrive = false
			self.followMeDrive = true
			self.autoDriveDrive = false
		elseif self.ad ~= nil and self.ad.isActive then
			helper.lastVehicleAiStarted = false
			self.courseplayDrive = false
			self.followMeDrive = false
			self.autoDriveDrive = true
		else
			helper.lastVehicleAiStarted = true
			self.courseplayDrive = false
			self.followMeDrive = false
			self.autoDriveDrive = false
		end

		helper.lastVehicle = self
		if helper.experiencePercentLast ~= helper.experiencePercent then
			helper.experiencePercentLast = helper.experiencePercent
			if self.spec_aiVehicle.mapAIHotspot ~= nil then
				self.spec_aiVehicle.mapAIHotspot:setText(helper.nameShow.." ("..tostring(math.floor(helper.experiencePercent)).."%)")
			end
			g_HelperAdvanced:activateHelperWorks(helper,self)
		end

		if self.spec_aiVehicle.currentHelper ~= nil and self:getIsAIActive() and self.isServer then
			self:onUpdateFuel(dt,self.spec_aiVehicle.currentHelper)
		end
	else
		self.courseplayDrive = false
		self.followMeDrive = false
		self.autoDriveDrive = false
		self.spec_aiVehicle.currentHelper = nil
		self.currentHelper = nil
		if self.spec_aiVehicle.lastHelper ~= nil and self.spec_aiVehicle.lastHelper > 0 and self.wasLastHired == true then
			self.wasLastHired = false
			local hp = g_helperManager:getHelperByIndex(self.spec_aiVehicle.lastHelper)
			if (hp.isHired ~= self:getIsAIActive() and self:getIsAIActive() == false) then
				g_helperManager.releaseHelper(hp)
				hp.lastVehicle = nil
			end
			if self.isServer then
			end
		end
	end
end

function HelperAdvancedVehicle:onUpdateFuel(dt, helper)
    local spec = self.spec_motorized
    if spec == nil then return end
    local idleFactor = 0.5
    local rpmPercentage = (spec.motor:getLastMotorRpm() - spec.motor:getMinRpm()) / (spec.motor:getMaxRpm() - spec.motor:getMinRpm())
    local rpmFactor = idleFactor + rpmPercentage * (1-idleFactor)
    local loadFactor = spec.smoothedLoadPercentage * rpmPercentage
    local motorFactor = 0.5 * ( (0.2*rpmFactor) + (1.8*loadFactor) )
    local usageFactor = 1.0
    if g_currentMission.missionInfo.fuelUsageLow then
        usageFactor = 0.7
    end
    local damage = self:getVehicleDamage()
    if damage > 0 then
        usageFactor = usageFactor * (1 + damage * Motorized.DAMAGED_USAGE_INCREASE)
    end
    for _,consumer in pairs(spec.consumers) do
        if consumer.permanentConsumption and consumer.usage > 0 then
            local used = usageFactor * motorFactor * consumer.usage * dt
            local addFuelFactor = 0.4
            addFuelFactor = addFuelFactor - (0.6 * helper.experience)
            local used2 = (usageFactor*addFuelFactor) * motorFactor * consumer.usage * dt
            if used ~= 0 then
                local fillType = self:getFillUnitLastValidFillType(consumer.fillUnitIndex)
                local stats = g_currentMission:farmStats(self:getOwnerFarmId())
                stats:updateStats("fuelUsage", used2)
                if self:getIsAIActive() then
                    if fillType == FillType.DIESEL or fillType == FillType.DEF then
                        if g_currentMission.missionInfo.helperBuyFuel then
                            if fillType == FillType.DIESEL then
                                local price = used2 * g_currentMission.economyManager:getPricePerLiter(fillType) * 1.5
                                stats:updateStats("expenses", price)
                                g_currentMission:addMoney(-price, self:getOwnerFarmId(), MoneyType.PURCHASE_FUEL, true)
                            end
                            used = 0
                            used2 = 0
                        end
                    end
                end
                if fillType == consumer.fillType then
                    self:addFillUnitFillLevel(self:getOwnerFarmId(), consumer.fillUnitIndex, -used2, fillType, ToolType.UNDEFINED)
                end
                if fillType == FillType.DIESEL then
                    spec.lastFuelUsage = (used+used2) / dt * 1000 * 60 * 60
                elseif fillType == FillType.DEF then
                    spec.lastDefUsage = (used+used2) / dt * 1000 * 60 * 60
                end
            end
        end
    end
end