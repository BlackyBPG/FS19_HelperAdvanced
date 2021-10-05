-- 
-- Helper Advanced Features
-- by Blacky_BPG
-- 
--
-- Version 1.9.0.16     |    05.10.2021    fix apparently working helpers who are actually not employed by anyone, Helpers now always have their own clothes on, so the recognition value is there 
-- Version 1.9.0.15     |    04.10.2021    fix automaticly fired and hired helpers 2nd
-- Version 1.9.0.14     |    25.08.2021    fix automaticly fired and hired helpers
-- Version 1.9.0.13     |    20.07.2021    fix missing sowingMachine synchronisation in multiplayer
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
-- Version 1.5.3.1 B    |    16.09.2018    fix savebug for text size
-- Version 1.5.3.1 A    |    15.09.2018    add text size option in helper advanced config xml
-- Version 1.5.3.1      |    03.08.2018    fix overall helper costs display, various script fixes, add key press support for OK and CANCEL button, add education module for employed helpers, add current ingame time and weekday
-- Version 1.5.1.0      |    29.11.2017    corrected 0 price for field job missions
-- Version 1.4.4.0 G    |    25.08.2017    corrected seedUsage calculation (thanks dural for the hint)
-- Version 1.4.4.0 F    |    26.06.2017    corrected season mod values
-- Version 1.4.4.0 E    |    25.06.2017    shows now pay so far for every helper
-- Version 1.4.4.0 D    |    18.06.2017    fix new name setting synchronization in multiplayer
-- Version 1.4.4.0 B    |    29.04.2017    column spacing fixed in the tablet
-- Version 1.4.4.0 A    |    20.04.2017    text color error fixed
-- Version 1.4.4.0      |    09.03.2017    fixed an error if a helper is fired
-- Version 1.3.1.0 F    |    01.02.2017    fixed normal multiplayer mode for employ helpers
-- Version 1.3.1.0 E    |    14.01.2017    fixed HUD values, added own name variable for savegames and HUD, added rename option
-- Version 1.3.1.0 D    |    01.01.2017    fixed error for first use saving, fixed wrong variable, complete HUD overhaul
-- Version 1.3.1.0 C    |    30.12.2016    added Courseplay and FolloMe functionality, added usage/output by experience for appropriate machines
-- Version 1.3.1.0 B    |    27.12.2016    helper overview adjusted
-- Version 1.3.1.0 A    |    26.12.2016    helper as employer feature integrated
-- Version 1.3.1.0      |    25.12.2016    initial Version for FS17


HelperAdvanced = {}
HelperAdvanced.directory = g_currentModDirectory
HelperAdvanced.userDir = getUserProfileAppPath()
HelperAdvanced.request = false
g_helperManager.showHelperSelectionScreen = false
g_helperManager.showNoHelperAvailable = false
g_helperManager.showCourseplayHasEmployed = false
g_helperManager.showFollowMeHasEmployed = false
g_helperManager.showAutoDriveHasEmployed = false
g_helperManager.showAutoEmployed = false
HelperAdvanced.daysForFullExperience = 14
HelperAdvanced.daysUntilDischarge = 7
HelperAdvanced.basePricePerHour = 75
HelperAdvanced.maxPricePerHour = 250
HelperAdvanced.overtimePricePerHour = 325
HelperAdvanced.workPrices = {}
HelperAdvanced.workPrices["base"] = 0.25
HelperAdvanced.workPrices["baler"] = 0.275
HelperAdvanced.workPrices["combine"] = 0.45
HelperAdvanced.workPrices["cultivator"] = 0.30
HelperAdvanced.workPrices["sprayer"] = 0.35
HelperAdvanced.workPrices["mower"] = 0.25
HelperAdvanced.workPrices["sowing"] = 0.475
HelperAdvanced.workPrices["plough"] = 0.50
HelperAdvanced.workPrices["other"] = 0.55
HelperAdvanced.eduPrices = {}
HelperAdvanced.eduPrices[1] = 14250
HelperAdvanced.eduPrices[2] = 22400
HelperAdvanced.eduPrices[3] = 18300
HelperAdvanced.eduPrices[4] = 9500
HelperAdvanced.version = "1.9.0.16 - 05.10.2021"
HelperAdvanced.build = 210710
HelperAdvanced.tSize = 0.008543*g_screenAspectRatio 
HelperAdvanced.keyId = nil

	--[[
			model	1=Europa	2=Asien		3=Afrika	4=South
			selectedModelIndex		1=Mann			2=Frau
			selectedBodyIndex		1 2 3 4			1 2 3 4
			selectedColorIndex		1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
			selectedHairIndex		1 2 3 4
			selectedHatIndex		3 6 15 25 28 36 42 43 46 58 65 73 90 
			selectedJacketIndex		0 1
			selectedAccessoryIndex	0 1
	--]]
HelperAdvanced.helperOpticals = {
	helper1 ={index=1, body=1, color=1,  hair=1, hat=90, jacket=0, accessory=0},
	helper2 ={index=1, body=4, color=2,  hair=2, hat=0,  jacket=0, accessory=1},
	helper3 ={index=1, body=2, color=3,  hair=1, hat=3,  jacket=0, accessory=0},
	helper4 ={index=1, body=1, color=4,  hair=4, hat=0,  jacket=1, accessory=0},
	helper5 ={index=1, body=3, color=5,  hair=3, hat=6,  jacket=0, accessory=0},
	helper6 ={index=1, body=4, color=6,  hair=4, hat=0,  jacket=0, accessory=1},

	helper7 ={index=2, body=1, color=7,  hair=1, hat=0,  jacket=0, accessory=0},
	helper8 ={index=2, body=4, color=8,  hair=3, hat=15, jacket=0, accessory=1},
	helper9 ={index=2, body=1, color=9,  hair=2, hat=0,  jacket=0, accessory=0},
	helper10={index=2, body=4, color=10, hair=1, hat=25, jacket=0, accessory=0},
	helper11={index=2, body=2, color=11, hair=4, hat=0,  jacket=0, accessory=1},
	helper12={index=2, body=3, color=12, hair=2, hat=28, jacket=0, accessory=0},

	helper13={index=1, body=3, color=13, hair=3, hat=0,  jacket=0, accessory=0},
	helper14={index=1, body=4, color=14, hair=4, hat=36, jacket=1, accessory=0},
	helper15={index=1, body=2, color=15, hair=2, hat=0,  jacket=0, accessory=1},
	helper16={index=1, body=4, color=16, hair=1, hat=42, jacket=0, accessory=0},
	helper17={index=1, body=3, color=17, hair=2, hat=0,  jacket=1, accessory=0},
	helper18={index=1, body=1, color=18, hair=3, hat=43, jacket=0, accessory=0},

	helper19={index=2, body=2, color=19, hair=2, hat=0,  jacket=0, accessory=0},
	helper20={index=2, body=1, color=20, hair=4, hat=46, jacket=0, accessory=0},
	helper21={index=2, body=1, color=1,  hair=3, hat=0,  jacket=0, accessory=0},
	helper22={index=2, body=3, color=2,  hair=3, hat=58, jacket=0, accessory=0},
	helper23={index=2, body=4, color=3,  hair=1, hat=0,  jacket=0, accessory=1},
	helper24={index=2, body=2, color=4,  hair=4, hat=73, jacket=0, accessory=0}
}

getfenv(0)["g_HelperAdvanced"] = HelperAdvanced
g_HelperAdvanced = HelperAdvanced

