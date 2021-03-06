// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

MainMissions =
[
	// Mission filename, weight
	["mission_ArmedDiversquad", 1],
	["mission_VTOL", 0.5],
	["mission_APC", 1],
	["mission_MBT", 1],
	["mission_LightArmVeh", 1],
	["mission_ArmedHeli", 1],
	["mission_AbandonedJet", 0.75],
	["mission_CivHeli", .5],
	["mission_Truck", 1]
];
SideMissions = [
	["mission_Convoy", .5],
	["mission_MiniConvoy", 1],
	["mission_SunkenSupplies", 1],
	["mission_ConvoyCSATSF", 1],
	["mission_ConvoyNATOSF", 1],
	["mission_GeoCache", 1],
	["mission_SupplyDrop", 1]
];
MoneyMissions = [
	["mission_SunkenTreasure", 1],
	["mission_militaryPatrol", .75],
	["mission_altisPatrol", .75],
	["mission_MoneyShipment", 1]
];
PatrolMissions = [
	["mission_NavalConvoy", 1],
	["mission_artypatrol", .75],
	["mission_tankRush", .75],
	["mission_Coastal_Convoy", .5],
	["mission_ChopperStrike", 1]
];
AirMissions = [
	["mission_Gunship", .75],
  ["mission_HostileJet", 1],
	["mission_HostileVTOL", 1],
	["mission_SmugglerPlane", .75],
	["mission_HostileHelicopter", 1],
	["mission_HostileHeliFormation", .8],
	["mission_HostileJetFormation", .8],
	["mission_CargoContainer", 1]
];
AssaultMissions = [
	["mission_Roadblock", 1],
	["mission_Sniper", 1],
	["mission_Outpost", 1],
	["mission_Smugglers", .75],
	["mission_TownInvasion", 1],
	["mission_HostageRescue", .75]
];

/* MainMissions =
[
];
SideMissions = [
];
MoneyMissions = [
	["mission_MoneyShipment", 1]
];
PatrolMissions = [
];
AirMissions = [
	["mission_CargoContainer", 1]
];
AssaultMissions = [
]; */

MissionSpawnMarkers = (allMapMarkers select {["Mission_", _x] call fn_startsWith}) apply {[_x, false]};
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call fn_startsWith}) apply {[_x, false]};
SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call fn_startsWith}) apply {[_x, false]};

if !(ForestMissionMarkers isEqualTo []) then
{
	SideMissions append
	[
		["mission_AirWreck", 1],
		["mission_WepCache", 1]
	];
};

LandConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\landConvoysList.sqf") apply {[_x, false]};
CoastalConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\coastalConvoysList.sqf") apply {[_x, false]};
navalConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\NavalConvoyList.sqf") apply {[_x, false]};

MainMissions = [MainMissions, [["A3W_heliPatrolMissions", ["mission_Coastal_Convoy", "mission_HostileHeliFormation", "mission_HostileJetFormation"]], ["A3W_underWaterMissions", ["mission_ArmedDiversquad"]]]] call removeDisabledMissions;
SideMissions = [SideMissions, [["A3W_heliPatrolMissions", ["mission_HostileHelicopter", "mission_HostileJet"]], ["A3W_underWaterMissions", ["mission_SunkenSupplies"]]]] call removeDisabledMissions;
MoneyMissions = [MoneyMissions, [["A3W_underWaterMissions", ["mission_SunkenTreasure"]]]] call removeDisabledMissions;

{ _x set [2, false] } forEach MainMissions;
{ _x set [2, false] } forEach SideMissions;
{ _x set [2, false] } forEach MoneyMissions;
{ _x set [2, false] } forEach PatrolMissions;
{ _x set [2, false] } forEach AirMissions;
{ _x set [2, false] } forEach AssaultMissions;

MissionSpawnMarkers = [];
SunkenMissionMarkers = [];
RoadblockMissionMarkers =[];
JetSpawnMarkers = [];
SniperMissionMarkers =[];
{
	switch (true) do
	{
		case (["Mission_", _x] call fn_startsWith):
		{
			MissionSpawnMarkers pushBack [_x, false];
		};
		case (["SunkenMission_", _x] call fn_startsWith):
		{
			SunkenMissionMarkers pushBack [_x, false];
		};
		case (["RoadBlock_", _x] call fn_startsWith):
		{
			RoadblockMissionMarkers pushBack [_x, false];
		};
		case (["Sniper_", _x] call fn_startsWith):
		{
			SniperMissionMarkers pushBack [_x, false];
		};
		case (["Jet_", _x] call fn_startsWith):
		{
			JetSpawnMarkers pushBack [_x, false];
		};
	};
} forEach allMapMarkers;

LandConvoyPaths = [];
{
	LandConvoyPaths pushBack [_x, false];
} forEach (call compile preprocessFileLineNumbers "mapConfig\convoys\landConvoysList.sqf");

CoastalConvoyPaths = [];
{
	CoastalConvoyPaths pushBack [_x, false];
} forEach (call compile preprocessFileLineNumbers "mapConfig\convoys\coastalConvoysList.sqf");
navalConvoyPaths = [];
{
	navalConvoyPaths pushBack [_x, false];
} forEach (call compile preprocessFileLineNumbers "mapConfig\convoys\NavalConvoyList.sqf");
PatrolConvoyPaths = [];
{
	PatrolConvoyPaths pushBack [_x, false];
} forEach (call compile preprocessFileLineNumbers "mapConfig\convoys\patrolConvoysList.sqf");
ArtyConvoyPaths = [];
{
	ArtyConvoyPaths pushBack [_x, false];
} forEach (call compile preprocessFileLineNumbers "mapConfig\convoys\artyConvoysList.sqf");

SFConvoyPaths = [];
{
SFConvoyPaths pushBack [_x, false];
} forEach (call compile preprocessFileLineNumbers "mapConfig\convoys\SFConvoysList.sqf");
