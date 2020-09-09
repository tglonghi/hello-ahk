#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
#Persistent ; always running - maybe not the best use of resources? but it works 
#NoTrayIcon
; https://www.autohotkey.com/boards/viewtopic.php?p=75175&sid=b8f64788b7d88db0f46d4f6ef85faa5d#p75175

Loop
{
    WinWait, ahk_class mpv
        Send #{Up}
    WinWaitClose
}