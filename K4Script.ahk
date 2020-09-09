#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force ; if script is already running, cut it and run this one
#InstallKeybdHook
#UseHook
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#KeyHistory 35
Menu, Tray, Icon, iAhk_k4.ico
~^s::Reload 

; Fixes dumb keyboard layout of k4 since they don't let you natively remap keys 

F1::
	ifWinExist, ahk_exe osu!.exe
	{
		; allow left clicking when using tablet 
		Send {LButton}
		Exit
	}
	Send {Home}
	Exit
	
F2::F1
F3::F2
F4::F3
F5::F4
F6::F5
F7::F6
F8::F7
F9::F8
F10::F9
F11::F10
F12::F11
Home::F12

PgDn::PgUp ; pgdn to pgup 