#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook
#UseHook
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to superior speed / reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetNumLockState, AlwaysOn ; nobody uses numpad mods
#SingleInstance force ; if script is already running, cut it and run this one
#KeyHistory 42 ; logging - one page, no scrolling
SetTitleMatchMode 2 ; 1 starts with / 2 anywhere within / 3 exact 
#NoTrayIcon ; hides tray icon duh
; ~^s::Reload 

; numpad shenanigans:
; /////////////////////////////////////////////////////////////////////////////////////
#If GetKeyState("NumpadDot", "P")
	NumpadEnter::Send {BackSpace}, ; numdot nument into comma 
	
#If GetKeyState("NumpadDiv", "P")
	Numpad7::Send {BackSpace}(
	Numpad9::Send {BackSpace})
#If
	
; numMinus into = on doubletap
	NumpadSub:: 
		If (A_ThisHotkey == A_PriorHotkey && A_TimeSincePriorHotkey < 250)
		{
			Send {BS}{=} 
		}
		Else 
		{
			Send {NumpadSub}
		}
	Exit
; NumDot into : on doubletap 
	NumpadDot:: 
		If (A_ThisHotkey == A_PriorHotkey && A_TimeSincePriorHotkey < 250)
		{
			Send {BS}{:} 
		}
		Else 
		{
			Send {NumpadDot} 
		}
	Exit

; k4 
^!Numpad0::
	_TXT2= 
(
: : `t`t  hotkey options  `t`t`t: :
|  # win`t|  ! alt`t|  ^ ctrl`t|  + shift  
|   ~ unblock native`t|`t$ prevent self send  
|  o remove trail space`t|`tC1 case insensitive

: :`t`t  K4 Shortcuts  `t`t`t: :

| fn+L+{light}		=	toggle light lock
| fn+i+D			=	switch del/ins
| fn+{caps lock}+P	= 	toggle caps lock backlight
| fn+P+{prt scrn}		= 	switch prtscrn/pgup
| fn+S+O		=	toggle LED timeout

{F1} bright dn`t`t|||`t{F2} bright up
{F5} backlight dn`t|||`t{F6} backlight up

		  YES if using K4
		  NO if not using K4
)
	_yOff=y260
	_bWidth=w90
	_bHeight=h25
	Gui, Add, Text,   x10 y10, %_TXT2%
	Gui, Add, Button, x200 %_yOff% %_bWidth% %_bHeight% +Default gbtnCcl, &Cancel
	Gui, Add, Button, x010 %_yOff% %_bWidth% %_bHeight% gbtnYes, &Yes
	Gui, Add, Button, x105 %_yOff% %_bWidth% %_bHeight% gbtnNo, &No
	Gui, Show,,Keyboard-Check-001
	Return
		
	btnYes:
		Gui Destroy
		
		SplashTextOn, 190,25,AutoHotkey,running k4 script
		Sleep,300
		SplashTextOff
		Run, open %A_MyDocuments%\GitHub\hello-ahk\K4Script.ahk
		Exit
		
	btnNo:
		Gui Destroy
		
		SplashTextOn, 190,25,AutoHotkey,closing k4 script
		Sleep,300
		SplashTextOff
		DetectHiddenWindows, On 
		WinClose, %A_MyDocuments%\GitHub\hello-ahk\K4Script.ahk ahk_class AutoHotkey
		Exit
		
	GuiClose:
	btnCcl:
		Gui Destroy
		Exit

	; allow nums 123 as alt selectors 
	#IfWinActive Keyboard-Check-001
		Numpad1::
		1::
			Send {Y}
			Exit
			
		Numpad2::
		2::
			Send {N}
			Exit
			
		Numpad3::
		3::
			Send {C}
			Exit
			
		Esc::Gui Destroy
	#IfWinActive
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; use numpad mods to toggle num lock / send intended command:
; #IfWinNotActive ahk_exe osu!.exe 
; 	NumpadPgDn::
; 		SetNumLockState, On
; 		Send {Numpad3}
; 	Exit
; 	NumpadPgUp::
; 		SetNumLockState, On
; 		Send {Numpad9}
; 	Exit
; #IfWinNotActive 

