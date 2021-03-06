// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: assaultMissionProcessor.sqf
//	@file Author: The Scotsman

#define MISSION_PROC_TYPE_NAME "Assault"
#define MISSION_PROC_TIMEOUT (["A3W_AssaultMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE assaultMissionColor

#include "assaultMissions\assaultMissionDefines.sqf"
#include "missionProcessor.sqf";
