#include <GUIConstantsEx.au3>
#include <File.au3>
#include <Array.au3>

ThemeSelector()

Func ThemeSelector()
	Local $hGUI = GUICreate("ThemeSelector", 770, 230)
	Local $toptext = GUICtrlCreateLabel("Select the theme you want from the drop-down menu.",5,5,700,30)
	GUICtrlSetFont(-1, 20)
	Local $idOK = GUICtrlCreateButton("OK", 200, 38, 85, 25)
	Local $idDropdown = GUICtrlCreateCombo("", 10, 40, 170, 25)
	Local $filelist = _FileListToArray(@ScriptDir, "settings_*.xml")
	If @error = 1 Then
		MsgBox(0, "No settings.", "No settings files found, please make sure the " & @CRLF & "settings_THEMENAME.xml files are present in the folder.")
		Exit
	EndIf
	Local $Preview = GUICtrlCreatePic("", 10, 70, 750, 150)

_ArrayDelete($filelist, 0)
	$themes = StringReplace(StringReplace(_ArrayToString($filelist), "settings_", ""), ".xml", "")
	$defaultFirst = StringReplace(StringReplace($filelist[0], "settings_", ""), ".xml", "")
	GUICtrlSetData($idDropdown, $themes, $defaultFirst)
	GUICtrlSetImage($Preview, $defaultFirst & ".bmp")

	; Display the GUI.
	GUISetState(@SW_SHOW, $hGUI)

	Local $ComboRead = $defaultFirst

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idOK
;~ 				Copy settings_*.xml to settings.xml
				FileCopy("settings_" & $ComboRead & ".xml", "settings.xml", 1)
				MsgBox(0, "Theme set", "The theme " & $ComboRead & " has been set." & @CRLF & "Reload xivbar to see the changes.")
				ExitLoop
			Case $idDropdown
				$ComboRead = GUICtrlRead($idDropdown)
;~ 				$PreviewImage = $ComboRead
				GUICtrlSetImage($Preview, $ComboRead & ".bmp")
		EndSwitch
	WEnd

	; Delete the previous GUI and all controls.
	GUIDelete($hGUI)
EndFunc   ;==>ThemeSelector
