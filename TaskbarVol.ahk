#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook
#UseHook
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to superior speed / reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force ; if script is already running, cut it and run this one
#KeyHistory 42 ; logging - one page, no scrolling
SetTitleMatchMode 2 ; 1 starts with / 2 anywhere within / 3 exact 
#NoTrayIcon ; hides tray icon 
; ~^s::Reload ; reload on save


#If MouseIsOver("ahk_class Shell_TrayWnd")
	~WheelUp:: Send {Volume_Up} 
	~WheelDown:: Send {Volume_Down} 
	~MButton:: Send {Volume_Mute} 

	MouseIsOver(WinTitle) ; defines above function
	{
		MouseGetPos,,, Win
		Return WinExist(WinTitle . " ahk_id " . Win)
	}
#If
