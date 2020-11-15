#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook
#UseHook
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to superior speed / reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force ; if script is already running, end it and run this one
#KeyHistory 42 ; logging - one page, no scrolling
SetTitleMatchMode 2 ; 1 starts with / 2 anywhere within / 3 exact 
#NoTrayIcon ; hides tray icon 
~^s::Reload ; reload on save

; hardcoding bc it gets weird if I don't 
#IfWinActive League of Legends
	!NumpadEnter::
		run %A_AppData%\nircmd-x64\nircmd.exe muteappvolume "League of Legends.exe" 2
		Exit
#IfWinActive ahk_exe osu!.exe
	!NumpadEnter::
		run %A_AppData%\nircmd-x64\nircmd.exe muteappvolume "osu!.exe" 2
		Exit
#ifWinActive ahk_exe fate.exe
	!NumpadEnter::
		run %A_AppData%\nircmd-x64\nircmd.exe muteappvolume "Fate.exe" 2
		Exit		
#ifWinActive ahk_class RCLIENT
	!NumpadEnter::
		run %A_AppData%\nircmd-x64\nircmd.exe muteappvolume "LeagueOfLegendsClient.exe" 2
		Exit		
#ifWinActive 