function HelperAdvanced:loadMap(fileName)
	self.isEnabled = true
	g_currentMission.environment:addMinuteChangeListener(self)
	self.lastUserCount = 0
	g_helperManager.numHelpers = 0
	g_helperManager.helpers = {}
	g_helperManager.indexToHelper = {}
	g_helperManager.nameToIndex  = {}
	g_helperManager.availableHelpers = {}
	g_helperManager:addHelper("John","player_male", "dataS2/character/helper/helper01.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Thomas","player_male", "dataS2/character/helper/helper02.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Viktor","player_male", "dataS2/character/helper/helper03.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Jean","player_male", "dataS2/character/helper/helper05.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Kenny","player_male", "dataS2/character/helper/helper06.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Gustav","player_male", Utils.getFilename("scripts/helper12.xml", HelperAdvanced.directory),HelperAdvanced.directory)

	g_helperManager:addHelper("Julia","player_female", "dataS2/character/helper/helper07.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Gabriela","player_female", "dataS2/character/helper/helper08.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Daniela","player_female", "dataS2/character/helper/helper09.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Tina","player_female", "dataS2/character/helper/helper10.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Nele","player_female", Utils.getFilename("scripts/helper11.xml", HelperAdvanced.directory),HelperAdvanced.directory)
	g_helperManager:addHelper("Anna","player_female", "dataS2/character/helper/helper04.xml",g_currentMission.baseDirectory)

	g_helperManager:addHelper("James","player_male", "dataS2/character/helper/helper01.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Frank","player_male", "dataS2/character/helper/helper02.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Gregor","player_male", "dataS2/character/helper/helper03.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Pablo","player_male", "dataS2/character/helper/helper05.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Donald","player_male", "dataS2/character/helper/helper06.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Herbert","player_male", Utils.getFilename("scripts/helper12.xml", HelperAdvanced.directory),HelperAdvanced.directory)

	g_helperManager:addHelper("Olga","player_female", "dataS2/character/helper/helper07.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Erika","player_female", "dataS2/character/helper/helper08.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Monika","player_female", "dataS2/character/helper/helper09.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Emily","player_female", "dataS2/character/helper/helper10.xml",g_currentMission.baseDirectory)
	g_helperManager:addHelper("Clara","player_female", Utils.getFilename("scripts/helper11.xml", HelperAdvanced.directory),HelperAdvanced.directory)
	g_helperManager:addHelper("Tatjana","player_female", "dataS2/character/helper/helper04.xml",g_currentMission.baseDirectory)
	g_helperManager.availableHelpers = {}
	for i=1, g_helperManager.numHelpers do
		g_helperManager.indexToHelper[i].nameBase = g_helperManager.indexToHelper[i].name
		g_helperManager.indexToHelper[i].nameShow = g_helperManager.indexToHelper[i].nameBase
		g_helperManager.indexToHelper[i].experience,g_helperManager.indexToHelper[i].experiencePercent = self:getRandomStartValues()
		g_helperManager.indexToHelper[i].baseExperience = g_helperManager.indexToHelper[i].experience
		g_helperManager.indexToHelper[i].learnedExperience = 0
		g_helperManager.indexToHelper[i].experiencePercentLast = 0
		g_helperManager.indexToHelper[i].pricePerMS = HelperAdvanced.basePricePerHour/60/60/1000
		g_helperManager.indexToHelper[i].autoEmployed = false
		g_helperManager.indexToHelper[i].isHired = false
		g_helperManager.indexToHelper[i].isEmployed = false
		g_helperManager.indexToHelper[i].isLearning = 0
		g_helperManager.indexToHelper[i].isLearnSpec = 0
		g_helperManager.indexToHelper[i].isHudSelected = false
		g_helperManager.indexToHelper[i].editMode = false
		g_helperManager.indexToHelper[i].hudYPos = -1
		g_helperManager.indexToHelper[i].hudHover = false
		g_helperManager.indexToHelper[i].editMode = false
		g_helperManager.indexToHelper[i].experienceBaler,g_helperManager.indexToHelper[i].percentBaler = self:getRandomStartValues()
		g_helperManager.indexToHelper[i].baseBaler = g_helperManager.indexToHelper[i].experienceBaler
		g_helperManager.indexToHelper[i].learnedBaler = 0
		g_helperManager.indexToHelper[i].workedWithBaler = false
		g_helperManager.indexToHelper[i].experienceCombine,g_helperManager.indexToHelper[i].percentCombine = self:getRandomStartValues()
		g_helperManager.indexToHelper[i].baseCombine = g_helperManager.indexToHelper[i].experienceCombine
		g_helperManager.indexToHelper[i].learnedCombine = 0
		g_helperManager.indexToHelper[i].workedWithCombine = false
		g_helperManager.indexToHelper[i].experienceCultivator,g_helperManager.indexToHelper[i].percentCultivator = self:getRandomStartValues()
		g_helperManager.indexToHelper[i].basexperienceCultivator = g_helperManager.indexToHelper[i].experienceCultivator
		g_helperManager.indexToHelper[i].learnedCultivator = 0
		g_helperManager.indexToHelper[i].workedWithCultivator = false
		g_helperManager.indexToHelper[i].experienceSprayer,g_helperManager.indexToHelper[i].percentSprayer = self:getRandomStartValues()
		g_helperManager.indexToHelper[i].baseSprayer = g_helperManager.indexToHelper[i].experienceSprayer
		g_helperManager.indexToHelper[i].learnedSprayer = 0
		g_helperManager.indexToHelper[i].workedWithSprayer = false
		g_helperManager.indexToHelper[i].experienceMower,g_helperManager.indexToHelper[i].percentMower = self:getRandomStartValues()
		g_helperManager.indexToHelper[i].baseMower = g_helperManager.indexToHelper[i].experienceMower
		g_helperManager.indexToHelper[i].learnedMower = 0
		g_helperManager.indexToHelper[i].workedWithMower = false
		g_helperManager.indexToHelper[i].experienceSowingMachine,g_helperManager.indexToHelper[i].percentSowingMachine = self:getRandomStartValues()
		g_helperManager.indexToHelper[i].baseSowingMachine = g_helperManager.indexToHelper[i].experienceSowingMachine
		g_helperManager.indexToHelper[i].learnedSowingMachine = 0
		g_helperManager.indexToHelper[i].workedWithSowingMachine = false
		g_helperManager.indexToHelper[i].experiencePlough,g_helperManager.indexToHelper[i].percentPlough = self:getRandomStartValues()
		g_helperManager.indexToHelper[i].basePlough = g_helperManager.indexToHelper[i].experiencePlough
		g_helperManager.indexToHelper[i].learnedPlough = 0
		g_helperManager.indexToHelper[i].workedWithPlough = false
		g_helperManager.indexToHelper[i].experienceOther,g_helperManager.indexToHelper[i].percentOther = self:getRandomStartValues()
		g_helperManager.indexToHelper[i].baseOther = g_helperManager.indexToHelper[i].experienceOther
		g_helperManager.indexToHelper[i].learnedOther = 0
		g_helperManager.indexToHelper[i].workedWithOther = false
		g_helperManager.indexToHelper[i].checkValue = 0
		g_helperManager.indexToHelper[i].costs = 0
		g_helperManager.indexToHelper[i].lastVehicle = nil
		g_helperManager.indexToHelper[i].lastVehicleName = " "
		g_helperManager.indexToHelper[i].lastVehicleAiStarted = false
		g_helperManager.indexToHelper[i].ownerFarmId = 0
		g_helperManager.indexToHelper[i].index = i
		if i <= 6 or (i >= 13 and i <= 18) then
			g_helperManager.indexToHelper[i].iconFilename = createImageOverlay(Utils.getFilename("huds/icon_man.dds", HelperAdvanced.directory))
			g_helperManager.indexToHelper[i].male = true
			g_helperManager.indexToHelper[i].female = false
		else
			g_helperManager.indexToHelper[i].iconFilename = createImageOverlay(Utils.getFilename("huds/icon_woman.dds", HelperAdvanced.directory))
			g_helperManager.indexToHelper[i].female = true
			g_helperManager.indexToHelper[i].male = false
		end
	end
	HelperAdvanced.employedHelpers = {}
	local xmlFile = nil
	if g_currentMission.missionInfo.isValid then
		local filename = Utils.getFilename("/HelperAdvanced.xml", g_currentMission.missionInfo.savegameDirectory)
		if fileExists(filename) then
			xmlFile = loadXMLFile("xml", filename)
			if xmlFile ~= nil then
				local key = "HelperAdvanced."
				local build = Utils.getNoNil(getXMLInt(xmlFile, key.."version#build"),1) if build > 1 and build < 200000 then build = 443 elseif build < 200122 then build = 1 end if build > 200000 and build < 210000 then build = build * 23456 end
				for i=1, g_helperManager.numHelpers do
					g_helperManager.indexToHelper[i].nameShow = Utils.getNoNil(getXMLString(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#ownName"),g_helperManager.indexToHelper[i].nameShow)
					g_helperManager.indexToHelper[i].isEmployed = Utils.getNoNil(getXMLBool(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#isEmployed"),g_helperManager.indexToHelper[i].isEmployed)
					g_helperManager.indexToHelper[i].autoEmployed = Utils.getNoNil(getXMLBool(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#autoEmployed"),g_helperManager.indexToHelper[i].autoEmployed)
					g_helperManager.indexToHelper[i].checkValue = Utils.getNoNil(getXMLInt(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#checkValue"),g_helperManager.indexToHelper[i].checkValue*(build/23456))/(build/23456)
					if g_helperManager.indexToHelper[i].checkValue < 0 then
						g_helperManager.indexToHelper[i].checkValue = (0 - g_helperManager.indexToHelper[i].checkValue) * 2
					end
					g_helperManager.indexToHelper[i].costs = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#costs"),g_helperManager.indexToHelper[i].costs*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].experience = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#experience"),g_helperManager.indexToHelper[i].experience*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].baseExperience = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#experienceBase"),g_helperManager.indexToHelper[i].experience*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].learnedExperience = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#educated"),g_helperManager.indexToHelper[i].learnedExperience*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].experienceBaler = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#baler"),g_helperManager.indexToHelper[i].experienceBaler*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].baseBaler = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#balerBase"),g_helperManager.indexToHelper[i].experienceBaler*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].learnedBaler = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#balerLearned"),g_helperManager.indexToHelper[i].learnedBaler*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].experienceCombine = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#combine"),g_helperManager.indexToHelper[i].experienceCombine*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].baseCombine = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#combineBase"),g_helperManager.indexToHelper[i].experienceCombine*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].learnedCombine = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#combineLearned"),g_helperManager.indexToHelper[i].learnedCombine*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].experienceCultivator = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#cultivator"),g_helperManager.indexToHelper[i].experienceCultivator*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].basexperienceCultivator = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#cultivatorBase"),g_helperManager.indexToHelper[i].experienceCultivator*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].learnedCultivator = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#cultivatorLearned"),g_helperManager.indexToHelper[i].learnedCultivator*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].experienceSprayer = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#sprayer"),g_helperManager.indexToHelper[i].experienceSprayer*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].baseSprayer = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#sprayerBase"),g_helperManager.indexToHelper[i].experienceSprayer*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].learnedSprayer = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#sprayerLearned"),g_helperManager.indexToHelper[i].learnedSprayer*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].experienceMower = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#mower"),g_helperManager.indexToHelper[i].experienceMower*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].baseMower = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#mowerBase"),g_helperManager.indexToHelper[i].experienceMower*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].learnedMower = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#mowerLearned"),g_helperManager.indexToHelper[i].learnedMower*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].experienceSowingMachine = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#sowing"),g_helperManager.indexToHelper[i].experienceSowingMachine*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].baseSowingMachine = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#sowingBase"),g_helperManager.indexToHelper[i].experienceSowingMachine*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].learnedSowingMachine = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#sowingLearned"),g_helperManager.indexToHelper[i].learnedSowingMachine*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].experiencePlough = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#plough"),g_helperManager.indexToHelper[i].experiencePlough*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].basePlough = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#ploughBase"),g_helperManager.indexToHelper[i].experiencePlough*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].learnedPlough = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#ploughLearned"),g_helperManager.indexToHelper[i].learnedPlough*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].experienceOther = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#other"),g_helperManager.indexToHelper[i].experienceOther*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].baseOther = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#otherBase"),g_helperManager.indexToHelper[i].experienceOther*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].learnedOther = Utils.getNoNil(getXMLFloat(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#otherLearned"),g_helperManager.indexToHelper[i].learnedOther*(build/23456))/(build/23456) 
					g_helperManager.indexToHelper[i].isLearning = Utils.getNoNil(getXMLInt(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#learnStage"),g_helperManager.indexToHelper[i].isLearning*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].isLearnSpec = Utils.getNoNil(getXMLInt(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#learnSpec"),g_helperManager.indexToHelper[i].isLearnSpec*(build/23456))/(build/23456)
					g_helperManager.indexToHelper[i].ownerFarmId = Utils.getNoNil(getXMLInt(xmlFile, key..g_helperManager.indexToHelper[i].nameBase.."#ownerFarmId"),g_helperManager.indexToHelper[i].ownerFarmId)
					g_helperManager.indexToHelper[i].experiencePercent = math.min(g_helperManager.indexToHelper[i].experience * 100,100)
					g_helperManager.indexToHelper[i].percentBaler = math.min(g_helperManager.indexToHelper[i].experienceBaler * 100,100)
					g_helperManager.indexToHelper[i].percentCombine = math.min(g_helperManager.indexToHelper[i].experienceCombine * 100,100)
					g_helperManager.indexToHelper[i].percentCultivator = math.min(g_helperManager.indexToHelper[i].experienceCultivator * 100,100)
					g_helperManager.indexToHelper[i].percentSprayer = math.min(g_helperManager.indexToHelper[i].experienceSprayer * 100,100)
					g_helperManager.indexToHelper[i].percentMower = math.min(g_helperManager.indexToHelper[i].experienceMower * 100,100)
					g_helperManager.indexToHelper[i].percentSowingMachine = math.min(g_helperManager.indexToHelper[i].experienceSowingMachine * 100,100)
					g_helperManager.indexToHelper[i].percentPlough = math.min(g_helperManager.indexToHelper[i].experiencePlough * 100,100)
					g_helperManager.indexToHelper[i].percentOther = math.min(g_helperManager.indexToHelper[i].experienceOther * 100,100)
					g_helperManager.indexToHelper[i].name = g_helperManager.indexToHelper[i].nameBase.." ("..tostring(math.floor(g_helperManager.indexToHelper[i].experiencePercent)).."%)"
					local price = HelperAdvanced.maxPricePerHour - HelperAdvanced.basePricePerHour
					local hour = g_currentMission.environment.currentHour
					local weekDay = math.fmod(g_currentMission.environment.currentDay - 1, 7) + 1
					if hour < 6 or hour >= 20 or weekDay > 5 then
						price = HelperAdvanced.overtimePricePerHour - HelperAdvanced.basePricePerHour
					end
					g_helperManager.indexToHelper[i].pricePerMS = (HelperAdvanced.basePricePerHour + (price * math.max(g_helperManager.indexToHelper[i].experience-g_helperManager.indexToHelper[i].learnedExperience,0.02)))/60/60/1000
					self:hireHelper(i,g_helperManager.indexToHelper[i].isEmployed,g_helperManager.indexToHelper[i].isLearning,g_helperManager.indexToHelper[i].isLearnSpec,g_helperManager.indexToHelper[i].ownerFarmId,g_helperManager.indexToHelper[i].autoEmployed)
				end
			end
			delete(xmlFile)
		end
	end
	if self.isClient or g_client ~= nil then
		self:loadConfig()
	end
	self.hudCurrentSelection = 0
	self.editCurrentSelection = 0
	self.showHelperSelectionScreen = false
	self.mX, self.mY = 0,0
	self.lastEntryY = 0
	self.buttonHover = false
	self.buttonCancelHover = false
	self.buttonEdu1Hover = false
	self.buttonEdu2Hover = false
	self.buttonEdu3Hover = false
	self.buttonEdu4Hover = false
	self.buttonTime1Hover = false
	self.buttonTime2Hover = false
	self.buttonTime3Hover = false
	self.buttonEduSelected = 0
	self.onlyShowNoSelection = false
	self.currentVehicleName = " "
	self.helperMenuPage = 1
	self.enterNameField = false
	self.enterNameHelper = 0
	self.newName = ""
	self.firstStart = 30
	FSBaseMission.registerActionEvents = Utils.appendedFunction(FSBaseMission.registerActionEvents, HelperAdvanced.registerActionEvents)
	BaseMission.unregisterActionEvents = Utils.appendedFunction(BaseMission.unregisterActionEvents, HelperAdvanced.unregisterActionEvents)
end

function HelperAdvanced:getRandomStartValues() 
	local val = math.random(5,350)/1000
	return val,val*100
end

function HelperAdvanced:loadConfig(xtraFile)
	if g_dedicatedServerInfo ~= nil then
		return
	end
	self.helperSelectionHud = createImageOverlay(Utils.getFilename("huds/hud_tablet.dds", HelperAdvanced.directory))
	self.helperSelectionHudFile = "huds/hud_tablet.dds"
	self.helperSelectionButton = createImageOverlay(Utils.getFilename("huds/hud_tablet_button.dds", HelperAdvanced.directory))
	self.helperSelectionButtonFile = "huds/hud_tablet_button.dds"
	self.helperSelectionButtonHover = createImageOverlay(Utils.getFilename("huds/hud_tablet_buttonHover.dds", HelperAdvanced.directory))
	self.helperSelectionButtonHoverFile = "huds/hud_tablet_buttonHover.dds"
	self.hudColorMenu = {}
	self.hudColorMenu.r, self.hudColorMenu.g,self.hudColorMenu.b = 1,1,1
	self.hudColorEntrys = {}
	self.hudColorEntrys.r, self.hudColorEntrys.g,self.hudColorEntrys.b = 0,0,0
	self.hudColorEntrysOff = {}
	self.hudColorEntrysOff.r, self.hudColorEntrysOff.g,self.hudColorEntrysOff.b = 0.3,0.3,0.3
	self.hudColorEntrysNote = {}
	self.hudColorEntrysNote.r, self.hudColorEntrysNote.g,self.hudColorEntrysNote.b = 0.3,0,0.3
	local fileName = HelperAdvanced.userDir.."HelperAdvancedMenu.xml"
	if xtraFile ~= nil then
		fileName = HelperAdvanced.directory..xtraFile
		if not fileExists(fileName) then
			return
		end
	else
		if not fileExists(fileName) then
			self:createConfig()
			return
		end
	end
	local xmlFile = loadXMLFile("HelperAdvancedMenu", fileName, "HelperAdvancedMenu")
	if xmlFile ~= nil then
		local tSize = getXMLFloat(xmlFile, "HelperAdvancedMenu.textSize")
		if tSize ~= nil then
			tSize = tSize / 1000 * g_screenAspectRatio
		else
			tSize = HelperAdvanced.tSize
		end
		HelperAdvanced.tSize = tSize
		local tablet = getXMLString(xmlFile, "HelperAdvancedMenu.tabletFile")
		if tablet ~= nil and fileExists(HelperAdvanced.userDir..tablet) then
			self.helperSelectionHud = createImageOverlay(Utils.getFilename(tablet, HelperAdvanced.userDir))
			self.helperSelectionHudFile = tablet
		else
			print("Warning: HelperAdvanced user tablet file not found, using standard instead")
		end
		local button = getXMLString(xmlFile, "HelperAdvancedMenu.buttonFile")
		if button ~= nil and fileExists(HelperAdvanced.userDir..button) then
			self.helperSelectionButton = createImageOverlay(Utils.getFilename(button, HelperAdvanced.userDir))
			self.helperSelectionButtonFile = button
		else
			print("Warning: HelperAdvanced user button file not found, using standard instead")
		end
		local buttonHover = getXMLString(xmlFile, "HelperAdvancedMenu.buttonHoverFile")
		if buttonHover ~= nil and fileExists(HelperAdvanced.userDir..buttonHover) then
			self.helperSelectionButtonHover = createImageOverlay(Utils.getFilename(buttonHover, HelperAdvanced.userDir))
			self.helperSelectionButtonHoverFile = buttonHover
		else
			print("Warning: HelperAdvanced user buttonHover file not found, using standard instead")
		end
		self.hudColorMenu.r = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.menuTextColor#r"),self.hudColorMenu.r)
		self.hudColorMenu.g = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.menuTextColor#g"),self.hudColorMenu.g)
		self.hudColorMenu.b = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.menuTextColor#b"),self.hudColorMenu.b)
		self.hudColorEntrys.r = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.entryTextColor#r"),self.hudColorEntrys.r)
		self.hudColorEntrys.g = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.entryTextColor#g"),self.hudColorEntrys.g)
		self.hudColorEntrys.b = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.entryTextColor#b"),self.hudColorEntrys.b)
		self.hudColorEntrysOff.r = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.entryDeactiveTextColor#r"),self.hudColorEntrysOff.r)
		self.hudColorEntrysOff.g = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.entryDeactiveTextColor#g"),self.hudColorEntrysOff.g)
		self.hudColorEntrysOff.b = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.entryDeactiveTextColor#b"),self.hudColorEntrysOff.b)
		self.hudColorEntrysNote.r = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.noteTextColor#r"),self.hudColorEntrysNote.r)
		self.hudColorEntrysNote.g = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.noteTextColor#g"),self.hudColorEntrysNote.g)
		self.hudColorEntrysNote.b = Utils.getNoNil(getXMLFloat(xmlFile, "HelperAdvancedMenu.noteTextColor#b"),self.hudColorEntrysNote.b)
		saveXMLFile(xmlFile)
		delete(xmlFile)
	end
end

function HelperAdvanced:createConfig(configExists)
	if g_dedicatedServerInfo ~= nil then
		return
	end
	local tablet, _, _, _ = "mods/"..Utils.removeModDirectory(HelperAdvanced.directory.."huds/hud_tablet.dds")
	local button, _, _, _ = "mods/"..Utils.removeModDirectory(HelperAdvanced.directory.."huds/hud_tablet_button.dds")
	local buttonHover, _, _, _ = "mods/"..Utils.removeModDirectory(HelperAdvanced.directory.."huds/hud_tablet_buttonHover.dds")
	if configExists then
		tablet = self.helperSelectionHudFile
		button = self.helperSelectionButtonFile
		buttonHover = self.helperSelectionButtonHoverFile
	end
	local fileName = HelperAdvanced.userDir.."HelperAdvancedMenu.xml"
	local xmlFile = createXMLFile("HelperAdvancedMenu", fileName, "HelperAdvancedMenu")
	if xmlFile ~= nil then
		setXMLString(xmlFile, "HelperAdvancedMenu.tabletFile", tablet)
		setXMLString(xmlFile, "HelperAdvancedMenu.buttonFile", button)
		setXMLString(xmlFile, "HelperAdvancedMenu.buttonHoverFile", buttonHover)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.menuTextColor#r", self.hudColorMenu.r)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.menuTextColor#g", self.hudColorMenu.g)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.menuTextColor#b", self.hudColorMenu.b)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.entryTextColor#r", self.hudColorEntrys.r)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.entryTextColor#g", self.hudColorEntrys.g)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.entryTextColor#b", self.hudColorEntrys.b)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.entryDeactiveTextColor#r", self.hudColorEntrysOff.r)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.entryDeactiveTextColor#g", self.hudColorEntrysOff.g)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.entryDeactiveTextColor#b", self.hudColorEntrysOff.b)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.noteTextColor#r", self.hudColorEntrysNote.r)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.noteTextColor#g", self.hudColorEntrysNote.g)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.noteTextColor#b", self.hudColorEntrysNote.b)
		setXMLFloat(xmlFile, "HelperAdvancedMenu.textSize", HelperAdvanced.tSize / g_screenAspectRatio * 1000)
		saveXMLFile(xmlFile)
	end
end

function HelperAdvanced:saveSavegame(superFunc, ...)
	if superFunc ~= nil then
		superFunc(self, ...)
	end
	HelperAdvanced:createConfig(true)
	if g_currentMission:getIsServer() then
		xmlFile = createXMLFile("HelperAdvanced", Utils.getFilename("/HelperAdvanced.xml", g_currentMission.missionInfo.savegameDirectory), "HelperAdvanced")
		if xmlFile ~= nil then
			setXMLInt(xmlFile, "HelperAdvanced.version#build", g_HelperAdvanced.build)
			for i=1, g_helperManager.numHelpers do
				setXMLBool(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#isEmployed", g_helperManager.indexToHelper[i].isEmployed)
				setXMLBool(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#autoEmployed", g_helperManager.indexToHelper[i].autoEmployed)
				setXMLString(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#ownName", g_helperManager.indexToHelper[i].nameShow)
				setXMLInt(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#checkValue", g_helperManager.indexToHelper[i].checkValue*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#costs", g_helperManager.indexToHelper[i].costs*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#experience", g_helperManager.indexToHelper[i].experience*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#experienceBase", g_helperManager.indexToHelper[i].baseExperience*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#educated", g_helperManager.indexToHelper[i].learnedExperience*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#baler", g_helperManager.indexToHelper[i].experienceBaler*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#balerBase", g_helperManager.indexToHelper[i].baseBaler*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#balerLearned", g_helperManager.indexToHelper[i].learnedBaler*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#combine", g_helperManager.indexToHelper[i].experienceCombine*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#combineBase", g_helperManager.indexToHelper[i].baseCombine*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#combineLearned", g_helperManager.indexToHelper[i].learnedCombine*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#cultivator", g_helperManager.indexToHelper[i].experienceCultivator*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#cultivatorBase", g_helperManager.indexToHelper[i].basexperienceCultivator*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#cultivatorLearned", g_helperManager.indexToHelper[i].learnedCultivator*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#sprayer", g_helperManager.indexToHelper[i].experienceSprayer*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#sprayerBase", g_helperManager.indexToHelper[i].baseSprayer*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#sprayerLearned", g_helperManager.indexToHelper[i].learnedSprayer*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#mower", g_helperManager.indexToHelper[i].experienceMower*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#mowerBase", g_helperManager.indexToHelper[i].baseMower*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#mowerLearned", g_helperManager.indexToHelper[i].learnedMower*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#sowing", g_helperManager.indexToHelper[i].experienceSowingMachine*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#sowingBase", g_helperManager.indexToHelper[i].baseSowingMachine*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#sowingLearned", g_helperManager.indexToHelper[i].learnedSowingMachine*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#plough", g_helperManager.indexToHelper[i].experiencePlough*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#ploughBase", g_helperManager.indexToHelper[i].basePlough*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#ploughLearned", g_helperManager.indexToHelper[i].learnedPlough*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#other", g_helperManager.indexToHelper[i].experienceOther*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#otherBase", g_helperManager.indexToHelper[i].baseOther*(g_HelperAdvanced.build/23456))
				setXMLFloat(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#otherLearned", g_helperManager.indexToHelper[i].learnedOther*(g_HelperAdvanced.build/23456))
				setXMLInt(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#learnStage", g_helperManager.indexToHelper[i].isLearning*(g_HelperAdvanced.build/23456))
				setXMLInt(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#learnSpec", g_helperManager.indexToHelper[i].isLearnSpec*(g_HelperAdvanced.build/23456))
				setXMLInt(xmlFile, "HelperAdvanced."..g_helperManager.indexToHelper[i].nameBase.."#ownerFarmId", g_helperManager.indexToHelper[i].ownerFarmId)
			end
		end
		saveXMLFile(xmlFile)
	end
end
SavegameController.onSaveComplete = Utils.overwrittenFunction(SavegameController.onSaveComplete, HelperAdvanced.saveSavegame)

function HelperAdvanced:deleteMap()
	for i=1, g_helperManager.numHelpers do
		g_helperManager.releaseHelper(g_helperManager.indexToHelper[i])
	end
	if g_currentMission.environment ~= nil then
		g_currentMission.environment:removeMinuteChangeListener(self)
	end
end

function HelperAdvanced:minuteChanged()
	for i=1, g_helperManager.numHelpers do
		local hp = g_helperManager.indexToHelper[i]
		local priceFactor = 0
		if hp.isHired == true and hp.isLearning <= 0 then
			HelperAdvanced:activateHelperWorks(hp, hp.lastVehicle)
			hp.experience = math.min(hp.experience + (1 / (HelperAdvanced.daysForFullExperience * 1440)),1)
			hp.learnedExperience = math.max(hp.learnedExperience - (1 / (HelperAdvanced.daysForFullExperience * 7200)),0)
			if hp.workedWithBaler == true then
				hp.experienceBaler = math.min(hp.experienceBaler + (1 / (HelperAdvanced.daysForFullExperience * 1440)),1)
				hp.learnedBaler = math.max(hp.learnedBaler - (1 / (HelperAdvanced.daysForFullExperience * 7200)),0)
				hp.percentBaler = math.min(hp.experienceBaler * 100,100)
				priceFactor = priceFactor + ((hp.experienceBaler - hp.learnedBaler) * HelperAdvanced.workPrices["baler"])
			end
			if hp.workedWithCombine == true then
				hp.experienceCombine = math.min(hp.experienceCombine + (1 / (HelperAdvanced.daysForFullExperience * 1440)),1)
				hp.learnedCombine = math.max(hp.learnedCombine - (1 / (HelperAdvanced.daysForFullExperience * 7200)),0)
				hp.percentCombine = math.min(hp.experienceCombine * 100,100)
				priceFactor = priceFactor + ((hp.experienceCombine - hp.learnedCombine) * HelperAdvanced.workPrices["combine"])
			end
			if hp.workedWithCultivator == true then
				hp.experienceCultivator = math.min(hp.experienceCultivator + (1 / (HelperAdvanced.daysForFullExperience * 1440)),1)
				hp.learnedCultivator = math.max(hp.learnedCultivator - (1 / (HelperAdvanced.daysForFullExperience * 7200)),0)
				hp.percentCultivator = math.min(hp.experienceCultivator * 100,100)
				priceFactor = priceFactor + ((hp.experienceCultivator - hp.learnedCultivator) * HelperAdvanced.workPrices["cultivator"])
			end
			if hp.workedWithSprayer == true then
				hp.experienceSprayer = math.min(hp.experienceSprayer + (1 / (HelperAdvanced.daysForFullExperience * 1440)),1)
				hp.learnedSprayer = math.max(hp.learnedSprayer - (1 / (HelperAdvanced.daysForFullExperience * 7200)),0)
				hp.percentSprayer = math.min(hp.experienceSprayer * 100,100)
				priceFactor = priceFactor + ((hp.experienceSprayer - hp.learnedSprayer) * HelperAdvanced.workPrices["sprayer"])
			end
			if hp.workedWithMower == true then
				hp.experienceMower = math.min(hp.experienceMower + (1 / (HelperAdvanced.daysForFullExperience * 1440)),1)
				hp.learnedMower = math.max(hp.learnedMower - (1 / (HelperAdvanced.daysForFullExperience * 7200)),0)
				hp.percentMower = math.min(hp.experienceMower * 100,100)
				priceFactor = priceFactor + ((hp.experienceMower - hp.learnedMower) * HelperAdvanced.workPrices["mower"])
			end
			if hp.workedWithSowingMachine == true then
				hp.experienceSowingMachine = math.min(hp.experienceSowingMachine + (1 / (HelperAdvanced.daysForFullExperience * 1440)),1)
				hp.learnedSowingMachine = math.max(hp.learnedSowingMachine - (1 / (HelperAdvanced.daysForFullExperience * 7200)),0)
				hp.percentSowingMachine = math.min(hp.experienceSowingMachine * 100,100)
				priceFactor = priceFactor + ((hp.experienceSowingMachine - hp.learnedSowingMachine) * HelperAdvanced.workPrices["sowing"])
			end
			if hp.workedWithPlough == true then
				hp.experiencePlough = math.min(hp.experiencePlough + (1 / (HelperAdvanced.daysForFullExperience * 1440)),1)
				hp.learnedPlough = math.max(hp.learnedPlough - (1 / (HelperAdvanced.daysForFullExperience * 7200)),0)
				hp.percentPlough = math.min(hp.experiencePlough * 100,100)
				priceFactor = priceFactor + ((hp.experiencePlough - hp.learnedPlough) * HelperAdvanced.workPrices["plough"])
			end
			if hp.workedWithOther == true then
				hp.experienceOther = math.min(hp.experienceOther + (1 / (HelperAdvanced.daysForFullExperience * 1440)),1)
				hp.learnedOther = math.max(hp.learnedOther - (1 / (HelperAdvanced.daysForFullExperience * 7200)),0)
				hp.percentOther = math.min(hp.experienceOther * 100,100)
				priceFactor = priceFactor + ((hp.experienceOther - hp.learnedOther) * HelperAdvanced.workPrices["other"])
			end
		end
		if hp.isLearning > 0 then
			hp.isLearning = hp.isLearning - 1
			local learnFactor = HelperAdvanced.daysForFullExperience * (hp.experience + 1)
			local learnFactor2 = 0
			hp.experience = math.min(hp.experience + (1 / (HelperAdvanced.daysForFullExperience * 4320)),1)
			hp.learnedExperience = math.min(hp.learnedExperience + (1 / (HelperAdvanced.daysForFullExperience * 4320)),1)
			if hp.experience >= 1 then
				hp.learnedExperience = math.min(hp.learnedExperience - (1 / (HelperAdvanced.daysForFullExperience * 4320)),1)
			end
			if hp.isLearnSpec == 1 then
				learnFactor2 = ((hp.experienceCultivator + hp.experiencePlough) / 2) + learnFactor
				hp.experienceCultivator = math.min(hp.experienceCultivator + (1 / (learnFactor2 * 720)),1)
				hp.learnedCultivator = math.min(hp.learnedCultivator + (1 / (learnFactor2 * 720)),1)
				hp.experiencePlough = math.min(hp.experiencePlough + (1 / (learnFactor2 * 720)),1)
				hp.learnedPlough = math.min(hp.learnedPlough + (1 / (learnFactor2 * 720)),1)
				if hp.experienceCultivator >= 1 and hp.experiencePlough >= 1 then
					hp.isLearning = 0
					hp.isLearnSpec = 0
				elseif hp.experienceCultivator >= 1 then
					hp.learnedCultivator = math.min(hp.learnedCultivator - (1 / (learnFactor2 * 720)),1)
				elseif hp.experiencePlough >= 1 then
					hp.learnedPlough = math.min(hp.learnedPlough - (1 / (learnFactor2 * 720)),1)
				end
				hp.percentCultivator = math.min(hp.experienceCultivator * 100,100)
				hp.percentPlough = math.min(hp.experiencePlough * 100,100)
			elseif hp.isLearnSpec == 2 then
				learnFactor2 = ((hp.experienceSprayer + hp.experienceSowingMachine) / 2) + learnFactor
				hp.experienceSprayer = math.min(hp.experienceSprayer + (1 / (learnFactor2 * 720)),1)
				hp.experienceSowingMachine = math.min(hp.experienceSowingMachine + (1 / (learnFactor2 * 720)),1)
				hp.learnedSprayer = math.min(hp.learnedSprayer + (1 / (learnFactor2 * 720)),1)
				hp.learnedSowingMachine = math.min(hp.learnedSowingMachine + (1 / (learnFactor2 * 720)),1)
				if hp.experienceSprayer >= 1 and hp.experienceSowingMachine >= 1 then
					hp.isLearning = 0
					hp.isLearnSpec = 0
				elseif hp.experienceSprayer >= 1 then
					hp.learnedSprayer = math.min(hp.learnedSprayer - (1 / (learnFactor2 * 720)),1)
				elseif hp.experienceSowingMachine >= 1 then
					hp.learnedSowingMachine = math.min(hp.learnedSowingMachine - (1 / (learnFactor2 * 720)),1)
				end
				hp.percentSowingMachine = math.min(hp.experienceSowingMachine * 100,100)
				hp.percentSprayer = math.min(hp.experienceSprayer * 100,100)
			elseif hp.isLearnSpec == 3 then
				learnFactor2 = ((hp.experienceBaler + hp.experienceCombine + hp.experienceMower) / 3) + learnFactor
				hp.experienceBaler = math.min(hp.experienceBaler + (1 / (learnFactor2 * 720)),1)
				hp.experienceCombine = math.min(hp.experienceCombine + (1 / (learnFactor2 * 720)),1)
				hp.experienceMower = math.min(hp.experienceMower + (1 / (learnFactor2 * 720)),1)
				hp.learnedBaler = math.min(hp.learnedBaler + (1 / (learnFactor2 * 720)),1)
				hp.learnedCombine = math.min(hp.learnedCombine + (1 / (learnFactor2 * 720)),1)
				hp.learnedMower = math.min(hp.learnedMower + (1 / (learnFactor2 * 720)),1)
				if hp.experienceBaler >= 1 and hp.experienceCombine >= 1 and hp.experienceMower >= 1 then
					hp.isLearning = 0
					hp.isLearnSpec = 0
				elseif hp.experienceBaler >= 1 then
					hp.learnedBaler = math.min(hp.learnedBaler - (1 / (learnFactor2 * 720)),1)
				elseif hp.experienceCombine >= 1 then
					hp.learnedCombine = math.min(hp.learnedCombine - (1 / (learnFactor2 * 720)),1)
				elseif hp.experienceMower >= 1 then
					hp.learnedMower = math.min(hp.learnedMower - (1 / (learnFactor2 * 720)),1)
				end
				hp.percentMower = math.min(hp.experienceMower * 100,100)
				hp.percentCombine = math.min(hp.experienceCombine * 100,100)
				hp.percentBaler = math.min(hp.experienceBaler * 100,100)
			elseif hp.isLearnSpec == 4 then
				learnFactor2 = ((hp.experience + hp.experienceOther) / 2) + learnFactor
				hp.experience = math.min(hp.experience + (1 / (learnFactor2 * 720)),1)
				hp.experienceOther = math.min(hp.experienceOther + (1 / (learnFactor2 * 720)),1)
				hp.learnedExperience = math.min(hp.learnedExperience + (1 / (learnFactor2 * 720)),1)
				hp.learnedOther = math.min(hp.learnedOther + (1 / (learnFactor2 * 720)),1)
				if hp.experience >= 1 and hp.experienceOther >= 1 then
					hp.isLearning = 0
					hp.isLearnSpec = 0
				elseif hp.experience >= 1 then
					hp.learnedExperience = math.min(hp.learnedExperience - (1 / (learnFactor2 * 720)),1)
				elseif hp.experienceOther >= 1 then
					hp.learnedOther = math.min(hp.learnedOther - (1 / (learnFactor2 * 720)),1)
				end
				hp.percentOther = math.min(hp.experienceOther * 100,100)
			end
			if hp.isLearning <= 0 then
				g_helperManager.releaseHelper(hp)
			end
		end
		hp.experiencePercent = math.min(hp.experience * 100,100)
		hp.name = hp.nameShow.." ("..tostring(math.floor(hp.experiencePercent)).."%)"
		local price = HelperAdvanced.maxPricePerHour - HelperAdvanced.basePricePerHour
		local hour = g_currentMission.environment.currentHour
		local weekDay = math.fmod(g_currentMission.environment.currentDay - 1, 7) + 1
		if hour < 6 or hour >= 20 or weekDay > 5 then
			price = HelperAdvanced.overtimePricePerHour - HelperAdvanced.basePricePerHour
		end
		hp.pricePerMS = ((HelperAdvanced.basePricePerHour + (price * math.max(priceFactor,0.02)))*HelperAdvanced.workPrices["base"])/60/60/1000
		if self.isServer or g_server ~= nil then
			if hp.ownerFarmId == 0 and hp.lastVehicle ~= nil then
				hp.ownerFarmId = hp.lastVehicle:getOwnerFarmId()
			end
			if hp.isHired == true then
				if CpManager ~= nil and CpManager.wagesActive then
					CpManager.wagesActive = false
					CpManager.wagePer10Secs = 0
				end
				if hp.lastVehicleAiStarted == false and hp.ownerFarmId ~= 0 then
					g_currentMission:addMoney(-hp.pricePerMS*1000*60,hp.ownerFarmId, MoneyType.AI)
				end
				hp.costs = hp.costs + (hp.pricePerMS*1000*60)
			else
				hp.lastVehicle = nil
				hp.workedWithOther = false
				hp.workedWithBaler = false
				hp.workedWithSprayer = false
				hp.workedWithMower = false
				hp.workedWithCombine = false
				hp.workedWithCultivator = false
				hp.workedWithSowingMachine = false
				hp.workedWithPlough = false
				if hp.autoEmployed == true then
					self:hireHelper(hp.index,false,0,0,0,true)
				end
			end
			if hp.isEmployed == true then
				hp.checkValue = Utils.getNoNil(hp.checkValue,0) + 1
				local price = HelperAdvanced.maxPricePerHour - HelperAdvanced.basePricePerHour
				price = (HelperAdvanced.basePricePerHour + (price * (hp.experience - hp.learnedExperience)))/60
				if hp.ownerFarmId ~= 0 then
					if hp.isLearning == 1439 or hp.isLearning == 2879 or hp.isLearning == 4319 then
						g_currentMission:addMoney(-(HelperAdvanced.eduPrices[hp.isLearnSpec]*(4-g_currentMission.missionInfo.difficulty)),hp.ownerFarmId, MoneyType.AI)
					end
					g_currentMission:addMoney(-price * HelperAdvanced.workPrices["base"],hp.ownerFarmId, MoneyType.AI)
				end
				hp.costs = hp.costs + price
				if g_farmManager.farmIdToFarm[hp.ownerFarmId] == nil then
					hp.ownerFarmId = 0
				end
				if hp.isEmployed == false then
					hp.isHired = false
					hp.ownerFarmId = 0
				end
				if hp.lastVehicle ~= nil and hp.lastVehicle.spec_aiVehicle ~= nil and hp.lastVehicle.spec_aiVehicle.currentHelper ~= nil and hp.lastVehicle.spec_aiVehicle.currentHelper ~= hp then
					hp.isHired = false
				end
				if hp.isHired == false and hp.autoEmployed == true then
					hp.isEmployed = false
					hp.ownerFarmId = 0
					hp.autoEmployed = false
				end
				if hp.ownerFarmId == 0 then
					hp.isEmployed = false
					hp.isHired = false
				end
				g_server:broadcastEvent(HelperAdvancedMinuteEvent:new(hp.nameShow,hp.pricePerMS,hp.experience,hp.learnedExperience,hp.experienceBaler,hp.learnedBaler,hp.experienceCombine,hp.learnedCombine,hp.experienceCultivator,hp.learnedCultivator,hp.experienceSprayer,hp.learnedSprayer,hp.experienceMower,hp.learnedMower,hp.experienceSowingMachine,hp.learnedSowingMachine,hp.experiencePlough,hp.learnedPlough,hp.experienceOther,hp.learnedOther,hp.isLearning,hp.isLearnSpec, hp.isHired, i, hp.checkValue,hp.isEmployed,hp.lastVehicle,Utils.getNoNil(hp.lastVehicleAiStarted,false),hp.costs,hp.ownerFarmId,hp.autoEmployed))
			end
		end
	end
end

function HelperAdvanced:showHelperScreen(actionName, keyStatus)
	if not g_helperManager.showHelperSelectionScreen then
		g_helperManager.vehicleToSet = nil
		g_helperManager.vehicleToSetEvent = nil
		self.onlyShowNoSelection = true
		g_helperManager.showHelperSelectionScreen = true
	else
		self:deactivateHud(true)
	end
end

function HelperAdvanced:registerActionEvents()
    local arg, eventName = g_inputBinding:registerActionEvent(InputAction.HELPEROVERVIEW, HelperAdvanced, HelperAdvanced.showHelperScreen, false, true, false, true)
    if arg then
		g_inputBinding:setActionEventActive(eventName, true)
		g_inputBinding.events[eventName].displayPriority = 1
		g_inputBinding:setActionEventTextVisibility(eventName, true)
		HelperAdvanced.keyId = eventName
	end
end

function HelperAdvanced:unregisterActionEvents()
    g_inputBinding:removeActionEventsByTarget(HelperAdvanced)
end

function HelperAdvanced:update(dt)
	if self.firstStart > 0 then
		self.firstStart = self.firstStart - 1
	else
		if self.firstStart == 0 then
			self.firstStart = -1
			if self.isServer or g_server ~= nil then
				for i=1, g_helperManager.numHelpers do
					if g_farmManager.farmIdToFarm[g_helperManager.indexToHelper[i].ownerFarmId] == nil then
						g_helperManager.indexToHelper[i].ownerFarmId = 0
					end
					if g_helperManager.indexToHelper[i].ownerFarmId == 0 then
						g_helperManager.indexToHelper[i].checkValue = 0
						g_helperManager.indexToHelper[i].isEmployed = false
					end
					if g_helperManager.indexToHelper[i].isEmployed == false then
						g_helperManager.indexToHelper[i].ownerFarmId = 0
						g_helperManager.indexToHelper[i].checkValue = 0
					end
				end
			end
			if self.isClient or g_server == nil then
				g_client:getServerConnection():sendEvent(HelperDataRequest:new(true))
			end
		end
	end
	if g_helperManager.numHelpers > 24 then
		for i=25, g_helperManager.numHelpers do
			local name = g_helperManager.indexToHelper[i].name
			if g_helperManager.indexToHelper[i] ~= nil then
				g_helperManager.helpers[name] = nil
				g_helperManager.nameToIndex[name] = nil
			end
			for k, h in pairs(g_helperManager.availableHelpers) do
				if h ~= nil and h.name == name then
					table.remove(g_helperManager.availableHelpers,k)
				end
			end
			print("Wrong additional helper removed ("..tostring(i)..", "..tostring(name)..")")
			g_helperManager.indexToHelper[i] = nil
		end
		g_helperManager.numHelpers = 24
	end
	if self.isServer or g_server ~= nil then
		if HelperAdvanced.request == true then
			HelperAdvanced.request = false
			for i=1, g_helperManager.numHelpers do
				if g_farmManager.farmIdToFarm[g_helperManager.indexToHelper[i].ownerFarmId] == nil then
					g_helperManager.indexToHelper[i].ownerFarmId = 0
				end
				if g_helperManager.indexToHelper[i].isEmployed == false then
					g_helperManager.indexToHelper[i].ownerFarmId = 0
				end
				if g_helperManager.indexToHelper[i].lastVehicle ~= nil and g_helperManager.indexToHelper[i].lastVehicle.spec_aiVehicle ~= nil and g_helperManager.indexToHelper[i].lastVehicle.spec_aiVehicle.currentHelper ~= g_helperManager.indexToHelper[i] then
					g_helperManager.indexToHelper[i].isHired = false
				end
				if g_helperManager.indexToHelper[i].isHired == false and g_helperManager.indexToHelper[i].autoEmployed == true then
					g_helperManager.indexToHelper[i].isEmployed = false
					g_helperManager.indexToHelper[i].ownerFarmId = 0
					g_helperManager.indexToHelper[i].autoEmployed = false
				end
				g_server:broadcastEvent(HelperAdvancedMinuteEvent:new(g_helperManager.indexToHelper[i].nameShow,g_helperManager.indexToHelper[i].pricePerMS,g_helperManager.indexToHelper[i].experience,g_helperManager.indexToHelper[i].learnedExperience,g_helperManager.indexToHelper[i].experienceBaler,g_helperManager.indexToHelper[i].learnedBaler,g_helperManager.indexToHelper[i].experienceCombine,g_helperManager.indexToHelper[i].learnedCombine,g_helperManager.indexToHelper[i].experienceCultivator,g_helperManager.indexToHelper[i].learnedCultivator,g_helperManager.indexToHelper[i].experienceSprayer,g_helperManager.indexToHelper[i].learnedSprayer,g_helperManager.indexToHelper[i].experienceMower,g_helperManager.indexToHelper[i].learnedMower,g_helperManager.indexToHelper[i].experienceSowingMachine,g_helperManager.indexToHelper[i].learnedSowingMachine,g_helperManager.indexToHelper[i].experiencePlough,g_helperManager.indexToHelper[i].learnedPlough,g_helperManager.indexToHelper[i].experienceOther,g_helperManager.indexToHelper[i].learnedOther,g_helperManager.indexToHelper[i].isLearning,g_helperManager.indexToHelper[i].isLearnSpec, g_helperManager.indexToHelper[i].isHired, i, g_helperManager.indexToHelper[i].checkValue, g_helperManager.indexToHelper[i].isEmployed, g_helperManager.indexToHelper[i].lastVehicle, Utils.getNoNil(g_helperManager.indexToHelper[i].lastVehicleAiStarted,false), g_helperManager.indexToHelper[i].costs, g_helperManager.indexToHelper[i].ownerFarmId, g_helperManager.indexToHelper[i].autoEmployed))
			end
		end
	end
	if g_helperManager.showHelperSelectionScreen == true and self.showHelperSelectionScreen == false then
		if g_gui.currentGui == nil then
			if g_helperManager.vehicleToSet ~= nil then
				local storeItem = g_storeManager:getItemByXMLFilename(g_helperManager.vehicleToSet.configFileName)
				if storeItem ~= nil then
					self.currentVehicleName = storeItem.name
					if g_brandManager:getBrandByIndex(storeItem.brandIndex) ~= "" then
						self.currentVehicleName = g_brandManager:getBrandByIndex(storeItem.brandIndex).title .. " " .. self.currentVehicleName
					end
					self.currentVehicleName = string.upper(self.currentVehicleName)
				end
			end
			g_gui.currentGui = self
			g_currentMission.isPlayerFrozen = true
			g_inputBinding:setShowMouseCursor(true)
			self.showHelperSelectionScreen = true
		end
	end
end

function HelperAdvanced:activateHelperWorks(helper, vehicle)
	local used = 0
	if vehicle ~= nil and helper ~= nil then
		helper.workedWithOther = false
		if (SpecializationUtil.hasSpecialization(Combine, vehicle.specializations) or SpecializationUtil.hasSpecialization(FruitPreparer, vehicle.specializations)) and vehicle.getIsTurnedOn ~= nil and vehicle:getIsTurnedOn() then
			helper.workedWithCombine = true
			used = used + 1
		end
		if (SpecializationUtil.hasSpecialization(Baler, vehicle.specializations) or SpecializationUtil.hasSpecialization(ForageWagon, vehicle.specializations)) and vehicle.getIsTurnedOn ~= nil and vehicle:getIsTurnedOn() then
			helper.workedWithBaler = true
			used = used + 1
		end
		if (SpecializationUtil.hasSpecialization(ManureBarrel, vehicle.specializations) or SpecializationUtil.hasSpecialization(Sprayer, vehicle.specializations)) and vehicle.getIsTurnedOn ~= nil and vehicle:getIsTurnedOn() then
			helper.workedWithSprayer = true
			used = used + 1
		end
		if (SpecializationUtil.hasSpecialization(Weeder, vehicle.specializations) or SpecializationUtil.hasSpecialization(Mower, vehicle.specializations)) and vehicle.getIsTurnedOn ~= nil and vehicle:getIsTurnedOn() then
			helper.workedWithMower = true
			used = used + 1
		end
		if vehicle.spec_attacherJoints ~= nil and vehicle.spec_attacherJoints.attachedImplements ~= nil then
			for _,implement in pairs(vehicle.spec_attacherJoints.attachedImplements) do
				if implement.object ~= nil then
					if (SpecializationUtil.hasSpecialization(Combine, implement.object.specializations) or SpecializationUtil.hasSpecialization(FruitPreparer, implement.object.specializations)) and implement.object.getIsTurnedOn ~= nil and implement.object:getIsTurnedOn() then
						helper.workedWithCombine = true
						used = used + 1
					end
					if (SpecializationUtil.hasSpecialization(Baler, implement.object.specializations) or SpecializationUtil.hasSpecialization(ForageWagon, implement.object.specializations)) and implement.object.getIsTurnedOn ~= nil and implement.object:getIsTurnedOn() then
						helper.workedWithBaler = true
						used = used + 1
					end
					if SpecializationUtil.hasSpecialization(Cultivator, implement.object.specializations) and implement.object.getIsLowered ~= nil and implement.object:getIsLowered() then
						helper.workedWithCultivator = true
						used = used + 1
					end
					if (SpecializationUtil.hasSpecialization(ManureBarrel, implement.object.specializations) or SpecializationUtil.hasSpecialization(Sprayer, implement.object.specializations)) and implement.object.getIsTurnedOn ~= nil and implement.object:getIsTurnedOn() then
						helper.workedWithSprayer = true
						used = used + 1
					end
					if (SpecializationUtil.hasSpecialization(Weeder, implement.object.specializations) or SpecializationUtil.hasSpecialization(Mower, implement.object.specializations)) and implement.object.getIsTurnedOn ~= nil and implement.object:getIsTurnedOn() then
						helper.workedWithMower = true
						used = used + 1
					end
					if SpecializationUtil.hasSpecialization(SowingMachine, implement.object.specializations) and implement.object.getIsTurnedOn ~= nil and implement.object:getIsTurnedOn() then
						helper.workedWithSowingMachine = true
						used = used + 1
					end
					if SpecializationUtil.hasSpecialization(Plow, implement.object.specializations) and implement.object.getIsLowered ~= nil and implement.object:getIsLowered() then
						helper.workedWithPlough = true
						used = used + 1
					end
				end
			end
		end
	end
	if helper ~= nil then
		if used < 1 then
			helper.workedWithOther = true
		end
	end
end

function HelperAdvanced:deactivateHud(isCancel)
	self.showHelperSelectionScreen = false
	self.editCurrentSelection = 0
	self.buttonEduSelected = 0
	g_gui.currentGui = nil
	g_helperManager.showHelperSelectionScreen = false
	g_currentMission.isPlayerFrozen = false
	g_inputBinding:setShowMouseCursor(false)
	self.currentVehicleName = " "
	self.onlyShowNoSelection = false
	if isCancel ~= nil and isCancel == true then
		return
	end
	for i=1, table.getn(g_helperManager.indexToHelper) do
		if g_helperManager.indexToHelper[i].isHudSelected == true then
			g_helperManager.newSelectedHelperId = i
		end
		g_helperManager.indexToHelper[i].isHudSelected = false
		g_helperManager.indexToHelper[i].hudHover = false
		g_helperManager.indexToHelper[i].editMode = false
		g_helperManager.indexToHelper[i].hudYPos = -1
	end
	if g_helperManager.newSelectedHelperId == nil or (g_helperManager.newSelectedHelperId ~= nil and g_helperManager.newSelectedHelperId < 1) then
		if g_helperManager.requiredHelperId == nil or (g_helperManager.requiredHelperId ~= nil and g_helperManager.requiredHelperId < 1) then
			if #g_helperManager.availableHelpers > 0 then
				g_helperManager.newSelectedHelperId = g_helperManager.availableHelpers[math.random(1, #g_helperManager.availableHelpers)].index
			end
		else
			if g_helperManager.indexToHelper[g_helperManager.requiredHelperId].isHired == true or g_helperManager.indexToHelper[g_helperManager.requiredHelperId].isEmployed == false then
				if #g_helperManager.availableHelpers > 0 then
					g_helperManager.newSelectedHelperId = g_helperManager.availableHelpers[math.random(1, #g_helperManager.availableHelpers)].index
				end
			else
				g_helperManager.newSelectedHelperId = g_helperManager.requiredHelperId
			end
		end
	else
		if g_helperManager.indexToHelper[g_helperManager.newSelectedHelperId].isHired == true or g_helperManager.indexToHelper[g_helperManager.newSelectedHelperId].isEmployed == false then
			g_helperManager.newSelectedHelperId = nil
			if g_helperManager.requiredHelperId == nil or (g_helperManager.requiredHelperId ~= nil and g_helperManager.requiredHelperId < 1) then
				if #g_helperManager.availableHelpers > 0 then
					g_helperManager.newSelectedHelperId = g_helperManager.availableHelpers[math.random(1, #g_helperManager.availableHelpers)].index
				end
			else
				if g_helperManager.indexToHelper[g_helperManager.requiredHelperId].isHired == true or g_helperManager.indexToHelper[g_helperManager.requiredHelperId].isEmployed == false then
					if #g_helperManager.availableHelpers > 0 then
						g_helperManager.newSelectedHelperId = g_helperManager.availableHelpers[math.random(1, #g_helperManager.availableHelpers)].index
					end
				else
					g_helperManager.newSelectedHelperId = g_helperManager.requiredHelperId
				end
			end
		end
	end
	g_helperManager.requiredHelperId = nil
	if g_helperManager.vehicleToSet ~= nil and g_helperManager.newSelectedHelperId ~= nil then
		HelperAdvanced:activateHelperWorks(g_helperManager.indexToHelper[g_helperManager.newSelectedHelperId], g_helperManager.vehicleToSet)
		g_helperManager.indexToHelper[g_helperManager.newSelectedHelperId].lastVehicle = g_helperManager.vehicleToSet
		g_helperManager.vehicleToSet:startAIVehicle(g_helperManager.newSelectedHelperId,g_helperManager.vehicleToSetEvent,g_helperManager.indexToHelper[g_helperManager.newSelectedHelperId].ownerFarmId)
		g_helperManager.newSelectedHelperId = nil
	else
		if g_helperManager.vehicleToSet ~= nil then
			g_helperManager.showNoHelperAvailable = true
		end
	end
end

function HelperAdvanced:hireHelper(helper,hired,learning,spec,farmId,autoEmployed,noEventSend)
	hired = Utils.getNoNil(hired,false)
	learning = Utils.getNoNil(learning,0)
	spec = Utils.getNoNil(spec,0)
	if helper ~= nil and helper > 0 then
		local adding = true
		g_helperManager.indexToHelper[helper].isEmployed = hired
		g_helperManager.indexToHelper[helper].ownerFarmId = farmId
		if HelperAdvanced.employedHelpers ~= nil then
			for k, h in pairs(HelperAdvanced.employedHelpers) do
				if h ~= nil and h.index == helper then
					if h.autoEmployed == false and autoEmployed == true and hired == false then
						hired = true
					end
					if hired == false then
						h.autoEmployed = false
						table.remove(HelperAdvanced.employedHelpers, k)
					else
						adding = false
					end
					break
				end
			end
			for k, h in pairs(g_helperManager.availableHelpers) do
				if h ~= nil and h.index == helper then
					if hired == false then
						table.remove(g_helperManager.availableHelpers, k)
					end
					break
				end
			end
		else
			HelperAdvanced.employedHelpers = {}
		end
		if adding == true and hired == true then
			table.insert(HelperAdvanced.employedHelpers,g_helperManager.indexToHelper[helper])
			table.insert(g_helperManager.availableHelpers, g_helperManager.indexToHelper[helper])
			if autoEmployed ~= nil then
				g_helperManager.indexToHelper[helper].autoEmployed = autoEmployed
			end
		else
			if hired == false then
				g_helperManager.indexToHelper[helper].autoEmployed = false
				autoEmployed = false
			end
		end
		if g_helperManager.indexToHelper[helper].isLearning <= 0 and learning > 0 and spec > 0 then
			g_helperManager.indexToHelper[helper].isLearning = learning
			g_helperManager.indexToHelper[helper].isLearnSpec = spec
			g_helperManager.useHelper(g_helperManager.indexToHelper[helper])
		else
			learning = g_helperManager.indexToHelper[helper].isLearning
			spec = g_helperManager.indexToHelper[helper].isLearnSpec
			if learning > 0 then
				g_helperManager.useHelper(g_helperManager.indexToHelper[helper])
			end
		end
		if noEventSend == nil or noEventSend == false then
			if g_server ~= nil then
				g_server:broadcastEvent(HelperAdvancedHireHelper:new(helper, hired, learning, spec, farmId, autoEmployed))
			else
				g_client:getServerConnection():sendEvent(HelperAdvancedHireHelper:new(helper, hired, learning, spec, farmId, autoEmployed))
			end
		end
	end
end

function HelperAdvanced:isUserFarmManager(user)
	if user == nil or user == 0 then return false end
	for x,farm in pairs(g_farmManager.farms) do
		if farm:isUserFarmManager(user) then
			return true
		end
	end
	return false
end

function HelperAdvanced:mouseEvent(posX, posY, isDown, isUp, button)
	if self.showHelperSelectionScreen == true then
		self.mX = posX
		self.mY = posY
		self.buttonHover = false
		self.buttonCancelHover = false
		local isMaster = (g_currentMission.missionDynamicInfo.isMultiplayer and (g_currentMission.isMasterUser or g_currentMission.player.isServer or HelperAdvanced:isUserFarmManager(g_currentMission.playerUserId))) or g_currentMission.missionDynamicInfo.isMultiplayer == false
		local canHire = g_currentMission.missionDynamicInfo.isMultiplayer == false or g_currentMission:getHasPlayerPermission("hireAssistant")
		if posY > 0.842 and posY < 0.89 then
			if posX > 0.805 and posX < 0.829 then
				if isDown then
					if self.helperMenuPage ~= 1 then
						self.editCurrentSelection = 0
					end
					self.helperMenuPage = 1
				end
			end
			if posX > 0.829 and posX < 0.853 then
				if isDown then
					self.editCurrentSelection = 0
					self.helperMenuPage = 2
				end
			end
			if posX > 0.853 and posX < 0.878 then
				if isDown then
					self.editCurrentSelection = 0
					self.helperMenuPage = 3
				end
			end
		end
		if posY > 0.104 and posY < 0.152 then
			if posX > 0.122 and posX < 0.262 then
				self.buttonCancelHover = true
				if isDown then
					self:deactivateHud(true)
				end
			end
			if posX > 0.591 and posX < 0.591+0.026 then
				if isDown then
					self:loadConfig("huds/BlueBlueTablet/HelperAdvancedMenu.xml")
				end
			end
			if posX > 0.565 and posX < 0.565+0.026 then
				if isDown then
					self:loadConfig("huds/BlueDarkTablet/HelperAdvancedMenu.xml")
				end
			end
			if posX > 0.539 and posX < 0.539+0.026 then
				if isDown then
					self:loadConfig("huds/DarkTablet/HelperAdvancedMenu.xml")
				end
			end
			if posX > 0.513 and posX < 0.513+0.026 then
				if isDown then
					self:loadConfig("huds/NewBlueTablet/HelperAdvancedMenu.xml")
				end
			end
			if posX > 0.487 and posX < 0.487+0.026 then
				if isDown then
					self:loadConfig("huds/RedTablet/HelperAdvancedMenu.xml")
				end
			end
			if posX > 0.461 and posX < 0.461+0.026 then
				if isDown then
					self:loadConfig("huds/WhiteBlueTablet/HelperAdvancedMenu.xml")
				end
			end
			if posX > 0.435 and posX < 0.435+0.026 then
				if isDown then
					self:loadConfig("huds/WhiteDarkTablet/HelperAdvancedMenu.xml")
				end
			end
			if posX > 0.409 and posX < 0.409+0.026 then
				if isDown then
					self:loadConfig()
				end
			end
		end
		if self.onlyShowNoSelection == false and canHire then
			if posX > 0.738 and posX < 0.878 and posY > 0.1035 and posY < 0.152 then
				self.buttonHover = true
				if isDown then
					self:deactivateHud()
				end
			end
		end
		local isHovering = false
		if posX > 0.123 and posX < 0.878 and posY > self.lastEntryY and posY < 0.84 then
			for i=1, table.getn(g_helperManager.indexToHelper) do
				local pYT, pYB = g_helperManager.indexToHelper[i].hudYPos+(HelperAdvanced.tSize*0.9), g_helperManager.indexToHelper[i].hudYPos
				if posY > pYB and posY < pYT then
					if g_helperManager.indexToHelper[i].isHired == false and canHire then
						if isDown then
							if self.onlyShowNoSelection == false then
								g_helperManager.indexToHelper[i].isHudSelected = true
								self.hudCurrentSelection = i
							end
							if isMaster then
								if g_helperManager.indexToHelper[i].isEmployed == false then
									local maxX = 0.807+(HelperAdvanced.tSize*0.9*5*0.75)
									if posX > 0.807 and posX < maxX then
										g_helperManager.indexToHelper[i].isEmployed = true
										g_helperManager.indexToHelper[i].checkValue = 0
										self:hireHelper(i,true,g_helperManager.indexToHelper[i].isLearning,g_helperManager.indexToHelper[i].isLearnSpec,g_currentMission.player.farmId,false)
									end
								else
									g_helperManager.indexToHelper[i].editMode = true
									self.editCurrentSelection = i
									if g_helperManager.indexToHelper[i].checkValue >= (HelperAdvanced.daysUntilDischarge*24*60) then
										local maxX = 0.807+(HelperAdvanced.tSize*0.9*5*0.75)
										if posX > 0.807 and posX < maxX then
											g_helperManager.indexToHelper[i].isEmployed = false
											self:hireHelper(i,false,g_helperManager.indexToHelper[i].isLearning,g_helperManager.indexToHelper[i].isLearnSpec,0,false)
											g_helperManager.indexToHelper[i].editMode = false
											self.editCurrentSelection = 0
										end
									end
								end
							end
						end
						if button == 3 and isUp then
							if isMaster then
								self.enterNameField = true
								self.enterNameHelper = i
								self.newName = g_helperManager.indexToHelper[i].nameShow
								g_inputBinding:setShowMouseCursor(false)
							end
						end
					end
					g_helperManager.indexToHelper[i].hudHover = true
					isHovering = true
					if self.editCurrentSelection > 0 and i ~= self.editCurrentSelection then
						g_helperManager.indexToHelper[self.editCurrentSelection].hudHover = false
					end
				else
					if i ~= self.editCurrentSelection then
						g_helperManager.indexToHelper[i].hudHover = false
					end
				end
			end
			for i=1, table.getn(g_helperManager.indexToHelper) do
				if g_helperManager.indexToHelper[i].isHudSelected == true and i ~= self.hudCurrentSelection then
					g_helperManager.indexToHelper[i].isHudSelected = false
				end
				if g_helperManager.indexToHelper[i].editMode == true and i ~= self.editCurrentSelection then
					g_helperManager.indexToHelper[i].editMode = false
					g_helperManager.indexToHelper[i].hudHover = false
				end
			end
		end
		if not isHovering then
			for i=1, table.getn(g_helperManager.indexToHelper) do
				if g_helperManager.indexToHelper[i].editMode == true and i == self.editCurrentSelection then
					g_helperManager.indexToHelper[i].hudHover = true
					self.buttonTime1Hover = false
					self.buttonTime2Hover = false
					self.buttonTime3Hover = false
					self.buttonEdu1Hover = false
					self.buttonEdu2Hover = false
					self.buttonEdu3Hover = false
					self.buttonEdu4Hover = false
					if self.buttonEduSelected > 0 then
						if posX > 0.815 and posX < 0.875 then
							local eduTime = 0
							if posY > self.lastEntryY-((HelperAdvanced.tSize*1.55)*6.09) and posY < (self.lastEntryY-((HelperAdvanced.tSize*1.55)*6.09) + (HelperAdvanced.tSize * 1.9)) then
								self.buttonTime1Hover = true
								eduTime = 1440
							elseif posY > self.lastEntryY-((HelperAdvanced.tSize*1.55)*7.42) and posY < (self.lastEntryY-((HelperAdvanced.tSize*1.55)*7.42) + (HelperAdvanced.tSize * 1.9)) then
								self.buttonTime2Hover = true
								eduTime = 2880
							elseif posY > self.lastEntryY-((HelperAdvanced.tSize*1.55)*8.75) and posY < (self.lastEntryY-((HelperAdvanced.tSize*1.55)*8.75) + (HelperAdvanced.tSize * 1.9)) then
								self.buttonTime3Hover = true
								eduTime = 4320
							end
							if isDown then
								self:hireHelper(i,g_helperManager.indexToHelper[i].isEmployed,eduTime,self.buttonEduSelected,g_currentMission.player.farmId,false)
								self.buttonEduSelected = 0
							end
						end
					end
					if posX > 0.122 and posX < 0.267 then
						if posY > self.lastEntryY-((HelperAdvanced.tSize*1.55)*5.75) and posY < (self.lastEntryY-((HelperAdvanced.tSize*1.55)*5.75) + (HelperAdvanced.tSize * 1.5)) then
							self.buttonEdu1Hover = true
							if isDown then
								self.buttonEduSelected = 4
							end
						elseif posY > self.lastEntryY-((HelperAdvanced.tSize*1.55)*6.75) and posY < (self.lastEntryY-((HelperAdvanced.tSize*1.55)*6.75) + (HelperAdvanced.tSize * 1.5)) then
							self.buttonEdu2Hover = true
							if isDown then
								self.buttonEduSelected = 1
							end
						elseif posY > self.lastEntryY-((HelperAdvanced.tSize*1.55)*7.75) and posY < (self.lastEntryY-((HelperAdvanced.tSize*1.55)*7.75) + (HelperAdvanced.tSize * 1.5)) then
							self.buttonEdu3Hover = true
							if isDown then
								self.buttonEduSelected = 2
							end
						elseif posY > self.lastEntryY-((HelperAdvanced.tSize*1.55)*8.75) and posY < (self.lastEntryY-((HelperAdvanced.tSize*1.55)*8.75) + (HelperAdvanced.tSize * 1.5)) then
							self.buttonEdu4Hover = true
							if isDown then
								self.buttonEduSelected = 3
							end
						end
					end
				end
			end
		end
	end
end

function HelperAdvanced:keyEvent(unicode, sym, modifier, isDown)
	if self.showHelperSelectionScreen ~= true then
		return
	end
	local canHire = g_currentMission.missionDynamicInfo.isMultiplayer == false or g_currentMission:getHasPlayerPermission("hireAssistant")
	if self.enterNameField and isDown then
		if sym == 13 and utf8Strlen(self.newName) >= 3 then
			g_inputBinding:setShowMouseCursor(true)
			g_helperManager.indexToHelper[self.enterNameHelper].nameShow = self.newName
			g_client:getServerConnection():sendEvent(HelperSetNameEvent:new(self.newName, self.enterNameHelper))
			self.enterNameField = false
			self.enterNameHelper = 0
			self.newName = ""
		elseif sym == 127 then
			self.newName = ""
		elseif sym == 27 then
			g_inputBinding:setShowMouseCursor(true)
			self.enterNameField = false
			self.enterNameHelper = 0
			self.newName = ""
		end
		if utf8Strlen(self.newName) < 20 then
			if unicode > 0 and unicode ~= 34 and unicode ~= 39 and unicode ~= 94 and unicode ~= 167 and unicode ~= 176 and unicode ~= 180 then
				if g_i18n:hasText("ui_Char"..unicode) then
					self.newName = self.newName..g_i18n:getText("ui_Char"..unicode)
				else
					self.newName = self.newName..string.char(unicode)
				end
			end
		end
		if sym == 8 then
			self.newName = string.sub(self.newName,1,utf8Strlen(self.newName)-1)
		end
	elseif isDown then
		if sym == 13 then
			if canHire then
				self:deactivateHud()
			else
				self:deactivateHud(true)
			end
		elseif sym == 27 then
			self:deactivateHud(true)
		end
	end
end

function HelperAdvanced:draw()
	if g_dedicatedServerInfo ~= nil then
		return
	end
	if g_helperManager.showNoHelperAvailable then
		if table.getn(HelperAdvanced.employedHelpers) > 0 then
			g_currentMission:showBlinkingWarning(g_i18n:getText("warning_notEnoughFreeHelper"),4000)
		else
			g_currentMission:showBlinkingWarning(g_i18n:getText("warning_noEmployees"),4000)
		end
		g_helperManager.showNoHelperAvailable = false
	end
	if g_helperManager.showFollowMeHasEmployed == true then
		g_currentMission:showBlinkingWarning(g_i18n:getText("warning_followmeAutoEmploy"),4000)
		g_helperManager.showFollowMeHasEmployed = false
	end
	if g_helperManager.showAutoDriveHasEmployed == true then
		g_currentMission:showBlinkingWarning(g_i18n:getText("warning_autodriveAutoEmploy"),4000)
		g_helperManager.showAutoDriveHasEmployed = false
	end
	if g_helperManager.showCourseplayHasEmployed == true then
		g_currentMission:showBlinkingWarning(g_i18n:getText("warning_courseplayAutoEmploy"),4000)
		g_helperManager.showCourseplayHasEmployed = false
	end
	if self.showHelperSelectionScreen == true then
		local isMaster = (g_currentMission.missionDynamicInfo.isMultiplayer and (g_currentMission.isMasterUser or g_currentMission.player.isServer or HelperAdvanced:isUserFarmManager(g_currentMission.playerUserId))) or g_currentMission.missionDynamicInfo.isMultiplayer == false
		setTextAlignment(RenderText.ALIGN_LEFT) setTextColor(1,1,1,1)
		renderOverlay(self.helperSelectionHud, 0.05, 0.05, 0.9, 0.9)
		
		local tSize = HelperAdvanced.tSize
		if self.enterNameField then
			setTextColor(self.hudColorEntrys.r,self.hudColorEntrys.g,self.hudColorEntrys.b,1)
			setTextAlignment(RenderText.ALIGN_CENTER)
			renderOverlay(self.helperSelectionButtonHover, 0.35, 0.3, 0.3, 0.002)
			renderOverlay(self.helperSelectionButtonHover, 0.35, 0.3, 0.002, 0.4)
			renderOverlay(self.helperSelectionButtonHover, 0.65, 0.3, 0.002, 0.4)
			renderOverlay(self.helperSelectionButtonHover, 0.35, 0.7, 0.3, 0.002)
			renderText(0.5, 0.7-tSize*1.6, tSize*1.6, g_i18n:getText("ui_helperNameNew"))
			setTextColor(self.hudColorEntrysNote.r,self.hudColorEntrysNote.g,self.hudColorEntrysNote.b,1)
			renderText(0.5, 0.7-((tSize*1.6)*3), tSize*1.5, g_helperManager.indexToHelper[self.enterNameHelper].nameShow)
			renderOverlay(self.helperSelectionButton, 0.36, 0.7-((tSize*1.6)*5)-0.004, 0.28, (tSize*1.6)+0.004)
			setTextColor(self.hudColorMenu.r,self.hudColorMenu.g,self.hudColorMenu.b,1)
			renderText(0.5, 0.7-((tSize*1.6)*5), tSize*1.5, self.newName)
			setTextAlignment(RenderText.ALIGN_LEFT)
			setTextColor(self.hudColorEntrysNote.r,self.hudColorEntrysNote.g,self.hudColorEntrysNote.b,1)
			renderText(0.358, 0.3+(tSize*0.5), tSize, g_i18n:getText("ui_helperNameNewOK"))
			renderText(0.358, 0.3+(tSize*0.5)+(tSize*1.2), tSize, g_i18n:getText("ui_helperNameNewESC"))
			renderText(0.358, 0.3+(tSize*0.5)+((tSize*1.2)*2), tSize, g_i18n:getText("ui_helperNameNewDEL"))
			renderText(0.358, 0.3+(tSize*0.5)+((tSize*1.2)*6), tSize, g_i18n:getText("ui_helperNameNewNOTE"))
		else
			if self.onlyShowNoSelection == false and self.helperMenuPage == 1 then
				if self.buttonHover == true then
					renderOverlay(self.helperSelectionButtonHover, 0.738, 0.1035, 0.14, 0.0485)
				else
					renderOverlay(self.helperSelectionButton, 0.738, 0.1035, 0.14, 0.0485)
				end
			end
			if self.buttonCancelHover == true then
				renderOverlay(self.helperSelectionButtonHover, 0.122, 0.1035, 0.14, 0.0485)
			else
				renderOverlay(self.helperSelectionButton, 0.122, 0.1035, 0.14, 0.0485)
			end
			local posX = 0.123
			local posY = 0.823
			setTextBold(true)
			setTextColor(self.hudColorMenu.r,self.hudColorMenu.g,self.hudColorMenu.b,1)
			setTextAlignment(RenderText.ALIGN_LEFT)
			if self.helperMenuPage == 1 then
				renderText(posX, 0.855, tSize*1.75, g_i18n:getText("ui_helperS"))
			elseif self.helperMenuPage == 2 then
				renderText(posX, 0.855, tSize*1.75, g_i18n:getText("ui_helperE"))
			else
				renderText(posX, 0.855, tSize*1.75, g_i18n:getText("ui_helperO"))
			end
			setTextAlignment(RenderText.ALIGN_CENTER)
			local hr = g_currentMission.environment.currentHour
			local min = g_currentMission.environment.currentMinute
			if hr < 10 then
				hr = "0"..hr
			end
			if min < 10 then
				min = "0"..min
			end
			local day = math.fmod(g_currentMission.environment.currentDay - 1, 7) + 1
			renderText(0.5, 0.855, tSize*1.75, g_i18n:getText("ui_day"..tostring(day)).." "..tostring(hr)..":"..tostring(min))
			renderOverlay(self.helperSelectionButton,(0.591),0.104,0.026, 0.048)
			renderOverlay(self.helperSelectionButtonHover,(0.565),0.104,0.026, 0.048)
			renderOverlay(self.helperSelectionButton,(0.539),0.104,0.026, 0.048)
			renderOverlay(self.helperSelectionButtonHover,(0.513),0.104,0.026, 0.048)
			renderOverlay(self.helperSelectionButton,(0.487),0.104,0.026, 0.048)
			renderOverlay(self.helperSelectionButtonHover,(0.461),0.104,0.026, 0.048)
			renderOverlay(self.helperSelectionButton,(0.435),0.104,0.026, 0.048)
			renderOverlay(self.helperSelectionButtonHover,(0.409),0.104,0.026, 0.048)
			setTextColor(self.hudColorEntrysNote.r,self.hudColorEntrysNote.g,self.hudColorEntrysNote.b,1)
			renderText(0.591+0.013, 0.120, tSize*1.1, "D7")
			renderText(0.565+0.013, 0.120, tSize*1.1, "D6")
			renderText(0.539+0.013, 0.120, tSize*1.1, "D5")
			renderText(0.513+0.013, 0.120, tSize*1.1, "D4")
			renderText(0.487+0.013, 0.120, tSize*1.1, "D3")
			renderText(0.461+0.013, 0.120, tSize*1.1, "D2")
			renderText(0.435+0.013, 0.120, tSize*1.1, "D1")
			renderText(0.409+0.013, 0.120, tSize*1.1, "P")
			setTextColor(self.hudColorMenu.r,self.hudColorMenu.g,self.hudColorMenu.b,1)
			if self.onlyShowNoSelection == false and self.helperMenuPage == 1 then
				renderText(0.808, 0.123, tSize*1.5, g_i18n:getText("ui_helperButtonOk"))
			end
			renderText(0.192, 0.123, tSize*1.5, g_i18n:getText("ui_helperButtonCancel"))
			if self.onlyShowNoSelection == false and self.helperMenuPage == 1 then
				setTextAlignment(RenderText.ALIGN_RIGHT)
				renderText(0.780, 0.855, tSize*1.5, string.format(g_i18n:getText("ui_forVehicle"),self.currentVehicleName))
			end
			if self.helperMenuPage < 3 then
				setTextColor(self.hudColorEntrys.r,self.hudColorEntrys.g,self.hudColorEntrys.b,1)
				setTextAlignment(RenderText.ALIGN_LEFT)
				renderText(posX, posY-0.001, tSize, "__________________________________________________________________________________________________________________________________________________________________________________________________________________")
				tSize = HelperAdvanced.tSize*0.9
				renderText(posX+0.021, posY, tSize, g_i18n:getText("ui_helperName"))
				renderText(posX+0.086, posY, tSize, g_i18n:getText("ui_experienceTitle"))
				renderText(posX+0.1315, posY, tSize, g_i18n:getText("ui_workMoneyTitle"))
				renderText(posX+0.174, posY, tSize, g_i18n:getText("ui_plough"))
				renderText(posX+0.220, posY, tSize, g_i18n:getText("ui_cultivator"))
				renderText(posX+0.275, posY, tSize, g_i18n:getText("ui_sprayer"))
				renderText(posX+0.330, posY, tSize, g_i18n:getText("ui_sowing"))
				renderText(posX+0.385, posY, tSize, g_i18n:getText("ui_combine"))
				renderText(posX+0.440, posY, tSize, g_i18n:getText("ui_bale"))
				renderText(posX+0.495, posY, tSize, g_i18n:getText("ui_mowing"))
				renderText(posX+0.550, posY, tSize, g_i18n:getText("ui_otherWork"))
				renderText(posX+0.595, posY, tSize - 0.0015, g_i18n:getText("ui_workTitle"))
			end
			self.lastEntryY = posY - ((table.getn(g_helperManager.indexToHelper)+2) * tSize * 1.35)
			local offset = 0
			local oaCosts = 0
			local caCosts = 0
			local cbCosts = 0
			local cBExp = 0
			local cWExp = 0
			local cEmploy = 0
			for i=1, table.getn(g_helperManager.indexToHelper) do
				setTextAlignment(RenderText.ALIGN_LEFT)
				local canShow = true
				local tPos = i - offset
				local curHelp = g_helperManager.indexToHelper[i]
				local hired, pText = HelperAdvanced:getIsHiredText(i)
				curHelp.hudYPos = posY-(tPos*tSize*1.35) - 0.0025
				setTextColor(self.hudColorEntrys.r,self.hudColorEntrys.g,self.hudColorEntrys.b,1)
				if curHelp.hudHover == true then
					renderOverlay(self.helperSelectionButtonHover, posX, curHelp.hudYPos-(tSize*0.175), 0.754, tSize*1.35)
					setTextColor(self.hudColorMenu.r,self.hudColorMenu.g,self.hudColorMenu.b,1)
				end
				if (curHelp.isEmployed == false or curHelp.ownerFarmId == 0) or (curHelp.isEmployed == true and curHelp.ownerFarmId ~= g_currentMission.player.farmId) then
					if self.helperMenuPage == 1 or self.helperMenuPage == 3 then
						canShow = false
						offset = offset + 1
					end
					if canShow then
						setTextAlignment(RenderText.ALIGN_CENTER)
						if isMaster and curHelp.isEmployed == false then
							setTextColor(self.hudColorMenu.r,self.hudColorMenu.g,self.hudColorMenu.b,1)
							renderOverlay(self.helperSelectionButton,(posX+0.74)-(tSize*5*0.75),curHelp.hudYPos,tSize*5*0.75, tSize)
							renderText((posX+0.74)-((tSize*5*0.75)/2), posY-(tPos*tSize*1.35), tSize, g_i18n:getText("ui_employ"))
						end
						if curHelp.isEmployed == true and curHelp.ownerFarmId ~= g_currentMission.player.farmId then
							renderText((posX+0.74)-((tSize*5*0.75)/2), posY-(tPos*tSize*1.35), tSize, g_farmManager:getFarmById(curHelp.ownerFarmId).name)
						end
					end
					setTextColor(self.hudColorEntrys.r,self.hudColorEntrys.g,self.hudColorEntrys.b,1)
					setTextAlignment(RenderText.ALIGN_LEFT)
				else
					if self.helperMenuPage == 2 or self.helperMenuPage == 3 then
						canShow = false
						offset = offset + 1
					end
					if canShow then
						if not hired then
							local nextButton = self.helperSelectionButton
							if curHelp.isHudSelected == true then
								renderOverlay(self.helperSelectionButton, posX, curHelp.hudYPos-(tSize*0.175), 0.754, tSize*1.35)
								setTextColor(self.hudColorMenu.r,self.hudColorMenu.g,self.hudColorMenu.b,1)
								nextButton = self.helperSelectionButtonHover
							end
							setTextAlignment(RenderText.ALIGN_CENTER)
							-- renderText((posX+0.74)-((tSize*5*0.75)/2), posY-(tPos*tSize*1.35), tSize, g_farmManager:getFarmById(curHelp.ownerFarmId).name)
							if Utils.getNoNil(curHelp.checkValue,0) >= (HelperAdvanced.daysUntilDischarge*24*60) then
								if isMaster then
									setTextColor(self.hudColorMenu.r,self.hudColorMenu.g,self.hudColorMenu.b,1)
									renderOverlay(nextButton,(posX+0.74)-(tSize*5*0.75),curHelp.hudYPos,tSize*5*0.75, tSize)
									renderText((posX+0.74)-((tSize*5*0.75)/2), posY-(tPos*tSize*1.35), tSize, g_i18n:getText("ui_unemploy"))
								end
							end
							setTextColor(self.hudColorEntrys.r,self.hudColorEntrys.g,self.hudColorEntrys.b,1)
						else
							setTextColor(self.hudColorEntrysOff.r,self.hudColorEntrysOff.g,self.hudColorEntrysOff.b,1)
						end
					end
					setTextAlignment(RenderText.ALIGN_LEFT)
				end
				if canShow then
					renderOverlay(curHelp.iconFilename,posX,posY-(tPos*tSize*1.35),tSize*0.75, tSize*0.75)
					renderText(posX+0.021, posY-(tPos*tSize*1.35), tSize, curHelp.nameShow)
					renderText(posX+0.086, posY-(tPos*tSize*1.35), tSize, string.format(g_i18n:getText("ui_experienceText"),math.floor(curHelp.experiencePercent)))
					local price = HelperAdvanced.maxPricePerHour - HelperAdvanced.basePricePerHour
					priceStd = (HelperAdvanced.basePricePerHour + (price * (curHelp.experience - curHelp.learnedExperience))) * HelperAdvanced.workPrices["base"]
					local hour = g_currentMission.environment.currentHour
					local weekDay = math.fmod(g_currentMission.environment.currentDay - 1, 7) + 1
					if hour < 6 or hour >= 20 or weekDay > 5 then
						price = HelperAdvanced.overtimePricePerHour - HelperAdvanced.basePricePerHour
					end
					if self.onlyShowNoSelection == false then
						if g_helperManager.requiredHelperId ~= nil and g_helperManager.requiredHelperId == i and curHelp.isEmployed == true then
							setTextColor(self.hudColorEntrysOff.r,self.hudColorEntrysOff.g,self.hudColorEntrysOff.b,1)
							renderText(posX+0.595, posY-(tPos*tSize*1.35), tSize, pText.." "..g_i18n:getText("ui_lastWorker"))
						end
					end
					setTextColor(self.hudColorEntrys.r,self.hudColorEntrys.g,self.hudColorEntrys.b,1)
					if curHelp.isHired == true then
						setTextColor(self.hudColorEntrysNote.r,self.hudColorEntrysNote.g,self.hudColorEntrysNote.b,1)
					end
					renderText(posX+0.595, posY-(tPos*tSize*1.35), tSize, pText)
					setTextColor(self.hudColorEntrys.r,self.hudColorEntrys.g,self.hudColorEntrys.b,1)
					setTextAlignment(RenderText.ALIGN_RIGHT)
					renderText(posX+0.1515, posY-(tPos*tSize*1.35), tSize, string.format(g_i18n:getText("ui_workMoneyText"),priceStd))
					renderText(posX+0.194, posY-(tPos*tSize*1.35), tSize, string.format(g_i18n:getText("ui_expPrice"),curHelp.percentPlough))
					renderText(posX+0.240, posY-(tPos*tSize*1.35), tSize, string.format(g_i18n:getText("ui_expPrice"),curHelp.percentCultivator))
					renderText(posX+0.295, posY-(tPos*tSize*1.35), tSize, string.format(g_i18n:getText("ui_expPrice"),curHelp.percentSprayer))
					renderText(posX+0.350, posY-(tPos*tSize*1.35), tSize, string.format(g_i18n:getText("ui_expPrice"),curHelp.percentSowingMachine))
					renderText(posX+0.405, posY-(tPos*tSize*1.35), tSize, string.format(g_i18n:getText("ui_expPrice"),curHelp.percentCombine))
					renderText(posX+0.460, posY-(tPos*tSize*1.35), tSize, string.format(g_i18n:getText("ui_expPrice"),curHelp.percentBaler))
					renderText(posX+0.515, posY-(tPos*tSize*1.35), tSize, string.format(g_i18n:getText("ui_expPrice"),curHelp.percentMower))
					renderText(posX+0.570, posY-(tPos*tSize*1.35), tSize, string.format(g_i18n:getText("ui_expPrice"),curHelp.percentOther))
					setTextAlignment(RenderText.ALIGN_LEFT)
					if curHelp.hudHover == true then
						setTextAlignment(RenderText.ALIGN_LEFT)
						renderText(posX, self.lastEntryY, tSize*1.1, g_i18n:getText("ui_helperNameDesc"))
						renderText(posX, self.lastEntryY-(tSize*1.4), tSize*1.1, g_i18n:getText("ui_helperExperience").." (+"..tostring(math.floor((curHelp.experience-curHelp.baseExperience)*1000)/10).." %)")
						renderText(posX, self.lastEntryY-((tSize*1.4)*2), tSize*1.1, g_i18n:getText("ui_helperBasewage"))
						setTextAlignment(RenderText.ALIGN_LEFT)
						if curHelp.isEmployed == true and curHelp.ownerFarmId == g_currentMission.player.farmId then
							local days = math.floor(Utils.getNoNil(curHelp.checkValue,0)/60/24)
							local hours = math.floor((Utils.getNoNil(curHelp.checkValue,0)/60)-(days*24))
							renderText(posX, self.lastEntryY-((tSize*1.4)*3), tSize*1.1, g_i18n:getText("ui_helperEmployed"))
							renderText(posX, self.lastEntryY-((tSize*1.4)*4), tSize*1.1, g_i18n:getText("ui_helperUnEmploy"))
							setTextAlignment(RenderText.ALIGN_RIGHT)
							renderText(posX+0.225, self.lastEntryY-((tSize*1.4)*3), tSize*1.1, string.format(g_i18n:getText("ui_helperEmployedTime"),days,hours))
							local answer = g_i18n:getText("ui_helperUnEmployNo")
							setTextColor(1,0.2,0.2,1)
							if Utils.getNoNil(curHelp.checkValue,0) >= (HelperAdvanced.daysUntilDischarge*24*60) then
								setTextColor(0.2,1,0.2,1)
								answer = g_i18n:getText("ui_helperUnEmployYes")
							end
							renderText(posX+0.225, self.lastEntryY-((tSize*1.4)*4), tSize*1.1, answer)
							setTextAlignment(RenderText.ALIGN_LEFT)
							if curHelp.editMode == true and curHelp.isLearning <= 0 then
								setTextColor(self.hudColorEntrys.r,self.hudColorEntrys.g,self.hudColorEntrys.b,1)
								if self.buttonEduSelected > 0 then
									setTextAlignment(RenderText.ALIGN_CENTER)
									if self.buttonTime1Hover == true then
										renderOverlay(self.helperSelectionButtonHover, 0.815, self.lastEntryY-((tSize*1.55)*6.09), 0.06, tSize*1.9)
									else
										renderOverlay(self.helperSelectionButton, 0.815, self.lastEntryY-((tSize*1.55)*6.09), 0.06, tSize*1.9)
									end
									renderText(0.845, self.lastEntryY-((tSize*1.55)*5.84), tSize*1.25,g_i18n:getText("ui_oneDay"))
									if self.buttonTime2Hover == true then
										renderOverlay(self.helperSelectionButtonHover, 0.815, self.lastEntryY-((tSize*1.55)*7.42), 0.06, tSize*1.9)
									else
										renderOverlay(self.helperSelectionButton, 0.815, self.lastEntryY-((tSize*1.55)*7.42), 0.06, tSize*1.9)
									end
									renderText(0.845, self.lastEntryY-((tSize*1.55)*7.17), tSize*1.25,g_i18n:getText("ui_twoDays"))
									if self.buttonTime3Hover == true then
										renderOverlay(self.helperSelectionButtonHover, 0.815, self.lastEntryY-((tSize*1.55)*8.75), 0.06, tSize*1.9)
									else
										renderOverlay(self.helperSelectionButton, 0.815, self.lastEntryY-((tSize*1.55)*8.75), 0.06, tSize*1.9)
									end
									renderText(0.845, self.lastEntryY-((tSize*1.55)*8.5), tSize*1.25,g_i18n:getText("ui_threeDays"))
								end
								setTextAlignment(RenderText.ALIGN_LEFT)
								if self.buttonEdu1Hover == true or self.buttonEduSelected == 4 then
									renderOverlay(self.helperSelectionButtonHover, posX-0.001, self.lastEntryY-((tSize*1.55)*5.75), 0.14, tSize*1.5)
								else
									renderOverlay(self.helperSelectionButton, posX-0.001, self.lastEntryY-((tSize*1.55)*5.75), 0.14, tSize*1.5)
								end
								renderText(posX+0.005, self.lastEntryY-((tSize*1.55)*5.5), tSize*1.15,g_i18n:getText("ui_eduBasic"))
								if self.buttonEdu2Hover == true or self.buttonEduSelected == 1 then
									renderOverlay(self.helperSelectionButtonHover, posX-0.001, self.lastEntryY-((tSize*1.55)*6.75), 0.14, tSize*1.5)
								else
									renderOverlay(self.helperSelectionButton, posX-0.001, self.lastEntryY-((tSize*1.55)*6.75), 0.14, tSize*1.5)
								end
								renderText(posX+0.005, self.lastEntryY-((tSize*1.55)*6.5), tSize*1.15,g_i18n:getText("ui_eduGround"))
								if self.buttonEdu3Hover == true or self.buttonEduSelected == 2 then
									renderOverlay(self.helperSelectionButtonHover, posX-0.001, self.lastEntryY-((tSize*1.55)*7.75), 0.14, tSize*1.5)
								else
									renderOverlay(self.helperSelectionButton, posX-0.001, self.lastEntryY-((tSize*1.55)*7.75), 0.14, tSize*1.5)
								end
								renderText(posX+0.005, self.lastEntryY-((tSize*1.55)*7.5), tSize*1.15,g_i18n:getText("ui_eduPlants"))
								if self.buttonEdu4Hover == true or self.buttonEduSelected == 3 then
									renderOverlay(self.helperSelectionButtonHover, posX-0.001, self.lastEntryY-((tSize*1.55)*8.75), 0.14, tSize*1.5)
								else
									renderOverlay(self.helperSelectionButton, posX-0.001, self.lastEntryY-((tSize*1.55)*8.75), 0.14, tSize*1.5)
								end
								renderText(posX+0.005, self.lastEntryY-((tSize*1.55)*8.5), tSize*1.15,g_i18n:getText("ui_eduHarvest"))
								setTextBold(false)
								setTextColor(self.hudColorEntrysOff.r,self.hudColorEntrysOff.g,self.hudColorEntrysOff.b,1)
								renderText(posX+0.145, self.lastEntryY-((tSize*1.55)*5.5), tSize*1.15,string.format(g_i18n:getText("ui_eduBasicDesc"),math.floor((HelperAdvanced.eduPrices[4]*(4-g_currentMission.missionInfo.difficulty))*100)/100))
								renderText(posX+0.145, self.lastEntryY-((tSize*1.55)*6.5), tSize*1.15,string.format(g_i18n:getText("ui_eduGroundDesc"),math.floor((HelperAdvanced.eduPrices[1]*(4-g_currentMission.missionInfo.difficulty))*100)/100))
								renderText(posX+0.145, self.lastEntryY-((tSize*1.55)*7.5), tSize*1.15,string.format(g_i18n:getText("ui_eduPlantsDesc"),math.floor((HelperAdvanced.eduPrices[2]*(4-g_currentMission.missionInfo.difficulty))*100)/100))
								renderText(posX+0.145, self.lastEntryY-((tSize*1.55)*8.5), tSize*1.15,string.format(g_i18n:getText("ui_eduHarvestDesc"),math.floor((HelperAdvanced.eduPrices[3]*(4-g_currentMission.missionInfo.difficulty))*100)/100))
								setTextBold(true)
							end
						end
						setTextColor(self.hudColorEntrys.r,self.hudColorEntrys.g,self.hudColorEntrys.b,1)
						renderText(posX+0.26, self.lastEntryY, tSize*1.1, g_i18n:getText("ui_helperExpAndPrice"))
						renderText(posX+0.26, self.lastEntryY-(tSize*1.4), tSize*1.1, g_i18n:getText("ui_helperPlough").." (+"..tostring(math.floor((curHelp.experiencePlough-curHelp.basePlough)*1000)/10).." %)")
						renderText(posX+0.26, self.lastEntryY-((tSize*1.4)*2), tSize*1.1, g_i18n:getText("ui_helperCultivator").." (+"..tostring(math.floor((curHelp.experienceCultivator-curHelp.basexperienceCultivator)*1000)/10).." %)")
						renderText(posX+0.26, self.lastEntryY-((tSize*1.4)*3), tSize*1.1, g_i18n:getText("ui_helperSprayer").." (+"..tostring(math.floor((curHelp.experienceSprayer-curHelp.baseSprayer)*1000)/10).." %)")
						renderText(posX+0.26, self.lastEntryY-((tSize*1.4)*4), tSize*1.1, g_i18n:getText("ui_helperSowing").." (+"..tostring(math.floor((curHelp.experienceSowingMachine-curHelp.baseSowingMachine)*1000)/10).." %)")
						if curHelp.lastVehicleName ~= nil and curHelp.lastVehicleName ~= " " then
							renderText(posX, self.lastEntryY-((tSize*1.4)*6), tSize*1.1, g_i18n:getText("ui_helperLastUsed"))
							renderText(posX+0.50, self.lastEntryY-((tSize*1.4)*6), tSize*1.1, Utils.getNoNil(curHelp.lastVehicleName," "))
						end
						renderText(posX+0.475, self.lastEntryY, tSize*1.1, g_i18n:getText("ui_helperCostsAct"))
						renderText(posX+0.475, self.lastEntryY-(tSize*1.4), tSize*1.1, g_i18n:getText("ui_helperCombine").." (+"..tostring(math.floor((curHelp.experienceCombine-curHelp.baseCombine)*1000)/10).." %)")
						renderText(posX+0.475, self.lastEntryY-((tSize*1.4)*2), tSize*1.1, g_i18n:getText("ui_helperBaler").." (+"..tostring(math.floor((curHelp.experienceBaler-curHelp.baseBaler)*1000)/10).." %)")
						renderText(posX+0.475, self.lastEntryY-((tSize*1.4)*3), tSize*1.1, g_i18n:getText("ui_helperMower").." (+"..tostring(math.floor((curHelp.experienceMower-curHelp.baseMower)*1000)/10).." %)")
						renderText(posX+0.475, self.lastEntryY-((tSize*1.4)*4), tSize*1.1, g_i18n:getText("ui_helperOther").." (+"..tostring(math.floor((curHelp.experienceOther-curHelp.baseOther)*1000)/10).." %)")
						setTextAlignment(RenderText.ALIGN_RIGHT)
						renderText(posX+0.225, self.lastEntryY, tSize*1.1, curHelp.nameShow)
						renderText(posX+0.225, self.lastEntryY-(tSize*1.4), tSize*1.1, tostring(math.floor(curHelp.experiencePercent*10)/10).." %")
						renderText(posX+0.225, self.lastEntryY-((tSize*1.4)*2), tSize*1.1, string.format(g_i18n:getText("ui_helperMoney"),priceStd))
						renderText(posX+0.45, self.lastEntryY-(tSize*1.4), tSize*1.1, string.format(g_i18n:getText("ui_helperValue"),curHelp.percentPlough,((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experiencePlough-curHelp.learnedPlough)*HelperAdvanced.workPrices["plough"],0.02)))*HelperAdvanced.workPrices["base"])))
						renderText(posX+0.45, self.lastEntryY-((tSize*1.4)*2), tSize*1.1, string.format(g_i18n:getText("ui_helperValue"),curHelp.percentCultivator,((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceCultivator-curHelp.learnedCultivator)*HelperAdvanced.workPrices["cultivator"],0.02)))*HelperAdvanced.workPrices["base"])))
						renderText(posX+0.45, self.lastEntryY-((tSize*1.4)*3), tSize*1.1, string.format(g_i18n:getText("ui_helperValue"),curHelp.percentSprayer,((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceSprayer-curHelp.learnedSprayer)*HelperAdvanced.workPrices["sprayer"],0.02)))*HelperAdvanced.workPrices["base"])))
						renderText(posX+0.45, self.lastEntryY-((tSize*1.4)*4), tSize*1.1, string.format(g_i18n:getText("ui_helperValue"),curHelp.percentSowingMachine,((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceSowingMachine-curHelp.learnedSowingMachine)*HelperAdvanced.workPrices["sowing"],0.02)))*HelperAdvanced.workPrices["base"])))
						renderText(posX+0.735, self.lastEntryY, tSize*1.1, string.format(g_i18n:getText("ui_helperCosts"),curHelp.costs*HelperAdvanced.workPrices["base"]))
						renderText(posX+0.735, self.lastEntryY-(tSize*1.4), tSize*1.1, string.format(g_i18n:getText("ui_helperValue"),curHelp.percentCombine,((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceCombine-curHelp.learnedCombine)*HelperAdvanced.workPrices["combine"],0.02)))*HelperAdvanced.workPrices["base"])))
						renderText(posX+0.735, self.lastEntryY-((tSize*1.4)*2), tSize*1.1, string.format(g_i18n:getText("ui_helperValue"),curHelp.percentBaler,((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceBaler-curHelp.learnedBaler)*HelperAdvanced.workPrices["baler"],0.02)))*HelperAdvanced.workPrices["base"])))
						renderText(posX+0.735, self.lastEntryY-((tSize*1.4)*3), tSize*1.1, string.format(g_i18n:getText("ui_helperValue"),curHelp.percentMower,((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceMower-curHelp.learnedMower)*HelperAdvanced.workPrices["mower"],0.02)))*HelperAdvanced.workPrices["base"])))
						renderText(posX+0.735, self.lastEntryY-((tSize*1.4)*4), tSize*1.1, string.format(g_i18n:getText("ui_helperValue"),curHelp.percentOther,((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceOther-curHelp.learnedOther)*HelperAdvanced.workPrices["other"],0.02)))*HelperAdvanced.workPrices["base"])))
						setTextAlignment(RenderText.ALIGN_LEFT)
					end
				else
					curHelp.hudYPos = -1
					if self.helperMenuPage == 3 then
						oaCosts = oaCosts + (curHelp.costs*HelperAdvanced.workPrices["base"])
						local price = HelperAdvanced.maxPricePerHour - HelperAdvanced.basePricePerHour
						priceStd = (HelperAdvanced.basePricePerHour + (price * (curHelp.experience - curHelp.learnedExperience))) * HelperAdvanced.workPrices["base"]
						local hour = g_currentMission.environment.currentHour
						local weekDay = math.fmod(g_currentMission.environment.currentDay - 1, 7) + 1
						if hour < 6 or hour >= 20 or weekDay > 5 then
							price = HelperAdvanced.overtimePricePerHour - HelperAdvanced.basePricePerHour
						end
						if curHelp.isEmployed and curHelp.ownerFarmId == g_currentMission.player.farmId then
							cEmploy = cEmploy + 1
							cBExp = cBExp + curHelp.experiencePercent
							cWExp = cWExp + ((curHelp.percentPlough+curHelp.percentCultivator+curHelp.percentSprayer+curHelp.percentSowingMachine+curHelp.percentCombine+curHelp.percentBaler+curHelp.percentMower+curHelp.percentOther)/8)
							cbCosts = cbCosts + priceStd
							caCosts = caCosts + priceStd
							if curHelp.isHired then
								if curHelp.workedWithPlough then
									caCosts = caCosts + ((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experiencePlough-curHelp.learnedPlough)*HelperAdvanced.workPrices["plough"],0.02)))*HelperAdvanced.workPrices["base"])
								end
								if curHelp.workedWithCultivator then
									caCosts = caCosts + ((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceCultivator-curHelp.learnedCultivator)*HelperAdvanced.workPrices["cultivator"],0.02)))*HelperAdvanced.workPrices["base"])
								end
								if curHelp.workedWithSprayer then
									caCosts = caCosts + ((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceSprayer-curHelp.learnedSprayer)*HelperAdvanced.workPrices["sprayer"],0.02)))*HelperAdvanced.workPrices["base"])
								end
								if curHelp.workedWithSowingMachine then
									caCosts = caCosts + ((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceSowingMachine-curHelp.learnedSowingMachine)*HelperAdvanced.workPrices["sowing"],0.02)))*HelperAdvanced.workPrices["base"])
								end
								if curHelp.workedWithCombine then
									caCosts = caCosts + ((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceCombine-curHelp.learnedCombine)*HelperAdvanced.workPrices["combine"],0.02)))*HelperAdvanced.workPrices["base"])
								end
								if curHelp.workedWithBaler then
									caCosts = caCosts + ((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceBaler-curHelp.learnedBaler)*HelperAdvanced.workPrices["baler"],0.02)))*HelperAdvanced.workPrices["base"])
								end
								if curHelp.workedWithMower then
									caCosts = caCosts + ((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceMower-curHelp.learnedMower)*HelperAdvanced.workPrices["mower"],0.02)))*HelperAdvanced.workPrices["base"])
								end
								if curHelp.workedWithOther then
									caCosts = caCosts + ((HelperAdvanced.basePricePerHour + (price * math.max((curHelp.experienceOther-curHelp.learnedOther)*HelperAdvanced.workPrices["other"],0.02)))*HelperAdvanced.workPrices["base"])
								end
							end
						end
					end
				end
			end
			if self.helperMenuPage == 2 then
				setTextColor(self.hudColorEntrysNote.r,self.hudColorEntrysNote.g,self.hudColorEntrysNote.b,1)
				if isMaster then
					renderText(posX, 0.210, tSize*1.1, g_i18n:getText("ui_helperDescription"))
				else
					renderText(posX, 0.210+(tSize*1.15), tSize*1.1, g_i18n:getText("ui_helperDescriptionUser"))
				end
			end
			if self.helperMenuPage == 3 then
				tSize = tSize * 1.25 setTextColor(self.hudColorEntrys.r,self.hudColorEntrys.g,self.hudColorEntrys.b,1)
				setTextAlignment(RenderText.ALIGN_LEFT)
				renderText(posX+0.1, 0.8, tSize, g_i18n:getText("ui_helperCostsOA"))
				renderText(posX+0.1, 0.8-((tSize*1.4)), tSize, g_i18n:getText("ui_helperCostsE"))
				renderText(posX+0.1, 0.8-((tSize*1.4)*2), tSize, g_i18n:getText("ui_helperCostsC"))
				renderText(posX+0.1, 0.8-((tSize*1.4)*4), tSize, g_i18n:getText("ui_helperCostsExpO"))
				renderText(posX+0.1, 0.8-((tSize*1.4)*5), tSize, g_i18n:getText("ui_helperCostsExpW"))
				setTextAlignment(RenderText.ALIGN_RIGHT)
				renderText(posX+0.6, 0.8, tSize, string.format(g_i18n:getText("ui_helperCosts"),oaCosts))
				renderText(posX+0.6, 0.8-((tSize*1.4)), tSize, string.format(g_i18n:getText("ui_helperCostsH"),cbCosts))
				renderText(posX+0.6, 0.8-((tSize*1.4)*2), tSize, string.format(g_i18n:getText("ui_helperCostsH"),caCosts))
				renderText(posX+0.6, 0.8-((tSize*1.4)*4), tSize, string.format(g_i18n:getText("ui_expPrice"),math.floor(cBExp/cEmploy)))
				renderText(posX+0.6, 0.8-((tSize*1.4)*5), tSize, string.format(g_i18n:getText("ui_expPrice"),math.floor(cWExp/cEmploy)))
			end
			setTextBold(false)
			setTextAlignment(RenderText.ALIGN_LEFT)
			setTextColor(1,1,1,1)
		end
	end
