#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook
#UseHook
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to superior speed / reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force ; if script is already running, cut it and run this one
#KeyHistory 42 ; logging - one page, no scrolling
SetTitleMatchMode 2 ; 1 starts with / 2 anywhere within / 3 exact 
#NoTrayIcon ; hides tray icon duh
GroupAdd, groupBackspace, ahk_class CabinetWClass ; file explorer 
GroupAdd, groupBackspace, ahk_class iTunes ; iTunes 
GroupAdd, groupBackspace, ahk_class RegEdit_RegEdit ; regedit
GroupAdd, groupBackspace, ahk_class Photoshop ; cs5 
GroupAdd, groupBackspace, ahk_class TfrmPdMain ; GRAHL PDF annotator
GroupAdd, groupBackspace, ahk_exe Bridge.exe ; bridge 
; ~^s::Reload 

; fix {ctrl}{backspace} for apps that have questionable support:

#IfWinActive ahk_group groupBackspace ; File Explorer
	^BS:: send, ^+{left}{delete}
#IfWinActive

; source and context: http://superuser.com/a/636973/124606