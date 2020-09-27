#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook
#UseHook
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to superior speed / reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetNumLockState, AlwaysOn ; we like num lock 
#SingleInstance force ; if script is already running, cut it and run this one
#KeyHistory 40 ; logging - one page, no scrolling
SetTitleMatchMode 2 ; 1 starts with / 2 anywhere within / 3 exact 
GroupAdd, groupCapsLock, ahk_exe osu!.exe ; yes it's a group of one no I don't want to change it 
Menu, Tray, Icon, iAhk_general.ico ; icon dependency 
~^s::Reload ; reload on save 

; one-liners 
^!+S::^!+S ; fixes osu reload somehow 
::npp:: Notepad{+}{+}
::mbok::msgbox, 262144,, 
#N::Run, DisplayTest.exe, %A_MyDocuments%\DisplayTest-master ; win-n toggles night light 
^Esc::Run, procexp64.exe, %A_MyDocuments%\ProcessExplorer ; open process explorer

; fix mb3 double click - g603 is starting to suffer from the doubleclick issue in the middle mouse button but rather than buying a new mouse or learning to solder, let's just make a really dumb script 
	MButton:: 
		If (A_ThisHotkey == A_PriorHotkey && A_TimeSincePriorHotkey < 125)
		{
			; if mouse middle is doucleclicked within 125 ms, send a splash but no command (based on minimum 130ms gap without deliberate effort)
			SetCapsLockState, off
			Splashimage,,b1 w130 h60 Y25 CTwhite CWblack fs10,`rdoubleclick
			sleep,100
			Splashimage,off
		}
		Else
		{
			Send {MButton}
		}
		Return

; ctrl+h for queueing handbrake remuxes (24 items = 24 loops, etc)
#ifWinActive ahk_exe HandBrake.exe
	^h::
		InputBox, loopCount, , enter count: for 24 items will do 24 loops etc ; dynamic loop count weee
		If ErrorLevel
			; canceled 
			Exit
		Else 
			Loop, %loopCount% 
			{
				WinActivate, HandBrake ; redundant switch to handbrake for safety 
				WinMaximize ; force maximize so cm screen works - coordmode client is inconsistent idk why 
				Click, 159, 136 ; open queue to start from top 
				Click, 159, 153 ; select from top of the queue
				CoordMode, Mouse, Screen ; coordmode checks whole screen 
				; Click, 287, 219 ; audio tab
				; Click, 115, 314 ; audio dropdown
				; Click, 80, 258 ; ?add aud track 
				; Click, 80, 287 ; ?click aud track 

				; Click, 91, 324 ; SELECT AUDIO 1 (usually en aud)
				; Click, 91, 344 ; SELECT AUDIO 2 (usually jp aud)

				Click, 342, 219 ; subtitles tab
				Click, 127, 309 ; subtitles dropdown

				; Click, 157, 345 ; SELECT SUBS 1 (usually en ss)
				Click, 157, 365 ; SELECT SUBS 2 (usually en full)

				Click, 480, 305 ; check default box 
				Click, 200, 75 ; add to queue 
				Click, 150, 135 ; item dropdown 
				Send {Down} {Enter} ; next item 
				
				if GetKeyState("Esc", "P") ;  see if escape is pressed
					break  ; exits Loop
			}
			Exit 
		; end msgbox yes 
#ifWinActive

; start menu LH shortcuts 
#ifWinActive ahk_class Windows.UI.Core.CoreWindow
	:*:ww::Osu{!}
	:*:aa::Logitech Gaming Software
	:*:vv::Visual Studio Code
	:*:cc::Adobe Photoshop CC 2019
	Tab::Enter
#ifWinActive

; mpv dupe key maps
#ifWinActive ahk_exe mpv.exe 
	Esc::q
	NumpadEnter::f
	Enter::f
#ifWinActive
	
; league maps
#IfWinActive League of Legends
	:C1:er::/fullmute all ; C1 case insensitive  
#IfWinActive

; iTunes maps 
#IfWinActive iTunes
	:o:kk::K-Pop   {BS}{BS}{BS}
#IfWinActive

; you have fat fingers 
	:?*:`;':: ; replace ;' with just a ' 
		Send {'}
		SplashTextOn, 190,25,AutoHotkey,oop
		Sleep,260
		SplashTextOff
	Exit
	>+Up:: ; ignore rshift+up
		SplashTextOn, 150,25,AutoHotkey,oop use LShift instead
		Sleep,225
		SplashTextOff
	Exit
	:?*:p[:: ; ignore p[ 
		Send {p}
		SplashTextOn, 150,25,AutoHotkey,oop 
		Sleep,225
		SplashTextOff
	Exit

; capslock only on 300ms doubletap, with notification 	
	#ifWinNotActive, ahk_exe osu!.exe
		CapsLock:: 
			If (A_ThisHotkey == A_PriorHotkey && A_TimeSincePriorHotkey < 300)
			{
				If GetKeyState("CapsLock", "T")
				{
					SetCapsLockState, off
					Splashimage,,b1 w130 h100 Y25 CTwhite CWblack fs10,`r`r c a p s   o f f
					sleep,325
					Splashimage,off
				}
				else
				{			
					SetCapsLockState, on
					Splashimage,,b1 w130 h100 Y25 CWwhite CTblack m9 fs10,`r`rC A P S   O N 
					sleep,325
					Splashimage,off
				}
			}
			Return
			; MORE ON SPLASHIMAGE: 
			; autohotkey.com/docs/commands/Progress.htm#Window_Size_Position_and_Behavior
	#ifWinNotActive
; osu! binds
#ifWinActive, ahk_exe osu!.exe
	; allow clicking on tablets 
		F1:: Send {LButton}
	; LH volume control 
		^r:: Send {Volume_Up}
		^f:: Send {Volume_Down}
		^e:: Up
		^d:: Down
	; backtick for LH enter
		`::SC11C
	; tab for LH next song 
		Tab::Right
	; fix alt-tab when above is active
		LAlt & Tab:: AltTab 
	; caps lock for LH prev song 
		CapsLock::Left
#ifWinActive
	