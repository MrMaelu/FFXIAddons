#include <GUIConstantsEx.au3>
#include <File.au3>
#include <Array.au3>

ThemeSelector()

Func ThemeSelector()
	Local $resfolder = @ScriptDir & "\ThemeSelectorResources\"
	Local $hGUI = GUICreate("ThemeSelector", 770, 280)
	Local $toptext = GUICtrlCreateLabel("Select the theme you want from the drop-down menu.", 5, 5, 700, 30)
	GUICtrlSetFont(-1, 20)
	Local $idOK = GUICtrlCreateButton("OK", 200, 38, 85, 25)
	Local $idDropdown = GUICtrlCreateCombo("", 10, 40, 170, 25)
	Local $filelist = _FileListToArray($resfolder, "settings_*.xml")
	If @error = 1 Then
		MsgBox(0, "No settings.", "No settings files found, please make sure the " & @CRLF & "settings_THEMENAME.xml files are present in the ThemeSelectorResources folder.")
		Exit
	EndIf
	Local $Preview = GUICtrlCreatePic("", 10, 70, 750, 200)

	_ArrayDelete($filelist, 0)
	$themes = StringReplace(StringReplace(_ArrayToString($filelist), "settings_", ""), ".xml", "")
	$defaultFirst = StringReplace(StringReplace($filelist[0], "settings_", ""), ".xml", "")
	GUICtrlSetData($idDropdown, $themes, $defaultFirst)
	GUICtrlSetImage($Preview, $resfolder & $defaultFirst & ".bmp")

	GUISetState(@SW_SHOW, $hGUI)

	Local $ComboRead = $defaultFirst

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idOK
				FileCopy($resfolder & "settings_" & $ComboRead & ".xml", "settings.xml", 1)
				MsgBox(0, "Theme set", "The theme " & $ComboRead & " has been set." & @CRLF & "Reload xivbar to see the changes.")
				ExitLoop
			Case $idDropdown
				$ComboRead = GUICtrlRead($idDropdown)
				GUICtrlSetImage($Preview, $resfolder & $ComboRead & ".bmp")
		EndSwitch
	WEnd

	; Delete the previous GUI and all controls.
	GUIDelete($hGUI)
EndFunc   ;==>ThemeSelector