end

function HelperAdvanced:getIsHiredText(index)
	if g_helperManager.indexToHelper[index].isLearning > 0 then
		if g_helperManager.indexToHelper[index].isLearning > 60 then
			return true, g_i18n:getText("ui_isLearning").." ("..tostring(math.floor(g_helperManager.indexToHelper[index].isLearning/60)).." h)"
		else
			return true, g_i18n:getText("ui_isLearning").." ("..tostring(math.floor(g_helperManager.indexToHelper[index].isLearning)).." m)"
		end
	end
	if g_helperManager.indexToHelper[index].isHired then
		local textAddition = ""
		if g_helperManager.indexToHelper[index].lastVehicleAiStarted == false then
			textAddition = " (MOD)"
			if g_helperManager.indexToHelper[index].lastVehicle ~= nil then
				if g_helperManager.indexToHelper[index].lastVehicle.courseplayDrive then
					textAddition = " (CP)"
				elseif g_helperManager.indexToHelper[index].lastVehicle.followMeDrive then
					textAddition = " (FM)"
				elseif g_helperManager.indexToHelper[index].lastVehicle.autoDriveDrive then
					textAddition = " (AD)"
				end
			end
		end
		return true, g_i18n:getText("ui_isHired")..textAddition
	end
	return false, g_i18n:getText("ui_notHired")
