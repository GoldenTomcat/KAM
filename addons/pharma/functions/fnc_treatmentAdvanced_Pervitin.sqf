#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Begins Pervitin Treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "RightArm", "Pervitin", objNull, "kat_pervitin"] call kat_pharma_fnc_treatmentAdvanced_Pervitin;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

if (ACE_Player != _patient) then {

	[LLSTRING(NoSelfTreatment), 2, _medic] call ACEFUNC(common,displayTextStructured);

} else {

	[_patient, _classname] call ACEFUNC(medical_treatment,addToTriageCard);
	[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), _classname]] call ACEFUNC(medical_treatment,addToLog);

	[_medic, 'kat_Pervitin'] call FUNC(removeItemfromMag);
	[QGVAR(medicationLocal), [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
	[QGVAR(pervitinLocal), _patient, _patient] call CBA_fnc_targetEvent;
};