; up next: funky media stuff
; /////////////////////////////////////////////////////////////////////////////////////
	#ifWinActive, ahk_class Bridge_WindowClass
		^!Numpad3::
		^!NumpadPgDn::
			Send ^{Numpad3}
		Exit
	#ifWinActive
	^Numpad3::
	^NumpadPgDn::
		Send {Volume_Down}
	Exit

	#ifWinActive ahk_exe Bridge.exe
		^Numpad9::
		^NumpadPgUp::
			Send ^{Numpad9}
		Exit
	#IfWinActive ahk_class RiotWindowClass
		^Numpad9::
		^NumpadPgUp::
			; Send {Volume_Up} ; idk why but using this over soundset makes you recall ?xd
			Soundset, 0, , Mute ; this way you can immediately vol up instead of needing to unmute after going down to zero 
			Soundset, +2 
			Exit
	#ifWinActive 
	^Numpad9::
	^NumpadPgUp::
		Send {Volume_Up}
	Exit

	; the following is from http://forums.na.leagueoflegends.com/board/showthread.php?t=1847687&page=2
	; allows control of iTunes media player without actively switching windows 
	
	; ---- ---- iTunes: Play/Pause ---- ----(Control+Numpad5/Clear)
	#ifWinActive ahk_exe Bridge.exe
		^Numpad5::
			Send ^{Numpad5}
			Exit
	#ifWinActive
	^Numpad5::
		DetectHiddenWindows, On
		Target := "ahk_class iTunes"
		IfWinExist %Target% 
		; ControlSend, ahk_parent, {Alt down}c{Alt up}p, ahk_class iTunes ; wont work bc ahk cant do context menus or something 
		; ControlSend, ahk_parent, {space}, ahk_class iTunes
		ControlSend, ahk_parent, {space}
		Exit

	; ---- ---- iTunes: Previous Song ---- ----(Control+Numpad4/Left)
	#ifWinActive ahk_exe Bridge.exe
		^Numpad4::
		^NumpadLeft::
			Send ^{Numpad4}
			Exit
	#ifWinActive
	^Numpad4::
	^NumpadLeft::
		DetectHiddenWindows, On ; Tells AHK to search for windows that are minimized/hidden
		Target := "ahk_class iTunes"
		IfWinExist %Target%
		ControlSend, ahk_parent, ^{left}
	return


	; ---- ---- iTunes: Next Song ---- ----(Control+Numpad6/Right)
	#ifWinActive ahk_exe Bridge.exe
		^Numpad6::
		^NumpadRight::
			Send ^{Numpad6}
			Exit
	#ifWinActive
	^Numpad6::
	^NumpadRight::
		DetectHiddenWindows, On ; Tells AHK to search for windows that are minimized/hidden
		Target := "ahk_class iTunes"
		IfWinExist %Target%
		ControlSend, ahk_parent, ^{right}
	return


	; ---- ---- iTunes: Volume Up ---- ----(Ctrl+Numpad8/Up)
	#ifWinActive ahk_exe Bridge.exe
		^Numpad8::
		^NumpadUp::
			Send ^{Numpad8}
			Exit
	#ifWinActive
	^Numpad8::
	^NumpadUp::
		DetectHiddenWindows, On ; Tells AHK to search for windows that are minimized/hidden
		Target := "ahk_class iTunes"
		IfWinExist %Target%
		ControlSend, ahk_parent, ^{up}
	return


	; ---- ---- iTunes: Volume Down ---- ----(Ctrl+Numpad2/Down)
	#ifWinActive ahk_exe Bridge.exe
		^Numpad2::
		^NumpadDown::
			Send ^{Numpad2}
			Exit
	#ifWinActive
	^Numpad2::
	^NumpadDown::
		DetectHiddenWindows, On ; Tells AHK to search for windows that are minimized/hidden

		Target := "ahk_class iTunes"
		IfWinExist %Target%
		ControlSend, ahk_parent, ^{down}
	Return