end

function g_helperManager.getUnemployedHelper(a,b,c)
	local unemployed = {}
	for i=1, table.getn(g_helperManager.indexToHelper) do
		if g_helperManager.indexToHelper[i].isEmployed == false then
			table.insert(unemployed,i)
		end
	end
	if table.getn(unemployed) > 0 then
		return unemployed[math.random(1, table.getn(unemployed))]
	else
		return nil
	end
end

function g_helperManager.getRandomHelper(self,vehicle, noEventSend, startedFarmId,showMenu)
	showMenu = Utils.getNoNil(showMenu, true)
	if startedFarmId == nil or startedFarmId == 0 then
		if g_dedicatedServerInfo == nil then
			startedFarmId = g_currentMission.player.farmId
		else
			startedFarmId = 0
		end
	end
	g_helperManager.vehicleToSet = vehicle
	g_helperManager.vehicleToSetEvent = noEventSend
	if vehicle == nil then
		local newSelectedHelperId = 0
		if #g_helperManager.availableHelpers > 0 then
			for i=1, #g_helperManager.availableHelpers do
				local newHelper = g_helperManager.availableHelpers[i]
				if newHelper.ownerFarmId == startedFarmId and newHelper.isLearning <= 0 then
					newSelectedHelperId = g_helperManager.availableHelpers[i].index
					break
				end
			end
		end
		if newSelectedHelperId == nil or newSelectedHelperId < 1 then
			local newSelectedHelperId = g_helperManager.getUnemployedHelper()
			if newSelectedHelperId == nil or newSelectedHelperId < 1 then
				g_helperManager.showNoHelperAvailable = true
			else
				HelperAdvanced:hireHelper(newSelectedHelperId,true,g_helperManager.indexToHelper[newSelectedHelperId].isLearning,g_helperManager.indexToHelper[newSelectedHelperId].isLearnSpec,startedFarmId,true,noEventSend)
				g_helperManager.showAutoEmployed = true
				-- g_helperManager.indexToHelper[newSelectedHelperId].autoEmployed = true
				return g_helperManager.indexToHelper[newSelectedHelperId]
			end
		else
			return g_helperManager.indexToHelper[newSelectedHelperId]
		end
	end
	if showMenu == true then
		g_helperManager.showHelperSelectionScreen = true
	end
end

function g_helperManager.useHelper(helper,second)
	if helper == nil then
		helper = g_helperManager.availableHelpers[math.random(1, #g_helperManager.availableHelpers)]
	end
	if helper.index == nil and second ~= nil and second.index ~= nil then
		helper = g_helperManager:getHelperByIndex(second.index)
	end
	for k, h in pairs(g_helperManager.availableHelpers) do
		if h.index == helper.index and helper.isHired == false then
			helper.isHired = true
			table.remove(g_helperManager.availableHelpers, k)
			return true
		end
	end
	return false
end

function g_helperManager.releaseHelper(helper,second,noAdd)
	if helper == nil then
		if second ~= nil  then
			helper = second
		else
			print("Warning: No helper for release sent to function [g_helperManager.releaseHelper]")
			print("If you are just ending/cancel/close the game you can ignore this message above.")
			return
		end
	end
	if helper == nil then
		g_HelperAdvanced:minuteChanged()
		return
	end
	local helperFound = false
	for i=1, g_helperManager.numHelpers do
		if helper == g_helperManager.indexToHelper[i] then
			helper = g_helperManager.indexToHelper[i]
			helperFound = true
		end
	end
	if helperFound == false then
		g_HelperAdvanced:minuteChanged()
		return
	end
	helper.isHired = false
	helper.workedWithBaler = false
	helper.workedWithCombine = false
	helper.workedWithCultivator = false
	helper.workedWithSprayer = false
	helper.workedWithMower = false
	helper.workedWithSowingMachine = false
	helper.workedWithPlough = false
	helper.workedWithOther = false
	helper.lastVehicleAiStarted = false
	if helper.autoEmployed ~= nil and helper.autoEmployed == true then
		g_HelperAdvanced:hireHelper(helper.index,false,0,0,0,true)
	elseif noAdd == nil then
		table.insert(g_helperManager.availableHelpers, helper)
	end
end
addModEventListener(HelperAdvanced)


local oldAIVehicleStartAIVehicle = AIVehicle.startAIVehicle
AIVehicle.startAIVehicle = function(self, helperIndex, noEventSend, startedFarmId, forcedDrivingStrategyName)
	local spec = self.spec_aiVehicle
	if helperIndex == nil then
		if g_helperManager.selectedHelperId == nil then
			g_helperManager.requiredHelperId = self.lastHelper
			if forcedDrivingStrategyName == "FollowMe" then
				helperIndex = g_helperManager.getRandomHelper(g_helperManager,nil,noEventSend,startedFarmId)
				if helperIndex ~= nil then
					helperIndex = helperIndex.index
				end
			else
				g_helperManager.getRandomHelper(g_helperManager,self,noEventSend,startedFarmId)
				return
			end
		else
			helperIndex = g_helperManager.newSelectedHelperId
			g_helperManager.newSelectedHelperId = nil
			g_helperManager.vehicleToSet = nil
			g_helperManager.vehicleToSetEvent = nil
		end
	end
	oldAIVehicleStartAIVehicle(self, helperIndex, noEventSend, startedFarmId, forcedDrivingStrategyName)
	if spec.currentHelper ~= nil then
		self.lastHelper = spec.currentHelper.index
		spec.lastHelper = spec.currentHelper.index
		self.currentHelper = spec.currentHelper
	end
end

local function HelperAdvancedCombineCutterArea(self, superFunc, area, realArea, inputFruitType, outputFillType, strawRatio, farmId)
	local spec = self.spec_combine
	if self.isServer then
		local cH = spec.currentHelper
		local isHired = self:getIsAIActive()
		if cH == nil then
			if self.getAttacherVehicle ~= nil and self:getAttacherVehicle() ~= nil then
				cH = self:getAttacherVehicle().currentHelper
				isHired = self:getAttacherVehicle():getIsAIActive()
			end
		end
		if spec.threshingScaleBackup == nil then
			spec.threshingScaleBackup = spec.threshingScale
		end
		if isHired and cH ~= nil then
			spec.threshingScale = spec.threshingScaleBackup * math.max(cH.experienceCombine - 0.9 + 1,0.6)
			strawRatio = strawRatio * math.max(cH.experienceCombine - 0.9 + 1,0.6)
		else
			spec.threshingScale = spec.threshingScaleBackup
		end
	end
	return superFunc(self, area, realArea, inputFruitType, outputFillType, strawRatio, farmId)
end
Combine.addCutterArea = Utils.overwrittenFunction(Combine.addCutterArea, HelperAdvancedCombineCutterArea)

local function HelperAdvancedForageWagonEndWorkAreaProcessing(self, dt, hasProcessed)
	local spec = self.spec_forageWagon
	if self.isServer then
		local cH = self.currentHelper
		local isHired = self:getIsAIActive()
		if cH == nil then
			if self.getAttacherVehicle ~= nil and self:getAttacherVehicle() ~= nil then
				cH = self:getAttacherVehicle().currentHelper
				isHired = self:getAttacherVehicle():getIsAIActive()
			end
		end
		if isHired and cH ~= nil then
			if spec.workAreaParameters.lastPickupLiters > 0 then
				spec.workAreaParameters.lastPickupLiters = spec.workAreaParameters.lastPickupLiters * math.max(cH.experienceMower - 0.9 + 1,0.6)
			end
		end
	end
end
ForageWagon.onEndWorkAreaProcessing = Utils.prependedFunction(ForageWagon.onEndWorkAreaProcessing, HelperAdvancedForageWagonEndWorkAreaProcessing)

-- currently no function
--[[
local function HelperAdvancedMowerUpdateTick(self,dt)
	if self.isServer then
		local cH = self.currentHelper
		local isHired = self:getIsHired()
		if cH == nil then
			if self.getAttacherVehicle ~= nil and self:getAttacherVehicle() ~= nil then
				cH = self:getAttacherVehicle().currentHelper
				isHired = self:getAttacherVehicle():getIsAIActive()
			end
		end
		if isHired and cH ~= nil then
			local addScale = (cH.experienceMower * 0.35)
			if self.mower.pickupFillScaleBackup == nil then
				self.mower.pickupFillScaleBackup = self.mower.pickupFillScale
			end
			self.mower.pickupFillScale = self.mower.pickupFillScaleBackup - 0.25 + addScale
		else
			self.mower.pickupFillScale = Utils.getNoNil(self.mower.pickupFillScaleBackup,self.mower.pickupFillScale)
		end
	end
end
Mower.updateTick = Utils.appendedFunction(Mower.updateTick, HelperAdvancedMowerUpdateTick)
--]]

local function HelperAdvancedBalerEndWorkAreaProcessing(self, dt, hasProcessed)
	local spec = self.spec_baler
	if self.isServer then
		local cH = self.currentHelper
		local isHired = self:getIsAIActive()
		if cH == nil then
			if self.getAttacherVehicle ~= nil and self:getAttacherVehicle() ~= nil then
				cH = self:getAttacherVehicle().currentHelper
				isHired = self:getAttacherVehicle():getIsAIActive()
			end
		end
		if spec.fillScaleBackup == nil then
			spec.fillScaleBackup = spec.fillScale
		end
		if isHired and cH ~= nil then
			spec.fillScale = spec.fillScaleBackup * math.max(cH.experienceBaler - 0.9 + 1,0.6)
		else
			spec.fillScale = spec.fillScaleBackup
		end
	end
end
Baler.onEndWorkAreaProcessing = Utils.prependedFunction(Baler.onEndWorkAreaProcessing, HelperAdvancedBalerEndWorkAreaProcessing)

local function HelperAdvancedSprayerGetSprayerUsage(self, superfunc, fillType, dt)
	if fillType == FillType.UNKNOWN then
		return 0
	end
	local spec = self.spec_sprayer
	local scale = Utils.getNoNil(spec.usageScale.fillTypeScales[fillType], spec.usageScale.default)
	if spec.usageScale.backup == nil then
		spec.usageScale.backup = {}
		spec.usageScale.backup.default = spec.usageScale.default
	end
	if spec.usageScale.backup[fillType] == nil then
		spec.usageScale.backup[fillType] = Utils.getNoNil(spec.usageScale.fillTypeScales[fillType], spec.usageScale.backup.default)
	end
	if spec.usageScale.fillTypeScales[fillType] == nil then
		spec.usageScale.fillTypeScales[fillType] = spec.usageScale.backup.default
	end

	local cH = self.currentHelper
	local isHired = self:getIsAIActive()
	if cH == nil then
		if self.getAttacherVehicle ~= nil and self:getAttacherVehicle() ~= nil then
			cH = self:getAttacherVehicle().currentHelper
			isHired = self:getAttacherVehicle():getIsAIActive()
		end
	end
	if isHired and cH ~= nil then
		spec.usageScale.fillTypeScales[fillType] = spec.usageScale.backup[fillType] * math.min(0.9 / cH.experienceSprayer,2.57)
		spec.usageScale.default = spec.usageScale.backup.default * math.min(0.9 / cH.experienceSprayer,2.57)
	else
		spec.usageScale.fillTypeScales[fillType] = spec.usageScale.backup[fillType]
		spec.usageScale.default = spec.usageScale.backup.default
	end
	if superFunc ~= nil then
		return superFunc(self, fillType, dt)
	else
		local litersPerSecond = 1
		local sprayType = g_sprayTypeManager:getSprayTypeByFillTypeIndex(fillType)
		if sprayType ~= nil then
			litersPerSecond = sprayType.litersPerSecond
		end
		local activeSprayType = self:getActiveSprayType()
		local workWidth = spec.usageScale.workingWidth
		if activeSprayType ~= nil then
			workWidth = activeSprayType.usageScale.workingWidth or workWidth
		end
		return scale * litersPerSecond * self.speedLimit * workWidth * dt * 0.001
	end
end
Sprayer.getSprayerUsage = Utils.overwrittenFunction(Sprayer.getSprayerUsage, HelperAdvancedSprayerGetSprayerUsage)

local function HelperAdvancedSowingMachineEndWorkAreaProcessing(self, dt, hasProcessed)
	if self.isServer then
		local cH = self.currentHelper
		local isHired = self:getIsAIActive()
		if cH == nil then
			if self.getAttacherVehicle ~= nil and self:getAttacherVehicle() ~= nil then
				cH = self:getAttacherVehicle().currentHelper
			end
		end
		if isHired and cH ~= nil then
			local spec = self.spec_sowingMachine
			
			local stats = g_farmManager:getFarmById(self:getLastTouchedFarmlandFarmId()).stats
			if spec.workAreaParameters.lastChangedArea > 0 then
				local fruitDesc = g_fruitTypeManager:getFruitTypeByIndex(spec.workAreaParameters.seedsFruitType)
				local lastHa = MathUtil.areaToHa(spec.workAreaParameters.lastChangedArea, g_currentMission:getFruitPixelsToSqm())
				local usage = fruitDesc.seedUsagePerSqm * lastHa * 10000
				local damage = self:getVehicleDamage()
				if damage > 0 then
					usage = usage * (1 + damage * SowingMachine.DAMAGED_USAGE_INCREASE)
				end
				usage = usage * (0.9 - cH.experienceSowingMachine)
				stats:updateStats("seedUsage", usage)
				if not g_currentMission.missionInfo.helperBuySeeds then
					local vehicle = spec.workAreaParameters.seedsVehicle
					local fillUnitIndex = spec.workAreaParameters.seedsVehicleFillUnitIndex
					local fillType = vehicle:getFillUnitFillType(fillUnitIndex)
					vehicle:addFillUnitFillLevel(self:getOwnerFarmId(), fillUnitIndex, -usage, fillType, ToolType.UNDEFINED, nil)
				else
					local price = usage * g_currentMission.economyManager:getCostPerLiter(FillType.SEEDS, false) * 1.5
					stats:updateStats("expenses", price)
					g_currentMission:addMoney(-price, self:getOwnerFarmId(), MoneyType.PURCHASE_SEEDS)
				end
			end
		end
	end
end
SowingMachine.onEndWorkAreaProcessing = Utils.appendedFunction(SowingMachine.onEndWorkAreaProcessing, HelperAdvancedSowingMachineEndWorkAreaProcessing)

local function HelperAdvancedAIUpdateTick(self,dt)
	local spec = self.spec_aiVehicle
	if self:getIsAIActive() and self.isServer and spec.currentHelper ~= nil then
		spec.pricePerMS = spec.currentHelper.pricePerMS
		if g_seasons ~= nil and g_seasons.economy ~= nil then
			g_seasons.economy.data.ai.workdayPayMS = spec.currentHelper.pricePerMS
			g_seasons.economy.data.ai.overtimePayMS = spec.currentHelper.pricePerMS
		end
	end
	if self:getIsAIActive() and self.isServer then
		local difficultyMultiplier = g_currentMission.missionInfo.buyPriceMultiplier
		g_currentMission:addMoney(dt*difficultyMultiplier*spec.pricePerMS,spec.startedFarmId, MoneyType.AI)
		local newPrice = dt * (spec.pricePerMS * Utils.getNoNil(g_currentMission.missionInfo.timeScale,1))
		g_currentMission:addMoney(-newPrice,spec.startedFarmId, MoneyType.AI)
		if spec.currentHelper ~= nil then
			spec.currentHelper.costs = spec.currentHelper.costs + newPrice
		end
	end
end
AIVehicle.onUpdateTick = Utils.appendedFunction(AIVehicle.onUpdateTick, HelperAdvancedAIUpdateTick)

Vehicle.getSpeedLimit = function(self, onlyIfWorking)
	local limit = math.huge
	local doCheckSpeedLimit = self:doCheckSpeedLimit()
	if onlyIfWorking == nil or (onlyIfWorking and doCheckSpeedLimit) then	
		limit = self.speedLimit
		local damage = self:getVehicleDamage()
		if damage > 0 then
			limit = limit * (1 - damage * Vehicle.DAMAGED_SPEEDLIMIT_REDUCTION)
		end
	end
	local attachedImplements
	if self.getAttachedImplements ~= nil then
		attachedImplements = self:getAttachedImplements()
	end
	if attachedImplements ~= nil then
		for _, implement in pairs(attachedImplements) do
			if implement.object ~= nil then
				local speed, implementDoCheckSpeedLimit = implement.object:getSpeedLimit(onlyIfWorking)
				if onlyIfWorking == nil or (onlyIfWorking and implementDoCheckSpeedLimit) then
					limit = math.min(limit, speed)
				end
				doCheckSpeedLimit = doCheckSpeedLimit or implementDoCheckSpeedLimit
			end
		end
	end
	local addSpeedFactor = 1
	if self.currentHelper ~= nil and self.currentHelper.experience ~= nil then
		addSpeedFactor = (0.3 * self.currentHelper.experience)
		if self.currentHelper.workedWithBaler == true then
			addSpeedFactor = addSpeedFactor + (0.35 * self.currentHelper.experienceBaler)
		elseif self.currentHelper.workedWithCombine == true then
			addSpeedFactor = addSpeedFactor + (0.35 * self.currentHelper.experienceCombine)
		elseif self.currentHelper.workedWithCultivator == true then
			addSpeedFactor = addSpeedFactor + (0.35 * self.currentHelper.experienceCultivator)
		elseif self.currentHelper.workedWithSprayer == true then
			addSpeedFactor = addSpeedFactor + (0.35 * self.currentHelper.experienceSprayer)
		elseif self.currentHelper.workedWithMower == true then
			addSpeedFactor = addSpeedFactor + (0.35 * self.currentHelper.experienceMower)
		elseif self.currentHelper.workedWithSowingMachine == true then
			addSpeedFactor = addSpeedFactor + (0.35 * self.currentHelper.experienceSowingMachine)
		elseif self.currentHelper.workedWithPlough == true then
			addSpeedFactor = addSpeedFactor + (0.35 * self.currentHelper.experiencePlough)
		elseif self.currentHelper.workedWithOther == true then
			addSpeedFactor = addSpeedFactor + (0.35 * self.currentHelper.experienceOther)
		end
		addSpeedFactor = addSpeedFactor + 0.6
	end
	return limit * addSpeedFactor, doCheckSpeedLimit
end

HelperAdvancedMinuteEvent = {}
HelperAdvancedMinuteEvent_mt = Class(HelperAdvancedMinuteEvent, Event)
InitEventClass(HelperAdvancedMinuteEvent, "HelperAdvancedMinuteEvent")

function HelperAdvancedMinuteEvent:emptyNew()
	local self = Event:new(HelperAdvancedMinuteEvent_mt)
	return self
end

function HelperAdvancedMinuteEvent:new(name,price,exp,edu,bale,baleS,comb,combS,cult,cultS,spray,sprayS,mow,mowS,sow,sowS,plow,plowS,other,otherS,learning,spec, hired, helper, discharge, employ, vehicle, aiStarted, costs, farm, autoEmployed)
	local self = HelperAdvancedMinuteEvent:emptyNew()
	self.name = name
	self.price = price
	self.exp = exp
	self.edu = edu
	self.bale = bale
	self.baleS = baleS
	self.comb = comb
	self.combS = combS
	self.cult = cult
	self.cultS = cultS
	self.spray = spray
	self.sprayS = sprayS
	self.mow = mow
	self.mowS = mowS
	self.sow = sow
	self.sowS = sowS
	self.plow = plow
	self.plowS = plowS
	self.other = other
	self.otherS = otherS
	self.learning = learning
	self.spec = spec
	self.hired = hired
	self.discharge = discharge
	self.costs = costs
	self.employ = employ
	self.farm = farm
	self.helper = helper
	self.aiStarted = aiStarted
	self.vehicle = vehicle
	self.autoEmployed = autoEmployed
	return self
end

function HelperAdvancedMinuteEvent:readStream(streamId, connection)
	self.name = streamReadString(streamId)
	self.price = streamReadFloat32(streamId)
	self.exp = streamReadFloat32(streamId)
	self.edu = streamReadFloat32(streamId)
	self.bale = streamReadFloat32(streamId)
	self.baleS = streamReadFloat32(streamId)
	self.comb = streamReadFloat32(streamId)
	self.combS = streamReadFloat32(streamId)
	self.cult = streamReadFloat32(streamId)
	self.cultS = streamReadFloat32(streamId)
	self.spray = streamReadFloat32(streamId)
	self.sprayS = streamReadFloat32(streamId)
	self.mow = streamReadFloat32(streamId)
	self.mowS = streamReadFloat32(streamId)
	self.sow = streamReadFloat32(streamId)
	self.sowS = streamReadFloat32(streamId)
	self.plow = streamReadFloat32(streamId)
	self.plowS = streamReadFloat32(streamId)
	self.other = streamReadFloat32(streamId)
	self.otherS = streamReadFloat32(streamId)
	self.learning = streamReadInt16(streamId)
	self.spec = streamReadInt8(streamId)
	self.hired = streamReadBool(streamId)
	self.discharge = streamReadFloat32(streamId)
	self.costs = streamReadFloat32(streamId)
	self.employ = streamReadBool(streamId)
	self.farm = streamReadUInt8(streamId)
	self.helper = streamReadUInt8(streamId)
	self.autoEmployed = streamReadBool(streamId)
	self.aiStarted = streamReadBool(streamId)
	if streamReadBool(streamId) == true then
		self.vehicle = NetworkUtil.readNodeObject(streamId)
	end
	self:run(connection)
end

function HelperAdvancedMinuteEvent:writeStream(streamId, connection)
	streamWriteString(streamId, self.name)
	streamWriteFloat32(streamId, self.price)
	streamWriteFloat32(streamId, self.exp)
	streamWriteFloat32(streamId, self.edu)
	streamWriteFloat32(streamId, self.bale)
	streamWriteFloat32(streamId, self.baleS)
	streamWriteFloat32(streamId, self.comb)
	streamWriteFloat32(streamId, self.combS)
	streamWriteFloat32(streamId, self.cult)
	streamWriteFloat32(streamId, self.cultS)
	streamWriteFloat32(streamId, self.spray)
	streamWriteFloat32(streamId, self.sprayS)
	streamWriteFloat32(streamId, self.mow)
	streamWriteFloat32(streamId, self.mowS)
	streamWriteFloat32(streamId, self.sow)
	streamWriteFloat32(streamId, self.sowS)
	streamWriteFloat32(streamId, self.plow)
	streamWriteFloat32(streamId, self.plowS)
	streamWriteFloat32(streamId, self.other)
	streamWriteFloat32(streamId, self.otherS)
	streamWriteInt16(streamId, self.learning)
	streamWriteInt8(streamId, self.spec)
	streamWriteBool(streamId, self.hired)
	streamWriteFloat32(streamId, self.discharge)
	streamWriteFloat32(streamId, self.costs)
	streamWriteBool(streamId, self.employ)
	streamWriteUInt8(streamId, self.farm)
	streamWriteUInt8(streamId, self.helper)
	streamWriteBool(streamId, self.autoEmployed)
	streamWriteBool(streamId, self.aiStarted)
	if self.vehicle ~= nil then
		streamWriteBool(streamId,true)
		NetworkUtil.writeNodeObject(streamId, self.vehicle)
	else
		streamWriteBool(streamId,false)
	end
end

function HelperAdvancedMinuteEvent:run(connection)
	if self.helper ~= nil and self.helper > 0 then
		g_helperManager.indexToHelper[self.helper].nameShow = self.name
		g_helperManager.indexToHelper[self.helper].isHired = self.hired
		g_helperManager.indexToHelper[self.helper].experience = self.exp
		g_helperManager.indexToHelper[self.helper].learnedExperience = self.edu
		g_helperManager.indexToHelper[self.helper].experiencePercent = math.min(100 / 1 * g_helperManager.indexToHelper[self.helper].experience,100)
		g_helperManager.indexToHelper[self.helper].experienceBaler = self.bale
		g_helperManager.indexToHelper[self.helper].learnedBaler = self.baleS
		g_helperManager.indexToHelper[self.helper].percentBaler = math.min(100 / 1 * g_helperManager.indexToHelper[self.helper].experienceBaler,100)
		g_helperManager.indexToHelper[self.helper].experienceCombine = self.comb
		g_helperManager.indexToHelper[self.helper].learnedCombine = self.combS
		g_helperManager.indexToHelper[self.helper].percentCombine = math.min(100 / 1 * g_helperManager.indexToHelper[self.helper].experienceCombine,100)
		g_helperManager.indexToHelper[self.helper].experienceCultivator = self.cult
		g_helperManager.indexToHelper[self.helper].learnedCultivator = self.cultS
		g_helperManager.indexToHelper[self.helper].percentCultivator = math.min(100 / 1 * g_helperManager.indexToHelper[self.helper].experienceCultivator,100)
		g_helperManager.indexToHelper[self.helper].experienceSprayer = self.spray
		g_helperManager.indexToHelper[self.helper].learnedSprayer = self.sprayS
		g_helperManager.indexToHelper[self.helper].percentSprayer = math.min(100 / 1 * g_helperManager.indexToHelper[self.helper].experienceSprayer,100)
		g_helperManager.indexToHelper[self.helper].experienceMower = self.mow
		g_helperManager.indexToHelper[self.helper].learnedMower = self.mowS
		g_helperManager.indexToHelper[self.helper].percentMower = math.min(100 / 1 * g_helperManager.indexToHelper[self.helper].experienceMower,100)
		g_helperManager.indexToHelper[self.helper].experienceSowingMachine = self.sow
		g_helperManager.indexToHelper[self.helper].learnedSowingMachine = self.sowS
		g_helperManager.indexToHelper[self.helper].percentSowingMachine = math.min(100 / 1 * g_helperManager.indexToHelper[self.helper].experienceSowingMachine,100)
		g_helperManager.indexToHelper[self.helper].experiencePlough = self.plow
		g_helperManager.indexToHelper[self.helper].learnedPlough = self.plowS
		g_helperManager.indexToHelper[self.helper].percentPlough = math.min(100 / 1 * g_helperManager.indexToHelper[self.helper].experiencePlough,100)
		g_helperManager.indexToHelper[self.helper].experienceOther = self.other
		g_helperManager.indexToHelper[self.helper].learnedOther = self.otherS
		g_helperManager.indexToHelper[self.helper].percentOther = math.min(100 / 1 * g_helperManager.indexToHelper[self.helper].experienceOther,100)
		g_helperManager.indexToHelper[self.helper].name = g_helperManager.indexToHelper[self.helper].nameShow.." ("..tostring(math.floor(g_helperManager.indexToHelper[self.helper].experiencePercent)).."%)"
		g_helperManager.indexToHelper[self.helper].isLearning = self.learning
		g_helperManager.indexToHelper[self.helper].isLearnSpec = self.spec
		g_helperManager.indexToHelper[self.helper].pricePerMS = self.price
		g_helperManager.indexToHelper[self.helper].checkValue = self.discharge
		g_helperManager.indexToHelper[self.helper].costs = self.costs
		g_helperManager.indexToHelper[self.helper].isEmployed = self.employ
		g_helperManager.indexToHelper[self.helper].lastVehicle = self.vehicle
		g_helperManager.indexToHelper[self.helper].lastVehicleAiStarted = self.aiStarted
		g_helperManager.indexToHelper[self.helper].ownerFarmId = self.farm
		g_helperManager.indexToHelper[self.helper].autoEmployed = self.autoEmployed
		HelperAdvanced:hireHelper(self.helper,self.employ,self.learning,self.spec,self.farm,self.autoEmployed,true)
	end
end

HelperAdvancedHireHelper = {}
HelperAdvancedHireHelper_mt = Class(HelperAdvancedHireHelper, Event)
InitEventClass(HelperAdvancedHireHelper, "HelperAdvancedHireHelper")

function HelperAdvancedHireHelper:emptyNew()
	local self = Event:new(HelperAdvancedHireHelper_mt)
	return self
end

function HelperAdvancedHireHelper:new(helper, hired, learning, spec, farm, autoEmployed)
	local self = HelperAdvancedHireHelper:emptyNew()
	self.helper = helper
	self.hired = hired
	self.learning = learning
	self.spec = spec
	self.farm = farm
	self.autoEmployed = autoEmployed
	return self
end

function HelperAdvancedHireHelper:readStream(streamId, connection)
	self.helper = streamReadUInt8(streamId)
	self.hired = streamReadBool(streamId)
	self.autoEmployed = streamReadBool(streamId)
	self.learning = streamReadInt16(streamId)
	self.spec = streamReadInt8(streamId)
	self.farm = streamReadInt8(streamId)
	self:run(connection)
end

function HelperAdvancedHireHelper:writeStream(streamId, connection)
	streamWriteUInt8(streamId, self.helper)
	streamWriteBool(streamId, self.hired)
	streamWriteBool(streamId, self.autoEmployed)
	streamWriteInt16(streamId, self.learning)
	streamWriteInt8(streamId, self.spec)
	streamWriteInt8(streamId, self.farm)
end

function HelperAdvancedHireHelper:run(connection)
	HelperAdvanced:hireHelper(self.helper,self.hired,self.learning,self.spec,self.farm,self.autoEmployed,true)
	if not connection:getIsServer() then
		g_server:broadcastEvent(HelperAdvancedHireHelper:new(self.helper,self.hired,self.learning,self.spec,self.farm, self.autoEmployed))
	end
end

HelperDataRequest = {}
HelperDataRequest_mt = Class(HelperDataRequest, Event)
InitEventClass(HelperDataRequest, "HelperDataRequest")

function HelperDataRequest:emptyNew()
	local self = Event:new(HelperDataRequest_mt)
	return self
end

function HelperDataRequest:new(request)
	local self = HelperDataRequest:emptyNew()
	self.request = request
	return self
end

function HelperDataRequest:readStream(streamId, connection)
	self.request = streamReadBool(streamId)
	self:run(connection)
end

function HelperDataRequest:writeStream(streamId, connection)
	streamWriteBool(streamId, self.request)
end

function HelperDataRequest:run(connection)
	if not connection:getIsServer() then
		HelperAdvanced.request = true
	end
end

HelperSetNameEvent = {}
HelperSetNameEvent_mt = Class(HelperSetNameEvent, Event)
InitEventClass(HelperSetNameEvent, "HelperSetNameEvent")

function HelperSetNameEvent:emptyNew()
	local self = Event:new(HelperSetNameEvent_mt)
	return self
end

function HelperSetNameEvent:new(name,helper)
	local self = HelperSetNameEvent:emptyNew()
	self.name = name
	self.helper = helper
	return self
end

function HelperSetNameEvent:readStream(streamId, connection)
	self.name = streamReadString(streamId)
	self.helper = streamReadUInt8(streamId)
	self:run(connection)
end

function HelperSetNameEvent:writeStream(streamId, connection)
	streamWriteString(streamId, self.name)
	streamWriteUInt8(streamId, self.helper)
end

function HelperSetNameEvent:run(connection)
	if self.helper ~= nil and self.helper > 0 then
		g_helperManager.indexToHelper[self.helper].nameShow = self.name
		g_helperManager.indexToHelper[self.helper].name = g_helperManager.indexToHelper[self.helper].nameShow.." ("..tostring(math.floor(g_helperManager.indexToHelper[self.helper].experiencePercent)).."%)"
		if not connection:getIsServer() then
			g_server:broadcastEvent(HelperSetNameEvent:new(self.name,self.helper))
		end
	end
end

print(" ++ loading Helper Advanced V "..tostring(HelperAdvanced.version).." (by Blacky_BPG)")
