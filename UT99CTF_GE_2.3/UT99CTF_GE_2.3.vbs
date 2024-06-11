'*
'*	Unreal Tournament 99 Capture The Flag Pinball 2.3
'*		   Godlike Edition  -  2021 by Oqqsan
'*

Randomize
On Error Resume Next
ExecuteGlobal GetTextFile("controller.vbs")
If Err Then MsgBox "You need the controller.vbs in order to run this table, available in the vp10 package"
On Error Goto 0

'Extra buttons'
'R' = rulesmagnifier
'Left Flipper + Startgame' = Slamtilt
'Left Magnasave'  = Select RandomMusic+Player TEAM color and LUT change pre game
'Right Magnesave' = Select Player TAUNT voice and LUT change pre game

'This is needed to run:
'UT99DMD - Move folder to same folder the VPX and b2s are in !
'UnrealTournament - Move folder to "Visual Pinball/Music/"
'FlexDMD 1.8  -  https://github.com/vbousquet/flexdmd/releases
'warning snapshot might not work, if you get errors revert to the stable released one 1.8.0.0
'recomend getting freezydmdextension v1.9 

'********************************************************
Const TournamentMode = 		0		' 1=on 0=off : Zero extraballs, Start on level 3
'********************************************************
Const MoviesIngame = 		1		' 1=on 0=off
'***********      Sound Options     *********************
'*   Recommended values should be no greater than 1   *
Const VolumeDial = 			0.8		' global volume multiplier for the mechanical sounds.
Const BG_Volume =			0.9		' backglass volume
Const Music_Volume =		0.6		' music volume
'***********         Options        *********************
RainFlasher.visible = 		1		' 0=off 1=on for raining mod
RainFlasher.opacity = 		5		' %strength Default 5   ' Dont go very high, you wont like it.

Const VRRoom =				0		' 0=off 1=Tournament Room  2=Minimal Room  3=Ultra Minimal
Const Gunshake =			0		' 0=off 1=on : Shaking PF when gun fire , probaly best to disable this if you go VRROOOM!

Const NormalBalls = 		0		' 0=off 1=No colored balls 2=No color + normal scratches.
Const BallTrail = 			1		' 0=off 1=on 
Const BallFlasher =			1		' 0=off 1=Smal 2=Big 3=XL 4=MEGA : Reverse shadow! Light up around the ball on PF and up the ramp...almost glowball rolling on the ramp.
Const BallSuperShiny = 		1		' 0=off 1=on : aka Disco Ball !  Makes the balltrail even more crazy.

Const DarkRoom = 			0		' 0=off >0=on : Force RoomLightEmissions.. very low like 0.1 and a very bright lut is funky ! Experiment on own risks.

Const BallhitSparks =		1		' 0=off 1=on : extra rubbersquiiizing, looks great so dont turn off :) 

Const DisableLUTchanges =	0		' 0=off 1=on  
Const OSBactive =			0		' 0=off 1=on    .. orbital scoreboard : Game is not registred on OSB yet !
Dim DB2S_on : DB2S_on	=	0		' 0=auto 1=on : dB2S
'********************************************************


'**
'*	WARNING WARNING WARNING WARNING
'**
'*	DO NOT DOWNLOAD FROM VPD
'*
'*	Please note that if you downloaded this 
'*	table from virtualpinballdownloads.com
'*	that you are doing so against the wishes 
'*	of the table authors. 
'*
'*	The admins at VPD steal and repost
'*	these tables without the authors permission 
'*	and by downloading from their website you
'*	are supporting these actions. 
'*	
'*	Please show support for the table authors
'*	and the community in general by ONLY 
'*	downloading from community supported 
'*	sites such as VPuniverse and VPForums. 
'*
'*	The tables are always free and you will be 
'*	able to receive tech support for any issues
'*	you may have, usually directly from the table author(s).
'*
'*	You will also have access to the latest
'*	updates much quicker and be supporting
'*	the actual table author(s) by doing so. If 
'*	you want to support this community in 
'*	a positive way, all we ask is to download 
'*	these tables from approved websites. 
'*
'*	Thank you!
'*
'*
'*
'*
'*	OK, OK, OK! take three !
'*	Sometimes Leo Getz way more than he asked for 
'*
'*	I GOT THE FLAG PINBALL ! Godlike Edition
'*
'*
'*	Big thanks to the testers again ! It is not easy without feedback ! And thanks for some great ideas :)
'*	
'*
'*	Changes from v1:
'*
'*	2.3
'*	Rawd - huge VRRoom, truly amazing stuff for those that drive in the fast lane. vrroom vrrooom
'*	leojreimroc - vr backglass 
'*	oqqsan - fix for snakegame, bad fix last time and i did not test it properly :P
'*
'*	2.2 - sixtoe
'*	Changed playfield mesh and inlane collidables to see if it stops ball getting caught on flippers, currently seems OK.
'*	Added holes to playfield image so it looks like shooter rails go properly into playfield.
'*	Fixed FlexDMD so it's now working in VR
'*	Colour corrected DMD flasher so it's in full colour.
'*	Added visible wall under apron for VR.
'*	Trimmed visible lights outside of table limits for VR.
'*
'*	2.1
'*	Fixed highscores, seems like i broke it just before uploading v2
'*	some failsafe on audio added
'*	a few minor fixes
'*
'*	2.0
'*	Pure Flex DMD 1.8 ( no crappy ultraDMD "simulation" anymore )
'*	SuperSnake v2 - DMD game, activate with plunger in attract mode.. fps will get very low on this
'*	2 new flashers
'*	New insert "Room of champions"
'*	Room of champions = extra missions wizard mode : 7 ramps on level 4 to activate
'*	animated the droptargets
'*	easier to get 2 droptargets at the same time
'*	bouncy targets, added to droptargets and a few posts
'*	alittle shorter levels 
'*	ramp is tiny bit easier to get up
'*	more sounds added, its getting heavy over there at F2
'*	mechtilt added, i did not know about this... thanks Thalamus :)
'*	fixed 3 headshots in a row for double headshots rest of the ball( was not working at all on v1.0 )
'*	added animations doubleheadshots and invisibility minigamE, now you will know if you get them
'*	DMD will show more info
'*	new failsafe for lost balls
'*	bouncy targets, added it to some other elements too
'*	even more animation for the DMD
'*	gi improvments for the cost of 5 MB on the sideblades ( later saved almost all back by splitting the big cab primitive )
'*	more blink blink stuff added
'*	10 extra backwall lights, Sixtoe had the idea and added those, me I just adjust for hours o.0
'*	extraball added for winning first map
'*	new "ballimages", apophis wanted a brighter one and then i changed it up, quite nice and lucky result on this one :)
'*	veryshiny "Disco Balls"  
'*	crazy good ball trails !  added a few options to turn off some ball effects 	 0.o
'*	pwnage update, will give out more goodies
'*	added new prizes on pwnage : includes minigames on special "jackpot" and "multiball"
'*	new insert for the doubletrouble pwnage
'*	lights adjusted for the millionth time
'*	GI has a finger on most elements now.. 0.o
'*	beveled edges playfield mesh for 2 kicker holes, ball behavior gets a thumbs up.. adjusted several times, the behavior is super nice now :) almost fails is great
'*	new tripple primitives for same 2 kickers, and animated kicker arms
'*	added 2 smal blinkers at top of 2 gates
'*	Ramp ends modified with new primitive, blinks with GI/flashers and animated when Hit
'*	rubber sleeved posts animated when Hit
'*	remade the red/blue base signs, the old ones bugged me in desktop mode
'*	New liandri minigame added, with new sign
'*	new insert for the pwnage inhuman jackpot 
'*	another insert for the double trouble, need 2 you know
'*	Liandri minigame sign now turns 360 with blinking text on the backside aswell
'*	godlike insert added, not easy to get many of those Lit
'*	25 ramps on same ball = extra life ... only once/game
'*	tri godlike, 25 lights, 25 ramps , ultra pwnage... each not completed will reset on next ball/extra life
'*	added "sparks" on collisions with many rubber objects on playfield ' option to turn them off.Will look like you squeeze them alittle more on top of the rubber movment added earlier
'*	Progress bar on backwall(x16), +7 collectables, some of them are very hard to get.. only to show you have gotten them
'*	smal gates on each ramp with Lights..
'*	ramp do now move abit when ball rolling on them.
'*	New layer on some plastics :) check out the slingshots and laneguides 
'*	updated all posts with new material and lights up with GI. Individual BDLighting to some of them :)
'*	bumpercaps move just a little bit when hit, and put on some new transparent material. you see the ring go off under them now!  
'*	Tournament Mode : RIK wanted hardcore and here it is!   Game too easy, too long games ? try setting this to ON ! ExtraLife is no more but so are level 1 and 2 ! 
'*	Fixed som respawn timer possible problems. Reduced all respawn timers alittle ( invisibility is unchanged, possible need a downgrade ? )
'*	Gameover turns into a thunderstorm !
'*	Foggystuff goes away in snakegame, Playfieldlights too go off.
'*	SlamTilt added :  Hold LeftFlipper 1 second and press startgame for a "quick" restart
'*	Bumpers deluxe, Ripper for the Win !
'*	New primitive cannons ontop of slings :)
'*	ReverseShadows added with option to turn off, 4 sizes to choose from. TeamColors + whiteish for the silverballs
'*	TodaysBest do not reset until next day. Even when restarting table !
'*	Optimized many 3d mesh and made a few new ones to make the game run faster :) Removed reflection from many.
'*
'*	109472 minor adjustments and bug fixes
'*	bigger rotating throphy ! And its more shiny and has more sparkle !
'*
'*
'*
'* OK, OK, OK! take two !
'* Sometimes Leo Getz more than he asked for !
'*
'* I GOT THE FLAG PINBALL !
'*
'* Based on Lethal Weapon 3 vpw modv1.02
'* no ROM is needed nor used for this table 
'* db2s included
'*
'* UT99DMD - Move folder to the TablesFolder
'* UnrealTournament - Move folder to "Visual Pinball/Music/"
'*
'* FlexDMD is needed so go get:
'*	https://github.com/freezy/dmd-extensions/releases
'*		Download the installer and run it.
'*
'*	https://github.com/vbousquet/flexdmd/releases
'*	copy files to vpinmame dir and run the flexDMDUI to register dlls
'*
'* Oqqsan					First King Of Morpheus ! Full Script, new ramps, inserts, a finger on everything
'* Major Frenchy			Playfield flippers and laneguides gfx
'* SiXtoe					VR-room
'* Tomate, iaakki			Nfozzy physics
'* Apophis					DOF  +  FleepPackage
'*
'* Testing: Hard to manage without ! 
'* Apophis
'* fluffhead35
'* RIK
'* VPW team 
'* 
'*
'* Features: 
'* 1-4 Players
'* 750 Different Sound Files ' wrong nr on v1
'* FlexDMD
'* FlupperDomes 2 
'* Nfozzy phsics	
'* FleepSounds
'* OrbitalScoreBoard
'* press "R" Will magnify Instructions 
'* left magnasave  - select player TEAM color
'* right magnesave - select player main taunt voice
'*
'*
'* Playd alot on LW3 vpw mod and saw the potential, this table is very good !
'* If you havent still playd that one go get it, you will not be disapointed !
'*
'*
'* OK, OK, OK! 
'* Lethal Weapon 3 table Tune-Up by VPin Workshop. 
'* It all started by again by just thinking about adding nFozzys physics and some missing textures in the original table,
'* then we started replacing some primitives and reworking the existing ones, then the apron, cabinet, metal ramp, bats and a few other things were replaced.
'* Totally new 3d inserts. Then different lamps were added to have a better lighting of all the new baked textures and finally adding a built in VR room...
'*
'* - New/reworked primitives: tomate
'* - Baked ON/OFF textures: tomate
'* - Inserts: Sheltemke, oqqsan
'* - Scripting: oqqsan
'* - nFozzys physics: Tomate, iaakki
'* - Fleep sounds: apophis
'* - Flashes & Lighting Overhaul: tomate, Sixtoe
'* - VR Room and fixes: Sixtoe, 360 Room by pattyg234.
'* - Miscellaneous tweaks: Sixtoe, tomate, oqqsan
'* - Testing: Bord, Rik, oqqsan, VPW team
'* 
'* This release would not have been possible without the legacy of those who came before us, including most notably, Javier for the original vpx table, EBisLit for the new playfield image and 32Assassin for the rework. Thank you.
'* Thanks to Flupper for his beautiful domes and Bumpers caps, Rothbauerw for nFozzy physics and Fleep for sounds.
'*
'*
'* Enjoy! 


'* POV desktop
'*	45
'*	45
'*	-12
'*	0
'*	1.048
'*	1.006
'*	1
'*	0
'*	90,2
'*	30


'DOF id
'E101 0/1 LeftFlipper
'E102 0/1 RightFlipper
'E103 2 Leftslingshot
'E104 2 Rightslingshot
'E105 2 top bumper left 
'E106 2 top bumper center
'E107 2 top bumper right
'E108 2 front blue Flasher  8
'E109 2 middle blu Flasher 3
'E110 2 back blu Flasher   9
'E111 2 front red Flasher   1
'E112 2 middle red Flasher  2
'E113 2 back red Flasher    7
'E114 0/1 Lauchbutton ready  ( guncontrol )
'E115 0/1 Startgamebutton ready
'E116 2 startgame
'E117 2 autolaunch/lauchbutton Fire
'E118 2 kickback fire
'E119 2 drain Hit
'E120 2 ballsaved
'E121 2 Left Spinner 
'E122 2 Right spinner
'E123 2 skillshot
'E124 2 skillshot perfect
'E125 2 skillshot 2
'E126 2 award extraball
'E127 2 add credits
'E128 2 middle DT
'E129 2 right DT
'E130 2 Pwnage
'E131 2 lite Kickback
'E133 2 invisibility awarded
'E134 2 left saucer
'E135 2 left orbit
'E136 2 TopVUK
'E137 2 right saucer
'E138 2 right orbit
'E139 2 mainramp
'E140 2 redeemer	
'E141 2 Jackpot	
'E142 2 HeadShot
'E143 2 ball locked
'E144 0/1 Multiball
'E145 2 Godlike
'E146 2 Monsterkill
'E147 0/1 redundercab
'E148 0/1 blueundercab
'E149 0/1 goldundercabdo
'E149 0/1 goldundercab
'E150 0/1 greenundercab
'E151 2 Ballrelease ( simulated )
'E152 2 4 skillshot lights hit
'E153 2 Capture
'E154 2 ENEMY Capture
'E155 2 Capture Denied
'E156 2 Whiteflasher top
'E157 2 Replay win


Const DOFdebug =			0		' need a double check all dof calls, many are missing  ' set to 1 to turn on debug on dof events
Const StaticScoreboard =	0		' new dmd is not enabled for this/not working				' if the vidoes on scoreboard are bad for you set this to 1

' Select Player team With left magna save 
Dim Team(4)
Dim Taunt(4)
Dim highscorename(3)
Dim hScore(3)
Dim LastScore(4)
Dim GamesPlayd
Const cGameName="ut99ctf"
Const cGameVersion="v1.1"
Const OSDversion = "1.00"

cab.blenddisablelighting=0.5
Dim DesktopMode:DesktopMode = Table1.ShowDT


Dim FlexDMD
Dim Scores(4) : Scores(1) = 0 : Scores(2) = 0 : Scores(3) = 0 : Scores(4) = 0
Dim Player : Player = 1
Dim RocTrigger ' rampx5
Dim FontScoreInactive, FontScoreActive, FontScoreCredits
Dim Frame : Frame = 0
dIM FlexPath
Dim DMDmode : DMDmode=0

'**********************************************************************************************************
'*
'**********************************************************************************************************
Dim SLS(202,14)
' 1-lIGHTS  FLAG 0-1-2 , 2FADELEVEL ,3BLINKING PAUSE , 4BLINKING COUNTDOWN, 5SPECIALSTATE 
            ' 6SP BLINK PAUSE, 7SP COUNTDOWN, 8SP nrofblinks(0=noend),9Normal nrofblinks : 10=SP off afterxx frames  11=DELAYSTART !  12=turn off special after done ( 12 = always so mby takeitaway )
			'13 and 14 coodinates
			' 0 = 1 for double speed ?
SLS(201,1)=1 
SLS(202,1)=1 ' apron lights always on can blink ofc
SLS(100,1)=1 ' plungerRed always on

Dim SC(4,50)
' player flags
'   SC(PN,x)=1
' 	 0=bounsscore for after
'	 1  Score
'	 2R Bonus1	3=Bonus2	4=Bonus3  11=MULTIPLYERLEVEL (2,3,4,6,8)
'	 5R  DT1 Sw25	6=DT2 Sw26	7=DT3 Sw27	8=DT4 Sw33	9=DT5 Sw34	10=DT6 Sw35  ... all DT/collected armor is lost each ball
'	12  Rightorbit 
'	13  Leftorbit nr(1-5=nr of lights lit) + more states ?
'	14  kicker1
'	15  kicker2
'	16  kicker3
'	17  Lockedballs
'	18  Needed to start Locking for multiball ( 5 lights )
'	19  Killingspree
'   20 HUMAN MAIN TAUNTS		<<< no reset 
'   21 Skilshotlevel
'
'	
'	22= 65 and 66 	blinks ' for reentry after lost ball so this can stay
'	23= 42 capture	blinks
'	24= 43 upgrade	blinks
'	25= 50 enemyF	blinks
'	26= 68 teamplay	blinks
'
'   27=Map Playing
'	28= map score left Counter
'	29= map score Right Counter
'   30= enemyflagcounter for next lit EF
'	31=GameTimerCheck
' 	32= GFBlevel  get flag back
'	33= save last countdown for reset next ball
'	34=roomofchampions
'	35/36 level /mission  ROC
'	37/38/39/40 just counters for missions
'	41= counter for face ... 5 ramps = ROC Start
'	42=liandri minigame
'	43 lane 1 .. 1=done
'	44 lane 2 .. 1=done
'	45 lane 3 .. 1=done
'	46 lane 4 .. 1=done
'	47 lane 5 .. 1=done

'	48 Ramp(25) EB gottenreplay
'	49 = saved GODLIKE LIGHT

'	50= collectables
'	and 1 = Moonsterkill	' 171
'	and 2 = Level 1			' 172 
'	and 4 = Level 2			' 173
'	and 8 = Level 3			' 174
'	and 16= Level godlike	' 147
'	and 32= Level godlike EL' 148
'	and 64= Level god pwnage' 149





' 1 each lane lites one letter,  triball= 1 letter, win map = 1 letter, 1 le


If DB2S_on=1 or not Desktopmode Then startcontroller
If OSBactive = 1 Then
	On Error Resume Next
	ExecuteGlobal GetTextFile("osb.vbs")
End If





' ****************** TABLE INIT****************************
Sub Table1_init
	Table1.BallTrail = BallTrail
	If BallSuperShiny=0 then Table1.BallImage = "ball_HDR_brightest"
	If Darkroom>0 and darkroom<1.1 Then Primitive033.blenddisablelighting=0.005

	LUTBox.Visible = 0
	If NOT Desktopmode Then Flasher006.visible=0 : Flasher007.visible=0
	
	Loadhighscore


	PN=1 ' to set P1 colors at startup

	SetTeamColors
	InitLightsXY

	If TournamentMode=1 Then Flasher004.visible=True

	If NormalBalls=2 Then Table1.BallFrontDecal="g5kscratchedmorelight"

End Sub

Dim startupcounter
Sub startupdelay_Timer
	startupcounter=startupcounter+1

' ****************** FLEX INIT****************************

	Select Case startupcounter
		Case 1 :
		Dim fso,curdir
	
		Set FlexDMD = CreateObject("FlexDMD.FlexDMD")
		If FlexDMD is Nothing Then
			MsgBox "No FlexDMD found. This table will NOT run without it."
			Exit Sub
		End If
		SetLocale(1033)
		With FlexDMD
			.GameName = cGameName
			.TableFile = Table1.Filename & ".vpx"
			.Color = RGB(255, 88, 32)
			.RenderMode = FlexDMD_RenderMode_DMD_RGB
			.Width = 128
			.Height = 32
			.Clear = True
			.Run = True
		End With
	
		Set fso = CreateObject("Scripting.FileSystemObject")
		curDir = fso.GetAbsolutePathName(".")
		FlexPath = curDir & "\UT99DMD\"
	
		CreateGameDMD

		Case 2 :
		Attract1.enabled=True
		World.Enabled=True
		FrameTimer.Enabled=True

		Case 3:
		CreateIntroVideo1
		startupdelay.enabled=False
		ApronRed2.state=1
		ApronBlue2.state=1
	End Select
End Sub


Dim SparkyObjectX, SparkyObjectY
Sub Sparky1_Timer
		sparky1.uservalue=sparky1.uservalue+1
		If sparky1.uservalue>5 Then spark1.z=-200 : sparky1.uservalue=0 : sparky1.enabled=False
		spark1.image="spark" & sparky1.uservalue
End Sub

Sub Sparky2_Timer
		sparky2.uservalue=sparky2.uservalue+1
		If sparky2.uservalue>5 Then spark2.z=-200 : sparky2.uservalue=0 : sparky2.enabled=False
		spark2.image="spark" & sparky2.uservalue
End Sub

Sub Sparky3_Timer
		sparky3.uservalue=sparky3.uservalue+1
		If sparky3.uservalue>5 Then spark3.z=-200 : sparky3.uservalue=0 : sparky3.enabled=False
		spark3.image="spark" & sparky3.uservalue
End Sub

Sub Sparky4_Timer
		sparky4.uservalue=sparky4.uservalue+1
		If sparky4.uservalue>5 Then spark4.z=-200 : sparky4.uservalue=0 : sparky4.enabled=False
		spark4.image="spark" & sparky4.uservalue
End Sub

Sub Sparky5_Timer
		sparky5.uservalue=sparky5.uservalue+1
		If sparky5.uservalue>5 Then spark5.z=-200 : sparky5.uservalue=0 : sparky5.enabled=False
		spark5.image="spark" & sparky5.uservalue
End Sub


Dim Nextspark
Nextspark=1
Sub SetSparks
'	debug.print "sparknr = " & nextspark
	If BallhitSparks=1 Then

		Select Case Nextspark
		Case 1 :
'			If sparky1.uservalue>0 Then debug.print "no more sparks" : Exit Sub
			sparky1.uservalue=1
			spark1.x=SparkyObjectx+(activeball.x- SparkyObjectx)/2
			spark1.y=SparkyObjecty+(activeball.y- SparkyObjectY)/2+100
			spark1.z=activeball.z-123
			spark1.image="spark1"
			sparky1.enabled=True
		Case 2 :
'			If sparky2.uservalue>0 Then debug.print "no more sparks" : Exit Sub
			sparky2.uservalue=1
			spark2.x=SparkyObjectx+(activeball.x- SparkyObjectx)/2
			spark2.y=SparkyObjecty+(activeball.y- SparkyObjectY)/2+100
			spark2.z=activeball.z-123
			spark2.image="spark1"
			sparky2.enabled=True

		Case 3 :
'			If sparky3.uservalue>0 Then debug.print "no more sparks" : Exit Sub
			sparky3.uservalue=1
			spark3.x=SparkyObjectx+(activeball.x- SparkyObjectx)/2
			spark3.y=SparkyObjecty+(activeball.y- SparkyObjectY)/2+100
			spark3.z=activeball.z-123
			spark3.image="spark1"
			sparky3.enabled=True

		Case 4 :
'			If sparky4.uservalue>0 Then debug.print "no more sparks" : Exit Sub
			sparky4.uservalue=1
			spark4.x=SparkyObjectx+(activeball.x- SparkyObjectx)/2
			spark4.y=SparkyObjecty+(activeball.y- SparkyObjectY)/2+100
			spark4.z=activeball.z-123
			spark4.image="spark1"
			sparky4.enabled=True

		Case 5 :
'			If sparky5.uservalue>0 Then debug.print "no more sparks" : Exit Sub
			sparky5.uservalue=1
			spark5.x=SparkyObjectx+(activeball.x- SparkyObjectx)/2
			spark5.y=SparkyObjecty+(activeball.y- SparkyObjectY)/2+100
			spark5.z=activeball.z-123
			spark5.image="spark1"
			sparky5.enabled=True

		End Select

		Nextspark=Nextspark+1
		If Nextspark>5 Then Nextspark=1
	End If
End Sub


'**********************************************************************************************************
'* linadri mini game
'**********************************************************************************************************

' FadeL 112 : Setp3 NL1,1.4' * neonflash
' FadeL 113 : Setp3 NL2,1.4' * neonflash
' FadeL 114 : Setp3 NL3,1.4' * neonflash
' FadeL 115 : Setp3 NL4,1.4' * neonflash
' FadeL 116 : Setp3 NL5,1.4' * neonflash
' FadeL 117 : Setp3 NL6,1.4' * neonflash
' FadeL 118 : Setp3 NL7,1.4' * neonflash
'	42=liandri minigame
'	43 lane 1 .. 1=done
'	44 lane 2 .. 1=done
'	45 lane 3 .. 1=done
'	46 lane 4 .. 1=done
'	47 lane 5 .. 1=done
' 1 each lane lites one letter,  triball= 1 letter, win map = 1 letter, 1 le

Sub ResetLiandri

	For i = 0 To 6
		SLS(112+i,1)=0
		If i=SC(PN,42) Then
			SLS(112+i,1)=2
		Elseif i<SC(PN,42) Then
			SLS(112+i,1)=1
		End If
	Next
	For i = 1 To 5
		If SC(pn,i+42)=1 Then
			SLS(i+140,1)=1
		Else
			SLS(i+140,1)=0
		End If
	Next

End Sub


Sub checkliandri
	scoring 7500,750
'	debug.print SC(pn,43) & " " & SC(pn,44) & " " & SC(pn,45) & " " & SC(pn,46) & " " & SC(pn,47) 
	For i = 43 to 47
		If SC(pn,i)=0 then exit Sub
	Next
	'reward new letter
	SLS(112+SC(pn,42),1)=1
	SC(pn,42)=SC(pn,42)+1 
	If SC(pn,42) < 7 then SLS(112+SC(pn,42),1)=2
	spb2 112,118,4,0,0,1
	for i = 1 to 5
		SLS(i+140,1)=0
		SC(pn,i+42)=0
	Next
	spb2 141,145,4,0,1,1

	if SC(pn,42) = 7 Then
		SC(pn,42) = 0
		' rewardliandri
		For i = 112 to 118	
			SLS(i,1)=0
		Next
		spb2 112,118,10,10,2,1
		spb2 141,145,10,10,0,1
		LiandriGameDone.Enabled=True
		PlaySound JP1(int(Rnd(1)*12)) , 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0
	End If
End Sub


Sub LiandriAddLetter
	SLS(112+SC(pn,42),1)=1
	SC(pn,42)=SC(pn,42)+1 
	scoring 75000,7500
	If SC(pn,42) < 7 then SLS(112+SC(pn,42),1)=2
	spb2 112,118,4,0,0,1
	spb2 141,145,4,0,0,1

	if SC(pn,42) = 7 Then
		SC(pn,42) = 0
		' rewardliandri
		For i = 112 to 118	
			SLS(i,1)=0
		Next
		spb2 112,118,10,10,2,1
		spb2 141,145,15,10,0,1

		'spb2 112,118,20,1,1,0
		'spb2 141,145,10,0,0,1
		LiandriGameDone.Enabled=True
		PlaySound JP1(int(Rnd(1)*12)) , 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0
	End If
End Sub


Sub LiandriGameDone_Timer ' reward after 3 sec
	crazyteamscore1.enabled=True
	LiandriGameDone.Enabled=False 

	spb2 112,118,5,0,2,1
	PlaySound JP1(int(Rnd(1)*12)) , 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0

	LiandriReward=1
	LiandriCounter=0
	scoring 2500000,250000
	LiandriText=FormatScore(FFTscore)

End Sub





'**********************************************************************************************************
'* snakysnakerson
'**********************************************************************************************************
DIM PF(70,50) ' 66x46
Dim SNAKEGAMEON
Dim PlayerSnake(1600,2)
Dim PlayerPosX,PlayerPosY, SnakeDir
Dim SnakeFoodX,SnakeFoodY,SnakeFoodZ,EatingOn
Dim snakelength, snakehigh, Snaketoday
Dim Wallsup, Bodysup
Dim SnakeIntro, SnakeTimer, SnakeSpeed
Dim Snakeover, snakesparkle


Snaketoday=25

Sub Snakeupdate  ' from DMD timer 17ms
	Dim Label,af,List,ii
	FlexDMD.LockRenderThread

	If snakesparkle>0 Then
		snakesparkle=snakesparkle+1
		Select Case snakesparkle
					case  2 : FlexDMD.Stage.GetImage("sparkle0").visible=True
					case  4 : FlexDMD.Stage.GetImage("sparkle1").visible=True : FlexDMD.Stage.Getimage("sparkle0").visible=False
					case  6 : FlexDMD.Stage.GetImage("sparkle2").visible=True : FlexDMD.Stage.Getimage("sparkle1").visible=False
					case  8 : FlexDMD.Stage.GetImage("sparkle3").visible=True : FlexDMD.Stage.Getimage("sparkle2").visible=False
					case 10 : FlexDMD.Stage.GetImage("sparkle4").visible=True : FlexDMD.Stage.GetImage("sparkle3").visible=False
					case 12 : FlexDMD.Stage.GetImage("sparkle5").visible=True : FlexDMD.Stage.GetImage("sparkle4").visible=False
					case 13 : FlexDMD.Stage.GetImage("sparkle6").visible=True : FlexDMD.Stage.GetImage("sparkle5").visible=False
					case 14 : FlexDMD.Stage.GetImage("sparkle7").visible=True : FlexDMD.Stage.GetImage("sparkle6").visible=False
					case 16 : FlexDMD.Stage.GetImage("sparkle8").visible=True : FlexDMD.Stage.GetImage("sparkle7").visible=False
					case 18 : FlexDMD.Stage.GetImage("sparkle9").visible=True : FlexDMD.Stage.GetImage("sparkle8").visible=False
					case 20 : FlexDMD.Stage.GetImage("sparkle10").visible=True : FlexDMD.Stage.GetImage("sparkle9").visible=False
					case 22 : FlexDMD.Stage.GetImage("sparkle11").visible=True : FlexDMD.Stage.GetImage("sparkle10").visible=False
					case 24 : FlexDMD.Stage.GetImage("sparkle12").visible=True : FlexDMD.Stage.GetImage("sparkle11").visible=False
					case 26 : FlexDMD.Stage.GetImage("sparkle13").visible=True : FlexDMD.Stage.GetImage("sparkle12").visible=False
					case 28 : FlexDMD.Stage.GetImage("sparkle14").visible=True : FlexDMD.Stage.GetImage("sparkle13").visible=False
					case 30 : FlexDMD.Stage.GetImage("sparkle15").visible=True : FlexDMD.Stage.GetImage("sparkle14").visible=False
					case 32 : FlexDMD.Stage.GetImage("sparkle16").visible=True : FlexDMD.Stage.GetImage("sparkle15").visible=False
					case 34 : FlexDMD.Stage.GetImage("sparkle17").visible=True : FlexDMD.Stage.GetImage("sparkle16").visible=False
					case 36 : FlexDMD.Stage.GetImage("sparkle18").visible=True : FlexDMD.Stage.GetImage("sparkle17").visible=False
					case 38 : FlexDMD.Stage.GetImage("sparkle19").visible=True : FlexDMD.Stage.GetImage("sparkle18").visible=False
					case 40 : FlexDMD.Stage.GetImage("sparkle20").visible=True : FlexDMD.Stage.GetImage("sparkle19").visible=False
					case 42 : FlexDMD.Stage.GetImage("sparkle21").visible=True : FlexDMD.Stage.GetImage("sparkle20").visible=False
					case 44 : FlexDMD.Stage.GetImage("sparkle22").visible=True : FlexDMD.Stage.GetImage("sparkle21").visible=False
					case 46 : FlexDMD.Stage.GetImage("sparkle23").visible=True : FlexDMD.Stage.GetImage("sparkle22").visible=False
					case 48 : 												  : FlexDMD.Stage.GetImage("sparkle23").visible=False
			snakesparkle=0
		End Select
	End If

	If ( Frame mod 12 ) = 1 Then SnakeScoreupdate

	SnakeRandomSounds
	If SnakeIntro=1 Then 
		SnakeShowIntro
		FlexDMD.UnLockRenderThread
		Exit Sub
	End If
	If SnakeIntro>1 Then
		SnakeIntro=SnakeIntro+1
		If SnakeIntro>50 Then
			SnakeIntro=0 
			SnakeTime.enabled=True
		End If
		FlexDMD.UnLockRenderThread
		Exit Sub
	End If

	If ( Frame mod 12 ) = 5 Then SnakeEating
	If ( Frame mod 12 ) = 9 Then SnakeShowArrows

	If ( Frame mod snakespeed ) = 0 Then SnakeBodyUpdate : SnakeTurningHead 
	If ( Frame mod snakespeed ) = 1 Then SnakeDisplayAll 
	
	FlexDMD.UnLockRenderThread
End Sub


Sub Snaketime_Timer
	SnakeTimer=SnakeTimer-1
	If SnakeTimer<0 Then
		PlaySound "gameover", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
		Snakeover=1
		CreateSnakeDMD 
		Snaketime.enabled=False
	End If
End Sub


Sub SnakeShowArrows
	i = PlayerPosX-SnakeFoodX
	If i > 0 Then 
		FlexDMD.Stage.GetImage("Arrow3").visible=True
		FlexDMD.Stage.GetImage("Arrow1").visible=False
	Elseif i=0 Then
		FlexDMD.Stage.GetImage("Arrow3").visible=False
		FlexDMD.Stage.GetImage("Arrow1").visible=False
	Else
		FlexDMD.Stage.GetImage("Arrow3").visible=False
		FlexDMD.Stage.GetImage("Arrow1").visible=True
	End If

	i = PlayerPosY-SnakeFoodY
	If i > 0 Then 
		FlexDMD.Stage.GetImage("Arrow0").visible=True
		FlexDMD.Stage.GetImage("Arrow2").visible=False
	Elseif i=0 Then
		FlexDMD.Stage.GetImage("Arrow0").visible=False
		FlexDMD.Stage.GetImage("Arrow2").visible=False
	Else
		FlexDMD.Stage.GetImage("Arrow0").visible=False
		FlexDMD.Stage.GetImage("Arrow2").visible=True
	End If
End Sub


Sub SnakeEating
	Dim xpos,ypos
	If EatingOn=0 Then ' need to place It
		xpos=Int(Rnd(1)*38)+2
		ypos=Int(Rnd(1)*38)+2
		If PF(13+xpos,4+ypos)=0 Then
			SnakeFoodX=xpos
			SnakeFoodY=ypos
			SnakeFoodZ=Int(Rnd(1)*7)+1
			PF(13+xpos,4+ypos)= SnakeFoodZ+2
			EatingOn=1
		End If
	End If
End Sub


Sub snake_init
	SNAKEGAMEON=1 ' use this to stopeverything else
	for i = 0 to 200
		SLS(i,1)=0
	Next
	SLS(100,1)=1
	dim ii
	for i = 0 to 70
		for ii=0 to 50
			PF(i,ii)=0
		Next
	Next

	' border ( 40x40) +13 + 4 ?
	for i = 0 to 41
		pf(13+i, 4)=1
		pf(13+i,45)=1
		pf(13, 4+i)=1  
		pf(54, 4+i)=1
	Next

	For i = 0 to 1600
		PlayerSnake(i,1)=0
		PlayerSnake(i,2)=0
	Next
	PlayerPosX=19
	PlayerPosY=19
	SnakeDir=0
	EatingOn=0
	SnakeIntro=1
	SnakeTimer=60

End Sub



Sub SnakeScoreupdate

		Set label = FlexDMD.Stage.GetLabel("Score") ' update scoring
		label.Text= CStr(abs(snakelength))
		label.SetAlignedPosition 131, 27, FlexDMD_Align_TopRight

		Set label = FlexDMD.Stage.GetLabel("HiScore") ' update scoring
		If snakelength=snakehigh Then
			If ( Frame mod 20 ) = 5 Then label.Text=" "
			If ( Frame mod 20 ) = 9 Then 
				label.Text=  CStr(abs(snakehigh))
				label.SetAlignedPosition 0, 27, FlexDMD_Align_TopLeft
			End If
		End If

	Set Label= FlexDMD.Stage.GetLabel("Timer")
	If SnakeIntro=0 Then
		label.Text=  CStr(abs(SnakeTimer))
		label.SetAlignedPosition 0, 0, FlexDMD_Align_TopLeft
	Else
		label.Text= " "
	End If
	Set Label= FlexDMD.Stage.GetLabel("Timer2")
	If SnakeIntro=0 Then
		label.Text=  CStr(abs(SnakeTimer))
		label.SetAlignedPosition 131, 0, FlexDMD_Align_TopRight
	Else
		label.Text= " "
	End If



End Sub



Sub SnakeDisplayAll
	Dim Label,af,List,ii,snakepos
		Wallsup=0
		Bodysup=0

		FlexDMD.stage.GetImage("Food").visible=False

		For i = -12 to 13
			For ii= -3 to +3
				snakepos=PF(i+13+PlayerPosX,ii+4+PlayerPosY)

				Select Case snakepos

'				If PF(i+13+PlayerPosX,ii+4+PlayerPosY)=1 Then 'Wall001
					Case 1 
						Set Title = FlexDMD.stage.GetImage("Wall"&Wallsup)
						Title.visible=True
						Set af = title.ActionFactory
						Set list = af.Sequence()
						list.Add af.MoveTo(61+i*5,13+ii*5, 0)
						title.AddAction af.Repeat(list, 1)
						Wallsup=Wallsup+1
'						debug.print "wallsup" & wallsup & " " & 62+i*5 & " " & 14+II*5
					Case 2
						Set Title = FlexDMD.stage.GetImage("Body"&Bodysup)
						Title.visible=True
						Set af = title.ActionFactory
						Set list = af.Sequence()
						list.Add af.MoveTo(61+i*5,13+ii*5, 0)
						title.AddAction af.Repeat(list, 1)
						Bodysup=Bodysup+1
'						debug.print "Bodysup" & Bodysup & " " & 62+i*5 & " " & 14+II*5
					Case 3,4,5,6,7,8,9 ' eat numbers
						Set Title = FlexDMD.stage.GetImage("Food")
						Title.visible=True
						Set af = title.ActionFactory
						Set list = af.Sequence()
						list.Add af.MoveTo(60+i*5,12+ii*5, 0)
						title.AddAction af.Repeat(list, 1)
'						debug.print "Food " & 61+i*5 & " " & 13+II*5
				End Select
			Next
		Next


		for i = Wallsup to 40
			FlexDMD.stage.GetImage("Wall"&i).visible=False
		Next
		for i = Bodysup to 170
			FlexDMD.stage.GetImage("Body"&i).visible=False
		Next


End Sub


Sub SnakeBodyUpdate
		PF(13+PlayerSnake(1,1),4+PlayerSnake(1,2))=0 ' turn off body
		for i = 0 to snakelength-1
			PlayerSnake(i,1) = PlayerSnake(i+1,1)
			PlayerSnake(i,2) = PlayerSnake(i+1,2)
		Next
		PlayerSnake(snakelength,1)=PlayerPosX
		PlayerSnake(snakelength,2)=PlayerPosY
		PF(13+PlayerPosX,4+PlayerPosY)=2
End Sub


Sub SnakeRandomSounds
		If ( frame mod 300 )=255 Then
			i = int(rnd(1)*3)
			Select Case i
				case 0 : PlaySound "hiss0", 1, 1 * BG_Volume, 0, 0,0,0, 0, 0
				case 1 : PlaySound "hiss1", 1, 0.3 * BG_Volume, 0, 0,0,0, 0, 0
				case 2 : PlaySound "hiss2", 1, 0.3 * BG_Volume, 0, 0,0,0, 0, 0
			End Select
		End If
End Sub


Sub SnakeHitSome
	i=PF(13+PlayerPosX,4+PlayerPosY)

	Select Case i
		case 1,2 
			PlaySound "gameover", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
			Snaketime.enabled=False
			Snakeover=1
			CreateSnakeDMD 
		case 3,4,5,6,7,8,9
			PF(13+PlayerPosX,4+PlayerPosY)=0
			EatingOn=0
			snakelength=snakelength+11
			If snakelength>snakehigh Then snakehigh=snakelength
			If snakelength>Snaketoday Then Snaketoday=snakelength 
			PlaySound "food", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
'			FlexDMD.stage.GetImage("Eat"&SnakeFoodZ).visible=False
	End Select
End Sub


Sub SnakeTurningHead
		If SnakeDir=0 Then
			FlexDMD.Stage.GetImage("Head0").visible=True
			PlayerPosX=PlayerPosX+1
			SnakeHitSome
		Else
			FlexDMD.Stage.GetImage("Head0").visible=False
		End If
		If SnakeDir=1 Then 
			FlexDMD.Stage.GetImage("Head1").visible=True
			PlayerPosY=PlayerPosY+1
			SnakeHitSome
		Else
			FlexDMD.Stage.GetImage("Head1").visible=False
		End If
		If SnakeDir=2 Then
			FlexDMD.Stage.GetImage("Head2").visible=True
			PlayerPosX=PlayerPosX-1
			SnakeHitSome
		Else
			FlexDMD.Stage.GetImage("Head2").visible=False
		End If
		If SnakeDir=3 Then
			FlexDMD.Stage.GetImage("Head3").visible=True
			PlayerPosY=PlayerPosY-1
			SnakeHitSome
		Else
			FlexDMD.Stage.GetImage("Head3").visible=False
		End If
End Sub



Sub SnakeShowIntro
		' just some blinking borders on supersnake
		If ( Frame mod 30 ) = 10 Then FlexDMD.Stage.GetImage("Snaketitle1").visible=True
		If ( Frame mod 30 ) = 11 Then FlexDMD.Stage.GetImage("Snaketitle1").visible=False
		If ( Frame mod 30 ) = 22 Then FlexDMD.Stage.GetImage("Snaketitle1").visible=True
		If ( Frame mod 30 ) = 24 Then FlexDMD.Stage.GetImage("Snaketitle1").visible=False

		If snakelength=snakehigh Then
			If ( Frame mod 20 ) = 5 Then FlexDMD.Stage.GetLabel("Score").Text=" "
			If ( Frame mod 20 ) = 9 Then FlexDMD.Stage.GetLabel("Score").Text= CStr(abs(snakelength))
		End If

		If ( Frame mod 900 ) =850 Then
			FlexDMD.Stage.GetLabel("Splash1").Text = " "
			FlexDMD.Stage.GetLabel("Splash2").Text = " "
		End If
		If ( Frame mod 900 ) =10 Then
			FlexDMD.Stage.GetLabel("Splash1").Text = "START BUTTON"
			FlexDMD.Stage.GetLabel("Splash1").SetAlignedPosition 64,17, FlexDMD_Align_Center
			FlexDMD.Stage.GetLabel("Splash2").Text = "TO PLAY"
			FlexDMD.Stage.GetLabel("Splash2").SetAlignedPosition 64,23, FlexDMD_Align_Center
		End If
		If ( Frame mod 900 ) =170 Then
			FlexDMD.Stage.GetLabel("Splash1").Text = " "
			FlexDMD.Stage.GetLabel("Splash2").Text = " "
		End If

		If ( Frame mod 900 ) =180 Then
			FlexDMD.Stage.GetLabel("Splash1").Text = "PLUNGER TO"
			FlexDMD.Stage.GetLabel("Splash1").SetAlignedPosition 64,17, FlexDMD_Align_Center
			FlexDMD.Stage.GetLabel("Splash2").Text = "EXIT SNAKE"
			FlexDMD.Stage.GetLabel("Splash2").SetAlignedPosition 64,23, FlexDMD_Align_Center
		End If
		If ( Frame mod 900 ) =340 Then
			FlexDMD.Stage.GetLabel("Splash1").Text = " "
			FlexDMD.Stage.GetLabel("Splash2").Text = " "
		End If
		If ( Frame mod 900 ) =350 Then
			FlexDMD.Stage.GetLabel("Splash1").Text = "FLIPPERS FOR"
			FlexDMD.Stage.GetLabel("Splash1").SetAlignedPosition 64,17, FlexDMD_Align_Center
			FlexDMD.Stage.GetLabel("Splash2").Text = "SNAKE MOVEMENT"
			FlexDMD.Stage.GetLabel("Splash2").SetAlignedPosition 64,23, FlexDMD_Align_Center
		End If
		If ( Frame mod 900 ) =510 Then
			FlexDMD.Stage.GetLabel("Splash1").Text = " "
			FlexDMD.Stage.GetLabel("Splash2").Text = " "
		End If
		If ( Frame mod 900 ) =520 Then
			FlexDMD.Stage.GetLabel("Splash1").Text = "SET YOUR SPEED"
			FlexDMD.Stage.GetLabel("Splash1").SetAlignedPosition 64,17, FlexDMD_Align_Center
			FlexDMD.Stage.GetLabel("Splash2").Text = "HIGHER = SLOWER"
			FlexDMD.Stage.GetLabel("Splash2").SetAlignedPosition 64,23, FlexDMD_Align_Center
		End If
		If ( Frame mod 900 ) =680 Then
			FlexDMD.Stage.GetLabel("Splash1").Text = " "
			FlexDMD.Stage.GetLabel("Splash2").Text = " "
		End If
		If ( Frame mod 900 ) =690 Then
			FlexDMD.Stage.GetLabel("Splash1").Text = "GONE IN 60 SECONDS"
			FlexDMD.Stage.GetLabel("Splash1").SetAlignedPosition 64,17, FlexDMD_Align_Center
			FlexDMD.Stage.GetLabel("Splash2").Text = "SO CHOOSE WISELY"
			FlexDMD.Stage.GetLabel("Splash2").SetAlignedPosition 64,23, FlexDMD_Align_Center
		End If

		FlexDMD.Stage.GetLabel("Splash3").Text = "SPEED = "&SnakeSpeed
		FlexDMD.Stage.GetLabel("Splash3").SetAlignedPosition 64,31, FlexDMD_Align_Center


End Sub


Sub SnakeHideIntro
	If Snakeover=2 Then Snakeover=0 : FlexDMD.Stage.GetImage("Gameover").Remove
	Set Title = FlexDMD.Stage.GetLabel("Splash1")
	Title.Text = "60 SECONDS"
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(-100,-10,1)
	list.Add af.Show(False)
	title.AddAction af.Repeat(list, 1)
	FlexDMD.Stage.GetImage("Snaketitle0").visible=False
	FlexDMD.Stage.GetImage("Snaketitle1").visible=False
'	FlexDMD.Stage.GetLabel("Splash1").visible=False
	FlexDMD.Stage.GetLabel("Splash2").visible=False
	FlexDMD.Stage.GetLabel("Splash3").visible=False
	SnakeIntro=2
End Sub


Sub CreateSnakeDMD
	SnakeTime.enabled=False
	snake_init

	frame=0
	DMDmode=7
	
	Dim title,af,List,i

	Set FontScoreactive = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(255, 255, 255), RGB(25, 25, 25), 1)
	Set FontScoreInactive = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(155, 185, 85), RGB(1, 1, 1), 1)
	Dim FontScoreInactive2
	Set FontScoreInactive2 = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(125, 185, 185), RGB(1, 1, 1), 1)


	Dim scene 
	Set scene = FlexDMD.NewGroup("Playfield")

	dim vidvid
	set vidvid=FlexDMD.Newvideo ("enter",FlexPath & "SNA/snakestars.gif")
	scene.GetGroup("Playfield").AddActor vidvid

'	scene.AddActor FlexDMD.NewGroup("Content")
	for i = 0 to 40
		scene.AddActor FlexDMD.NewImage("Wall"&i , FlexPath & "SNA/Wall.png" )
		scene.GetImage("Wall"&i).visible=False
	Next
	for i = 0 to 170 : scene.AddActor FlexDMD.NewImage("Body" & i , FlexPath & "SNA/Body.png" ) : Next
	for i = 0 to 170 : scene.GetImage("Body" & i).visible=False : Next

	scene.AddActor FlexDMD.NewImage("Head0", FlexPath & "SNA/Head0.png" )
	scene.GetImage("Head0").SetAlignedPosition 64,16, FlexDMD_Align_Center
	scene.AddActor FlexDMD.NewImage("Head1", FlexPath & "SNA/Head1.png" )
	scene.GetImage("Head1").SetAlignedPosition 64,16, FlexDMD_Align_Center
	scene.AddActor FlexDMD.NewImage("Head2", FlexPath & "SNA/Head2.png" )
	scene.GetImage("Head2").SetAlignedPosition 64,16, FlexDMD_Align_Center
	scene.AddActor FlexDMD.NewImage("Head3", FlexPath & "SNA/Head3.png" )
	scene.GetImage("Head3").SetAlignedPosition 64,16, FlexDMD_Align_Center
	scene.GetImage("Head0").visible=False
	scene.GetImage("Head1").visible=False
	scene.GetImage("Head2").visible=False
	scene.GetImage("Head3").visible=False

	scene.AddActor FlexDMD.NewImage("Food", FlexPath & "SNA/Food.png" )
	scene.GetImage("Food").visible=False


'	scene.AddActor FlexDMD.NewGroup("Scoring")
	scene.AddActor FlexDMD.NewLabel("Score", FontScoreactive, "0")
	scene.GetLabel("Score").SetAlignedPosition 131, 27, FlexDMD_Align_TopRight
	scene.AddActor FlexDMD.NewLabel("HiScore", FontScoreInactive, CStr(abs(snakehigh)))
	scene.GetLabel("HiScore").SetAlignedPosition 0, 27, FlexDMD_Align_TopLeft
	scene.AddActor FlexDMD.NewLabel("Timer", FontScoreInactive,"60")
	scene.GetLabel("Timer").SetAlignedPosition 0, 0, FlexDMD_Align_TopLeft
	scene.AddActor FlexDMD.NewLabel("Timer2", FontScoreInactive,"60")
	scene.GetLabel("Timer2").SetAlignedPosition 131, 0, FlexDMD_Align_TopRight

	scene.AddActor FlexDMD.NewImage("Arrow0", FlexPath & "SNA/arrowup.png" )
	scene.AddActor FlexDMD.NewImage("Arrow1", FlexPath & "SNA/arrowright.png" )
	scene.AddActor FlexDMD.NewImage("Arrow2", FlexPath & "SNA/arrowdown.png" )
	scene.AddActor FlexDMD.NewImage("Arrow3", FlexPath & "SNA/arrowleft.png" )
	scene.GetImage("Arrow0").visible=False
	scene.GetImage("Arrow1").visible=False
	scene.GetImage("Arrow2").visible=False
	scene.GetImage("Arrow3").visible=False

'	scene.AddActor FlexDMD.NewGroup("Ontop")
	scene.AddActor FlexDMD.NewImage("Snaketitle0", FlexPath & "SNA/snaketitle0.png" )
	scene.AddActor FlexDMD.NewImage("Snaketitle1", FlexPath & "SNA/snaketitle1.png" )
	scene.GetImage("Snaketitle1").visible=False
	scene.AddActor FlexDMD.NewLabel("Splash1", FontScoreInactive, "START BUTTON")
	scene.GetLabel("Splash1").SetAlignedPosition 64,17, FlexDMD_Align_Center
	scene.AddActor FlexDMD.NewLabel("Splash2", FontScoreInactive, "TO PLAY")
	scene.GetLabel("Splash2").SetAlignedPosition 64,23, FlexDMD_Align_Center
	scene.AddActor FlexDMD.NewLabel("Splash3", FontScoreInactive2, "SPEED = "&SnakeSpeed)
	scene.GetLabel("Splash3").SetAlignedPosition 64,31, FlexDMD_Align_Center


'	scene.AddActor FlexDMD.NewImage("Gameover", FlexPath & "SNA/Gameover.png" )
'	scene.AddActor FlexDMD.NewImage("Highscore", FlexPath & "SNA/highscore.png" )
'	scene.GetImage("Gameover").visible=False
'	scene.GetImage("Highscore").visible=False

'	scene.AddActor FlexDMD.NewGroup("Ontop3")
'	scene.AddActor FlexDMD.NewGroup("Ontop2")

	If Snakeover=1 Then
		Snakeover=2
			Set title = FlexDMD.NewImage("Gameover", flexpath & "SNA/Gameover.png" )
			title.Visible = False
			Set af = title.ActionFactory
			Set list = af.Sequence()
			list.Add af.Wait(0.3)
			list.add af.show(True)
			list.Add af.Wait(0.1)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.1)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.1)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.1)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.1)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			list.Add af.Wait(1.5)
			title.AddAction af.Repeat(list, 6)
			scene.AddActor title

	End If

	If snakelength=snakehigh  Then
			playsound "a38"
			Set title = FlexDMD.NewImage("Highscore", flexpath & "SNA/Highscore.png" )
			title.Visible = False
			Set af = title.ActionFactory
			Set list = af.Sequence()
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			title.AddAction af.Repeat(list, 2)
'			scene.GetGroup("Ontop3").AddActor title
			scene.AddActor title
			for i = 0 to 23
				Set title = FlexDMD.NewImage("sparkle" & i, flexpath & "SPA/sparkle" & i & ".png")
				title.SetBounds 0, 0, 128, 32
				title.Visible = False
				scene.AddActor title
			Next
			snakesparkle=1
	Elseif snakelength=Snaketoday then
			playsound "a39"

			Set title = FlexDMD.NewImage("Highscore", flexpath & "SNA/todayhigh.png" )
			title.Visible = False
			Set af = title.ActionFactory
			Set list = af.Sequence()
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			list.Add af.Wait(0.1)
			list.add af.show(True)
			list.Add af.Wait(0.2)
			list.add af.show(False)
			title.AddAction af.Repeat(list, 2)
'			scene.GetGroup("Ontop3").AddActor title
			scene.AddActor title
			for i = 0 to 23
				Set title = FlexDMD.NewImage("sparkle" & i, flexpath & "SPA/sparkle" & i & ".png")
				title.SetBounds 0, 0, 128, 32
				title.Visible = False
				scene.AddActor title
			Next
			snakesparkle=1
	End If



	FlexDMD.LockRenderThread
	FlexDMD.RenderMode =  FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	If VRroom > 0 Then FlexDMD.Show = False Else FlexDMD.Show = True
	FlexDMD.UnlockRenderThread

End Sub



Dim Controller
Sub startcontroller
	Set Controller = CreateObject("B2S.Server") 
	Controller.B2SName = "ut99ctf"
	Controller.Run
	B2SOn = True
	DB2S_on=1
End Sub

Dim B21
Sub B2STimer1_Timer
	If B2STimer1.enabled=False Then
		B2STimer1.enabled=True
		B21=6
	Else
		B21=B21-1 
		Select Case B21
			case 0,2,4 : Controller.B2SSetData 10,0
			case 1,3,5 : Controller.B2SSetData 10,1
		End Select
		If B21<0 Then B2STimer1.enabled=False
	End If
End Sub
Dim B22
Sub B2STimer2_Timer
	If B2STimer2.enabled=False Then
		B2STimer2.enabled=True
		B22=6
	Else
		B22=B22-1 
		Select Case B22
			case 0,2,4 : Controller.B2SSetData 11,0
			case 1,3,5 : Controller.B2SSetData 11,1
		End Select
		If B22<0 Then B2STimer2.enabled=False
	End If
End Sub


Sub SavePlayerLights
	If countdown30.enabled=True Then
		countdown30.enabled=False
'		debug.print "countdown saved " & lastcd & " s gone  P" & PN
		if SC(pn,33)<1000 Then SC(PN,33)=lastcd+1000
		
	End If
	
	SC(PN,49)= SLS(119,1) 
	If SC(pn,49)>0 Then SC(PN,49)=2

	If SLS(65,1)>0 Then SLS(65,1)=2
	SC(PN,22)=SLS(65,1)

	If SLS(42,1)>0 Then SLS(42,1)=2
	SC(PN,23)=SLS(42,1)

	If SLS(43,1)>0 Then SLS(43,1)=2
	SC(PN,24)=SLS(43,1)

	If SLS(41,1)>0 Then SLS(41,1)=2
	SC(PN,25)=SLS(41,1)

	If SLS(68,1)>0 Then SLS(68,1)=2 ' 
	SC(PN,26)=SLS(68,1)
End Sub



Dim PN , MaxPlayers ' current player,maxplayer=total entered

Dim tempstr, tempstr2, tempnr, tempnr2, startgame					'misc

Startgame=0

Dim MBActive  , Locked1 , Locked2 
Dim Firstblood , FastFrags 
Dim AutoKick
Dim Tilt, Tilted,TiltedBalls
Const TiltSens = 50
Dim Ownage, BallInPlay, Credits
Dim superbumpers
Dim Invisiblilty(5)



'init ' must reset all 
FFlevel=0
KSlevel=0
LostBalls=0 
MBActive=0
AutoKick=0
Ownage=0

superbumpers=0



'**********************************************************************************************************
'* CAPTURE DISPLAYS *
'**********************************************************************************************************

Sub BlueDisplay(nr)
	DisplayStrength=displayaway
	Select Case nr
		Case 0 : Mini PB1,1 : Mini PB2,1 : Mini PB3,1 : Mini PB4,1 : Mini PB5,1 : Mini PB6,1 : Mini PB7,0
		Case 1 : Mini PB1,0 : Mini PB2,1 : Mini PB3,1 : Mini PB4,0 : Mini PB5,0 : Mini PB6,0 : Mini PB7,0
		Case 2 : Mini PB1,1 : Mini PB2,1 : Mini PB3,0 : Mini PB4,1 : Mini PB5,1 : Mini PB6,0 : Mini PB7,1
		Case 3 : Mini PB1,1 : Mini PB2,1 : Mini PB3,1 : Mini PB4,1 : Mini PB5,0 : Mini PB6,0 : Mini PB7,1
		Case 4 : Mini PB1,0 : Mini PB2,1 : Mini PB3,1 : Mini PB4,0 : Mini PB5,0 : Mini PB6,1 : Mini PB7,1
		Case 5 : Mini PB1,1 : Mini PB2,0 : Mini PB3,1 : Mini PB4,1 : Mini PB5,0 : Mini PB6,1 : Mini PB7,1
		Case 6 : Mini PB1,0 : Mini PB2,0 : Mini PB3,1 : Mini PB4,1 : Mini PB5,1 : Mini PB6,1 : Mini PB7,1
		Case 7 : Mini PB1,1 : Mini PB2,1 : Mini PB3,1 : Mini PB4,0 : Mini PB5,0 : Mini PB6,0 : Mini PB7,0
		Case 8 : Mini PB1,1 : Mini PB2,1 : Mini PB3,1 : Mini PB4,1 : Mini PB5,1 : Mini PB6,1 : Mini PB7,1
		Case 9 : Mini PB1,1 : Mini PB2,1 : Mini PB3,1 : Mini PB4,0 : Mini PB5,0 : Mini PB6,1 : Mini PB7,1
		Case 10: Mini PB1,0 : Mini PB2,0 : Mini PB3,0 : Mini PB4,0 : Mini PB5,0 : Mini PB6,0 : Mini PB7,0
		Case 11: MINI PB1,int(rnd(1)*2)
				 Mini PB2,int(rnd(1)*2) 
				 Mini PB3,int(rnd(1)*2) 
				 Mini PB4,int(rnd(1)*2) 
				 Mini PB5,int(rnd(1)*2) 
				 Mini PB6,int(rnd(1)*2) 
				 Mini PB7,int(rnd(1)*2)
	End Select
End Sub

Dim DisplayStrength,displayhome,displayaway
Sub RedDisplay(nr)
	DisplayStrength=displayhome

	Select Case nr

		Case 0 : Mini PR1,1 : Mini PR2,1 : Mini PR3,1 : Mini PR4,1 : Mini PR5,1 : Mini PR6,1 : Mini PR7,0
		Case 1 : Mini PR1,0 : Mini PR2,1 : Mini PR3,1 : Mini PR4,0 : Mini PR5,0 : Mini PR6,0 : Mini PR7,0
		Case 2 : Mini PR1,1 : Mini PR2,1 : Mini PR3,0 : Mini PR4,1 : Mini PR5,1 : Mini PR6,0 : Mini PR7,1
		Case 3 : Mini PR1,1 : Mini PR2,1 : Mini PR3,1 : Mini PR4,1 : Mini PR5,0 : Mini PR6,0 : Mini PR7,1
		Case 4 : Mini PR1,0 : Mini PR2,1 : Mini PR3,1 : Mini PR4,0 : Mini PR5,0 : Mini PR6,1 : Mini PR7,1
		Case 5 : Mini PR1,1 : Mini PR2,0 : Mini PR3,1 : Mini PR4,1 : Mini PR5,0 : Mini PR6,1 : Mini PR7,1
		Case 6 : Mini PR1,0 : Mini PR2,0 : Mini PR3,1 : Mini PR4,1 : Mini PR5,1 : Mini PR6,1 : Mini PR7,1
		Case 7 : Mini PR1,1 : Mini PR2,1 : Mini PR3,1 : Mini PR4,0 : Mini PR5,0 : Mini PR6,0 : Mini PR7,0
		Case 8 : Mini PR1,1 : Mini PR2,1 : Mini PR3,1 : Mini PR4,1 : Mini PR5,1 : Mini PR6,1 : Mini PR7,1
		Case 9 : Mini PR1,1 : Mini PR2,1 : Mini PR3,1 : Mini PR4,0 : Mini PR5,0 : Mini PR6,1 : Mini PR7,1
		Case 10: Mini PR1,0 : Mini PR2,0 : Mini PR3,0 : Mini PR4,0 : Mini PR5,0 : Mini PR6,0 : Mini PR7,0
		Case 11: MINI PR1,int(rnd(1)*2)
				 Mini PR2,int(rnd(1)*2) 
				 Mini PR3,int(rnd(1)*2) 
				 Mini PR4,int(rnd(1)*2) 
				 Mini PR5,int(rnd(1)*2) 
				 Mini PR6,int(rnd(1)*2) 
				 Mini PR7,int(rnd(1)*2) 
	End Select
End Sub

Sub MINI(object,onoff)
	object.visible=onoff
	object.BlendDisableLighting = onoff*DisplayStrength/20

End Sub





'**********************************************************************************************************
'* Start Next Player or Next Ball *
'**********************************************************************************************************

Dim playchamp
Sub GameOVER
	SignTurnOFF.Enabled=True
	nl001.image="gameover"


	createvidGAMEOVER
	allDTdrop
	countdown30.enabled=False
	LFinfo=0 : RFinfo=0
	playchamp=0
	If SC(1,27)>2 Then playchamp=1
	If SC(2,27)>2 Then playchamp=1
	If SC(3,27)>2 Then playchamp=1
	If SC(4,27)>2 Then playchamp=1
	If playchamp=1 Then
		endmusic
		Playmusic "UnrealTournament/UT-Champions.mp3"
		MusicVolume=Music_Volume
	Else
		EndMusic
		Playmusic "UnrealTournament/UT-Menu.mp3"
		MusicVolume=Music_Volume

	End If
	for i = 0 to 200
		SLS(i,1)=0
	Next

	SLS (146,1)=2
	SLS(100,1)=1 ' plungerRed always on
	for i = 179 to 190

		SLS(i,1)=1		' TURNgi ON 
		SLS(i,2)=333  ' blink GI alittle
	Next

	startgame=2
	leftflipper.rotatetostart
	rightflipper.rotatetostart

	FoggymcFoggerson=1


	LockBolt1.Z=88
	LockBolt1.collidable=False
'	debug.Print "Boltmoved DOWN"
	If SC(1,1)>0 And osbactive = 1 Then SubmitOSBScore SC(1,1)
	If SC(2,1)>0 And osbactive = 1 Then SubmitOSBScore SC(2,1)
	If SC(3,1)>0 And osbactive = 1 Then SubmitOSBScore SC(3,1)
	If SC(4,1)>0 And osbactive = 1 Then SubmitOSBScore SC(4,1)
End Sub

'*orbital scoreboard
'****************************
' POST SCORES
'****************************



'	Dim osbtempscore:osbtempscore = 0
	Sub SubmitOSBScore(osbtempscore)
		If osbkey="" Then Exit Sub
'		pupDMDDisplay "-","Uploading Your^Score to OSB",dmdnote,3,0,10
		On Error Resume Next
		if osbactive = 1 Then
			Dim objXmlHttpMain, Url, strJSONToSend 

			Url = "https://hook.integromat.com/82bu988v9grj31vxjklh2e4s6h97rnu0"

			strJSONToSend = "{""auth"":""" & osbkey &""",""player id"": """ & osbid & """,""player initials"": """ & osbdefinit &""",""score"": " & CStr(osbtempscore) & ",""table"":"""& cGameName & """,""version"":""" & OSDversion & """}"

			Set objXmlHttpMain = CreateObject("Msxml2.ServerXMLHTTP")
			objXmlHttpMain.open "PUT",Url, False
			objXmlHttpMain.setRequestHeader "Content-Type", "application/json"
			objXmlHttpMain.setRequestHeader "application", "application/json"

			objXmlHttpMain.send strJSONToSend
		end if
	End Sub	



'****************************
'*GAMEOVER TIMER*
'****************************

Dim checkHS : checkHS=9  ' must be 9 to alow startbutton to work for first game
Dim HSname, TodaysBest

Sub GameOverTimer_Timer   ' 500ms

	If GameOverTimer.enabled=False Then
		GameOverTimer.enabled=True
		checkHS=0
		Lastscore(1)=SC(1,1)
		Lastscore(2)=SC(2,1)
		Lastscore(3)=SC(3,1)
		Lastscore(4)=SC(4,1)

		If Not Thisistheday=Month(Now())&Day(Now()) Then
			TodaysBest=0
			Thisistheday=Month(Now())&Day(Now()) 
		End If

		If SC(1,1)>TodaysBest Then TodaysBest=SC(1,1)
		If SC(2,1)>TodaysBest Then TodaysBest=SC(2,1)
		If SC(3,1)>TodaysBest Then TodaysBest=SC(3,1)
		If SC(4,1)>TodaysBest Then TodaysBest=SC(4,1)

	Else
		
		If checkHS=0 Then  ' player 1	  
			LockBolt1.Z=88
			LockBolt1.collidable=False
			Locked1=0
			Locked2=0
'			debug.Print "Boltmoved DOWN"
			If SC(1,1)> HScore(1) Then
				AwardReplay
				Award2xReplay
				HSNAME=1
				hScore(3)=hScore(2) : highscorename(3)=highscorename(2)
				hScore(2)=hScore(1) : highscorename(2)=highscorename(1)
				hScore(1)=SC(1,1)

				InitialPlayer=1
				FlexInitInit
				checkHS=1 '  stop everything until entered name is done
				Exit Sub
			Elseif SC(1,1)>hScore(2) Then
				AwardReplay
				HSNAME=2
				hScore(3)=hScore(2) : highscorename(3)=highscorename(2)
				hScore(2)=SC(1,1)

				InitialPlayer=1
				FlexInitInit
				checkHS=1 '  stop everything until entered name is done
				Exit Sub
				
			Elseif SC(1,1)>hScore(3) Then
				AwardReplay
				HSNAME=3
				hScore(3)=SC(1,1)

				InitialPlayer=1
				FlexInitInit
				checkHS=1 '  stop everything until entered name is done
				Exit Sub
			End If
			checkHS=2 ' next player
		End If

		If checkHS=2 Then  ' player 2	
			If SC(2,1)> HScore(1) Then
				AwardReplay
				Award2xReplay
				HSNAME=1
				hScore(3)=hScore(2) : highscorename(3)=highscorename(2)
				hScore(2)=hScore(1) : highscorename(2)=highscorename(1)
				hScore(1)=SC(2,1)

				InitialPlayer=2
				FlexInitInit
				checkHS=3 '  stop everything until entered name is done
				Exit Sub
			Elseif SC(2,1)>hScore(2) Then
				AwardReplay
				HSNAME=2
				hScore(3)=hScore(2) : highscorename(3)=highscorename(2)
				hScore(2)=SC(2,1)

				InitialPlayer=2
				FlexInitInit
				checkHS=3 '  stop everything until entered name is done
				Exit Sub
			Elseif SC(2,1)>hScore(3) Then
				AwardReplay
				HSNAME=3
				hScore(3)=SC(2,1)

				InitialPlayer=2
				FlexInitInit
				checkHS=3 '  stop everything until entered name is done
				Exit Sub
			End If
			checkHS=4 ' next player
		End If	

		If checkHS=4 Then  ' player 3	
			If SC(3,1)> HScore(1) Then
				AwardReplay
				Award2xReplay

				HSNAME=1
				hScore(3)=hScore(2) : highscorename(3)=highscorename(2)
				hScore(2)=hScore(1) : highscorename(2)=highscorename(1)
				hScore(1)=SC(3,1)

				InitialPlayer=3
				FlexInitInit
				checkHS=5 '  stop everything until entered name is done
				Exit Sub
			Elseif SC(3,1)>hScore(2) Then
				AwardReplay

				HSNAME=2
				hScore(3)=hScore(2) : highscorename(3)=highscorename(2)
				hScore(2)=SC(3,1)
				InitialPlayer=3

				FlexInitInit
				checkHS=5 '  stop everything until entered name is done
				Exit Sub
			Elseif SC(3,1)>hScore(3) Then
				AwardReplay

				HSNAME=3
				hScore(3)=SC(3,1)

				InitialPlayer=3
				FlexInitInit
				checkHS=5 '  stop everything until entered name is done
				Exit Sub
			End If
			checkHS=6 ' next player
		End If	

		If checkHS=6 Then  ' player 4	
			If SC(4,1)> HScore(1) Then
				AwardReplay
				Award2xReplay
				HSNAME=1
				hScore(3)=hScore(2) : highscorename(3)=highscorename(2)
				hScore(2)=hScore(1) : highscorename(2)=highscorename(1)
				hScore(1)=SC(4,1)

				InitialPlayer=4
				FlexInitInit
				checkHS=7 '  stop everything until entered name is done
				Exit Sub
			Elseif SC(4,1)>hScore(2) Then
				AwardReplay

				HSNAME=2
				hScore(3)=hScore(2) : highscorename(3)=highscorename(2)
				hScore(2)=SC(4,1)

				InitialPlayer=4
				FlexInitInit
				checkHS=7 '  stop everything until entered name is done
				Exit Sub
			Elseif SC(4,1)>hScore(3) Then
				AwardReplay

				HSNAME=3
				hScore(3)=SC(4,1)

				InitialPlayer=4
				FlexInitInit
				checkHS=7 '  stop everything until entered name is done
				Exit Sub
			End If
			checkHS=8 ' next player
			exit Sub
		End If	

		If checkhS=8 Then
			CreateIntroVideo2 ' moved from 11
			for i = 0 to 50
				SC(1,i)=0
				SC(2,i)=0
				SC(3,i)=0
				SC(4,i)=0
			Next' reset all players
			checkhS=9


			Exit Sub

		End If
		
		If checkHS=9 Then checkHS=10 : Exit Sub
		If checkHS=10 Then checkHS=11 :  Exit Sub
		If checkHS=11 Then checkHS=12 : Startgame=3 : Exit Sub



		If checkhS=12 Then
			Locked1=0 : Locked2=0
			If startgame=1 Then
				GameOverTimer.enabled=False
			End If
		End If

	End If
End Sub


Sub l60b_Timer

	dim xx
	xx=0

	i= (Bumper1Cap.Roty mod 360)
	If i>0 Then
		i=i+2
		xx=1
		If i>359 then
			i=0 
			PlaySound "Blade_Ric", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
		End If
	End If
	Bumper1Cap.Roty=i

	i= (Bumper2Cap.Roty mod 360)
	If i>0 Then
		i=i+2
		xx=1
		If i>359 then
			i=0 
			PlaySound "Blade_Ric", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
		End If
	End If
	Bumper2Cap.Roty=i

	i= (Bumper3Cap.Roty mod 360)
	If i>0 Then
		i=i+2
		xx=1
		If i>359 then
			i=0 
			PlaySound "Blade_Ric", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
		End If
	End If
	Bumper3Cap.Roty=i 

	If xx=0 Then l60b.timerenabled=False

End Sub



Dim NewPlayerNewBall
Sub StartNewPlayer
	playsound "Blade_travel", 1,0.1*VolumeDial,0,0,0,0,0,0
	l60b.Timerenabled=True   ' RESET bumpers to 0 pos
	quickMBlimit=7  ' reset for every ball

'	FadeL 155 : Setp3 Bwp001,4.4
'.'
'	FadeL 174 : Setp3 Bwp020,4.4
'	FadeL 147 : Setp3 Bwp021,4.4
'	FadeL 148 : Setp3 Bwp022,4.4
'	FadeL 149 : Setp3 Bwp023,4.4
	for i = 155 to 174 : SLS(i,1)=0 : Next


	crazyteamscore1.enabled=True
	NewPlayerNewBall=1

	permaspinners=0
	superspinner.enabled=False
	superspi=0

	TrippleHS=0
	DoubleHS=0
	P044.material="InsertWhiteOnTri"
	Lastcap=0
	Lastcap2=0 
	lastcap3=0


	LFinfo=0 : RFinfo=0
'	Debug.Print "StartNewPlayer"
'	Debug.Print "ExtraBall=" & Extraball & "EXTRA EXTRA=" & EXTRAEXTRALIFE

	quickMBcounter=0
	pwnageMBready=0	
	pwnage=0
	Invisiblilty(1)=0
	Invisiblilty(2)=0
	Invisiblilty(3)=0
	Invisiblilty(4)=0
	Invisiblilty(5)=0
	If RampEB<100 Then RampEB=0

	If TournamentMode=0 Then ' skip extraballs since they dont want to cooperate
		If RampEB=100 Then
			RampEB=200 
			Addpopup "EXTRA LIFE","EXTRA LIFE",fontbig3
			SLS(85,1)=0
			RESETFORNEWBALL
			ResetLiandri
			SetTeamColors
			' room of champions
			If SC(PN,34) = 1 Then ' room of champions lit
				SLS(54,1)=2 ' should forever blink
				SLS(54,3)=18 'pause
			Else
				SLS(54,1)=0
			End If
			If Extraball=2 or EXTRAEXTRALIFE=1 Then SLS(85,1)=1
			SPB2 85,85,11,0,0,1
	
			SLS(73,1)=1
			SLS(74,1)=1
			SPB1 71,74,10,2,0,1
			RedDisplay SC(PN,28)
			BlueDisplay SC(PN,29)
			If L063.timerenabled=True Then
				L063.timerenabled=False
				FlagOn10=0
				L063.timerenabled=True	
			End If
				KBstatus=1
				SLS(49,1)=1
				LiteKBstatus=0
				SLS(47,1)=0
	
			ProgressBarReset
			Exit Sub
		End If
	
	
		If EXTRAEXTRALIFE=1 Then
			EXTRAEXTRALIFE=0 
	'		Debug.Print "EXTRA EXTRA=" & EXTRAEXTRALIFE
			Addpopup "EXTRA LIFE","EXTRA LIFE",fontbig3
			SLS(85,1)=0
			RESETFORNEWBALL
			ResetLiandri
			SetTeamColors
			' room of champions
			If SC(PN,34) = 1 Then ' room of champions lit
				SLS(54,1)=2 ' should forever blink
				SLS(54,3)=18 'pause
			Else
				SLS(54,1)=0
			End If
	
			If Extraball=2 Then SLS(85,1)=1
			SPB2 85,85,11,0,0,1
	
			SLS(73,1)=1
			SLS(74,1)=1
			SPB1 71,74,10,2,0,1
			RedDisplay SC(PN,28)
			BlueDisplay SC(PN,29)
			If L063.timerenabled=True Then
				L063.timerenabled=False
				FlagOn10=0
				L063.timerenabled=True	
			End If
			ProgressBarReset
				KBstatus=1
				SLS(49,1)=1
				LiteKBstatus=0
				SLS(47,1)=0
	
			Exit Sub
		End If
	
		If Extraball=2 Then
			ExtraBall=3 ' prevent getting another on same BIP
	'		Debug.Print "ExtraBall=" & Extraball
			Addpopup "EXTRA LIFE","EXTRA LIFE",fontbig3
			SLS(85,1)=0
			SPB1 85,85,4,1,1,1
			RESETFORNEWBALL
			ResetLiandri
			SetTeamColors
			' room of champions
			If SC(PN,34) = 1 Then ' room of champions lit
				SLS(54,1)=2 ' should forever blink
				SLS(54,3)=18 'pause
			Else
				SLS(54,1)=0
			End If
	
			SLS(73,1)=1
			SLS(74,1)=1
			SPB1 71,74,10,2,0,1
			RedDisplay SC(PN,28)
			BlueDisplay SC(PN,29)
			If L063.timerenabled=True	Then
				L063.timerenabled=False
				FlagOn10=0
				L063.timerenabled=True
			End If
			ProgressBarReset
			KBstatus=1
			SLS(49,1)=1
			LiteKBstatus=0
			SLS(47,1)=0

			Exit Sub
		End If
	End If

	Extraball=0
	RampEB=0
	PN=PN+1

	IF PN>MAXplayers Then 
		StopAddingPlayers=1 
		PN=1 
		Ballinplay=Ballinplay+1 
		If Ballinplay>3 then GAMEOVER : exit Sub
	End If

	If Ballinplay=1 Then 
		Firstblood=0 ' ONCE FOR ALL PLAYERS
	Else
		Firstblood=1
	End If

	RESETFORNEWBALL

	ResetLiandri
	SPB2 112,118,3,0,0,1


	' room of champions
	If SC(PN,34) = 1 Then ' room of champions lit
		SLS(54,1)=2 ' should forever blink
		SLS(54,3)=18 'pause
	Else
		SLS(54,1)=0
	End If

	SetTeamColors
	SLS(73,1)=1
	SLS(74,1)=1
	SPB1 71,74,10,2,0,1
	RedDisplay SC(PN,28)
	BlueDisplay SC(PN,29)

	If SC(PN,27)=0 Then ' 0 = level1
		SLS( 7,1)=1  ' handicap on level 1, make sure those are on
		SLS(15,1)=1
		SLS(20,1)=1
		SLS(25,1)=1
		SLS(30,1)=1
		IF SC(PN,12)=0 Then SC(PN,12)=1
		IF SC(PN,13)=0 Then SC(PN,13)=1
		IF SC(PN,14)=0 Then SC(PN,14)=1
		IF SC(PN,15)=0 Then SC(PN,15)=1
		IF SC(PN,16)=0 Then SC(PN,16)=1

	End If
	If 	SLS(41,1)>0	Then
		L063.timerenabled=False
		FlagOn10=0
		L063.timerenabled=True	
	End If

'	SetMapON
	SPB2 50,53,3,0,0,1
	if SC(PN,27)=0 Then SLS(50,1)=1 : SPB2 50,50,10,0,0,1
	if SC(PN,27)=1 Then SLS(53,1)=1 : SPB2 53,53,10,0,0,1
	if SC(PN,27)=2 Then SLS(52,1)=1 : SPB2 52,52,10,0,0,1
	if SC(PN,27)=3 Then SLS(51,1)=1 : SPB2 51,51,10,0,0,1


	allDTdrop
	ProgressBarReset
			KBstatus=1
			SLS(49,1)=1 : SLS(49,5)=0
			LiteKBstatus=0
			SLS(47,1)=0

End Sub



Dim crazycounter
Sub crazyteamscore1_Timer
	crazycounter=crazycounter+1
	RedDisplay 11'SC(PN,28)
	BlueDisplay 11'SC(PN,29)

	if crazycounter = 50 Then
		crazycounter=0
		RedDisplay SC(PN,28)
		BlueDisplay SC(PN,29)
		crazyteamscore1.enabled=False
	End If
End Sub



Sub RESETFORNEWBALL
	SetMapOff
	lostballs=0
	Lightsout
	SPB2 1,178,3,7,0,1

	superspinner.enabled=False
	superspi=0

	L035.timerenabled=False
	L036.timerenabled=False
	L037.timerenabled=False
	L038.timerenabled=False
	L039.timerenabled=False
	L040.timerenabled=False
	Sw25.isdropped=False
	Sw26.isdropped=False
	Sw27.isdropped=False
	Sw33.isdropped=False
	Sw34.isdropped=False
	Sw35.isdropped=False
	
	L049.timerenabled=False
	KBStatus=1
'	debug.print "kickback ON"
	SLS(49,1)=1 ' KB ON
	LiteKBstatus=0
	SLS(47,1)=0
'L047.timerenabled=False
		'  restore plyers Lights

		SC(PN,2)=0 ' bonus Reset
		SC(PN,3)=0
		SC(PN,4)=0
		SC(PN,11)=0
		SC(PN,4)=0  'DT Reset
		SC(PN,5)=0
		SC(PN,6)=0
		SC(PN,7)=0
		SC(PN,8)=0
		SC(PN,9)=0
		SC(PN,10)=0

		If SC(PN,13)>0 Then SLS( 7,1)=1'	12  Rightorbit
		If SC(PN,13)>1 Then SLS( 8,1)=1
		If SC(PN,13)>2 Then SLS( 9,1)=1
		If SC(PN,13)>3 Then SLS(10,1)=1
		If SC(PN,13)>4 Then SLS(11,1)=1

		If SC(PN,12)>0 Then SLS(15,1)=1'	13  Leftorbit nr(1-5=nr of lights lit) + more states ?
		If SC(PN,12)>1 Then SLS(16,1)=1
		If SC(PN,12)>2 Then SLS(17,1)=1
		If SC(PN,12)>3 Then SLS(18,1)=1
		If SC(PN,12)>4 Then SLS(19,1)=1

		If SC(PN,14)>0 Then SLS(20,1)=1'	14  kicker1
		If SC(PN,14)>1 Then SLS(21,1)=1
		If SC(PN,14)>2 Then SLS(22,1)=1
		If SC(PN,14)>3 Then SLS(23,1)=1
		If SC(PN,14)>4 Then SLS(24,1)=1

		If SC(PN,15)>0 Then SLS(25,1)=1'	15  kicker2
		If SC(PN,15)>1 Then SLS(26,1)=1
		If SC(PN,15)>2 Then SLS(27,1)=1
		If SC(PN,15)>3 Then SLS(28,1)=1
		If SC(PN,15)>4 Then SLS(29,1)=1

		If SC(PN,16)>0 Then SLS(30,1)=1'	16  kicker3
		If SC(PN,16)>1 Then SLS(31,1)=1
		If SC(PN,16)>2 Then SLS(32,1)=1
		If SC(PN,16)>3 Then SLS(33,1)=1
		If SC(PN,16)>4 Then SLS(34,1)=1

'		SC(PN,18)=0
		SC(PN,19)=0

		SLS(65,1)=SC(PN,22)
		SLS(66,1)=SC(PN,22) ' CP

 		SLS(43,1)=SC(PN,24) ' EB
		SLS(41,1)=SC(PN,25) ' EF
		SLS(70,1)=SC(PN,25)
		SLS(48,1)=SC(PN,25)
		SLS(63,1)=SC(PN,25)

		SLS(119,1)=SC(PN,49)


		SLS(42,1)=SC(PN,23) ' CAP
		If SLS(41,1)>1 and SC(PN,23)>1 Then SLS(42,1)=1
		SLS(68,1)=SC(PN,26) ' TP



		' LockBolt  up/down and divider on if light 65 is flashing 
		If locked1=1 or Locked2=1 Then 
			LockBolt1.Z=140
			LockBolt1.collidable=True
'			debug.Print "Boltmoved UP"
		Else
			LockBolt1.Z=88
			LockBolt1.collidable=False
'			debug.Print "Boltmoved DOWN"
		End If

		If SLS(65,1)>1 Then
			LockBolt1.Z=140
			LockBolt1.collidable=True
'			debug.Print "Boltmoved UP"
		End If

		If SLS(65,1)>1 Or SLS(67,1)>1 Then
			DividerWall1_Timer ' open if a light is on
		Else
			DividerWall0_Timer ' else must close this
		End If


		MusicVolume=Music_Volume*0.7
		Superbumpers=0
		SC(PN,11)=0
		FFlevel=0
		KSlevel=0
		LostBalls=0 
		MBActive=0
		Ownage=0

		PlaySound "Prepare", 1, 0.3 * BG_Volume, 0, 0,0,0, 0, 0 '  .... red leader and red balls that sor of thing, according to operation manual ?
		Addpopup "  PLAYER " & PN,"PREPARE",fontbig1

		AutoKick=0  ' wait for plunger key
		Skillshotactive=1

		RespawnWaiting=RespawnWaiting+1
		PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease

			DOF 151,2 
'			If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"
		L062.timerenabled=False
		L062_Timer  
		L063_Timer
End Sub

'**********************************************************************************************************
'* Lightsout *
'**********************************************************************************************************
	
Sub Lightsout

	for i = 0 to 200 
			SLS(i,0)=0 ' new double speed blinking flag for sp state 
			SLS(i,1)=0
			SLS(i,2)=0
			SLS(i,3)=0
			SLS(i,4)=0
			SLS(i,5)=0
			SLS(i,6)=0
			SLS(i,7)=0
			SLS(i,8)=0
			SLS(i,9)=0
			SLS(i,10)=0
			SLS(i,11)=0
			SLS(i,12)=0 
	Next ' TURNoff everything not the XY pos  on 13,14
	SLS(100,1)=1 ' plungerRed always on
	for i = 179 to 190

		SLS(i,1)=1		' TURNgi ON 
		SLS(i,2)=123  ' blink for 123 updates ' 1 solid blink=33 ``?
	Next
	PlaySound "fx_relay", 1,0.2*VolumeDial,0,0,0,0,0,0

	kickback.PULLBACK
	PlaySoundAtLevelStatic ("Plunger_Pull_1"), PlungerPullSoundLevel, kickback
	L049.timerenabled=False 
	KBStatus=1
'	debug.print "kickback ON"

	SLS(49,1)=1 ' KB ON
	LiteKBstatus=0
	SLS(47,1)=0


End Sub



'**********************************************************************************************************
'* GAMESTART *
'**********************************************************************************************************

SUB GAMESTARTER

	quickMBlimit=7

	for i = 155 to 174 : SLS(i,1)=0 : Next
	ProgressbarCounter=0


	SignTurnON.enabled=True
	crazyteamscore1.enabled=True
	quickMBcounter=0
	NewPlayerNewBall=1

	SC(1,1)=0
	SC(2,1)=0
	SC(3,1)=0
	SC(4,1)=0
		Lastscore(1)=0
		Lastscore(2)=0
		Lastscore(3)=0
		Lastscore(4)=0

	gottenreplay(1)=0
	gottenreplay(2)=0
	gottenreplay(3)=0
	gottenreplay(4)=0

	SetReplaytarget

	TrippleHS=0
	DoubleHS=0
	P044.material="InsertWhiteOnTri"
	Lastcap=0
	Lastcap2=0 
	lastcap3=0

	StopAddingPlayers=0

	locked1=0
	locked2=0
	pwnage=0
	Invisiblilty(1)=0
	Invisiblilty(2)=0
	Invisiblilty(3)=0
	Invisiblilty(4)=0
	Invisiblilty(5)=0
	If DB2S_on Then B2STimer2_Timer  ' or b2stimer2 for big one
	DividerWall0_Timer ' be sure to turn it to normal up there
	LockBolt1.Z=88
	LockBolt1.collidable=False
'	debug.Print "Boltmoved down"

	initialmusic=1
	Startgame=1
	BallInPlay=1
'	LightsOut


	lostballs=0
	RespawnWaiting=RespawnWaiting+1
		PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease

	DOF 151,2 
'	If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"

	PlaySound "Prepare", 1, 0.3 * BG_Volume, 0, 0,0,0, 0, 0 '  .... red leader and red balls that sor of thing, according to operation manual ?
	MusicOn  ' change music


	AutoKick=0  ' wait for plunger key
	Skillshotactive=1

	L062.timerenabled=False
	L062_Timer

	'Player1
	PN=1
  	MaxPLayers=1 

	SetTeamColors
	SLS(73,1)=1
	SLS(74,1)=1
	SPB1 71,74,5,2,0,1
	
	RedDisplay 0
	BlueDisplay 0

	SC(1,32)=5 ' GETFLAGBACK LIMIT SET ON ALL PLAYERS
	SC(2,32)=5
	SC(3,32)=5
	SC(4,32)=5

	SLS( 7,1)=1  ' handicap on level 1
	SLS(15,1)=1
	SLS(20,1)=1
	SLS(25,1)=1
	SLS(30,1)=1

	SC(PN,12)=1
	SC(PN,13)=1
	SC(PN,14)=1
	SC(PN,15)=1
	SC(PN,16)=1


	SC(1,20) = Taunt(1)
	SC(2,20) = Taunt(2)
	SC(3,20) = Taunt(3)
	SC(4,20) = Taunt(4)

	SetMapOff

	If TournamentMode=1 Then
		SC(1,27)=2
		SC(2,27)=2
		SC(3,27)=2
		SC(4,27)=2
	End If
	SPB2 50,53,3,0,0,1
	if SC(PN,27)=0 Then SLS(50,1)=1 : SPB2 50,50,10,0,0,1
	if SC(PN,27)=1 Then SLS(53,1)=1 : SPB2 53,53,10,0,0,1
	if SC(PN,27)=2 Then SLS(52,1)=1 : SPB2 52,52,10,0,0,1
	if SC(PN,27)=3 Then SLS(51,1)=1 : SPB2 51,51,10,0,0,1
	
	ResetLiandri
	SPB2 112,118,3,0,0,1
	Gidark1234.Enabled=True
	Gidark1234.interval=2000

	allDTdrop
	
End Sub

Sub SetMapOff
	SLS(50,1)=0
	SLS(51,1)=0
	SLS(52,1)=0
	SLS(53,1)=0
End Sub


'**********************************************************************************************************
'* BONUS TIME AT BALL LOST *
'**********************************************************************************************************

Dim BonusCounter,BonusX,bonusblinks
Sub BonusTime_Timer ' 60ms
	If BonusTime.enabled=False Then
		If 	SLS(41,1)>0	Then
			L063.timerenabled=False
			FlagOn10=0
			L063.timerenabled=True	' keeping this alive but resetting it
		End If

		BonusTime.Enabled=True
		PlaySound "UT_TitleB", 1, 0.7 * Music_Volume, 0, 0,0,0, 0, 0
		MusicVolume=0.05
'		debug.print "BONUS no multi =" & SC(PN,0)
		If SC(PN,11)=1 Then  SC(PN,0)=SC(PN,0)*2 : spb1 2,2,6,2,10,1
		If SC(PN,11)=2 Then  SC(PN,0)=SC(PN,0)*3 : spb1 2,3,6,2,10,1
		If SC(PN,11)=3 Then  SC(PN,0)=SC(PN,0)*4 : spb1 2,4,6,2,10,1
		If SC(PN,11)=4 Then  SC(PN,0)=SC(PN,0)*6 : spb1 2,5,6,2,10,1
		If SC(PN,11)>4 Then  SC(PN,0)=SC(PN,0)*8 : spb1 2,6,6,2,10,1
'		debug.print "BONUS X Multi =" & SC(PN,0)

		Addpopup "  BONUS ", "  " & FormatScore(SC(PN,0)),fontbig1
		BonusCounter=0
		LFinfo=0 : RFinfo=0
		bonusblinks=15

	Else
		bonusblinks=bonusblinks-1
		If bonusblinks<0 Then
			bonusblinks=15
			Objlevel(5) = 1 : FlasherFlash5_Timer
			If SC(PN,11)=1 Then  spb2 2,2,2,0,0,1
			If SC(PN,11)=2 Then  spb2 2,3,2,0,0,1
			If SC(PN,11)=3 Then  spb2 2,4,2,0,0,1
			If SC(PN,11)=4 Then  spb2 2,5,2,0,0,1
			If SC(PN,11)>4 Then  spb2 2,6,2,0,0,1

		End If


		BonusCounter=BonusCounter+1
		If BonusCounter=60 Then
			PlaySound "hum4", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
			If RampEB=100 or Extraball=2 or EXTRAEXTRALIFE=1 Then SPB2 85,85,5,0,0,1
		End If

		If BonusCounter<60 Then exit Sub
		If SC(PN,0)>1000000 Then SC(PN,0)=SC(PN,0)-1000000 : SC(PN,1)=SC(PN,1)+1000000 : exit Sub
		If SC(PN,0)>100000 Then SC(PN,0)=SC(PN,0)-100000 : SC(PN,1)=SC(PN,1)+100000 : exit Sub
		If SC(PN,0)>20000  Then SC(PN,0)=SC(PN,0)-10000  : SC(PN,1)=SC(PN,1)+10000  : exit Sub
		If SC(PN,0)>1000   Then SC(PN,0)=SC(PN,0)-1000   : SC(PN,1)=SC(PN,1)+1000   : exit Sub
		If SC(PN,0)>200    Then SC(PN,0)=SC(PN,0)-100    : SC(PN,1)=SC(PN,1)+100    : exit Sub
		If SC(PN,0)>10     Then SC(PN,0)=SC(PN,0)-10     : SC(PN,1)=SC(PN,1)+10     : exit Sub
		If SC(PN,0)>0      Then SC(PN,0)=SC(PN,0)-1      : SC(PN,1)=SC(PN,1)+1      : exit Sub
		SC(PN,0)=0
		BonusTime.enabled=False
		BonusEndTimer.enabled=True
		SparkleEffect=1
		If RampEB=100 or Extraball=2 or EXTRAEXTRALIFE=1 Then SPB2 85,85,3,0,0,1
	End If
End Sub

Sub BonusEndTimer_timer   '1.2 sec
	BonusEndTimer.enabled=False

	SetMapOff

	StartNewPlayer
End Sub


'**********************************************************************************************************
'* SKILLSHOT *
'**********************************************************************************************************

Dim Skill1 , Skill2, SSLevel
Sub L062_Timer   ' 80ms

	If L062.timerenabled=False Then ' skillshot level 1
		L062.timerenabled=True
		Skill1=0
		Skill2=0
		SLS(59,5)=2 ' off=2 on SP
		SLS(60,5)=2
		SLS(61,5)=2
		SLS(62,5)=2
		SLS(56,1)=2
		SLS(153,1)=2
'		Debug.print"SSON"
		If SC(PN,27)=0 Then L062.TimerInterval=83
		If SC(PN,27)=1 Then L062.TimerInterval=76 ' up speed
		If SC(PN,27)=2 Then L062.TimerInterval=69 ' even faster on last maps
		If SC(PN,27)=3 Then L062.TimerInterval=62
	Else

			Skill1=skill1+1
			Select Case Skill1
				Case  1 : SLS(59,5)=1 : SLS(62,5)=2 : 
				Case  2 : Skill1=3
				Case  7 : SLS(60,5)=1 : SLS(59,5)=2 
				Case  8 : Skill1=9
				Case 13 : SLS(61,5)=1 : SLS(60,5)=2
				Case 14 : skill1=15
				Case 19 : SLS(62,5)=1 : SLS(61,5)=2
				Case 23 : Skill1=0
			End Select

'		End If
	End If

End Sub


Sub L061_Timer
	SkillshotOFF
End Sub


Sub SkillshotOFF
	SLS(56,1)=0
	SLS(153,1)=0
	Skill1=0
	L062.timerenabled=False
	L061.timerenabled=False
	SLS(59,5)=0
	SLS(60,5)=0
	SLS(61,5)=0
	SLS(62,5)=0
	Skillshotactive=0
'	Debug.print"SSOFF"
End Sub


Sub Skillshot2
	SPB2 1,1,3,0,0,1
	DOF 110,2
	DOF 113,2
	SPB2 2,178,8,0,0,1'all go nuts
	headshotdealySS.enabled=True
	Scoring 25000,4000 ' reward double headshot this once
	Skillshotactive=5 : Skillshotresult=4
End Sub

Sub headshotdealySS_timer
	headshotdealySS.enabled=False
	PlaySound "AANali" & Int(rnd(1)*6)+1 , 1, 1.2*BG_Volume, 0, 0,0,0, 0, 0
	PlaySound "mach15", 1, 0.3 * BG_Volume, 0, 0,0,0, 0, 0

End Sub

Sub SkillShotPerfect
	DOF 124,2 
'	If DOFdebug=1 Then debug.print "DOF 124,2 skilshot perfect"
	SkillshotOFF
	Scoring 20000,2000
	FFT=FFTscore
	PlaySound "AANali" & Int(rnd(1)*6)+1 , 1, 1.2*BG_Volume, 0, 0,0,0, 0, 0
	PlaySound "mach15", 1, 0.3 * BG_Volume, 0, 0,0,0, 0, 0
'	Debug.print"PerfectHit"
	SPB1 44,45,35,2,9,1
	SPB1 66,67,35,2,9,1
	L059.timerenabled=True
	SS2=1
	Skillshotactive=3 : Skillshotresult=4
End Sub


DIM SS2
Sub L059_Timer '  2nd skillshot timer
	SS2=0
	L059.timerenabled=False
	Skillshotactive=5 : Skillshotresult=1
End Sub


'123 skillshot
'124 skillshot perfect
'125 skillshot 2
Sub SkillShotGood
	DOF 123,2 
'	If DOFdebug=1 Then debug.print "DOF 123,2 skilshotgood"
	SkillshotOFF
	Scoring 10000,1000
	FFT=FFTscore
	PlaySound "mach15", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
'	Debug.print"DirectHit"
	SPB1 44,45,29,2,5,1
	SPB1 66,67,29,2,5,1
	L059.timerenabled=True
	SS2=1
	Skillshotactive=3 : Skillshotresult=3

End Sub



Sub SkillshotClose
	SkillshotOFF
	Scoring 3000,300
'	Debug.print"AlmostSS"
Skillshotactive=3 : Skillshotresult=2

End Sub



Sub SkillshotBad
	SkillshotOFF
	Scoring 500,50
'	Debug.print"MissedSS"
Skillshotactive=3 : Skillshotresult=1

End Sub




'**********************************************************************************************************
'* FLEX INITIALS *
'**********************************************************************************************************


Dim EnterCurrent ' the letter flippers changes
Dim EnteredName ' what has been entered
Dim InitialPlayer '  nr of player entering name
Dim EnterBlink

Sub FlexInitInit
	enterdelay.enabled=True
End Sub

Sub enterdelay_Timer
	enterdelay.enabled=False
	entertemp=initialplayer
	createvidEnter

	EnteredName=""
	EnterCurrent=1
	FlexEnterName=1

End Sub

Sub FlexInitials
	tempstr2="ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789"
	tempstr="   PLAYER " & InitialPlayer & " NAME = " & EnteredName    ' & EnterCurrent
	EnterBlink=EnterBlink+1
	If EnterBlink=4 Then EnterBlink=0


	If len (EnteredName)=3 Then 
		entertimer.enabled=True

	End If

End Sub

Sub entertimer_Timer ' 500ms
		entertimer.enabled=False
		FlexEnterName=0
		highscorename(HSname) = EnteredName
		entercurrent=0
		enteredname=""
		checkHS=checkHS+1 ' NEXT
End Sub



'**********************************************************************************************************
'* FLEX SCORING *
'**********************************************************************************************************

Dim FlexEnterName
Sub FlexTimer_Timer

	If FlexEnterName=1 Then FlexInitials : Exit Sub
End Sub


Function FormatScore(ByVal Num)
    dim NumString
    NumString = CStr(abs(Num) )
    If len(NumString)<10 then
'		NumString = left(NumString, Len(NumString)-9) & "," & right(NumString,9)
'	Else
		If len(NumString)>6 then NumString = left(NumString, Len(NumString)-6) & "," & right(NumString,6) 
		If len(NumString)>3 then NumString = left(NumString, Len(NumString)-3) & "," & right(NumString,3)
	End If
	FormatScore = NumString
End function





'**********************************************************************************************************
'* dtbg animate *
'**********************************************************************************************************
Dim desktopbg
Sub dtbg_timer
	If dtbg.enabled=False Then
		dtbg.enabled=True
		desktopbg=0
	
	Else
		desktopbg=desktopbg+1
		If desktopbg<5 Then '1-4
			Flasher006.opacity= 60+10*desktopbg : Flasher007.opacity= 60+10*Desktopbg
		Else
			Flasher006.opacity= 60+10*(8-desktopbg) : Flasher007.opacity= 60+10*(8-desktopbg)
		End If
		If desktopbg=8 Then dtbg.enabled=False

	End If

End Sub

Dim dtbg2(5)
Sub dtbg001_Timer
	dtbg2(1)=dtbg2(1)+4
	If dtbg2(1)>360 Then dtbg2(1)=dtbg2(1)-360 

	dtbg2(2)=dtbg2(2) + sin((dtbg2(1)-180)/360)
	flasher006.height=100 + dtbg2(2)
	flasher007.height=100 - dtbg2(2)
	flasher006.roty=  dtbg2(2)/16
	flasher007.roty=  dtbg2(2)/16

End Sub





'**********************************************************************************************************
'* Skarj animate *
'**********************************************************************************************************

Dim Skarj, skarj2
Sub scarjitimer_Timer
	If scarjitimer.enabled=False Then
		scarjitimer.Enabled=True
		skarj=0
		skarj2=0
		
		PlaySound "roam1WL" , 1, BG_Volume, 0, 0,0,0, 0, 0
		PlaySound "mcreak6" , 1, 0.33 * BG_Volume, 0, 0,0,0, 0, 0
	Else
		skarj = skarj + 10
		skarj2 = skarj2 - sin((Skarj-180)/360)
		Primitive012.objrotz=skarj2 * 20 
		If skarj=180 Then PlaySound "mcreak7" , 1, 0.33 * BG_Volume, 0, 0,0,0, 0, 0
		If skarj>359 Then scarjitimer.enabled=False
	End If

End Sub


Sub sw49_hit
	SoundHeavyGate
	scarjitimer_Timer
	spb2 97,97,2,0,2,1
End Sub
Sub Trigger005_hit
	activeball.vely=activeball.vely-2.5
	activeball.velx=activeball.velx+1

End Sub



Sub Kicker004_Hit
	debug.print "ball should not goto kicker004"
	Kicker004.destroyball
	kicker002.createball
	kicker002.kick 255,11
End Sub


Sub Trigger006_Hit
	megapulsedir=0 : megapulsepos=1
	MegaPulse.Enabled=True

	moverampRed.uservalue=0
	moverampRed.enabled=True
End Sub


Sub moverampRed_Timer
	i=moverampRed.uservalue+1
	moverampRed.uservalue=i
	If i<5 Then
		Primitive062.TransX=i*0.15
		Primitive062.TransY=i*0.15
		Primitive062.TransZ=-i*0.05
	Elseif i>35 Then
			moverampRed.uservalue=0
			moverampRed.enabled=False		
	Else ' move it back
		Primitive062.TransX=0.7-i*0.02
		Primitive062.TransY=0.7-i*0.02
		Primitive062.TransZ=-0.25+i*0.01
	End If
End Sub


Sub moverampBlue_Timer
	i=moverampBlue.uservalue+1
	moverampBlue.uservalue=i
	If i<5 Then
		Primitive034.TransX=i*0.1
		Primitive034.TransY=i*0.15
		Primitive034.TransZ=-i*0.05
	Elseif i>35 Then
			moverampBlue.uservalue=0
			moverampBlue.enabled=False		
	Else ' move it back
		Primitive034.TransX=0.5-i*0.02
		Primitive034.Transy=0.7-i*0.02
		Primitive034.TransZ=-0.25+i*0.01
	End If
End Sub



'**********************************************************************************************************
'* Frame Timer *
'**********************************************************************************************************
Dim Lflipperflash
Dim Rflipperflash

Sub RealFrameTimer_Timer() '  timer on -1 for every frame

	Primitive132.RotZ = LeftFlipper.currentangle-122
	Primitive133.RotZ = RightFlipper.currentangle-122
	If Lflipperflash>0 Then Lflipperflash=Lflipperflash-0.1
	If Rflipperflash>0 Then Rflipperflash=Rflipperflash-0.1
	Primitive132.BlendDisableLighting=0.04*(cabimage-1) + Lflipperflash
	Primitive133.BlendDisableLighting=0.07*(cabimage-1) + Rflipperflash


	FlipperLSh.RotZ = LeftFlipper.currentangle
	FlipperRSh.RotZ = RightFlipper.currentangle
    PrimGate.RotX = Sw49.CurrentAngle + 90
	gate1p.RotX =gate1.currentangle
	Primitive134.RotX= gate001.currentangle
	Primitive136.RotX = gate002.currentangle

	RDampen

	RollingTimer
End Sub



Sub Frametimer_Timer()  ' 17ms
	' for update lights and stuff
	If LSAllUP=1 Then
		LShead=LShead+LSaddH ' double the ups
		If LShead<-300 Then
			LSAllUP=0
		End If
	End If
	
	If LSAllDOWN=1 Then
		LShead=LShead+LSaddH
		If LShead>2456 Then
			LSAllDown=0
		End If
	End If


	UpdateLights




End Sub


World.interval=45 
FrameTimer.interval=17


'**********************************************************************************************************
'* WORLD TIMER *
'**********************************************************************************************************
dim i
Dim rotateslower

Dim FoggymcFoggerson, FoggyFade, foggystrength, fogblast, fogthickness
FoggymcFoggerson=1


Sub World_Timer 
 If gamereadytostart>0 Then ' fog comes here
	If FoggymcFoggerson=2 Then
		foggystrength=foggystrength+1
		If foggystrength=20 Then foggystrength=0

		FoggyFade=FoggyFade-2
		FLinsertcoin.visible=FoggymcFoggerson
		FLgameover.visible=FoggymcFoggerson
		FLinsertcoin.opacity=FoggyFade
		FLgameover.opacity=FoggyFade

		FLsupersnake.opacity=FoggyFade
		FLsupersnake.visible=FoggymcFoggerson
		FLsupersnake.y=2222-Foggyfade*2.4

		FLfoggy.visible=FoggymcFoggerson

		If Credits>0 Then FLinsertcoin.ImageA="pressstart" Else FLinsertcoin.ImageA="insertcoin"


		If ( rotateslower mod 256) =   0 Then FLfoggy.roty=180 : FLinsertcoin.visible=True
		If ( rotateslower mod 256) =  64 Then FLfoggy.rotx=180-6.6 : FLfoggy.ImageA="smoke"&Int(Rnd(1)*6)+1
		If ( rotateslower mod 256) = 128 Then FLfoggy.roty=0   : FLinsertcoin.visible=False
		If ( rotateslower mod 256) = 192 Then FLfoggy.rotx=-6.6 : FLfoggy.ImageA="smoke"&Int(Rnd(1)*6)+1
		If fogblast>0 Then
			fogblast=fogblast-5
			If fogblast<1 then fogblast=0
			If fogblast>200 Then fogthickness=200 - fogblast
			If fogblast<100 Then fogthickness=fogblast
			i=(foggystrength+ FoggyFade )/20 + fogthickness/4
			if i > 99 Then i = 99
			FLfoggy.opacity=i

		Else
			FLfoggy.opacity=(foggystrength+ FoggyFade )/20 
		End If

		If FoggyFade<1 Then
			Foggyfade=0
			FoggymcFoggerson=0
			FLinsertcoin.visible=False
			FLgameover.visible=False
			FLfoggy.visible=False
			FLsupersnake.visible=False
		End If

	End If
	If FoggymcFoggerson=1 and Startgame=0 Then
		foggystrength=foggystrength+1
		If foggystrength=20 Then foggystrength=0

		If FoggyFade<100 Then FoggyFade=FoggyFade+0.5
		FLinsertcoin.visible=FoggymcFoggerson
		FLgameover.visible=FoggymcFoggerson
		FLinsertcoin.opacity=FoggyFade
		FLgameover.opacity=FoggyFade

		FLsupersnake.opacity=FoggyFade
		FLsupersnake.visible=FoggymcFoggerson
		FLsupersnake.y=2222-Foggyfade*2.4

		FLfoggy.visible=FoggymcFoggerson

		If Credits>0 Then FLinsertcoin.ImageA="pressstart" Else FLinsertcoin.ImageA="insertcoin"
		FLfoggy.opacity=(foggystrength + FoggyFade)/20
		If ( rotateslower mod 8) = 0 Then FLfoggy.roty=180 : FLinsertcoin.visible=True
		If ( rotateslower mod 8) = 2 Then FLfoggy.rotx=180-6.6 : FLfoggy.ImageA="smoke"&Int(Rnd(1)*6)+1
		If ( rotateslower mod 8) = 4 Then FLfoggy.roty=0   : FLinsertcoin.visible=False
		If ( rotateslower mod 8) = 6 Then FLfoggy.rotx=-6.6 : FLfoggy.ImageA="smoke"&Int(Rnd(1)*6)+1
		If ( rotateslower mod 350) = 250 Then fogblast=1
		If fogblast>0 Then
			fogblast=fogblast+2
			If fogblast>200 Then fogblast=0
			If fogblast>100 Then fogthickness=200 - fogblast : FLgameover.height=340-fogblast/4
			If fogblast<100 Then fogthickness=fogblast : FLgameover.height=290+fogblast/4
			i=(foggystrength+ FoggyFade )/20 + fogthickness/4
			if i > 99 Then i = 99
			FLfoggy.opacity=i
		Else
			FLfoggy.opacity=(foggystrength+ FoggyFade )/20 
		End If

	Elseif FoggymcFoggerson=1 and Startgame=1 Then
		FoggymcFoggerson=2
	End If
	If SNAKEGAMEON=1 And FoggymcFoggerson=1 Then FoggymcFoggerson=2	
	
End If


	If startgame=0 And int(rnd(1)*80)=10 Then dtbg_timer


	If Tilt > 0 Then
		Tilt = Tilt - 1
		If Tilt < 20 Then Tilt = 0
'		Debug.print "Tiltrecovery ="&Tilt
	End If

	If startgame=0 And SNAKEGAMEON=0 Then lightshow
	If SNAKEGAMEON=0 Then RainingMOD
	rotateslower=rotateslower+1
	if rotateslower>1440 then rotateslower=0

	Primitive033.roty=rotateslower/2




End Sub




'**********************************************************************************************************
'* WAITING FOR PLUNGER *
'**********************************************************************************************************




Dim longrange
Sub plungertoolong_Timer ' 1250
	If startgame=0 Then plungertoolong.enabled=False
	SPB1 100,100,7,4,0,1
	SPB1 75,77,2,4,10,1
	longrange=longrange+1
	If longrange>6 Then longrange=0
	If longrange=5 Then PlaySound "draw", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
	If longrange=2 Then	PlaySound "disabled", 1, 0.4 * BG_Volume, 0, 0,0,0, 0, 0
End Sub


'**********************************************************************************************************
'* Fade all Lights *
'**********************************************************************************************************


Sub InitLightsXY ' lightname + SLS(nr,?)
	SetSLSXY L002,  2
	SetSLSXY L003,  3
	SetSLSXY L004,  4
	SetSLSXY L005,  5
	SetSLSXY L006,  6
	SetSLSXY L007,  7
	SetSLSXY L008,  8
	SetSLSXY L009,  9 
	SetSLSXY L010, 10  
	SetSLSXY L011, 11  
	SetSLSXY L012, 12  
	SetSLSXY L013, 13  
	SetSLSXY L014, 14  
	SetSLSXY L015, 15  
	SetSLSXY L016, 16  
	SetSLSXY L017, 17  
	SetSLSXY L018, 18  
	SetSLSXY L019, 19  
	SetSLSXY L020, 20 
	SetSLSXY L021, 21 
	SetSLSXY L022, 22 
	SetSLSXY L023, 23 
	SetSLSXY L024, 24 
	SetSLSXY L025, 25 
	SetSLSXY L026, 26 
	SetSLSXY L027, 27 
	SetSLSXY L028, 28 
	SetSLSXY L029, 29 
	SetSLSXY L030, 30 
	SetSLSXY L031, 31 
	SetSLSXY L032, 32 
	SetSLSXY L033, 33 
	SetSLSXY L034, 34 
	SetSLSXY L035, 35 
	SetSLSXY L036, 36 
	SetSLSXY L037, 37 
	SetSLSXY L038, 38 
	SetSLSXY L039, 39 
	SetSLSXY L040, 40  
	SetSLSXY L041, 41  
	SetSLSXY L042, 42  
	SetSLSXY L043, 43  
	SetSLSXY L044, 44  
	SetSLSXY L045, 45  
	SetSLSXY L046, 46  
	SetSLSXY L047, 47  
	SetSLSXY L048, 48  
	SetSLSXY L049, 49  
	SetSLSXY L050, 50  
	SetSLSXY L051, 51 
	SetSLSXY L052, 52 
	SetSLSXY L053, 53 
	SetSLSXY L054, 54 

'	SetSLSXY L055, 55 

	SetSLSXY L056, 56 
	SetSLSXY L057, 57 
	SetSLSXY L058, 58 
	SetSLSXY L059, 59 
	SetSLSXY L060, 60 
	SetSLSXY L061, 61 
	SetSLSXY L062, 62 
	SetSLSXY L063, 63 
	SetSLSXY L064, 64 
	SetSLSXY L065, 65 
	SetSLSXY L066, 66 
	SetSLSXY L067, 67 
	SetSLSXY L068, 68 
	SetSLSXY L34C, 69 
	SetSLSXY L070, 70 
	SetSLSXY L071, 71 
	SetSLSXY L072, 72 
	SetSLSXY L073, 73 
	SetSLSXY L074, 74 
'	SetSLSXY L075, 75 
'	SetSLSXY L076, 76 
'	SetSLSXY L077, 77 
	SetSLSXY L078, 78 
	SetSLSXY L079, 79 
	SetSLSXY L080, 80 
	SetSLSXY L081, 81 
	SetSLSXY L082, 82 
	SetSLSXY L083, 83 
	SetSLSXY L085, 85 
'	SetSLSXY LiftTopRedLight, 99 
'	SetSLSXY PlungerRed,100 
	SetSLSXY LO001,101 
	SetSLSXY LO002,102 
	SetSLSXY LO003,103 
	SetSLSXY LO004,104 
	SetSLSXY LO005,105 
	SetSLSXY LO006,106 
	SetSLSXY LO007,107 
	SetSLSXY LO008,108 
	SetSLSXY LO009,109 
	SetSLSXY LO010,110 
	SetSLSXY LO011,111 	
'	SetSLSXY Rspwn001,120
'	SetSLSXY Rspwn002,121
'	SetSLSXY Rspwn003,122
'	SetSLSXY Rspwn004,123
'	SetSLSXY Rspwn005,124
'	SetSLSXY Rspwn006,125
'	SetSLSXY Rspwn007,126
'	SetSLSXY Rspwn008,127
'	SetSLSXY Rspwn009,128
'	SetSLSXY Rspwn010,129
'	SetSLSXY Rspwn011,130
'	SetSLSXY Rspwn012,131
'	SetSLSXY Rspwn013,132
'	SetSLSXY Rspwn014,133
'	SetSLSXY Rspwn015,134
'	SetSLSXY Rspwn016,135
'	SetSLSXY Rspwn017,136
'	SetSLSXY Rspwn018,137
'	SetSLSXY Rspwn019,138
'	SetSLSXY Rspwn020,139
End Sub

Sub SetSLSXY(object,nr)
	SLS(nr,13)=object.x
	SLS(nr,14)=object.y
End Sub



Dim NeonFlash
Dim cab3blend
Dim bwlights  ' override
Dim bdlrightsling
Dim bdlleftsling

Sub UpdateLights

	FadeL 2  : SetL L002,1 : SetL LT002,0.8 : SetP3 p002,0.98 : Setp3 p002off,0.8	' GREEN bonuslightsbottom
	FadeL 3  : SetL L003,1 : SetL LT003,0.8 : SetP3 p003,0.98 : Setp3 p003off,0.8
	FadeL 4  : SetL L004,1 : SetL LT004,0.8 : SetP3 p004,0.98 : Setp3 p004off,0.8
	FadeL 5  : SetL L005,1 : SetL LT005,0.8 : SetP3 p005,0.98 : Setp3 p005off,0.8
	FadeL 6  : SetL L006,1 : SetL LT006,0.8 : SetP3 p006,0.98 : Setp3 p006off,0.8
	cab3blend=0
' BLUE outlane x5
	FadeL 1 : bwlights=i
	FadeL 7  : SetL L007,0.5 : SetL LT007,1 : SetP p007,1 : Setp2 p007off 
		If SLS(1,1)>0 Or SLS(1,5)>0 Then i=bwlights 
		SetL bw7l, 2.5 : SetP3 bw7p, 4 : SetP3 bw7ps,0.2 : SetP3 bw7s,0.1 : bw7f001.opacity=i* 10
		cab3blend=cab3blend+i
	FadeL 8  : SetL L008,0.5 : SetL LT008,0.8 : SetP p008,1 : Setp2 p008off 
		If SLS(1,1)>0 Or SLS(1,5)>0 Then i=bwlights 
		SetL bw8l, 2.2: SetP3 bw8p, 4 : SetP3 bw8ps,0.2 : SetP3 bw8s,0.1 : bw8f001.opacity=i* 6 
		cab3blend=cab3blend+i
	FadeL 9  : SetL L009,0.5 : SetL LT009,0.8 : SetP p009,1 : Setp2 p009off 
		If SLS(1,1)>0 Or SLS(1,5)>0 Then i=bwlights 
		SetL bw9l, 2.2:  SetP3 bw9p, 4 : SetP3 bw9ps,0.2 : SetP3 bw9s,0.1
		cab3blend=cab3blend+i
	FadeL 10 : SetL L010,0.5 : SetL LT010,0.8 : SetP p010,1 : Setp2 p010off
		If SLS(1,1)>0 Or SLS(1,5)>0 Then i=bwlights 
		SetL bw10l,2.2 : SetP3 bw10p,4 : SetP3 bw10ps,0.2 : SetP3 bw10s,0.1
		cab3blend=cab3blend+i
	FadeL 11 : SetL L011,0.5 : SetL LT011,0.8 : SetP p011,1 : SetP2 p011off 
		If SLS(1,1)>0 Or SLS(1,5)>0 Then i=bwlights 
		SetL bw11l,2.2 : SetP3 bw11p,4 : SetP3 bw11ps,0.2 : SetP3 bw11s,0.1
		cab3blend=cab3blend+i

	FadeL 12 : SetL L012,1.5 : SetL LT012,1 : SetP p012,2 : Setp2 p012off 	' Bonus X3 top
	FadeL 13 : SetL L013,1.5 : SetL LT013,1 : SetP p013,2 : Setp2 p013off 
	FadeL 14 : SetL L014,1.5 : SetL LT014,1 : SetP p014,2 : Setp2 p014off

' RED outlane x5    was /3 middle and *4 first
	FadeL 15 : SetL L015,0.1 : SetL LT015,0.9 : SetP p015,1 : SetP2 p015off
		If SLS(1,1)>0 Or SLS(1,5)>0 Then i=bwlights 
		SetL bw15l,1 : SetP3 bw15p,1.5 : SetP3 bw15ps,0.16 : SetP3 bw15s,0.1 : bw15f001.opacity=i* 5
		cab3blend=cab3blend+i
	FadeL 16 : SetL L016,0.1 : SetL LT016,0.6 : SetP p016,1 : SetP2 p016off
		If SLS(1,1)>0 Or SLS(1,5)>0 Then i=bwlights 
		SetL bw16l,0.88: SetP3 bw16p,1.5 : SetP3 bw16ps,0.16 : SetP3 bw16s,0.1 : bw16f001.opacity=i* 3
		cab3blend=cab3blend+i
	FadeL 17 : SetL L017,0.1 : SetL LT017,0.4 : SetP p017,1: SetP2 p017off
		If SLS(1,1)>0 Or SLS(1,5)>0 Then i=bwlights 
		SetL bw17l,0.88 : SetP3 bw17p,1.5 : SetP3 bw17ps,0.16 : SetP3 bw17s,0.1
		cab3blend=cab3blend+i
	FadeL 18 : SetL L018,0.1 : SetL LT018,0.4 : SetP p018,1: SetP2 p018off
		If SLS(1,1)>0 Or SLS(1,5)>0 Then i=bwlights 
		SetL bw18l,0.88 : SetP3 bw18p,1.5 : SetP3 bw18ps,0.16 : SetP3 bw18s,0.1
		cab3blend=cab3blend+i
	FadeL 19 : SetL L019,0.1 : SetL LT019,0.4 : SetP p019,1: SetP2 p019off
		If SLS(1,1)>0 Or SLS(1,5)>0 Then i=bwlights 
		SetL bw19l,0.88 : SetP3 bw19p,1.5 : SetP3 bw19ps,0.16 : SetP3 bw19s,0.1
		cab3blend=cab3blend+i
	FadeL 20 : SetL L020,0.8 : SetL LT020,1 : SetP p020,0.4 : Setp2 p020off	'  kicker 01
	FadeL 21 : SetL L021,0.8 : SetL LT021,1 : SetP p021,0.4 : Setp2 p021off
	FadeL 22 : SetL L022,0.8 : SetL LT022,1 : SetP p022,0.4 : Setp2 p022off
	FadeL 23 : SetL L023,0.8 : SetL LT023,1 : SetP p023,0.4 : Setp2 p023off
	FadeL 24 : SetL L024,0.8 : SetL LT024,1 : SetP p024,0.4 : Setp2 p024off
	FadeL 25 : SetL L025,0.7 : SetL LT025,0.8 : SetP p025,0.34 : Setp2 p025off	'  kicker 02
	FadeL 26 : SetL L026,0.7 : SetL LT026,0.8 : SetP p026,0.34 : Setp2 p026off
	FadeL 27 : SetL L027,0.7 : SetL LT027,0.8 : SetP p027,0.34 : Setp2 p027off
	FadeL 28 : SetL L028,0.7 : SetL LT028,0.8 : SetP p028,0.34 : Setp2 p028off
	FadeL 29 : SetL L029,0.7 : SetL LT029,0.8 : SetP p029,0.34 : Setp2 p029off
	FadeL 30 : SetL L030,0.8 : SetL LT030,1 : SetP p030,0.4 : Setp2 p030off	'  kicker 03
	FadeL 31 : SetL L031,0.8 : SetL LT031,1 : SetP p031,0.4 : Setp2 p031off
	FadeL 32 : SetL L032,0.8 : SetL LT032,1 : SetP p032,0.4 : Setp2 p032off
	FadeL 33 : SetL L033,0.8 : SetL LT033,1 : SetP p033,0.4 : Setp2 p033off
	FadeL 34 : SetL L034,0.8 : SetL LT034,1 : SetP p034,0.4 : Setp2 p034off

	FadeL 35 : SetL L035,0.5 : SetL LT035,0.6 : SetP p035,0.2 : Setp2 p035off 	' DT middle
	FadeL 36 : SetL L036,0.5 : SetL LT036,0.6 : SetP p036,0.2 : Setp2 p036off
	FadeL 37 : SetL L037,0.9   : SetL LT037,0.8   : SetP p037,0.5  : Setp2 p037off

	FadeL 38 : SetL L038,0.2 : SetL LT038,0.8 : SetP p038,0.2 : Setp2 p038off		'  DT RIGHT
	FadeL 39 : SetL L039,0.2 : SetL LT039,0.8 : SetP p039,0.2 : Setp2 p039off
	FadeL 40 : SetL L040,0.2 : SetL LT040,0.8 : SetP p040,0.2 : Setp2 p040off

	FadeL 41 : SetL L041,1   : SetL LT041,1   : SetP p041,1   : Setp2 p041off '  ENEMY FLAG1
	FadeL 42 : SetL L042,0.6 : SetL LT042,0.6 : SetP p042,0.5 : Setp2 p042off '  CAPTUREkicker2 main
	FadeL 43 : SetL L043,0.6 : SetL LT043,0.7 : SetP p043,0.5 : Setp2 p043off '  EXTRABALLkicker3 main
	FadeL 44 : SetL L044,1 : SetL LT044,1 : SetP p044,1.8   : Setp2 p044off '  high ground
	FadeL 45 : SetL L045,1 : SetL LT045,1 : SetP p045,1.8   : Setp2 p045off '  jackpot
	FadeL 46 : SetL L046,0.7 : SetL LT046,0.8 : SetP p046,0.7 : Setp2 p046off '  pwnage
	FadeL 47 : SetL L047,0.7 : SetL LT047,0.8 : SetP p047,0.7 : Setp2 p047off '  lite kickback
	FadeL 48 : SetL L048,0.8 : SetL LT048,0.8 : SetP p048,0.7 : Setp2 p048off '  EF
	FadeL 49 : SetL L049,0.5 : SetL LT049,0.6 : SetP p049,0.4 : Setp2 p049off '  kickback
	FadeL 63 : SetL L063,1   : SetL LT063,1   : SetP p063,0.5 : Setp2 p063off '  EF

	FadeL 50 : SetL L050,0.8 : SetL LT050,0.8 : SetP p050,0.015 : SetP2b p050off  ' coret       4x CTF maps
	FadeL 51 : SetL L051,0.8 : SetL LT051,0.8 : SetP p051,0.015 : SetP2b p051off  ' face
	FadeL 52 : SetL L052,0.8 : SetL LT052,0.8 : SetP p052,0.015 : SetP2b p052off  ' november
	FadeL 53 : SetL L053,0.8 : SetL LT053,0.8 : SetP p053,0.015 : SetP2b p053off  ' dreary

	FadeL 54 : SetL L054,0.8 : SetL LT054,0.8 : SetP3 p054,0.4 : Setp3 p054off,0.8		' room of champions


	FadeL 56 : SetL L056,4 : Flasher056.opacity=i*7 		' Spot MidL
	FadeL 57 : SetL L057,4 : Flasher057.opacity=i*7			' Spot Left
	FadeL 58 : SetL L058,4 : Flasher058.opacity=i*7			' Spot Right

	FadeL 59 : SetL L059,0.4 : SetL LT059,1  : SetP p059,0.5 : Setp2 p059off' WHITE skillshots x4   
	FadeL 60 : SetL L060,0.4 : SetL LT060,1  : SetP p060,0.5 : Setp2 p060off
	FadeL 61 : SetL L061,0.3: SetL LT061,1  : SetP p061,0.3 : Setp2 p061off
	FadeL 62 : SetL L062,0.1 : SetL LT062,1  : SetP p062,0.2 : Setp2 p062off

	FadeL 64 : SetL L064,0.5 : SetL LT064,1 : Setp2 p064off : P064.blenddisablelighting=i*0.4+0.05'  respawn

	FadeL 65 : SetL L065,0.8 : SetL LT065,0.8  : SetP p065,0.5 : Setp2 p065off	' cntrP1
	FadeL 66 : SetL L066,0.8 : SetL LT066,0.8  : SetP p066,0.5 : Setp2 p066off	' cntrP2
	FadeL 67 : SetL L067,0.8 : SetL LT067,1    : SetP p067,1 : Setp2 p067off	'  Redeemer
	FadeL 68 : SetL L068,0.8 : SetL LT068,0.8  : SetP p068,0.5 : Setp2 p068off	' Teamplay
	
'	FadeL 69 : SetL L34C,4 :  SetL L60C,4 :  SetL L61C,0.4  '  3 extra bumper Lights , ONLY BLINKING SO ARE STRONG ?

	FadeL 70 : SetL L070,0.5 : SetL LT070,1  : SetP p070,1   : Setp2 p070off 	 'EnemyFlag2

	FadeL 71 : SetL L071,0.3 : SetL LT071,0.4 : Setp3 p071off,0.1 : P071.blenddisablelighting=i+0.05  	 'RedScore
	FadeL 73 : If Team(PN)=1 Then SetL L073,10 Else SetL L073,15 
	FadeL 72 : SetL L072,0.3 : SetL LT072,0.4  : Setp3 p072off,0.1 : P072.blenddisablelighting=i+0.05 	 'BlueScore
	FadeL 74 : If Team(PN)=0 Then SetL L074,15 Else SetL L074,10 


	FadeL 78 : SetL L078,1 : SetL LT078,1  : P078.blenddisablelighting=i*0.5+0.05 	 'INVISIBILITY
	FadeL 79 : SetL L079,1 : SetL LT079,.6 : P079.blenddisablelighting=i*0.5+0.05
	FadeL 80 : SetL L080,1 : SetL LT080,.6 : P080.blenddisablelighting=i*0.5+0.05
	FadeL 81 : SetL L081,1 : SetL LT081,.6 : P081.blenddisablelighting=i*0.5+0.05
	FadeL 82 : SetL L082,1 : SetL LT082,.6 : P082.blenddisablelighting=i*0.5+0.05
	FadeL 83 : SetL L083,1 : SetL LT083,1  : P083.blenddisablelighting=i*1.2+0.07

	FadeL 85 : SetL L085,0.8 : SetL LT085,0.8  : SetP p085,0.3  : Setp3 p085off,0.1 ' EXTRA LIFE
	FadeL 86 : SetP3 RedBaseLight001,5 			
			   SetP3 RedBaseLight002,2
			   SetP3 RedBaseLight004,2
			   SetP3 RedBaseLight003,2



	FadeL 55 : SetL L055,0.7 : SetL LT055,0.7 : SetP P055,0.5 : Setp2 P055off ' doubltroubletower
	FadeL 90 : SetL L001,0.7 : SetL LT001,0.7-SLS(187,1)/5 : SetP p001,0.34-SLS(187,1)/5 : Setp2 p001off'  doubletrouble
	FadeL 96 : SetL L001A,0.7 : SetL LT001A,0.7-SLS(187,1)/5 : SetP p001A,0.34-SLS(187,1)/5 : Setp2 p001Aoff'  Inhuman
	FadeL 119: SetL L119,0.7 : SetL LT119,0.7 : SetP P119,0.5 : Setp2 P119off

	FadeL 91 : sw40bottom.blenddisablelighting=i*0.8
	FadeL 92 : sw30bottom.blenddisablelighting=i*0.8

	FadeL 94 : topgateP1.blenddisablelighting=i*6' : topgateF1.opacity=i*50-100
			   topgateP2.blenddisablelighting=i*6': topgateF2.opacity=i*50-100 
	FadeL 95 :  topgateP003.blenddisablelighting=i*1.5 
				topgateP004.blenddisablelighting=i*1.5
'CHANGE 95 TO LEFT Ramp001
' 98 TO RIGHT Ramp001


	FadeL 97 : topgateP001.blenddisablelighting=i*6 ': topgateF001.opacity=i*50-100
				topgateP002.blenddisablelighting=i*6' : topgateF002.opacity=i*50-100
	FadeL 98 : topgateP005.blenddisablelighting=i*7 
				topgateP006.blenddisablelighting=i*7 

	FadeL 99 : SetL LiftTopRedLight,15   


	FadeL 100 : SetL PlungerRed,2


	FadeL 101 :	SetL L60a,2.2 : SetL L60b,3.5 : If superbumpers>15 Then SetL L60c,7
				Setp3 Bumper1Cap,0.5 : Setp3 Bumper1Base,0.5                        ' bumper 1
				If Bumper1cap.uservalue>0 Then Bumper1cap.Z = 80 + 0.4*i : Bumper1cap.uservalue=i

	FadeL 102 :	SetL L34a,2.2 : SetL L34b,3.5 : If superbumpers>15 Then SetL L34c,7
				Setp3 Bumper2Cap,0.5 : Setp3 Bumper2Base,0.5                        ' bumper 2
				If Bumper2cap.uservalue>0 Then Bumper2cap.Z = 80 + 0.4*i : Bumper2cap.uservalue=i

	FadeL 103 :	SetL L61a,2.2 : SetL L61b,3.5 : If superbumpers>15 Then SetL L61c,7
				Setp3 Bumper3Cap,0.5 : Setp3 Bumper3Base,0.5                        ' bumper 3
				If Bumper3cap.uservalue>0 Then Bumper3cap.Z = 80 + 0.4*i : Bumper3cap.uservalue=i

	FadeL 104 : SetL LO001, 15 : SetL LO005, 15 : SetL LO009, 15
	FadeL 105 : SetL LO002, 15 : SetL LO006, 15 : SetL LO010, 15
	FadeL 106 : SetL LO003, 15 : SetL LO007, 15 : SetL LO011, 15
	FadeL 107 : SetL LO004, 15 : SetL LO008, 15

'	FadeL 108
'	FadeL 109
'	FadeL 110
'	FadeL 111

'
' liandri Lights
	FadeL 112 : NL1.blenddisablelighting=i*7+1
	FadeL 146 : NL001.blenddisablelighting=i*7+1
	FadeL 113 : NL2.blenddisablelighting=i*7+1
	FadeL 114 : NL3.blenddisablelighting=i*7+1
	FadeL 115 : NL4.blenddisablelighting=i*7+1
	FadeL 116 : NL5.blenddisablelighting=i*7+1
	FadeL 117 : NL6.blenddisablelighting=i*7+1
	FadeL 118 : NL7.blenddisablelighting=i*7+1
	FadeL 141 :liandri1.blenddisablelighting=i*6+1
	FadeL 142 :liandri2.blenddisablelighting=i*6+1
	FadeL 143 :liandri3.blenddisablelighting=i*6+1
	FadeL 144 :liandri4.blenddisablelighting=i*6+1
	FadeL 145 :liandri5.blenddisablelighting=i*6+1


	FadeL 120 : SetL Rspwn001,2
	FadeL 121 : SetL Rspwn002,2
	FadeL 122 : SetL Rspwn003,2
	FadeL 123 : SetL Rspwn004,2
	FadeL 124 : SetL Rspwn005,2
	FadeL 125 : SetL Rspwn006,2
	FadeL 126 : SetL Rspwn007,2
	FadeL 127 : SetL Rspwn008,2
	FadeL 128 : SetL Rspwn009,2
	FadeL 129 : SetL Rspwn010,2
	FadeL 130 : SetL Rspwn011,2
	FadeL 131 : SetL Rspwn012,2
	FadeL 132 : SetL Rspwn013,2
	FadeL 133 : SetL Rspwn014,2
	FadeL 134 : SetL Rspwn015,2
	FadeL 135 : SetL Rspwn016,2
	FadeL 136 : SetL Rspwn017,2
	FadeL 137 : SetL Rspwn018,2
	FadeL 138 : SetL Rspwn019,2
	FadeL 139 : SetL Rspwn020,2


	FadeL 150 : SetP3 Psw17,1
	FadeL 151 : SetP3 Psw18,1
	FadeL 152 : SetP3 Psw19,1
	FadeL 153 : SetP3 Psw20,1
	FadeL 154 : SetP3 Psw39,1

	FadeL 75 : SetL L075,1 : F075.opacity=i*24 : p075.blenddisablelighting=i*2   'GunLights Bottom
	FadeL 76 : SetL L076,1 : F076.opacity=i*24 : p076.blenddisablelighting=i*2	 'GunLights	middle
	FadeL 77 : SetL L077,1 : F077.opacity=i*24 : p077.blenddisablelighting=i*2 	 'GunLights	top


	FadeL 155 : Setp3 Bwp001,1.8 : If SLS(155,5)=0 or startgame=0 Then Bwp001.material="InsertDarkGreenOffTri" Else Bwp001.material="InsertYellowOffTri"
	FadeL 156 : Setp3 Bwp002,1.8 : If SLS(156,5)=0 or startgame=0 Then Bwp002.material="InsertDarkGreenOffTri" Else Bwp002.material="InsertYellowOffTri"
	FadeL 157 : Setp3 Bwp003,1.8 : If SLS(157,5)=0 or startgame=0 Then Bwp003.material="InsertDarkGreenOffTri" Else Bwp003.material="InsertYellowOffTri"
	FadeL 158 : Setp3 Bwp004,1.8 : If SLS(158,5)=0 or startgame=0 Then Bwp004.material="InsertDarkGreenOffTri" Else Bwp004.material="InsertYellowOffTri"
	FadeL 159 : Setp3 Bwp005,1.8 : If SLS(159,5)=0 or startgame=0 Then Bwp005.material="InsertDarkGreenOffTri" Else Bwp005.material="InsertYellowOffTri"
	FadeL 160 : Setp3 Bwp006,1.8 : If SLS(160,5)=0 or startgame=0 Then Bwp006.material="InsertDarkGreenOffTri" Else Bwp006.material="InsertYellowOffTri"
	FadeL 161 : Setp3 Bwp007,1.8 : If SLS(161,5)=0 or startgame=0 Then Bwp007.material="InsertDarkGreenOffTri" Else Bwp007.material="InsertYellowOffTri"
	FadeL 162 : Setp3 Bwp008,1.8 : If SLS(162,5)=0 or startgame=0 Then Bwp008.material="InsertDarkGreenOffTri" Else Bwp008.material="InsertYellowOffTri"
	FadeL 163 : Setp3 Bwp009,1.8 : If SLS(163,5)=0 or startgame=0 Then Bwp009.material="InsertDarkGreenOffTri" Else Bwp009.material="InsertYellowOffTri"
	FadeL 164 : Setp3 Bwp010,1.8 : If SLS(164,5)=0 or startgame=0 Then Bwp010.material="InsertDarkGreenOffTri" Else Bwp010.material="InsertYellowOffTri"
	FadeL 165 : Setp3 Bwp011,1.8 : If SLS(165,5)=0 or startgame=0 Then Bwp011.material="InsertDarkGreenOffTri" Else Bwp011.material="InsertYellowOffTri"
	FadeL 166 : Setp3 Bwp012,1.8 : If SLS(166,5)=0 or startgame=0 Then Bwp012.material="InsertDarkGreenOffTri" Else Bwp012.material="InsertYellowOffTri"
	FadeL 167 : Setp3 Bwp013,1.8 : If SLS(167,5)=0 or startgame=0 Then Bwp013.material="InsertDarkGreenOffTri" Else Bwp013.material="InsertYellowOffTri"
	FadeL 168 : Setp3 Bwp014,1.8 : If SLS(168,5)=0 or startgame=0 Then Bwp014.material="InsertDarkGreenOffTri" Else Bwp014.material="InsertYellowOffTri"
	FadeL 169 : Setp3 Bwp015,1.8 : If SLS(169,5)=0 or startgame=0 Then Bwp015.material="InsertDarkGreenOffTri" Else Bwp015.material="InsertYellowOffTri"
	FadeL 170 : Setp3 Bwp016,1.8 : If SLS(170,5)=0 or startgame=0 Then Bwp016.material="InsertDarkGreenOffTri" Else Bwp016.material="InsertYellowOffTri"

	FadeL 171 : Setp3 Bwp017,1   : If SLS(171,5)=0 or startgame=0 Then Bwp017.material="InsertDarkGreenOffTri" Else Bwp017.material="InsertYellowOffTri"
	FadeL 172 : Setp3 Bwp018,1   : If SLS(172,5)=0 or startgame=0 Then Bwp018.material="InsertDarkGreenOffTri" Else Bwp018.material="InsertYellowOffTri"
	FadeL 173 : Setp3 Bwp019,1   : If SLS(173,5)=0 or startgame=0 Then Bwp019.material="InsertDarkGreenOffTri" Else Bwp019.material="InsertYellowOffTri"
	FadeL 174 : Setp3 Bwp020,1   : If SLS(174,5)=0 or startgame=0 Then Bwp020.material="InsertDarkGreenOffTri" Else Bwp020.material="InsertYellowOffTri"
	FadeL 147 : Setp3 Bwp021,1   : If SLS(147,5)=0 or startgame=0 Then Bwp021.material="InsertDarkGreenOffTri" Else Bwp021.material="InsertYellowOffTri"
	FadeL 148 : Setp3 Bwp022,1   : If SLS(148,5)=0 or startgame=0 Then Bwp022.material="InsertDarkGreenOffTri" Else Bwp022.material="InsertYellowOffTri"
	FadeL 149 : Setp3 Bwp023,1   : If SLS(149,5)=0 or startgame=0 Then Bwp023.material="InsertDarkGreenOffTri" Else Bwp023.material="InsertYellowOffTri"

'GI
	FadeL 201 : SetL ApronRed1,0.7 : SetL ApronRed2,1.2
	FadeL 202 : SetL ApronBlue1,0.7 : SetL ApronBlue2,2

' new edge GI on 185 !


	SetGI 190,Gi001 : Gi002.state=i : Gi003.state=i : Gi004.state=i 		 ' laneguide R
		If VRRoom > 0 and VRRoom < 3 Then
			If startgame = 1 Then
				BGBright.visible = i
			End If
		End If
		Primitive017.blenddisablelighting=i*0.5				 ' laneguide R
		Primitive018.blenddisablelighting=i*0.4
		Primitive057.blenddisablelighting=i*2
		Gi009.state=i : Gi010.state=i : Gi011.state=i : Gi012.state=i
		Primitive016.blenddisablelighting=i*0.5 ' laneguide L





	SetGI 185,Gi025 : Gi026.state=i : Gi075.state=i

		Primitive138.blenddisablelighting=i*0.5
		Primitive136.blenddisablelighting=i*0.5
		Primitive135.blenddisablelighting=i*0.5
		Primitive134.blenddisablelighting=i*0.5

		If i = 0 Then
			Primitive033.material="Metal_Gold4"
			lamps002.material="Plastic Spots1"
			lamps001.material="Plastic Spots1"
			lamps.material="Plastic Spots1"
		Else
			Primitive033.material="Metal_Gold3"
			lamps002.material="Plastic Spots"
			lamps001.material="Plastic Spots"
			lamps.material="Plastic Spots"
		End If

					  Gi024.state=i : GI073.state=i : GI074.state=i : GI033.state=i : GI034.state=i : GI045.state=i : GI046.state=i  :
					  Gi027.state=i : Gi_001.state=i: Gi_002.state=i : Gi_003.state=i : GI043.state=i : GI044.state=i :
					  GI053.state=i : GI050.state=i : GI077.state=i : GI049.state=i : GI051.state=i : Gi019.state=i
					  Gi029.state=i : Gi028.state=i :  Gi_022.state=i :Gi030.state=i :  Gi031.state=i ' DT right
					  Gi021.state=i : Gi022.state=i : Gi023.state=i ' lonlytargetleft

		S109a.state=i : S109b.state=i : S109c.state=i
		Primitive123.blenddisablelighting=i
		Primitive122.blenddisablelighting=i
		Primitive121.blenddisablelighting=i
		Primitive119.blenddisablelighting=i
		Primitive117.blenddisablelighting=i
		if i>0 Then
			cabimage=cabimage+1
			If cabimage=2 Then cabimage=4
			If cabimage=7 Then cabimage=8
			if cabimage>9 Then cabimage=9
		Else
			cabimage=cabimage-1
			if cabimage<1 Then cabimage=1	
		End If
		Select case cabimage
			Case 1,2 : cab.image="UTcab1"
			Case 3,4 : cab.image="UTcab2"
			Case 5,6 : cab.image="UTcab3"
			Case 7,8 : cab.image="UTcab4"
			Case   9 : cab.image="UTcab5"
		End Select

		Flasherbloom001.opacity=cabimage*10-10

		Primitive129.blenddisablelighting=cabimage/10 + Pflash34*3
		Primitive130.blenddisablelighting=cabimage/5  + Pflash62*3


		primitive062.BlendDisableLighting=0.13*(cabimage-1) + Pflash62
		primitive034.BlendDisableLighting=0.19*(cabimage-1) + Pflash34
		Redbasesign.BlendDisableLighting=0.01*(cabimage-1)
		Bluebasesign.BlendDisableLighting=0.02*(cabimage-1)
		Bumper1Cap.BlendDisableLighting=0.05*(cabimage-1)
		Bumper2Cap.BlendDisableLighting=0.05*(cabimage-1)
		Bumper3Cap.BlendDisableLighting=0.05*(cabimage-1)
		Wall052.BlendDisableLighting=0.5*(cabimage-1)
		metal_walls.BlendDisableLighting=0.05*(cabimage-1)
		metalRamp.BlendDisableLighting=0.05*(cabimage-1)
		Primitive011.BlendDisableLighting=0.03*(cabimage-2)
'		liandriTower.BlendDisableLighting=0.03*(cabimage-2)
		for each i in nuts : i.BlendDisableLighting=0.005*(cabimage-1) : Next
		for each i in postsm : i.BlendDisableLighting=0.1*(cabimage) : Next


		gatesprims.blenddisablelighting=1+cabimage/3
		DT25.blenddisablelighting=0.07*(cabimage-1)
		DT26.blenddisablelighting=0.07*(cabimage-1)
		DT27.blenddisablelighting=0.07*(cabimage-1)
		DT33.blenddisablelighting=0.07*(cabimage-1)
		DT34.blenddisablelighting=0.07*(cabimage-1)
		DT35.blenddisablelighting=0.07*(cabimage-1)
	Primitive131.blenddisablelighting=0.07*(cabimage-1)+(15-RStep)/5
	Primitive082.blenddisablelighting=0.07*(cabimage-1)
	Primitive149.blenddisablelighting=0.07*(cabimage-1)+(15-lstep)/5
	Primitive148.blenddisablelighting=0.07*(cabimage-1)


	SetGI 188,Gi005 : Gi017.state=i : Gi006.state=i : Gi007.state=i : Gi008.state=i : SLS(175,1)=i ' Sling R
		If i>0 Then bdlrightsling = bdlrightsling + 1 Else bdlrightsling=bdlrightsling-1
		if bdlrightsling>6 Then bdlrightsling=6
		if bdlrightsling<0 Then bdlrightsling=0
		Primitive003.BlendDisableLighting=0.1*(cabimage)+0.2*bdlrightsling
		Primitive026.BlendDisableLighting=0.1*(cabimage)+0.2*bdlrightsling
		Primitive030.BlendDisableLighting=0.1*(cabimage)+0.2*bdlrightsling


	SetGI 187,Gi013 : Gi018.state=i  : Gi014.state=i : Gi015.state=i :  Gi016.state=i :  SLS(176,1)=i ' Sling L
		If i>0 Then bdlleftsling = bdlleftsling + 1 Else bdlleftsling=bdlleftsling-1
		if bdlleftsling>6 Then bdlleftsling=6
		if bdlleftsling<0 Then bdlleftsling=0
		Primitive004.BlendDisableLighting=0.1*(cabimage)+0.2*bdlleftsling
		Primitive005.BlendDisableLighting=0.1*(cabimage)+0.2*bdlleftsling
		Primitive006.BlendDisableLighting=0.1*(cabimage)+0.2*bdlleftsling

	SetGI 183,GI020 :   Flasher001.Opacity=towerBOTopacity/1.5*(cabimage-1) ' inside tower
					    Flasher002.Opacity=towerBOTopacity/1.5*(cabimage-1) 
				    	Flasher003.Opacity=towerBOTopacity/1.5*(cabimage-1) 
	FadeL 184 : If i>0 Then
					if i>6 Then i = 6
					Flasher001.Opacity=towerBOTopacity*i*2	'/1.5
					Flasher002.Opacity=towerBOTopacity*i*2	'/1.5
					Flasher003.Opacity=towerBOTopacity*i*2	'/1.5
				End If


	SetGI 182,Gi035 : Gi036.state=i : Gi037.state=i : Gi038.state=i : SLS(178,1)=i  ' DT Mid
	Primitive048.BlendDisableLighting=0.1*(cabimage)+i
	Primitive049.BlendDisableLighting=0.1*(cabimage)+i
	Primitive050.BlendDisableLighting=0.1*(cabimage)+i
	Primitive051.BlendDisableLighting=0.1*(cabimage)+i
	Primitive052.BlendDisableLighting=0.1*(cabimage)+i
	Primitive053.BlendDisableLighting=0.1*(cabimage)+i

	SetGI 181,GI039 : GI040.state=i : GI041.state=i : GI042.state=i : SLS(177,1)=i' topleft
		  GI070.state=i : Gi_016.state=i : GI071.state=i : Gi076.state=i ' TOP LEFT

	SetGI 180,GI047 : GI048.state=i :  GI055.state=i 
		 GI052.state=i : GI054.state=i : Primitive118.blenddisablelighting=i ' top Right
		GI064.state=i : GI065.state=i :

	SetGI 179,GI056 : GI057.state=i : GI058.state=i : GI059.state=i : GI060.state=i : GI061.state=i  ' overbumpers
		GI062.state=i : GI063.state=i :  GI066.state=i : GI067.state=i
		GI068.state=i : GI069.state=i
		Primitive088.BlendDisableLighting=0.1*(cabimage)+i
		Primitive089.BlendDisableLighting=0.1*(cabimage)+i
		Primitive090.BlendDisableLighting=0.1*(cabimage)+i
		Primitive091.BlendDisableLighting=0.1*(cabimage)+i
		Primitive092.BlendDisableLighting=0.1*(cabimage)+i
		Primitive093.BlendDisableLighting=0.1*(cabimage)+i
		Primitive094.BlendDisableLighting=0.1*(cabimage)+i
		Primitive095.BlendDisableLighting=0.1*(cabimage)+i
		Primitive096.BlendDisableLighting=0.1*(cabimage)+i*0.6

'
	
	FadeL 178 : Primitive084.blenddisablelighting=i*0.1 + cabimage/10   ' mid
	FadeL 177 : Primitive120.blenddisablelighting=i*0.1 + cabimage/16	
	FadeL 176 : Primitive001.blenddisablelighting=i + cabimage/9' : Primitive142.blenddisablelighting=i*0.5 + cabimage/9 'slings
	FadeL 175 : Primitive002.blenddisablelighting=i + cabimage/9' : Primitive143.blenddisablelighting=i*0.5 + cabimage/9




End Sub


Sub Gate1_Hit
	SoundHeavyGate
End Sub



Sub Gate001_Hit
	PlaySoundAtLevelStatic ("Gate_2"), GateSoundLevel*3, Activeball
	
	spb2 95,95,4,0,0,1
End Sub

Sub Gate002_Hit
	PlaySoundAtLevelStatic ("Gate_2"), GateSoundLevel*3, Activeball
	spb2 98,98,4,0,0,1
End Sub




Sub ProgressBarReset
	ProgressbarCounter=0
	ProgressBar

	If SC(pn,50) and 1  Then SLS(171,1)=1 Else SLS(171,1)=0
	If SC(pn,50) and 2  Then SLS(172,1)=1 Else SLS(172,1)=0
	If SC(pn,50) and 4  Then SLS(173,1)=1 Else SLS(173,1)=0
	If SC(pn,50) and 8  Then SLS(174,1)=1 Else SLS(174,1)=0
	If SC(pn,50) and 16 Then SLS(147,1)=1 Else SLS(147,1)=0
	If SC(pn,50) and 32 Then SLS(148,1)=1 Else SLS(148,1)=0
	If SC(pn,50) and 64 Then SLS(149,1)=1 Else SLS(149,1)=0


End Sub

Dim towerBOTopacity
Dim ProgressbarCounter 

Sub ProgressBar

	Dim Maxprogress, ProgressbarTemp
	If SC(pn,27)=0 Then Maxprogress=20
	If SC(pn,27)=1 Then Maxprogress=28
	If SC(pn,27)=2 Then Maxprogress=31
	If SC(pn,27)=3 Then Maxprogress=33

	ProgressbarTemp=int (SC(PN,31) * 16 / Maxprogress)
	If ProgressbarTemp>16 Then ProgressbarTemp=16 : Exit Sub

'	debug.print "progressNR = " & ProgressbarTemp & "   PN,31 = " & SC(PN,31) & " of20 LvL1"

	If ProgressbarCounter<ProgressbarTemp Then
		SPB2 154+ProgressbarTemp,154+ProgressbarTemp,12,0,0,1
		for i = 1 to ProgressbarTemp
			SLS(154+i,1)=1
		Next
		If ProgressbarCounter<15 Then ProgressbarCounter=ProgressbarCounter+1
	End If
'	FadeL 155 : Setp3 Bwp001,4.4

End Sub


Sub SignTurnOFF_Timer ' turn to game over
	dim x

	x=Primitive086.RotY+1
	If x>359 then x=0
	For Each i in Liandri 
		i.Roty=X
	Next
'	if x = 0 then SignTurnOFF.Enabled=False
End Sub

Sub SignTurnON_Timer ' turn to normal
	dim x
	
	SignTurnOFF.enabled=False
	x=Primitive086.RotY+1

'	debug.print "signturning " & X

	If x>359 then x=0
	For Each i in Liandri 
		i.Roty=X
	Next
	if x = 180 then SignTurnON.Enabled=False
End Sub

'	nl001.RotY=270
'	NL1.RotY=270
'	NL2.RotY=270
'	NL3.RotY=270
'	NL4.RotY=270
'	NL5.RotY=270
'	NL6.RotY=270
'	NL7.RotY=270
'	liandri1.RotY=270
'	liandri2.RotY=270
'	liandri3.RotY=270
'	liandri4.RotY=270
'	liandri5.RotY=270
'	Primitive086.RotY=270





dim cabimage
cabimage=1
Dim Pflash34, Pflash62


Sub Gidark1234_Timer
	If Gidark1234.Enabled=False Then
		Gidark1234.Enabled=True
		for i = 179 to 190
			SLS(i,1)=0
		Next
	Else
		Gidark1234.Enabled=False
		Gidark1234.interval=1234
		for i = 179 to 190
			SLS(i,1)=1
		Next
	End If
End Sub


'**********************************************************************************************************
'* Ramp ends move alittle when ball hits
'**********************************************************************************************************


Sub Wall003_Hit
	Primitive129.transY=3
	wall003.timerenabled=True
End Sub


Sub Wall003_Timer
		Primitive129.transY=Primitive129.transY-1
		If Primitive129.transY<1 Then
			Primitive129.transY=0
			wall003.timerenabled=False
		End If
End Sub
 
Sub Wall202_Hit
	Primitive130.transY=3
	wall202.timerenabled=True
End Sub


Sub Wall202_Timer
		Primitive130.transY=Primitive130.transY-1
		If Primitive130.transY<1 Then
			Primitive130.transY=0
			wall202.timerenabled=False
		End If
End Sub

'**********************************************************************************************************
'* Special blinkers *
'**********************************************************************************************************

Sub SPB1( tmp1,tmp5,tmp2,tmp6,tmp3,tmp4)
	tempnr=tmp3 : tempnr2=1
	If tmp1>tmp5 then tempnr2=-1
	for i=tmp1 to tmp5 Step tempnr2
		SLS(i, 5) = 3
		SLS(i, 6) = tmp6
		SLS(i, 8) = tmp2 
		SLS(i,11) = tempnr
		SLS(i,12) = tmp4
		tempnr = tempnr + tmp3
	Next
End Sub 
Sub SPB2( tmp1,tmp5,tmp2,tmp6,tmp3,tmp4)
	tempnr=tmp3 : tempnr2=1
	If tmp1>tmp5 then tempnr2=-1
	for i=tmp1 to tmp5 Step tempnr2
		SLS(i, 0) = 1 ' fastblinks ( double speed )
		SLS(i, 5) = 3
		SLS(i, 6) = tmp6
		SLS(i, 8) = tmp2 
		SLS(i,11) = tempnr
		SLS(i,12) = tmp4
		tempnr = tempnr + tmp3
	Next
End Sub 
Sub SPB3( tmp1,tmp5,tmp2,tmp6,tmp3,tmp4)
	tempnr=tmp3 : tempnr2=1
	If tmp1>tmp5 then tempnr2=-1
	for i=tmp1 to tmp5 Step tempnr2
		SLS(i, 0) = 2 ' triple speed blinks
		SLS(i, 5) = 3
		SLS(i, 6) = tmp6
		SLS(i, 8) = tmp2 
		SLS(i,11) = tempnr
		SLS(i,12) = tmp4
		tempnr = tempnr + tmp3
	Next
End Sub

Dim LShead, LStail, LSAllUP, LSaddH , LSblinks
Sub SPBallup(tmp2,tmp1,tmp3) '  tail in updates
	If LSALLDOWN=0 Then  ' only if the other is not running
	
		LSALLUP = 1
		LShead  = 2150
		LSaddH  =-tmp2
		LStail  = tmp1 ' how long light should be on before going out
		LSblinks= tmp3
	
		for i = 1 to 170
			If sls(i,14)>0 Then SLS(i,5)=2 ' off all that has stored XY
		Next
	End If
End Sub

Dim LSALLDOWN
Sub SPBalldown(tmp2,tmp1,tmp3) '  tail in updates
	If LSALLUP=0 Then  ' only if the other is not running
		LSALLDOWN = 1
		LShead  = 0
		LSaddH  = tmp2
		LStail  = tmp1 ' how long light should be on before going out
		LSblinks= tmp3
		for i = 1 to 170
			If sls(i,14)>0 Then SLS(i,5)=2 ' off all that has stored XY
		Next
	End If
End Sub

Sub SPBredside
	for i = 1 to 130
		If SLS(i,13)>475 Then
			SLS(i,5)=2 'off
		Elseif SLS(i,13)>0 Then
			SLS(i,5)=1 'on
		End If
	Next
	SPBred.enabled=True
End Sub


Sub SPBred_Timer ' 88ms
	SPBred.enabled=False
	for i = 1 to 139
		If SLS(i,13)>0 Then SLS(i,5)=0
	Next
End Sub

Sub SPBblueside
	for i = 1 to 130
		If SLS(i,13)>475 Then
			SLS(i,5)=1 'On
		Elseif SLS(i,13)>0 Then
			SLS(i,5)=0 'off
		End If
	Next
	SPBblue.enabled=True
End Sub


Sub SPBblue_Timer ' 88ms
	SPBblue.enabled=False
	for i = 1 to 139
		If SLS(i,13)>0 Then SLS(i,5)=0
	Next
End Sub

Dim LShalfandhalf
Sub SPBhalfandhalf(tmp1) ' nr of blinks
	LShalfandhalf = tmp1
	LShalfcounter=0
	SPBleftright.enabled=True
End Sub

Dim LShalfcounter
Sub SPBleftright_Timer ' 30ms
	LShalfcounter=LShalfcounter+1

	Select Case  LShalfcounter
		Case 1 : 
			for i = 1 to 130
				If SLS(i,13)>475 Then
					SLS(i,5)=1 'On
				Elseif SLS(i,13)>0 Then
					SLS(i,5)=0 'off
				End If
			Next
		
		Case 4 :	
			for i = 1 to 130
				If SLS(i,13)>475 Then
					SLS(i,5)=2 'off
				Elseif SLS(i,13)>0 Then
					SLS(i,5)=1 'on
				End If
			Next

		Case 6 :
			LShalfcounter=0
			LShalfandhalf=LShalfandhalf-1
			If LShalfandhalf<1 Then
				SPBleftright.enabled=False
				for i = 1 to 170
					If sls(i,14)>0 Then SLS(i,5)=0 ' off Spesial state all that has stored XY
				Next
			End If
	End Select

End Sub




'**********************************************************************************************************
'* Fade level *
'**********************************************************************************************************
Sub FadeL ( nr )
	If LSALLUP=1 And SLS(nr,14)<LShead And SLS(nr,14)>LShead+LSaddH And SLS(nr,5)=2 Then
		SPB1 nr,nr,2, LStail ,0, 1
	Elseif LSALLDOWN=1 And SLS(nr,14)>LShead And SLS(nr,14)<LShead+LSaddH And SLS(nr,5)=2 Then
		SPB1 nr,nr,2, LStail ,0, 1
	End If
	i = SLS(nr,2)

	If SLS(nr,5) < 1 Then ' no special light state
		Select Case SLS(nr,1)
			Case 1 : i=i+1 
					If i = 1 then i = 2
					If i > 6 Then i = 6 
			Case 0 : i=i-1 : If i < 0 Then i = 0
			Case 2 : i=i-1 : If i < 0 Then i = 0 : 					SLS(nr,1)=3							' 2+ = blinking
			Case 3 : i=i+1
					 If i = 1 then i = 2 
					 If i > 6 Then i = 6 						:	SLS(nr,1)=4 : SLS(nr,4)=SLS(nr,3)
			Case 4 : SLS(nr,4) = SLS(nr,4) -1 : If SLS(nr,4)<0 Then SLS(nr,1)=5 
			Case 5 : i=i-1 : If i < 0 Then i = 0 				:	SLS(nr,1)=6 : SLS(nr,4)=SLS(nr,3)
			Case 6 : SLS(nr,4) = SLS(nr,4) -1 
						If SLS(nr,4)<0 Then
							If SLS(nr,9)>0 Then
								SLS(nr,9)=SLS(nr,9)-1
								If SLS(nr,9)=0 Then
									SLS(nr,1)=1 'turn on after blinking is done
								Else
									SLS(nr,1)=3  ' next blink
								End If
							Else
								SLS(nr,1)=3  ' state 2 : no number of blinks set = always blink 
							End If
						End If
		End select
'SLS=1 LFS=2 SLSP=3 SLSQ=4 LSP=5 LSPP=6 LSPQ=7 8=sp nrblinks   9= normal numberof blinks ( if 8 or 9 = 0 ) then repeat blinking forever 10=special state ends after xxx frames ( a blink is 12 frames )

	Else
		If SLS(NR,11)>0 Then SLS(nr,11)=SLS(nr,11)-1 : If SLS(nr,11)>0 Then Exit Sub
		If SLS(nr,10)>0 Then SLS(nr,10)=SLS(nr,10)-1 : If SLS(nr,10)=0 Then SLS(nr,5)=0
		Select Case SLS(nr,5)   
			' special takes over  2= off 3=blink
			Case 1 : i=i+1 + SLS(NR,0)
					If i = 1 then i = 2
					If i > 6 Then i = 6 
			Case 2 : i=i-1- SLS(NR,0) : If i < 0 Then i = 0 
			Case 3 : i=i-1- SLS(NR,0) : If i < 0 Then i = 0 : 					SLS(nr,5)=4							' 2+ = blinking
			Case 4 : i=i+1+ SLS(NR,0) :	
					 If i=1 then i=2
					 If i > 6 Then i = 6 				  		  : SLS(nr,5)=5 : SLS(nr,7)=SLS(nr,6)
			Case 5 : SLS(nr,7) = SLS(nr,7) -1 : If SLS(nr,7)<0 Then SLS(nr,5)=6 
			Case 6 : i=i-1- SLS(NR,0) : If i < 0 Then i = 0 : 					SLS(nr,5)=7 : SLS(nr,7)=SLS(nr,6)
			Case 7 : SLS(nr,7) = SLS(nr,7) -1 
						If SLS(nr,7)<0 Then
							If SLS(nr,8)>0 Then
								SLS(nr,8)=SLS(nr,8)-1
								If SLS(nr,8)=0 Then
									If SLS(nr,12)=0 Then
										SLS(nr,5)=1 'turn on after blinking is done . special state still on
									Else
										SLS(nr,12)=0 'reset flag 12
										SLS(nr,5)=0 'turn off special if flag 12 is set 
										SLS(nr,0)=0 ' fastblinking off ( must be reaplied everytime )
									End If
								Else
									SLS(nr,5)=4  ' next blink
								End If
							Else
								SLS(nr,5)=4  ' state 2 : no number of blinks set = always blink 
							End If
						End If
		End select

	End If

	SLS(nr,2) = i 

	If LSALLUP=1 or LSALLDOWN=1 Then i=i*1.3


End Sub

Sub SetL( object,Multi)
	object.intensity = i * Multi - cabimage/15
End Sub

Sub SetP2 ( object )
	If i = 0 Then
		object.visible=true
		object.BlendDisableLighting = (cabimage-1) / 9
	else
		object.visible=false
	End If
End Sub

Sub SetP2b ( object ) ' bigones
	If i = 0 Then
		object.visible=true
		object.BlendDisableLighting = (cabimage-1) / 3
	else
		object.visible=false
	End If
End Sub

Sub SetP3 ( object,Multi)
	object.BlendDisableLighting = multi*i
End Sub

Sub SetP ( object,Multi)
	object.BlendDisableLighting = multi*i
	object.visible=i
End Sub

Dim GIsound
Sub SetGI(nr,object)
	i= SLS(nr,1)
	If SLS(nr,2) > 0 Then ' delayed turnoff
		GIsound=GIsound+1
		If GIsound=260 Then GIsound=0 : PlaySound "fx_relay", 1,0.05*VolumeDial,0,0,0,0,0,0
		SLS(nr,2) = SLS(nr,2) - 1
'		SLS(nr,3)=SLS(nr,3)+1 ' count 20 frames ?
		If ( SLS(nr,2) mod 32 ) <18 Then i=1 else i=0
'		If SLS(nr,3)>32 Then SLS(nr,3)=0
	End If
	object.state = i
End Sub

Sub allDTdrop
	DropAllNoHit.enabled=False
	DropAllNoHit_Timer
End Sub


'**********************************************************************************************************
'* Lightshow at Gameover *
'**********************************************************************************************************
L27a_timer

Dim LS1,stopgi, count01, count02, GIswitch, FlashCount
Dim walllights, walldir
walldir=1

Sub lightshow

	If startgame=1 Then Exit Sub

	count01=count01+1
	If count01=22 And Int(Rnd(1)*3)=1 Then count01=0
	If count01=43 And Int(Rnd(1)*4)=1 Then count01=22
	If count01>45 Then
		count01=0
		If Giswitch=0 Then
			GIswitch=1 
		Else
			GIswitch=0 
		End if
			For i = 179 To 190 
				SLS(i,1)=GiSwitch 
			Next
		PlaySound "fx_relay", 1,0.2*VolumeDial,0,0,0,0,0,0
	End if

	select case count01


		case 1 ,37 : SLS(2,1)=1 : SLS(7,1) =1 : SLS(15,1) =1  : SLS(50,1) =1 : SLS(24,1) =1 : SLS(29,1) =1 : SLS(34,1) =1 : SLS(35,1) =1 : SLS(41,1) =1 : SLS(46,1) =1 : SLS(47,1) =1 : SLS(91,1)=1
		case 5 : SLS(94,1)=1 : SLS(98,1)=1 : SLS(95,1)=1 : SLS(97,1)=1 : SLS(119,1)=1
		case 11:  SLS(95,1)=0 : SLS(97,1)=0: SLS(94,1)=0 : SLS(98,1)=0 : SLS(119,1)=0
		case 17 : 	
			If Int(Rnd(1)*3)=1 Then
		SPB2 101,103,1,0,0,1
			End If
			VRBGFLBump

		case 4 ,34 : SLS(3,1)=1 : SLS(8,1) =1 : SLS(16,1) =1  : SLS(51,1) =1 : SLS(23,1) =1 : SLS(28,1) =1 : SLS(33,1) =1 : SLS(36,1) =1 : SLS(42,1) =1 : SLS(48,1) =1 : SLS(71,1) =1 : SLS(92,1)=1
		case 7 ,31 : SLS(4,1)=1 : SLS(9,1) =1 : SLS(17,1) =1  : SLS(52,1) =1 : SLS(22,1) =1 : SLS(27,1) =1 : SLS(32,1) =1 : SLS(37,1) =1 : SLS(43,1) =1 : SLS(49,1) =1 : SLS(85,1) =1
		case 10,28 : SLS(5,1)=1 : SLS(10,1)=1 : SLS(18,1) =1  : SLS(53,1) =1 : SLS(21,1) =1 : SLS(26,1) =1 : SLS(31,1) =1 : SLS(38,1) =1 : SLS(44,1) =1 : SLS(63,1) =1 : SLS( 1,1) =1
		case 13,25 : SLS(6,1)=1 : SLS(11,1)=1 : SLS(19,1) =1  : SLS(54,1) =1 : SLS(20,1) =1 : SLS(25,1) =1 : SLS(30,1) =1 : SLS(39,1) =1 : SLS(45,1) =1 : SLS(64,1) =1 : SLS(72,1) =1 
		case 16,22 :	Objlevel(5) = 1 : FlasherFlash5_Timer : 	  SLS(55,1) =1 :	SLS(96,1)=1 :SLS(90,1)=1  :        SLS(40,1) =1:        SLS(70,1) =1 : spb2 94,95,2,0,0,1 : spb2 97,98,2,0,0,1
	
		case 6 ,42 : SLS(2,1)=0 : SLS(7,1) =0 : SLS(15,1) =0  : SLS(50,1) =0 : SLS(24,1) =0 : SLS(29,1) =0 : SLS(34,1) =0 : SLS(35,1) =0 : SLS(41,1) =0 : SLS(46,1) =0 : SLS(47,1) =0 : SLS(91,1)=0
		case 9 ,39 : SLS(3,1)=0 : SLS(8,1) =0 : SLS(16,1) =0  : SLS(51,1) =0 : SLS(23,1) =0 : SLS(28,1) =0 : SLS(33,1) =0 : SLS(36,1) =0 : SLS(42,1) =0 : SLS(48,1) =0 : SLS(71,1) =0 : SLS(92,1)=0
		case 12,36 : SLS(4,1)=0 : SLS(9,1) =0 : SLS(17,1) =0  : SLS(52,1) =0 : SLS(22,1) =0 : SLS(27,1) =0 : SLS(32,1) =0 : SLS(37,1) =0 : SLS(43,1) =0 : SLS(49,1) =0 : SLS(85,1) =0
		case 15,33 : SLS(5,1)=0 : SLS(10,1)=0 : SLS(18,1) =0  : SLS(53,1) =0 : SLS(21,1) =0 : SLS(26,1) =0 : SLS(31,1) =0 : SLS(38,1) =0 : SLS(44,1) =0 : SLS(63,1) =0 : SLS( 1,1) =0
		case 18,30 : SLS(6,1)=0 : SLS(11,1)=0 : SLS(19,1) =0  : SLS(54,1) =0 : SLS(20,1) =0 : SLS(25,1) =0 : SLS(30,1) =0 : SLS(39,1) =0 : SLS(45,1) =0 : SLS(64,1) =0 : SLS(72,1) =0
		case 21,27 :	Objlevel(5) = 1 : FlasherFlash5_Timer :   SLS(55,1) =0 : 		SLS(96,1)=0 :SLS(90,1)=0:		  SLS(40,1) =0 :        SLS(70,1) =0
		Case 44 : 
					Objlevel(4) = 1 : FlasherFlash4_Timer
					playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.3, 0,0,0,0,0,0
					DOF 156,2
					dtbg_timer ' little flash on desktop background

	End Select

if ( count02 mod 2 ) = 1 Then
	If walllights>19 Then
		SPB1 127+walllights,127+walllights,1,0,0,1
	Else
		SPB1 155+walllights,155+walllights,1,0,0,1
	End If
	walllights=walllights+walldir
	if walllights<0 then walllights=0 : walldir=1 : If int(rnd(1)*2)=1 Then : spb2 155,174,1,0,0,1 : spb2 147,149,1,0,0,1 : End If
	if walllights>22 then walllights=22 : walldir=-1 : If int(rnd(1)*2)=1 Then : spb2 155,174,1,0,0,1 : spb2 147,149,1,0,0,1 : End If
End If
	count02=count02+1
		If count02>14 then
			count02=0
			FlashCount=FlashCount+1
			Select Case FlashCount
				Case 1 : Objlevel(1) = 1 : FlasherFlash1_Timer : Objlevel(8) = 1 : FlasherFlash8_Timer :	playSound "fx_relay", 1,0.15*VolumeDial,0,0,0,0,0,0 
						DOF 108,2 
'						If DOFdebug=1 Then debug.print "DOF 108,2 flasherB1"
						DOF 111,2 
'						If DOFdebug=1 Then debug.print "DOF 111,2 flasherR1" 


						liandrilightshow
						for i = 78 to 82 : SLS(i,1)=1 : Next 

				Case 2 : Objlevel(2) = 1 : FlasherFlash2_Timer : Objlevel(3) = 1 : FlasherFlash3_Timer :	playSound "fx_relay", 1,0.15*VolumeDial,0,0,0,0,0,0

						DOF 112,2 
'						If DOFdebug=1 Then debug.print "DOF 112,2 flasherb2"
						DOF 109,2 
'						If DOFdebug=1 Then debug.print "DOF 109,2 flasher1"
						for i = 78 to 82 : SLS(i,1)=0 : Next 
						SLS(83,1)=1

				Case 3 : Objlevel(7) = 1 : FlasherFlash7_Timer : Objlevel(9) = 1 : FlasherFlash9_Timer :	playSound "fx_relay", 1,0.15*VolumeDial,0,0,0,0,0,0

						DOF 113,2 
'						If DOFdebug=1 Then debug.print "DOF 113,2 flasher7"
						DOF 110,2 
'						If DOFdebug=1 Then debug.print "DOF 110,2 flasher1"
						SLS(83,1)=0
						liandrilightshow
				Case 4 : FlashCount=0
			End Select
		End If
	Select Case count02
		Case 1  :  SLS(59,1)=1 : SLS(14,1)=1 : SLS(65,1)=1 : BlueDisplay(8)
		Case 3  :  SLS(60,1)=1 : SLS(13,1)=1 : SLS(66,1)=1 : SLS(73,1)=1 
		Case 5  :  SLS(61,1)=1 : SLS(12,1)=1 : SLS(67,1)=1 : REDDisplay(8)
		Case 7  :  SLS(62,1)=1 :			   SLS(68,1)=1 : SLS(74,1)=1

		Case 6  :  SLS(59,1)=0 : SLS(14,1)=0 : SLS(65,1)=0 : BlueDisplay(10) 
		Case 8  :  SLS(60,1)=0 : SLS(13,1)=0 : SLS(66,1)=0 : SLS(73,1)=0 
		Case 10 :  SLS(61,1)=0 : SLS(12,1)=0 : SLS(67,1)=0 : REDDisplay(10)
		Case 12 :  SLS(62,1)=0 :			   SLS(68,1)=0 : SLS(74,1)=0 
	End Select

	If Int(Rnd(1)*17)=2 Then

		SLS( 56 + LS1 ,1 ) = 0

		LS1 = LS1 + 1
		If LS1 > 2 Then LS1 = 0

			SLS( 56 + LS1 ,1 ) = 1
	End If


	If Int(Rnd(1)*10)=3 Then
		PlaySound "fx_relay", 1,0.05*VolumeDial,0,0,0,0,0,0
		i= Int(Rnd*12)
		If SLS(179+i,1) = 1 Then
			SLS(179+i,1) = 0 
		Else
			SLS(179+i,1) = 1 
		End If
		if i=11 or i=12 Then SLS(185,1)=1


	End If

End Sub

Sub liandrilightshow
	i=Int(Rnd(1)*11)+1
	Select Case i
		case 1 : SPB2 112,118,1,0,3,1
		case 2 : SPB2 118,112,1,0,3,1
		case 3 : spb2 141,145,4,0,1,1
		case 4 : spb1 141,145,2,0,2,1
		case 5 : SPB1 112,118,2,0,0,1
		case 6 : SPB1 112,118,1,0,1,1
		case 7 : SPB2 118,112,1,0,1,1
		case 8 : SPB2 112,118,1,0,2,1
				 spb2 141,145,2,0,0,1
		case 9 : SPB2 118,112,1,0,2,1
				 spb2 141,145,2,0,0,1
		case 10: spb2 112,118,2,10,2,1
				 spb2 141,145,2,10,0,1
		case 11: spb2 118,112,2,10,2,1
				 spb2 145,141,2,10,0,1
		case 10: spb2 112,118,2,1,3,1
				 spb2 141,145,2,1,1,1
		case 11: spb2 118,112,2,1,3,1
				 spb2 145,141,2,1,1,1

	End Select
End Sub
 




'**********************************************************************************************************
'* Taunting * And * Randomsounds * Random background noise *
'**********************************************************************************************************

Sub Taunting_Timer  ' male 1,2   female 1,2 

	If tilted=0 Then
		If Taunting.enabled=False Then
			Taunting.enabled=True '  2sec delay
		Else

			If SC(PN,20)=0 Then playsound "a" & int(rnd(1)*47)+1 , 1, 0.9*BG_Volume, 0, 0,0,0, 0, 0	
			If SC(PN,20)=1 Then playsound "m" & int(rnd(1)*39)+1 , 1, 0.9*BG_Volume, 0, 0,0,0, 0, 0

			If SC(PN,20)=2 Then playsound "b" & int(rnd(1)*46)+1 , 1, 0.9*BG_Volume, 0, 0,0,0, 0, 0
			If SC(PN,20)=3 Then playsound "c" & int(rnd(1)*50)+1 , 1, 0.9*BG_Volume, 0, 0,0,0, 0, 0
			Taunting.enabled=False 
		End If
	End If

End Sub



Sub Taunting2_Timer
	Dim weaponsounds
	weaponsounds=Array("aarocket_exp","aarocketload","aarocket_fire","aasniperfire1","aasniperfire2","aareload","aashock_fire","aashockalt_fire","aamini_fire","aaflakload","aaflak_fire","aadrawsniper","biofire","bioimpact","controlsound","minialtfire","pulsebolt","pulsefire","ripperfire")
'19	
	If Startgame=1 And Tilted=0 And plungertoolong.enabled=False Then
		
		i=int(rnd(1)*36)
		If i=SC(PN,20) Then i=i+1
		tempnr=int(Rnd(1)*3)-1
		tempnr2=rnd(1) * BG_Volume * 0.6
'		debug.print "taunting2 rndvolume=" & tempnr2
		Select Case i
			Case 0 : playsound "a" & int(rnd(1)*47)+1 , 1, tempnr2, 0, 0,0,0, 0, 0
			Case 1 : playsound "m" & int(rnd(1)*39)+1 , 1, tempnr2, 0, 0,0,0, 0, 0
			Case 2 : playsound "b" & int(rnd(1)*46)+1 , 1, tempnr2, 0, 0,0,0, 0, 0
			Case 3 : playsound "c" & int(rnd(1)*50)+1 , 1, tempnr2, 0, 0,0,0, 0, 0
			Case 4,5,6,7,8,9,10,11,12,13		: playsound Weaponsounds(int(rnd(1)*19)),1,  tempnr2, Rnd(1)*tempnr, 0,0,0, 0, 0
			Case 14,15,24,25,32,33,34 : 		 playsound "f" & int(rnd(1)*36)+1,1,  tempnr2, Rnd(1)*tempnr, 0,0,0, 0, 0

			Case 16,17,18,19,20,21,22,23		: playsound "d" & int(rnd(1)*95)+1 , 1, tempnr2, Rnd(1)*tempnr, 0,0,0, 0, 0
			Case 26,27,28,29,30,31 				: playsound Weaponsounds(int(rnd(1)*19)),1,  tempnr2/2.5 , Rnd(1)*tempnr, 0,0,0, 0, 0
			Case 35 :
					If Int(Rnd(1)*3)=1 Then 
						MegaPulse.Enabled=True
					Else
						playsound "vr" & int(rnd(1)*10),1,  tempnr2, Rnd(1)*tempnr, 0,0,0, 0, 0
					End If
		End Select

	End If

End Sub

Sub perfection_Timer
	playsound "perfection", 1, 0.7*BG_Volume, 0, 0,0,0, 0, 0
	perfection.enabled=False
End Sub

Dim megapulsecount
Dim megapulsepos
Dim megapulsedir
megapulsedir=0 : megapulsepos=1


Sub MegaPulse_Timer

	If megapulsedir=0 Then

		Megapulsepos=Megapulsepos-0.25
		If Megapulsepos<-1 Then 
			MegaPulse.Enabled=False
			megapulsedir=int(Rnd(1)*2)
			If megapulsedir=0 Then megapulsepos=1 Else megapulsepos=-1
			Exit Sub
		End If
	Else
		Megapulsepos=Megapulsepos+0.25
		If Megapulsepos>1 Then 
			MegaPulse.Enabled=False
			megapulsedir=int(Rnd(1)*2)
			If megapulsedir=0 Then megapulsepos=1 Else megapulsepos=-1
			Exit Sub
		End If
	End If 
	stopsound "pulsefire"
	playsound "pulsefire",1,  0.1*BG_Volume , megapulsepos, 0,0,0, 0, 0
End Sub




'**********************************************************************************************************
'* HEADSHOT *
'**********************************************************************************************************
Dim TrippleHS	
Dim DoubleHS	
Sub HeadShot

	spb2 97,97,3,0,0,1
	SPB2 112,118,2,0,0,1

	dtbg_timer
	SPB2 201,202,2,0,0,1 ' apronlights
	SLS(185,2)=24 '  fast GI 
	spb2 1,1,3,0,0,1
	DOF 110,2
	DOF 113,2
	spb2 7,34,3,0,0,1
	If OntopEffect=0 Then OntopEffect=1

	If SC(PN,34)=1 Then ' ROC On
		If SC(PN,35)=2 Then ' mission2
			SC(PN,38)=SC(PN,38)+1 '  add to flag counter
			If SC(PN,38) >= SC(PN,36)*5 Then ' next level
				Scoring SC(PN,36)*1000000,50000
				RocReward = formatscore(FFTscore)  ' / 20 !!! face give *20 : champtext2
				SC(PN,35)=3 ' nextlevel on
				SC(PN,38)=0
				SC(PN,39)=0
			End If
		End If
	End If

	
	playsound "AAheadshot", 1, 0.6*BG_Volume, 0, 0,0,0, 0, 0 

	TrippleHS=TrippleHS+1

	If TrippleHS=3 And doubleHS=0 Then
		doubleHS=2
		P044.material="InsertOrangeOnTri"

		' fix lights anim ation ?
		'  text ACTIVE 2x , HEADSHOT fast
		SPBallup 35,6,3  ' speed up, lightstayontime, blinks
		perfection.enabled=True

		Scoring 50000,6000
		FFT=FFTscore
'		Addpopup "ACTIVE DOUBLE","HEADSHOTS",fontbig2
		doubleheadshots=1

		If DB2S_on Then B2STimer1_Timer  ' or b2stimer2 for big one
		DOF 142,2 
'		If DOFdebug=1 Then debug.print "DOF 142,2 Headshot"
	End If
	
	If doubleHS=0 Then
		Scoring 25000,3000
		FFT=FFTscore
		Addpopup "HEADSHOT",FormatScore(FFT),fontbig2

		If DB2S_on Then B2STimer1_Timer  ' or b2stimer2 for big one
		DOF 142,2 
'		If DOFdebug=1 Then debug.print "DOF 142,2 Headshot"
	End If
	If doubleHS=1 Then
		Scoring 50000,6000
		FFT=FFTscore
		Addpopup "HEADSHOT X2",FormatScore(FFT),fontbig2
		If DB2S_on Then B2STimer1_Timer  ' or b2stimer2 for big one
		DOF 142,2 
'		If DOFdebug=1 Then debug.print "DOF 142,2 Headshot"
	End If
	If DoubleHS=2 Then DoubleHS=1

'	DEBUG.print "HS DS=" & DoubleHS & " THS=" & trippleHS
	Gidark1234_Timer

End Sub

Sub Frag
	Scoring 2500,250
End Sub


Dim JP1
JP1=Array("perfection","stepaside","wantsome","inferior","myhouse","superior","obsolete","diehuman","imonfire","hadtohurt","fearme","bowdown")
Sub Jackpot

	Scoring 200000,25000
	FFT=FFTscore
	Addpopup "CAMPER BONUS",FormatScore(FFT),fontbig2
	Objlevel(5) = 1 : Flasherflash5_Timer
	playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0
	Objlevel(4) = 1 : Flasherflash4_Timer
	DOF 156,2
	SPB1 1,139,2,1,0,1 ' megablinks
	PlaySound JP1(int(Rnd(1)*12)) , 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0

End Sub


Sub FirstbloodX
	PlaySound "AAFirstblood" , 1, BG_Volume, 0, 0,0,0, 0, 0 : Firstblood=1
		Addpopup "FIRSTBLOOD","FIRSTBLOOD" ,fontbig3
End Sub

Sub SetlightsRedeemer

		If SC(PN,13)>0 Then SLS( 7,1)=1 : SPB1 7,7,3,2,1,1 '	12  Rightorbit
		If SC(PN,13)>1 Then SLS( 8,1)=1 : SPB1 8,8,3,2,1,1
		If SC(PN,13)>2 Then SLS( 9,1)=1 : SPB1 9,9,3,2,1,1
		If SC(PN,13)>3 Then SLS(10,1)=1 : SPB1 10,10,2,3,1,1
		If SC(PN,13)>4 Then SLS(11,1)=1 : SPB1 11,11,2,3,1,1

		If SC(PN,12)>0 Then SLS(15,1)=1 : SPB1 15,15,2,3,1,1'	13  Leftorbit nr(1-5=nr of lights lit) + more states ?
		If SC(PN,12)>1 Then SLS(16,1)=1 : SPB1 16,16,2,3,1,1
		If SC(PN,12)>2 Then SLS(17,1)=1 : SPB1 17,17,2,3,1,1
		If SC(PN,12)>3 Then SLS(18,1)=1 : SPB1 18,18,2,3,1,1
		If SC(PN,12)>4 Then SLS(19,1)=1 : SPB1 19,19,2,3,1,1

		If SC(PN,14)>0 Then SLS(20,1)=1 : SPB1 20,20,2,3,1,1'	14  kicker1
		If SC(PN,14)>1 Then SLS(21,1)=1 : SPB1 21,21,2,3,1,1
		If SC(PN,14)>2 Then SLS(22,1)=1 : SPB1 22,22,2,3,1,1
		If SC(PN,14)>3 Then SLS(23,1)=1 : SPB1 23,23,2,3,1,1
		If SC(PN,14)>4 Then SLS(24,1)=1 : SPB1 24,24,2,3,1,1

		If SC(PN,15)>0 Then SLS(25,1)=1 : SPB1 25,25,2,3,1,1'	15  kicker2
		If SC(PN,15)>1 Then SLS(26,1)=1 : SPB1 26,26,2,3,1,1
		If SC(PN,15)>2 Then SLS(27,1)=1 : SPB1 27,27,2,3,1,1
		If SC(PN,15)>3 Then SLS(28,1)=1 : SPB1 28,28,2,3,1,1
		If SC(PN,15)>4 Then SLS(29,1)=1 : SPB1 29,29,2,3,1,1

		If SC(PN,16)>0 Then SLS(30,1)=1 : SPB1 30,30,2,3,1,1'	16  kicker3
		If SC(PN,16)>1 Then SLS(31,1)=1 : SPB1 31,31,2,3,1,1
		If SC(PN,16)>2 Then SLS(32,1)=1 : SPB1 32,32,2,3,1,1
		If SC(PN,16)>3 Then SLS(33,1)=1 : SPB1 33,33,2,3,1,1
		If SC(PN,16)>4 Then SLS(34,1)=1 : SPB1 34,34,2,3,1,1

		CaptureCheck

End Sub



'**********************************************************************************************************
'* KICKERS *
'**********************************************************************************************************

Dim RampEB, showRampEB

Sub Kicker001_Hit   ' JUST A TEMP ONE... 
	If SC(pn,48)=0 Then ' have you gotten the 25 ramp EL ?
		If RampEB<25 Then

			RampEB=RampEB+1
			If TournamentMode=0 Then ShowRampEB =Frame+50

		Else
'	50= collectables
'	and 1 = Moonsterkill	' 171
'	and 2 = Level 1			' 172 
'	and 4 = Level 2			' 173
'	and 8 = Level 3			' 174
'	and 16= Level godlike	' 147
'	and 32= Level godlike EL' 148
'	and 64= Level god pwnage' 149
				SLS(148,1)=1
				SC(PN,50)= SC(PN,50) Or 32
				SPB1 148,148,6,0,0,1
		
				SLS(119,1)=2 : SPB2 119,119,7,0,0,1
				SC(PN,48)=1
				RampEB=100
				PlaySound "godlike", 1, BG_Volume, 0, 0,0,0, 0, 0
				Dof 145,2
				Extralife=1
			If TournamentMode=0 Then
				SLS(85,1)=1 : SPB2 85,85,10,0,0,1
			End If
		End If
	End If

	If pwnJP=1 And pwnJPCounter<1000 Then
		spb2 97,97,7,0,0,1

		SPB2 201,202,2,0,0,1
		SLS(96,1)=0 : spb2 96,96,3,0,0,1
		scoring 1000000,50000
		pwnJPscore=FFTscore
		pwnJPCounter=2000
		pwnage=pwnage+1 ' reset pwn to next level
		If SLS(44,1)=0 Then	PlaySound JP1(int(Rnd(1)*12)) , 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0
	End If
	
	SLS(183,2)=33 ' blink towerbottomlight
	SPB1 99,99,4,10,0,1
	SPB1 86,86,5,5,0,1

	If KBstatus=0 Then LiteKBstatus=1 : SLS(47,1)=2



	'E139 mainramp done
	'E140 redeemer	
	'E141 Jackpot	
	'E142 HeadShot  done
	If 	SS2=1 Then
		SS2=0
'		Debug.print "SS2 awarded"
		L059.timerenabled=False
		Skillshot2 ' extra scoring headshot value
		SLS(44,1)=2 ' set hs light on for the rest
	End If

'	If Lockingthisball=1 Then ' something is wrong if this one activates ?
'		kicker001.kick 90,48
'		SPBblueside 
'
'		SoundSaucerKick 1, kicker001
'		exit sub
'	End If

	If SLS(44,1)>1 Then
		HeadShot
		i = int(rnd(1)*3)
		If SC(PN,12+i)<5 Then
			SC(PN,12+i)=SC(PN,12+i)+1
		elseIf SC(PN,13+i)<5 then
			SC(PN,13+i)=SC(PN,13+i)+1
		elseIf SC(PN,14+i)<5 then
			SC(PN,14+i)=SC(PN,14+i)+1
		End If
		If SLS(67,1)=0 Then EnemyFlag
		
		SetlightsRedeemer
	Else
		TrippleHS=0
	End If



	If SLS(45,1)>1 Then

		SLS(173,1)=1'	collectables
		SC(PN,50)= SC(PN,50) Or 4
		SPB1 173,173,6,0,0,1

		Jackpot
		DOF 141,2 

'		If DOFdebug=1 Then debug.print "DOF 141,2 jackpot"
	End If


	If SLS(83,1)>0 then 'Invisiblilty(1)=1 And Invisiblilty(2)=1 And Invisiblilty(3)=1 And Invisiblilty(4)=1 And Invisiblilty(5)=1 Then

		If SC(PN,34)=1 Then ' ROC On
			If SC(PN,35)=5 Then '  mission 5
				Scoring SC(PN,36)*5000000,250000
				RocReward = formatscore(FFTscore)  ' / 20 !!! face give *20 : champtext2
				SC(PN,35)=1 ' nextlevel on
				SC(PN,36)=SC(PN,36)+1
 			End If
		End If

		SPB2 78,83,10,0,0,1

		Respawn=Respawn+60
		SPB2 120,139,10,0,3,1
		For i = 120 to 139
			SLS(i,1)=1
		Next
		SLS(64,1)=2
		SLS(64,3)=6
		Scoring 200000,30000
		FFT=FFTscore
		invisireward=1
'		Addpopup "INVISIBILITY",FormatScore(FFT),fontbig2

		DOF 133,2 
'		If DOFdebug=1 Then debug.print "DOF 133,2 invisibility awarded"
		'133 invisibility awarded
		Invisiblilty(1)=0
		Invisiblilty(2)=0
		Invisiblilty(3)=0
		Invisiblilty(4)=0
		Invisiblilty(5)=0
		SLS (78,1)=0
		SLS (79,1)=0
		SLS (80,1)=0
		SLS (81,1)=0
		SLS (82,1)=0
		SLS (83,1)=0
	End If

	If SC(PN,27)=3 Then
		SC(PN,41)=SC(PN,41)+1
		If SC(PN,41) = 7 Then ' start ROC
			EnterRoc=1
			SC(PN,34) = 1 ' room of champions lit

			SignTurnON.enabled=True
			nl001.image="champ"
			spb1 146,146,20,2,2,1

			SLS(54,1)=2 ' should forever blink
			SLS(54,3)=18 'pause
			SC(PN,35)=1 ' mission 1
			SC(PN,36)=1 ' level 1 
			SC(PN,37)=0 ' 4 silly counters, could probably do it with 1
			SC(PN,38)=0
			SC(PN,39)=0
			SC(PN,40)=0
		End If
	End If


	HeadShotON
	FastFrags=FastFrags+1
	Frag
	SC(PN,19)=SC(PN,19)+1
	CheckFastFrags

	SoundSaucerLock()

	If SLS(65,1)>1 Then
'		Debug.print "kicker001 lockball"
		DOF 143,2 
'		If DOFdebug=1 Then debug.print "DOF 143,2 ball locked"
		lockedanim=2

		Objlevel(4) = 1 : Flasherflash4_Timer
		Objlevel(5) = 1 : Flasherflash5_Timer
		playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0

		DOF 156,2
		'E143 ball locked 1
		SPB1 86,86,10,1,0,1

		If locked1=0 or locked2=0 Then
			kicker001.destroyball
			RandomSoundDrain(Kicker001)
'		Debug.print "kicker001 lockball start lockthisball1"
			' lock this ball and shoot out a new one
			If locked1=0 Then
				locked1=1
				LockThisBall1.enabled=True  ' 1sec then kick to lock Position
			elseIf Locked2=0 Then
				Locked2=1
				LockThisBall1b.enabled=True  ' 1sec then kick to lock Position
				SLS(65,1)=0 : SLS(66,1)=0
			End If
			DividerWall0_Timer


			' turn on lock1 or 2
			SPBalldown 40,15,4
			If SC(PN,17)=1 Then SLS(65,1)=0 : SLS(66,1)=0
			If pwnagemultiball=1 Then
				respawn=respawn+8' 10 sec if pwnmulti is still on
				For i = 0 to 19
					If respawn-1 > i Then  SLS(120+i,1)=1
				Next
				SLS(64,1)=2 ' respawn blinks
				SLS(64,3)=6
			End If
		Else 
'		 Debug.print "kicker001 lockball start ballrelease as locked is full"

			SPBalldown 40,15,4
			Kicker001.destroyball
			RandomSoundDrain(Kicker001)

			SC(PN,17)=SC(PN,17)+1 
			If SC(PN,17)=2 Then
				SLS(65,1)=0
				SLS(66,1)=0
				SPB1 65,66,3,2,1,1  ' blinks,timer,special off after done
				SLS(68,1)=2 '  last for multiball set ! kicker 3?
			End If
			PlaySound "searchdestroy" & int(rnd(1)*2)+1 , 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
		
			If pwnagemultiball=0 Then
'				Debug.print "kicker001 lockball pwnagemultiball=0 ballrelease"

				SPB2 120,139,10,0,3,1
				For i = 120 to 139
					SLS(i,1)=1
				Next
				SLS(64,1)=2 ' respawn blinks
				SLS(64,3)=6

				AutoKick=0
				Skillshotactive=1
			Else
				respawn=respawn+8' 10 sec if pwnmulti is still on
				For i = 0 to 19
					If respawn-1 > i Then  SLS(120+i,1)=1
				Next
				SLS(64,1)=2 ' respawn blinks
				SLS(64,3)=6
			End If

			RespawnWaiting=RespawnWaiting+1
			PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease

			DOF 151,2 
'			If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"
			'E151 2 Ballrelease ( simulated )
			DOF 151,2 
'			If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"
			L062_Timer
			RandomSoundBallRelease(BallRelease)
			PlaySound "AARespawn", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
			Addpopup "READY SET GO","READY SET GO",fontbig1

		End If

	elseIf SLS(67,1)>0 Then ' redeemer is on !
'		Debug.print "kicker001 lockball redeemer no lock"
		spb2 150,153,5,0,2,1
		DOF 140,2 
'		If DOFdebug=1 Then debug.print "DOF 140,2 Redeemer"
		SPB1 67,67,7,2,1,1 ' 3 blinks rEDEEMER
		SLS(67,1)=0 ' turn off redeemer light
		Scoring 20000,4000
		For i = 179 to 190
			SLS(i,2)=300  ' blink for 300 updates
			SLS(184,1)=0
		Next
		' redeemer award 2 "random" Lights
		i = int(rnd(1)*3)
		If SC(PN,12+i)<5 Then
			SC(PN,12+i)=SC(PN,12+i)+1
		elseIf SC(PN,13+i)<5 Then
			 SC(PN,13+i)=SC(PN,13+i)+1
		elseIf SC(PN,14+i)<5 Then
			 SC(PN,14+i)=SC(PN,14+i)+1
		End If
		i = int(rnd(1)*3)
		If SC(PN,12+i)<5 Then
			SC(PN,12+i)=SC(PN,12+i)+1
		elseIf SC(PN,13+i)<5 Then
			 SC(PN,13+i)=SC(PN,13+i)+1
		elseIf SC(PN,14+i)<5 Then
			 SC(PN,14+i)=SC(PN,14+i)+1
		End If
		EnemyFlag
		
		SetlightsRedeemer


		If SLS(48,1)>1 Then   ' return enemy flag
		' turn off enemyflag  l046 1500ms
			L041.timerenabled=True
			SLS(41,1)=0
		    If SLS(42,1)=1 Then SLS(42,1)=2
			SLS(48,1)=0
			SLS(63,1)=0
			SLS(70,1)=0
			Addpopup "FLAG","RETURNED",fontbig2
			Scoring 5000,1000


		End If

		Gate6.timerenabled=True ' delayed sound 2sec
		SLS(1,0)=1 : spb1 1,1,10,0,0,1 'top10 lights faster blinks
		DOF 110,2
		DOF 113,2
		kicker001.destroyball
		kicker003.createball

		PlaySound "AARedeemer", 1, 0.7 * BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "INCOMING","REDEEMER",fontbig1
		SLS(1,0)=1 : spb1 1,1,5,0,0,1 'top10 lights faster blinks
		DOF 110,2
		DOF 113,2
		DividerWall0_Timer '  open for normal biz
	Else ' normal operation
			' something is not right if it gets here

		If SLS(65,1)>1 Or SLS(67,1)>1 Then
			If kickr5=0 Then DividerWall1_Timer ' open if a light is on
		Else
			DividerWall0_Timer ' else must close this
		End If

		kicker001.destroyball
		kicker002.createball
		kicker002.kick 255,11
		SPB1 86,86,1,2,0,1
		SPBredside ' nr of blinks
	End If

End Sub


Sub HeadShotON
	MapBlinker_Timer 
	SLS(44,1)=2 ' blinking
	L044.timerenabled=False
	L044.timerenabled=True ' headshot timer 7 sec 
End Sub


Sub Kicker003_hit
	kicker003.kick 40,40
	SPB1 86,86,1,2,0,1
	SoundSaucerKick 1, kicker003 
End Sub


Sub Gate6_Timer 'redeemer

	FastFrags=FastFrags+2
	Frag
	Frag
	HeadShotON
	SC(PN,19)=SC(PN,19)+2
	CheckFastFrags

	kicker003.kick 30,30+int(rnd(1)*10)
	SPB1 86,86,1,2,0,1
	SLS(1,0)=1 : spb1 1,1,5,0,0,1 'top10 lights faster blinks
	DOF 110,2
	DOF 113,2
	SoundSaucerKick 1, kicker003 
	PlaySound "AAlift1act", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
	Gate6.timerenabled=False
End Sub




'invisibilty (1) = sw40
'invisibilty (2) = 21
'invisibilty (3) = topvuk
'invisibilty (4) = 32
'invisibilty (5) = 22


Sub Sw40_hit  ' kicker 1
		If MBActive=0 And pwnagemultiball=0 Then SLS(185,2)=30

'		AwardComboKickers
'		AwardComboBlue
'		AwardComboRed
'		AwardComboOrbits
		If MBActive=0 And pwnagemultiball=0 Then ' 1 ball combos !!
'			Debug.print "RedKicker frame=" & Frame & "COMBOKICKERS=" & ComboKickers

			If Frame < ComboKickers And CombosLastHit = 4 Then
				AwardComboKickers
				SLS(187,2)=88
				SLS(188,2)=88
			End If

			ComboKickers=Frame+333
			CombosLastHit=1
		End If


	If SC(PN,43)=0 Then	'	LiandriGame
		SC(PN,43)=1		'	43= lane 1 done
		spb2 112,118,3,0,0,1
		SLS(141,1)=1
		spb2 141,141,3,0,0,1
		checkliandri
	End If

	


	spb2 92,92,2,0,0,1

	TrippleHS=0
	Objlevel(2) = 1 : FlasherFlash2_Timer : playSound "fx_relay", 1,0.05*VolumeDial,0,0,0,0,0,0
	DOF 112,2 
'	If DOFdebug=1 Then debug.print "DOF 112,2 flasherb2"

	'flak
	DOF 134,2 
'	If DOFdebug=1 Then debug.print "DOF 134,2 left saucer"
	'133 invisibility awarded
	'134 left saucer
	'135 left orbit
	'136 TopVUK
	'137 right saucer
	'138 right orbit
	
	If Invisiblilty(1)=1 Then
		Invisiblilty(1)=1
		Invisiblilty(2)=0
		Invisiblilty(3)=0
		Invisiblilty(4)=0
		Invisiblilty(5)=0
		SLS (78,1)=1
		SLS (79,1)=0
		SLS (80,1)=0
		SLS (81,1)=0
		SLS (82,1)=0
		SLS (83,1)=0
		SPB1 78,82,2,2,0,1

	Else
		Invisiblilty(1)=1
		SLS (78,1)=1
		SPB1 78,78,5,2,0,1

		If Invisiblilty(1)=1 And Invisiblilty(2)=1 And Invisiblilty(3)=1 And Invisiblilty(4)=1 And Invisiblilty(5)=1 Then SLS(83,1)=2 : SPB2 78,83,10,0,0,1


	End If


	If Firstblood=0 Then FirstBloodX
	HeadShotON
	FastFrags=FastFrags+1
	Frag
	SC(PN,19)=SC(PN,19)+1
	CheckFastFrags

	If SLS(43,1)>0 And TournamentMode=0 Then
		SLS(43,1)=0
		Extraball=2 ' 2 = gotten
'		Debug.Print "ExtraBall=" & Extraball
		SLS(85,1)=1
		SPB1 85,85,8,8,1,1
		SPB1 43,43,3,2,1,1
		
		PlaySound "AANali" & Int(rnd(1)*6)+1 , 1, BG_Volume, 0, 0,0,0, 0, 0
		extralife=1
		Objlevel(4) = 1 : Flasherflash4_Timer
		Objlevel(5) = 1 : Flasherflash5_Timer
		playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0

		DOF 126,2 
		DOF 156,2
'		If DOFdebug=1 Then debug.print "DOF 126,2 award extraball"
	End If


	If SLS(48,1)>1 Then
		' turn off enemyflag  l041 1500ms
		L041.timerenabled=True
		SLS(41,1)=0
		If SLS(42,1)=1 Then SLS(42,1)=2
		SLS(48,1)=0
		SLS(63,1)=0
		Addpopup "FLAG","RETURNED",fontbig2
		SLS(70,1)=0
		Scoring 5000,1000

	End If

	EnemyFlag
	GameTimerCheck

		' check to see if lock lights should be turned on
	If MBactive=0 Then 
		SC(PN,18) = SC(PN,18) + 1   ' 18 is lights done
		If SC(PN,18)=7 Then			
			DividerWall1_Timer ' divider=on ramp goes to tower
			PlaySound "AApointsecure" & Int(rnd(1)*4)+1 , 1, BG_Volume, 0, 0,0,0, 0, 0
			Addpopup "CONTROLPOINT","1 SECURE",fontbig3

			SLS(65,1)=2
			SLS(66,1)=2
			LockBolt1.Z=140
			LockBolt1.collidable=True
'			debug.Print "Boltmoved UP"
		End If
	End If



	SC(PN,14) = SC(PN,14) + 1
	If SC(PN,14) = 5 Then
		'!Turn on capture!
		SLS(42,1)=2 ' blinking
		If SLS(41,1)>1 Then SLS(42,1)=1
		SPB1 42,42,7,2,2,1
		PlaySound "wdend04", 1, BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "CAPTURE LIT","CAPTURE LIT",fontbig2

		PlaySound "AAassist", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
	Elseif SC(PN,14) > 4 Then
		SC(PN,14) = 5
	End If
	
 	Select Case SC(PN,14)
		Case 1: SLS(20,1)=1
		Case 2: SLS(21,1)=1
		Case 3: SLS(22,1)=1
		Case 4: SLS(23,1)=1
				PlaySound "AASpreeSound", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
		Case 5: SLS(24,1)=1
				Scoring 1000,100
	End Select

	SoundSaucerLock()
	Sw40.timerenabled=True
	Light003.state=2
	Light003.timerenabled=True
	sw40flash.Enabled=True
	SPB1 20,24,3,2, 7,1  ' light 7,specialstate, 3 blinks,timer,special off after done
	SLS(182,2)=33 ' blink middletopgi  1 solid blink ``?

End Sub



Sub sw40flash_Timer
	sw40flash.uservalue=sw40flash.uservalue+1
	Objlevel(2) = 1 : Flasherflash2_Timer
	If sw40flash.uservalue>3 Then sw40flash.uservalue=0 : sw40flash.enabled=False
End Sub

Sub Light003_Timer
	Light003.timerenabled=False
	Light003.state=0
End Sub

Sub Light004_Timer
	Light004.timerenabled=False
	Light004.state=0
End Sub

Sub Sw40_Timer
	Sw40.Kick 135,14
	sw40arm_Timer
	SoundSaucerKick 1, Sw40 
	PlaySound "AAFlak_fire", 1, 0.5*BG_Volume, 0, 0,0,0, 0, 0
	Sw40.timerenabled=False
	Objlevel(1) = 1 : FlasherFlash1_Timer :	playSound "fx_relay", 1,0.15*VolumeDial, AudioPan(Flasherbase1),0,0,0,0, AudioPan(Flasherbase1)
	DOF 111,2 
'	If DOFdebug=1 Then debug.print "DOF 111,2 flasherR1" 
End Sub


Sub sw40arm_Timer
	If sw40arm.Enabled=False Then
		sw40arm.Enabled = True
		sw40eject.RotZ = -60 
		spb1 91,91,4,0,0,1
	Else
		sw40eject.RotZ = sw40eject.RotZ + 2.5
		If sw40eject.RotZ > -20 Then 
			sw40arm.Enabled = False
		End If
	End If
End Sub




Sub TopVUK_Hit ' kicker2

	If MBActive=0 And pwnagemultiball=0 Then ' 1 ball combos !!
		SLS(185,2)=30
		If Frame<ComboTower Then
			AwardComboTower
			SLS(187,2)=88
			SLS(188,2)=88
		End If
	End If


	Spb1 184,184,1,0,0,1


	If SC(PN,45)=0 Then	'	LiandriGame
		SC(PN,45)=1		'	45= centerlane done
		spb2 112,118,3,0,0,1
		SLS(143,1)=1
		spb2 143,143,3,0,0,1

		checkliandri
	End If


	If pwnMB=1 And pwnMBCounter<1000 Then
		pwnMBCounter=2000

		pwnage=pwnageOld ' advance pwnage to old level
		pwnagemultiball=pwnagemultiball+1
		respawn=respawn+8
		SPB2 120,139,10,0,3,1
		For i = 0 to 19
					If respawn-1 > i Then  SLS(120+i,1)=1
		Next

		SLS(64,1)=2 ' respawn blinks
		SLS(64,3)=6
		quickMBcounter=0
		pwnageMBready=0
		SLS(90,1)=0 : SPB2 90,90,7,0,0,1
		SLS(55,1)=0 : SPB2 55,55,7,0,0,1
		SPB2 201,202,2,0,0,1

		scoring 50000,2000
		If SLS(65,1)=0 Then PlaySound JP1(int(Rnd(1)*12)) , 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0
		RespawnWaiting=RespawnWaiting+1
		PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease
		Gidark1234.interval=3000
		Gidark1234.Enabled=True
	End If


		SLS(183,2)=100 ' blink towerbottomlight 3 times

		TrippleHS=0

		SPB1 99,99,4,10,0,1
		SPB1 86,86,1,2,0,1

		DOF 136,2 
'		If DOFdebug=1 Then debug.print "DOF 136,2 Top VUK"
'		133 invisibility awarded
'		134 left saucer
'		135 left orbit
'		136 TopVUK
'		137 right saucer
'		138 right orbit
	If Invisiblilty(3)=1 Then
		Invisiblilty(1)=0
		Invisiblilty(2)=0
		Invisiblilty(3)=1
		Invisiblilty(4)=0
		Invisiblilty(5)=0
		SLS (78,1)=0
		SLS (79,1)=0
		SLS (80,1)=1
		SLS (81,1)=0
		SLS (82,1)=0
		SLS (83,1)=0
		SPB1 78,82,2,2,0,1
	Else
		Invisiblilty(3)=1
		SLS (80,1)=1
		SPB1 80,80,5,2,0,1

		If Invisiblilty(1)=1 And Invisiblilty(2)=1 And Invisiblilty(3)=1 And Invisiblilty(4)=1 And Invisiblilty(5)=1 Then SLS(83,1)=2 : SPB2 78,83,10,0,0,1

	End If

	If Firstblood=0 Then FirstBloodX
	HeadShotON
	FastFrags=FastFrags+1
	Frag
	SC(PN,19)=SC(PN,19)+1
	CheckFastFrags
	SoundSaucerLock()

	If SLS(65,1)>1 Then ' locking ballsssss


		SPB1 86,86,10,1,0,1
		lockedanim=2
		DOF 143,2 
'		If DOFdebug=1 Then debug.print "DOF 143,2 ball locked"
		Objlevel(4) = 1 : Flasherflash4_Timer
		Objlevel(5) = 1 : Flasherflash5_Timer
		playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0

		DOF 156,2
		Scoring 2000,1000
		If locked1=0 or locked2=0 Then
			' lock this ball and shoot out a new one
			DividerWall0_Timer

			If locked1=0 Then
				locked1=1
				LockThisBall2.enabled=True  ' 1sec then kick to lock Position
			elseIf Locked2=0 Then
				Locked2=1
				LockThisBall2b.enabled=True  ' 1sec then kick to lock Position
				SLS(65,1)=0 : SLS(66,1)=0
			End If

			' turn on lock1 or 2
			SPBalldown 40,15,4
			If SC(PN,17)=1 Then SLS(65,1)=0 : SLS(66,1)=0
			If pwnagemultiball=1 Then
				respawn=respawn+8' 10 sec if pwnmulti is still on
				For i = 0 to 19
					If respawn-1 > i Then  SLS(120+i,1)=1
				Next
				SLS(64,1)=2 ' respawn blinks
				SLS(64,3)=6
			End If
		Else 
			SPBalldown 40,15,4	
			TopVUK.destroyball
			RandomSoundDrain(TopVUK)

			SC(PN,17)=SC(PN,17)+1 
			If SC(PN,17)=2 Then
				SLS(65,1)=0
				SLS(66,1)=0
				SPB1 65,66,3,2,1,1  ' blinks,timer,special off after done
				SLS(68,1)=2 '  last for multiball set ! kicker 3?
			End If
			PlaySound "searchdestroy" & int(rnd(1)*2)+1 , 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
		
			If pwnagemultiball=0 Then
				SPB2 120,139,10,0,3,1
				For i = 120 to 139
					SLS(i,1)=1
				Next
				SLS(64,1)=2 ' respawn blinks
				SLS(64,3)=6

				AutoKick=0
				Skillshotactive=1
			Else
				respawn=respawn+8' +10 sec if pwnmulti is still on
				For i = 0 to 19
					If respawn-1 > i Then  SLS(120+i,1)=1
				Next
				SLS(64,1)=2 ' respawn blinks
				SLS(64,3)=6
			End If



			RespawnWaiting=RespawnWaiting+1
			PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease

			DOF 151,2 
'			If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"
			L062.timerenabled=False
			L062_Timer

			PlaySound "AARespawn", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
			Addpopup "READY SET GO","READY SET GO",fontbig1


		End If
	Else
		TopVUK.timerenabled=True

	End If


		' check to see if lock lights should be turned on
		If MBactive=0 Then 
			SC(PN,18) = SC(PN,18) + 1   ' 18 is lights done
			If SC(PN,18)=7 Then			
				DividerWall1_Timer ' divider=on ramp goes to tower
				PlaySound "AApointsecure" & Int(rnd(1)*4)+1 , 1, BG_Volume, 0, 0,0,0, 0, 0
				addpopup "CONTROLPOINT","1 SECURE",fontbig3
 
				SLS(65,1)=2
				SLS(66,1)=2
				LockBolt1.Z=140
				LockBolt1.collidable=True
'				debug.Print "Boltmoved UP"
			End If
		End If

	
	If SLS(42,1)>1 Then	 CaptureTheFlag 'if capture blinks dont reward lighg

		
	EnemyFlag
	GameTimerCheck 

	SC(PN,15) = SC(PN,15) + 1
	If SC(PN,15) =5 Then
		'!Turn on capture!
		SLS(42,1)=2 ' blinking
		If SLS(41,1)>1 Then SLS(42,1)=1
		SPB1 42,42,7,2,2,1
		PlaySound "wdend04", 1, BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "CAPTURE LIT","CAPTURE LIT",fontbig2

		PlaySound "AAassist", 1, BG_Volume, 0, 0,0,0, 0, 0
	elseif SC(PN,15) > 4 Then
		SC(PN,15) = 5
	End If


	Select Case SC(PN,15)
		Case 1: SLS(25,1)=1
		Case 2: SLS(26,1)=1
		Case 3: SLS(27,1)=1
		Case 4: SLS(28,1)=1
		PlaySound "AASpreeSound", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
		Case 5: SLS(29,1)=1
		Scoring 1000,100
	End Select

	SPB1 25,29,3,2, 7,1  ' light 7,specialstate, 3 blinks,timer,special off after done
	SLS(181,2)=33 ' blink middletopgi  1 solid blink ``?

End Sub



Dim quickMBlimit  ' start on 7 on each ball then increase by 2 each time success ???
Sub GameTimerCheck

	quickMBcounter=quickMBcounter+1
	If quickMBcounter = quickMBlimit Then
		If pwnagemultiball<2 Then
			
			quickMBlimit=quickMBlimit+1

			SLS(90,1)=1 : SPB2 90,90,7,0,0,1
			SLS(55,1)=1 : SPB2 55,55,7,0,0,1

			If SLS(46,1)>0 And SLS(96,1)=0 Then
				SLS(90,1)=2
			End If

		Else
			quickMBcounter=6 ' wait for next light and try again
		End If
	End If


	SC(PN,31)=SC(PN,31)+1 ' each player keeps this going
'	debug.print "progress" & SC(PN,31)

	ProgressBar


	If SC(PN,27)=0 Then ' 0=map 1 coret
		If SC(PN,31)=  3 Then PlaySound "cd5min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0
		If SC(PN,31)=  9 Then PlaySound "cd3min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0	
		If SC(PN,31)= 16 Then PlaySound "cd1min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0
		If SC(PN,31)= 20 or SC(PN,31)=21 Then
			SC(PN,31)=22
			PlaySound "cd30sec", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0
			'start 1sec timer with last countdown' restart at 32 if new ball !!!! 
			Lastcd=0 : countdown30.enabled=True
		End If
	End If

	If SC(PN,27)=1 Then ' november
		If SC(PN,31)=  3 Then PlaySound "cd5min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0
		If SC(PN,31)= 11 Then PlaySound "cd3min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0	
		If SC(PN,31)= 23 Then PlaySound "cd1min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0
		If SC(PN,31)= 28  or SC(PN,31)=29 Then
			SC(PN,31)=30

			PlaySound "cd30sec", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0
			'start 1sec timer with last countdown' restart at 32 if new ball !!!! 
			Lastcd=0 : countdown30.enabled=True
		End If
	End If

	If SC(PN,27)=2 Then ' dreary
		If SC(PN,31)=  3 Then PlaySound "cd5min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0

		If SC(PN,31)= 6 Then
			PlaySound "AACaptureSound" & int(rnd(1)*3)+1 , 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
			Addpopup "ENEMY","CAPTURE",fontbig2
			dtbg_timer
			If SC(PN,28)=SC(PN,29)+1 Then LOSTLEAD.enabled=true

			SC(PN,29)=SC(PN,29)+1
			'E154 2 ENEMY Capture
			DOF 154,2 
	'		If DOFdebug=1 Then debug.print "DOF 154,2 enemy capture"

			BlueDisplay SC(PN,29)
			SPB1 72,72,7,2,1,1
			SPB1 73,74,5,2,1,1
		End If

		If SC(PN,31)= 13 Then PlaySound "cd3min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0	
		If SC(PN,31)= 25 Then PlaySound "cd1min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0
		If SC(PN,31)= 31 or SC(PN,31)=32 Then
			SC(PN,31)=33

			PlaySound "cd30sec", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0
			'start 1sec timer with last countdown' restart at 32 if new ball !!!! 
			Lastcd=0 : countdown30.enabled=True
		End If
	End If




	If SC(PN,27)=3 Then ' FACE
		If SC(PN,31)=  3 Then PlaySound "cd5min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0

		If SC(PN,31)= 6 Then
			PlaySound "AACaptureSound" & int(rnd(1)*3)+1 , 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
			Addpopup "ENEMY","CAPTURE",fontbig2
			dtbg_timer
			If SC(PN,28)=SC(PN,29)+1 Then LOSTLEAD.enabled=True

			SC(PN,29)=SC(PN,29)+1
			'E154 2 ENEMY Capture
			DOF 154,2 
'			If DOFdebug=1 Then debug.print "DOF 154,2 enemy capture"

			BlueDisplay SC(PN,29)
			SPB1 72,72,7,2,1,1
			SPB1 73,74,5,2,1,1
		End If

		If SC(PN,31)= 22 Then
			PlaySound "AACaptureSound" & int(rnd(1)*3)+1 , 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
			Addpopup "ENEMY","CAPTURE",fontbig2
			dtbg_timer
			If SC(PN,28)=SC(PN,29)+1 Then LOSTLEAD.enabled=True

			SC(PN,29)=SC(PN,29)+1
			'E154 2 ENEMY Capture
			DOF 154,2 
'			If DOFdebug=1 Then debug.print "DOF 154,2 enemy capture"

			BlueDisplay SC(PN,29)
			SPB1 72,72,7,2,1,1
			SPB1 73,74,5,2,1,1
		End If


		If SC(PN,31)= 14 Then PlaySound "cd3min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0	
		If SC(PN,31)= 27 Then PlaySound "cd1min", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0
		If SC(PN,31)= 33 or SC(PN,31)=34 Then
			SC(PN,31)=35
			PlaySound "cd30sec", 1, 1.1*BG_Volume, 0, 0,0,0, 0, 0
			'start 1sec timer with last countdown' restart at 32 if new ball !!!! 
			Lastcd=0 : countdown30.enabled=True
		End If
	End If
End Sub

Dim lastcd
Sub countdown30_Timer
	lastcd=lastcd+1
	If lastcd=20 Then PlaySound "cd10", 1, BG_Volume, 0, 0,0,0, 0, 0
	If lastcd=21 Then PlaySound  "cd9", 1, BG_Volume, 0, 0,0,0, 0, 0
	If lastcd=22 Then PlaySound  "cd8", 1, BG_Volume, 0, 0,0,0, 0, 0
	If lastcd=23 Then PlaySound  "cd7", 1, BG_Volume, 0, 0,0,0, 0, 0
	If lastcd=24 Then PlaySound  "cd6", 1, BG_Volume, 0, 0,0,0, 0, 0
	If lastcd=25 Then PlaySound  "cd5", 1, BG_Volume, 0, 0,0,0, 0, 0
	If lastcd=26 Then PlaySound  "cd4", 1, BG_Volume, 0, 0,0,0, 0, 0
	If lastcd=27 Then PlaySound  "cd3", 1, BG_Volume, 0, 0,0,0, 0, 0
	If lastcd=28 Then PlaySound  "cd2", 1, BG_Volume, 0, 0,0,0, 0, 0
	If lastcd=29 Then PlaySound  "cd1", 1, BG_Volume, 0, 0,0,0, 0, 0
	If lastcd=30 Then
		ENDMAP
		countdown30.enabled=False	
	End If
End Sub



'*************************************
'*** MAP IS OVER  WIN OR LOOSE ?
'*************************************
DIM EXTRAEXTRALIFE
Sub ENDMAP

	for i = 155 to 174 : SLS(i,1)=0 : Next
	ProgressbarCounter=0

	SparkleEffect=3
	Lastcap=0
	Lastcap2=0 
	lastcap3=0
	LFinfo=0 : RFinfo=0
	If DB2S_on Then B2STimer2_Timer  ' or b2stimer2 for big one
	pwnage=0 
	Invisiblilty(1)=0
	Invisiblilty(2)=0
	Invisiblilty(3)=0
	Invisiblilty(4)=0
	Invisiblilty(5)=0

	L049.timerenabled=False ' reenable kickback both places
	KBstatus=1
	SLS(49,1)=1
	LiteKBstatus=0
	SLS(47,1)=0
'	L047.timerenabled=False
	If SC(PN,28)>SC(PN,29) Then'check score  28 vs 29
		
		LiandriAddLetter

		' you win
		PlaySound  "winner", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
		'12-16

		SignTurnON.enabled=True
		nl001.image="winner"
		spb1 146,146,20,2,2,1

		Respawn=Respawn+15
		SPB2 120,139,5,1,3,1
		For i = 0 to 19
					If respawn-1 > i Then  SLS(120+i,1)=1
		Next
		SLS(64,1)=2 ' respawn blinks
		SLS(64,3)=6
'		L064.timerenabled=True

		SLS(42,1)=0 ' Cap off
		SLS(41,1)=0 ' EF
		SLS(48,1)=0 ' EF
		SLS(70,1)=0 ' EF
		SLS(63,1)=0 ' EF


		SC(PN,12)=0
		SC(PN,13)=0
		SC(PN,14)=0
		SC(PN,15)=0
		SC(PN,16)=0
		For i = 7 to 11
			SLS(i,1)=0
		Next
		For i = 15 to 34
			SLS(i,1)=0
		Next
		SPB1 1,77,7,2,0,1 ' blink all 7 times

		For i = 179 to 190
		SLS(i,2)=800  ' blink for 230 updates
		Next

		If SC(pn,27)=0 then ' coret Bonus



			endofmapreward=1
			Endofmaptext1="CORET BONUS"
			Scoring 1000000,0
			Endofmaptext2="EXTRA LIFE"
			EXTRAEXTRALIFE=1
'			Debug.Print  "EXTRA EXTRA=" & EXTRAEXTRALIFE
			SPB2 1,1,10,1,0,1
			DOF 110,2
			DOF 113,2
			SLS(85,1)=1
			SPB2 85,85,11,0,0,1
			SPB1 43,43,3,2,1,1
			PlaySound "AANali" & Int(rnd(1)*6)+1 , 1, BG_Volume, 0, 0,0,0, 0, 0
			Objlevel(4) = 1 : Flasherflash4_Timer
			Objlevel(5) = 1 : Flasherflash5_Timer
			playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0
			DOF 126,2 
			DOF 156,2
	'		If DOFdebug=1 Then debug.print "DOF 126,2 award extraball"

		End If
		If SC(pn,27)=1 then 

			endofmapreward=1
			Endofmaptext1="- NOVEMBER -"
			Scoring 2000000,0
			Endofmaptext2=FormatScore(FFTscore)
		End If
		If SC(pn,27)=2 then 


			SLS(174,1)=1 ' collectables
			SC(PN,50)= SC(PN,50) Or 8
			SPB1 174,174,6,0,0,1

			endofmapreward=1
			Endofmaptext1="DREARY BONUS"
			Scoring 2000000,0
			Endofmaptext2=FormatScore(FFTscore)
		End If
		If SC(pn,27)=3 then 
			endofmapreward=1
			Endofmaptext1="FACE BONUS"
			Scoring 2000000,0
			Endofmaptext2=FormatScore(FFTscore)
		End If



		'reset PF Score
		SC(PN,28)=0
		SC(PN,29)=0

		BlueDisplay 0
		RedDisplay 0

		SC(PN,27) = SC(PN,27) +1 ' next map
		SetMapOff
		If SC(PN,27) >2 Then   '  ROC on lvl 4 or 5 ? now its set to start when map is changed to face 
			SC(PN,27)=3
		End If
		If SC(pn,27)=1 Then SC(PN,32)=4 ' november ONLY NEED TO SET GFB HERE
		If SC(pn,27)=2 Then SC(PN,32)=3 ' dreary
		If SC(pn,27)=3 Then SC(PN,32)=3 ' face

		SC(PN,31)=0 'reset gametimer

		spb2 50,50,10,1,0,1
		if SC(PN,27)=0 Then SLS(50,1)=1
		if SC(PN,27)=1 Then SLS(53,1)=1
		if SC(PN,27)=2 Then SLS(52,1)=1
		if SC(PN,27)=3 Then SLS(51,1)=1

	' turn off lights too
	' make everything blink ?=
	' CP can stay
	' teamplay can stay
	' redeemer can stay
		ProgressBarReset

	Else
		' you lost .. even on draw and need to replay level
		PlaySound  "lostmatch", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
		Respawn=Respawn+15
			SPB2 120,139,5,1,3,1
			For i = 0 to 19
					If respawn-1 > i Then  SLS(120+i,1)=1
			Next
		SLS(64,1)=2 ' respawn blinks
		SLS(64,3)=6

'		reset lights and start next level 

		SLS(42,1)=0 ' Cap off
		SLS(41,1)=0 ' EF
		SLS(48,1)=0 ' EF
		SLS(70,1)=0 ' EF
		SLS(63,1)=0 ' EF

		SC(PN,12)=0
		SC(PN,13)=0
		SC(PN,14)=0
		SC(PN,15)=0
		SC(PN,16)=0
		For i = 7 to 11
			SLS(i,1)=0
		Next
		For i = 15 to 34
			SLS(i,1)=0
		Next

		If SC(PN,27)=0 Then ' 0 = level1
			SLS( 7,1)=1  ' handicap on level 1, make sure those are on
			SLS(15,1)=1
			SLS(20,1)=1
			SLS(25,1)=1
			SLS(30,1)=1
			IF SC(PN,12)=0 Then SC(PN,12)=1
			IF SC(PN,13)=0 Then SC(PN,13)=1
			IF SC(PN,14)=0 Then SC(PN,14)=1
			IF SC(PN,15)=0 Then SC(PN,15)=1
			IF SC(PN,16)=0 Then SC(PN,16)=1
		End If

		SPB1 1,77,7,2,0,1 ' blink all 7 times

		For i = 179 to 190
		SLS(i,2)=800  ' blink for 230 updates
		Next

		endofmapreward=1
		Endofmaptext1="MATCH LOST"
		If sc(pn,27)=0 Then Scoring 500000,0 Else Scoring 1000000,0 ' half
		Endofmaptext2=FormatScore(FFTscore)

		'reset PF Score
		SC(PN,28)=0
		SC(PN,29)=0
		BlueDisplay 0
		RedDisplay 0

		SC(PN,31)=0 'reset gametimer
	End If
	SC(PN,30)=0 ' enemyflag reset to 0


	ProgressBarReset
End Sub

Sub Gi020_Timer
	Gi020.timerenabled=False
	SLS(183,2)=24 '  fast GI 
	SLS(185,2)=24 '  fast GI 
End Sub

Sub TopVUK_Timer
	SLS(183,1)=0
	SLS(183,2)=33

	gi020.timerenabled=True
	Spb2 184,184,2,0,0,1
	topvuk.destroyball
	Kicker002.createball
	SPB1 86,86,1,2,1,1
	Kicker002.kick 255,11
	SPBredside ' nr of blinks
	SoundSaucerKick 1, TopVUK
	PlaySound "AAsniperfire" & int(rnd(1)*2)+1 , 1, BG_Volume, 0, 0,0,0, 0, 0
	TopVUK.timerenabled=False
	Objlevel(7) = 1
	FlasherFlash7_Timer
	playSound "fx_relay", 1,0.2*VolumeDial, AudioPan(Flasherbase7),0,0,0,0, AudioPan(Flasherbase7)
	DOF 113,2 
'	If DOFdebug=1 Then debug.print "DOF 113,2 flasher7"
End Sub

Sub TakenLead_Timer
	TAKENLEAD.enabled=False
	PlaySound "takenlead", 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0
End Sub

Sub LostLead_Timer
	LostLEAD.enabled=False
	PlaySound "lostlead", 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0
End Sub

Dim Lastcap,Lastcap2,lastcap3
Dim FFT 'used in  atlest for now


'*************************************
'*** Capture 
'*************************************

Dim RocReward
Sub CaptureTheFlag

	If SC(PN,34)=1 Then ' ROC On
		If SC(PN,35)=1 Then ' mission1
			SC(PN,37)=SC(PN,37)+1 '  add to flag counter
			If SC(PN,37) >= SC(PN,36) Then ' next level
				Scoring SC(PN,36)*500000,25000
				RocReward = formatscore(FFTscore)  ' / 20 !!! face give *20 : champtext2
				SC(PN,35)=2 ' nextlevel on
				SC(PN,37)=0
				SC(PN,38)=0
			End If
		End If
	End If



	Objlevel(4) = 1 : Flasherflash4_Timer
	Objlevel(5) = 1 : Flasherflash5_Timer
	playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0

	DOF 156,2
	SPB1  7,11,4,1,1,1 ' all blink alittle and 10 for the lane that capture
	SPB1 15,34,4,1,1,1

	SLS(42,1)=0 ' turn off capture Flag ( will get checked on capturecheck and reset if needed

	If SC(PN,14)>4 Then
		Lastcap=14
		SC(PN,14)=0
		CaptureCheck
		If SC(PN,27)=0 Then SLS(20,1)=1 : SC(PN,14)=1 : Else SLS(20,1)=0
		SLS(21,1)=0
		SLS(22,1)=0
		SLS(23,1)=0
		SLS(24,1)=0
		SPB2 20,24,15,0,0,1
		If lastcap2 = 14 or lastcap3=14 Then CapisDenied : exit Sub
		CapisGood
		Exit Sub
	End If

	If SC(PN,15)>4 Then
		Lastcap=15
		SC(PN,15)=0
		CaptureCheck
		If SC(PN,27)=0 Then SLS(25,1)=1 : SC(PN,15)=1 : Else SLS(25,1)=0
		SLS(26,1)=0
		SLS(27,1)=0
		SLS(28,1)=0
		SLS(29,1)=0
		SPB2 25,29,15,0,0,1
		If lastcap2 = 15 or lastcap3=15 Then CapisDenied : exit Sub
		CapisGood
		Exit Sub
	End If


	If SC(PN,16)>4 Then
		Lastcap=16
		SC(PN,16)=0
		CaptureCheck
		If SC(PN,27)=0 Then SLS(30,1)=1 : SC(PN,16)=1 : Else SLS(30,1)=0
		SLS(31,1)=0
		SLS(32,1)=0
		SLS(33,1)=0
		SLS(34,1)=0
		SPB2 30,34,15,0,0,1
		If lastcap2 = 16 or lastcap3=16 Then CapisDenied : exit Sub
		CapisGood
		Exit Sub
	End If

	If SC(PN,13)>4 Then
		Lastcap=13
		SC(PN,13)=0
		CaptureCheck
		If SC(PN,27)=0 Then SLS( 7,1)=1 : SC(PN,13)=1 : Else SLS( 7,1)=0
		SLS( 8,1)=0
		SLS( 9,1)=0
		SLS(10,1)=0
		SLS(11,1)=0
		SPB2  7,11,15,0,0,1
		If lastcap2 = 13 or lastcap3=13 Then CapisDenied : exit Sub
		CapisGood
		Exit Sub
	End If

	If SC(PN,12)>4 Then
		Lastcap=12
		SC(PN,12)=0
		CaptureCheck
		If SC(PN,27)=0 Then SLS(15,1)=1 : SC(PN,12)=1 : Else SLS(15,1)=0
		SLS(16,1)=0
		SLS(17,1)=0
		SLS(18,1)=0
		SLS(19,1)=0
		SPB2 15,19,15,0,0,1
		If lastcap2 = 12 or lastcap3=12 Then CapisDenied : exit Sub
		CapisGood
		Exit Sub
	End If

End Sub



Sub CapisDenied
	crazyteamscore1.enabled=True
	DOF 155,2
'	If DOFdebug=1 Then debug.print "DOF 155,2 capture DENIED"
	SPB1 86,86,3,12,0,1	' towerlights x3 long blinks
	dtbg_timer

	SPB1 73,74,5,2,1,1 ' 2 smal flags


	Scoring 10000,1000
		Addpopup "CAPTURE" ,"D E N I E D",fontbig2

	LiftTopRedLight.timerenabled=True ' 1sec delay denied
End Sub

Sub LiftTopRedLight_Timer
	LiftTopRedLight.timerenabled=False
	PlaySound "Denied", 1, 1.5*BG_Volume, 0, 0,0,0, 0, 0
End Sub




Sub CapisGood
	crazyteamscore1.enabled=True
	lastcap3=lastcap2
	lastcap2=lastcap
	'E153 2 Capture
	'E154 2 ENEMY Capture
	DOF 153,2 
'	If DOFdebug=1 Then debug.print "DOF 153,2 capture"

	SPB1 86,86,10,1,0,1	' towerlights x10 blinks

	dtbg_timer
	'	28= map score left Counter
	'	29= map score Right Counter
	If SC(PN,28)=SC(PN,29) Then TAKENLEAD.enabled=True
	SC(PN,28)=SC(PN,28)+1
	RedDisplay SC(PN,28)
	SPB1 71,71,7,2,1,1
	SPB1 73,74,5,2,1,1 ' 2 smal flags


	Scoring 50000,5000
	FFT=FFTscore
	Addpopup FormatScore(FFT),FormatScore(FFT) ,fontbig2  
	capture=1



	PlaySound "Capture", 1, BG_Volume, 0, 0,0,0, 0, 0
	PlaySound "AACaptureSound" & int(rnd(1)*3)+1 , 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0


End Sub




Sub CaptureCheck
	If SC(PN,12)>4 Then SPB1 42,42,5,2,2,1 : SLS(42,1)=2 : If SLS(41,1)>1 Then SLS(42,1)=1
	If SC(PN,13)>4 Then SPB1 42,42,5,2,2,1 : SLS(42,1)=2 : If SLS(41,1)>1 Then SLS(42,1)=1
	If SC(PN,14)>4 Then SPB1 42,42,5,2,2,1 : SLS(42,1)=2 : If SLS(41,1)>1 Then SLS(42,1)=1
	If SC(PN,15)>4 Then SPB1 42,42,5,2,2,1 : SLS(42,1)=2 : If SLS(41,1)>1 Then SLS(42,1)=1
	If SC(PN,16)>4 Then SPB1 42,42,5,2,2,1 : SLS(42,1)=2 : If SLS(41,1)>1 Then SLS(42,1)=1
End Sub



'**********************  RIGHT KICKER ****************************



Sub Sw32_hit  ' kicker 3
	If MBActive=0 And pwnagemultiball=0 Then SLS(185,2)=30
'		AwardComboKickers
'		AwardComboBlue
'		AwardComboRed
'		AwardComboOrbits
	If MBActive=0 And pwnagemultiball=0 Then ' 1 ball combos !!
'		Debug.print "BlueKicker frame=" & Frame & "COMBOKICKERS=" & ComboKickers
		If Frame<ComboKickers And CombosLastHit=1 Then
			AwardComboKickers
			SLS(187,2)=88
			SLS(188,2)=88
		End If
		ComboKickers=Frame+420
		CombosLastHit=4
	End If


	If SLS(119,1)>0 Then
			Dof 145,2
			SignTurnON.enabled=True
			nl001.image="godlike"
			SLS(119,1)=0
			spb1 119,119,10,0,0,1
			PlaySound "godlike", 1, BG_Volume*0.7, 0, 0,0,0, 0, 0
			Scoring 2000000,200000
			Addpopup "GODLIKE",FormatScore(FFTscore),fontbig2
	End If


	If SC(PN,46)=0 Then	'	LiandriGame
		SC(PN,46)=1		'	46= right kicker done
		spb2 112,118,3,0,0,1
		SLS(144,1)=1
		spb2 144,144,3,0,0,1

		checkliandri
	End If

	spb2 94,94,2,0,0,1
	TrippleHS=0
		DOF 137,2 
'		If DOFdebug=1 Then debug.print "DOF 137,2 right saucer"
'133 invisibility awarded
'134 left saucer
'135 left orbit
'136 TopVUK
'137 right saucer
'138 right orbit
	If Invisiblilty(4)=1 Then
		Invisiblilty(1)=0
		Invisiblilty(2)=0
		Invisiblilty(3)=0
		Invisiblilty(4)=1
		Invisiblilty(5)=0
		SLS (78,1)=0
		SLS (79,1)=0
		SLS (80,1)=0
		SLS (81,1)=1
		SLS (82,1)=0
		SLS (83,1)=0
		SPB1 78,82,2,2,0,1
	Else
		Invisiblilty(4)=1
		SLS (81,1)=1
		SPB1 81,81,5,2,0,1

		If Invisiblilty(1)=1 And Invisiblilty(2)=1 And Invisiblilty(3)=1 And Invisiblilty(4)=1 And Invisiblilty(5)=1 Then SLS(83,1)=2 : SPB2 78,83,10,0,0,1

	End If

	If Firstblood=0 Then FirstBloodX
	HeadShotON
	FastFrags=FastFrags+1
	Frag

	SC(PN,19)=SC(PN,19)+1


	CheckFastFrags

	If SLS(48,1)>1 Then
		' turn off enemyflag  l046 1500ms
		L041.timerenabled=True
		SLS(41,1)=0
		If SLS(42,1)=1 Then SLS(42,1)=2
		SLS(48,1)=0
		SLS(63,1)=0
		SLS(70,1)=0
		Addpopup "FLAG","RETURNED",fontbig2
		Scoring 5000,1000
	End If

	EnemyFlag
	GameTimerCheck


		' check to see if lock lights should be turned on
		If MBactive=0 Then 
			SC(PN,18) = SC(PN,18) + 1   ' 18 is lights done
			If SC(PN,18)=7 Then			
				DividerWall1_Timer ' divider=on ramp goes to tower
				PlaySound "AApointsecure" & Int(rnd(1)*4)+1 , 1, BG_Volume, 0, 0,0,0, 0, 0
				addpopup "CONTROLPOINT","1 SECURE",fontbig3
				SLS(65,1)=2
				SLS(66,1)=2
			LockBolt1.Z=140
			LockBolt1.collidable=True
'			debug.Print "Boltmoved UP"
			End If
		End If



	SC(PN,16) = SC(PN,16) + 1
	If SC(PN,16) =5 Then
		'!Turn on capture!
		SLS(42,1)=2 ' blinking
		If SLS(41,1)>1 Then SLS(42,1)=1
		SPB1 42,42,7,2,2,1
		PlaySound "wdend04" , 1, BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "CAPTURE LIT","CAPTURE LIT",fontbig2
		PlaySound "AAassist", 1, BG_Volume, 0, 0,0,0, 0, 0
	elseif SC(PN,16) > 4 Then
		SC(PN,16) = 5

	End If


	Select Case SC(PN,16)
		Case 1: SLS(30,1)=1
		Case 2: SLS(31,1)=1
		Case 3: SLS(32,1)=1
		Case 4: SLS(33,1)=1
				PlaySound "AASpreeSound", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
		Case 5: SLS(34,1)=1
		Scoring 1000,100
	End Select

	SoundSaucerLock()
	SPB1 30,34,3,2, 7,1  ' light 7,specialstate, 3 blinks,timer,special off after done
	SLS(180,2)=33 ' blink middletopgi  1 solid blink ``?
	Objlevel(3) = 1 : FlasherFlash3_Timer :	playSound "fx_relay", 1,0.2*VolumeDial, AudioPan(Sling1),0,0,0,0, AudioPan(Sling1)
						DOF 112,2 
'						If DOFdebug=1 Then debug.print "DOF 112,2 flasherb2"
	If SLS(68,1)>0 Then
		DOF 144,1 
'		If DOFdebug=1 Then debug.print "DOF 144,1 multiball on"
'		E144 multiball
'		E145 godlike
'		E146 monsterkill
		PlaySound "objectivedest" & int(rnd(1)*5)+1 , 1, 1.5* BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "OBJECTIVE","DESTROYED",fontbig3
		Objlevel(4) = 1 : Flasherflash4_Timer
		Objlevel(5) = 1 : Flasherflash5_Timer
		playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0
		crazyteamscore1.enabled=True
		DOF 156,2
		Scoring 10000,2000

		L068.timerenabled=True
		' start multiball
		SPB1 65,66,6,2,0,1
		SPB1 68,68,6,2,0,1
		SLS(68,1)=0
		For i = 179 to 190
		SLS(i,2)=700  ' blink for 230 updates
		Next
		spb2 1,1,20,0,0,1
		DOF 110,2
		DOF 113,2
		Respawn=Respawn+15 ' 20 sec respawn timer
			SPB2 120,139,5,1,3,1
			For i = 0 to 19
					If respawn-1 > i Then  SLS(120+i,1)=1
			Next
		SLS(64,1)=2 ' respawn blinks
		SLS(64,3)=6
'		L064.timerenabled=True

	Else
		Sw32.timerenabled=True
		Light004.state=2
		Light004.timerenabled=True
	End If
End Sub

Sub Sw32_Timer
	Sw32.Kick 283,16+Rnd(1)*2
	spb2 94,94,5,0,5,1
	sw32arm_Timer
	SoundSaucerKick 1, Sw32
	PlaySound "AAMini_Fire", 1,0.6*BG_Volume, 0, 0,0,0, 0, 0
	sw32.timerenabled=False
End Sub


Sub sw32arm_Timer
	If sw32arm.Enabled=False Then
		sw32arm.Enabled = True
		sw32eject.RotZ = -60 
		spb1 92,92,4,0,0,1
	Else
		sw32eject.RotZ = sw32eject.RotZ + 3
		If sw32eject.RotZ > -20 Then 
			sw32arm.Enabled = False
		End If
	End If
End Sub



Dim MBalls,LockingBalls
Sub L068_timer
	MBalls=Mballs+1
	MBActive=1

	Select Case MBalls
	 Case 1 : 	SPB1 1,68,1,2,5,1
		Light004.state=2
		Light004.timerenabled=True
				MultiAnim=3
	 Case 2 : 	Sw32.Kick 283,16+Rnd(1)*2
				SoundSaucerKick 1, Sw32
				PlaySound "AAMini_Fire", 1, 0.6 * BG_Volume, 0, 0,0,0, 0, 0

	 Case 3 :	SLS(45,1)=2


			SLS(172,1)=1 ' collectables
			SC(PN,50)= SC(PN,50) Or 2
			SPB1 172,172,6,0,0,1

'	50= collectables
'	and 1 = Moonsterkill	' 171
'	and 2 = Level 1			' 172 
'	and 4 = Level 2			' 173
'	and 8 = Level 3			' 174
'	and 16= Level godlike	' 147
'	and 32= Level godlike EL' 148
'	and 64= Level god pwnage' 149

				SPBhalfandhalf 6
				SPB1 86,86,20,0,0,1
				Objlevel(4) = 1 : Flasherflash4_Timer
				Objlevel(5) = 1 : Flasherflash5_Timer
				playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0
				spb2 1,1,7,0,0,1
				DOF 110,2
				DOF 113,2
				DOF 156,2
				If Team(PN)=0 Then 
					PlaySound "RedLeader" & int(rnd(1)*5)+1 ,1 , 1.5*BG_Volume, 0, 0,0,0, 0, 0
					Addpopup "RED LEADER","RED LEADER",fontbig3
				End If

				If Team(PN)=1 Then
					PlaySound "BlueLeader" & int(rnd(1)*4)+1 ,1 , 1.5*BG_Volume, 0, 0,0,0, 0, 0
					Addpopup "BLUE LEADER","BLUE LEADER",fontbig3
					End If

				If Team(PN)=2 Then
					PlaySound "GoldLeader" & int(rnd(1)*5)+1 ,1 , 1.5*BG_Volume, 0, 0,0,0, 0, 0
					Addpopup "GOLD LEADER","GOLD LEADER",fontbig3
				End If

				If Team(PN)=3 Then
					PlaySound "GreenLeader" & int(rnd(1)*5)+1 ,1 , 1.5*BG_Volume, 0, 0,0,0, 0, 0
					Addpopup "GREENLEADER ","GREENLEADER ",fontbig3
				End If

				SignTurnON.enabled=True
				nl001.image="multiball"
				spb1 146,146,20,2,2,1

' flasher 8 + 3

	 Case 4 : 	SPBhalfandhalf 6
				multiBflasher.enabled=True
				If Locked1=1 Then
					Locked1=0
					LockBolt1.Z=88
					LockBolt1.collidable=False
'					debug.Print "Boltmoved Down"

				Else
					RespawnWaiting=RespawnWaiting+1
					PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease

					DOF 151,2 
'					If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"
					PlaySound "AARespawn", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
					RandomSoundBallRelease(BallRelease)
				End If
	'			SPB1 1,68,3,2,1,1


	 Case 6 :  	multiBflasher.enabled=True
				If Locked2=1 Then
					Locked2=0
					LockBolt1.Z=88
					LockBolt1.collidable=False
'					debug.Print "Boltmoved Down"
					
				Else
					RespawnWaiting=RespawnWaiting+1
					PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease

					DOF 151,2 
'					If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"
					PlaySound "AARespawn", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
					RandomSoundBallRelease(BallRelease)		
				End If
				SPB1 1,68,3,2,1,1

	 Case 5 : 	
				SPBhalfandhalf 6
				PlaySound "Assault" & int(rnd(1)*4)+1,1 , BG_Volume*1.5, 0, 0,0,0, 0, 0
				Addpopup "ASSAULT","THE BASE",fontbig3
				SPB1 86,86,10,0,0,1
				Objlevel(4) = 1 : Flasherflash4_Timer
				Objlevel(5) = 1 : Flasherflash5_Timer
				playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0
				spb2 1,1,7,0,0,1
				DOF 110,2
				DOF 113,2
				DOF 156,2
	 Case 7 :	SPBhalfandhalf 6
				MBalls=0
				SPB1 45,45,5,2,1,1
				L068.timerenabled=False
				PlaySound "engage" & int(rnd(1)*5)+1,1 , BG_Volume*1.5, 0, 0,0,0, 0, 0
				Addpopup "ENGAGE","THE ENEMY",fontbig3
				SPB1 86,86,10,0,0,1
				Objlevel(4) = 1 : Flasherflash4_Timer
				Objlevel(5) = 1 : Flasherflash5_Timer
				playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0
				spb2 1,1,7,0,0,1
				DOF 110,2
				DOF 113,2
				DOF 156,2
	End Select
End Sub
	


Sub multiBflasher_Timer
	multiBflasher.uservalue=multiBflasher.uservalue+1
	Objlevel(3) = 1 : Flasherflash3_Timer
	Objlevel(8) = 1 : Flasherflash8_Timer
	If multiBflasher.uservalue>3 Then multiBflasher.uservalue=0 : multiBflasher.enabled=False
End Sub


'E139 mainramp done
'E140 redeemer	
'E141 Jackpot	
'E142 HeadShot  done
Sub RampR_fx2_unhit

	If SC(pn,48)=0 Then ' have you gotten the 25 ramp EL ?
		If RampEB<25 Then

			RampEB=RampEB+1
			ShowRampEB =Frame+50

		Else
'	50= collectables
'	and 1 = Moonsterkill	' 171
'	and 2 = Level 1			' 172 
'	and 4 = Level 2			' 173
'	and 8 = Level 3			' 174
'	and 16= Level godlike	' 147
'	and 32= Level godlike EL' 148
'	and 64= Level god pwnage' 149
				SLS(148,1)=1
				SC(PN,50)= SC(PN,50) Or 32
				SPB1 148,148,6,0,0,1
		
				SLS(119,1)=2 : SPB2 119,119,7,0,0,1
				SC(PN,48)=1
				RampEB=100
				PlaySound "godlike", 1, BG_Volume, 0, 0,0,0, 0, 0
				Dof 145,2
				Extralife=1
			If TournamentMode=0 Then
				SLS(85,1)=1 : SPB2 85,85,10,0,0,1
			End If
		End If
	End If


	If pwnJP=1 And pwnJPCounter<1000 Then
		spb2 97,97,7,0,0,1

		SPB2 201,202,2,0,0,1
		SLS(96,1)=0 : spb2 96,96,3,0,0,1
		PlaySound JP1(int(Rnd(1)*12)) , 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0
		scoring 1000000,50000
		pwnJPscore=FFTscore
		pwnJPCounter=2000
		pwnage=pwnage+1 ' reset pwn to next level
	End If


	SLS(183,2)=33 ' blink towerbottomlight 

	SPBblueside 
	SPB1 99,99,1,10,0,1
	SPB1 86,86,1,1,0,1

	If KBstatus=0 Then LiteKBstatus=1 : SLS(47,1)=2

	DOF 139,2 
'	If DOFdebug=1 Then debug.print "DOF 139,2 mainramp"
	If SLS(83,1)>0 Then ' Invisiblilty(1)=1 And Invisiblilty(2)=1 And Invisiblilty(3)=1 And Invisiblilty(4)=1 And Invisiblilty(5)=1 Then

		If SC(PN,34)=1 Then ' ROC On
			If SC(PN,35)=5 Then '  mission 5
				Scoring SC(PN,36)*5000000,250000
				RocReward = formatscore(FFTscore)  ' / 20 !!! face give *20 : champtext2
				SC(PN,35)=1 ' nextlevel on
				SC(PN,36)=SC(PN,36)+1
			End If
		End If

		Respawn=Respawn+60
		SPB2 120,139,10,0,3,1
			For i = 120 to 139
				SLS(i,1)=1
			Next
		SLS(64,1)=2
		SLS(64,3)=6
		Scoring 200000,30000
		FFT=FFTscore
		invisireward=1
		'Addpopup "INVISIBILITY", formatscore(FFT),fontbig2
		PlaySound "CloakOn", BG_Volume*1.5, 0, 0,0,0, 0, 0

		DOF 133,2 
'		If DOFdebug=1 Then debug.print "DOF 133,2 invisibility awarded"

		'133 invisibility awarded
		Invisiblilty(1)=0
		Invisiblilty(2)=0
		Invisiblilty(3)=0
		Invisiblilty(4)=0
		Invisiblilty(5)=0
		SLS (78,1)=0
		SLS (79,1)=0
		SLS (80,1)=0
		SLS (81,1)=0
		SLS (82,1)=0
		SLS (83,1)=0
		SPB2 78,83,10,0,0,1
	End If

	If SC(PN,27)=3 Then
		SC(PN,41)=SC(PN,41)+1
		If SC(PN,41) = 7 Then ' start ROC
			EnterRoc=1
			SC(PN,34) = 1 ' room of champions lit
			SLS(54,1)=2 ' should forever blink
			SLS(54,3)=18 'pause
			SC(PN,35)=1 ' mission 1
			SC(PN,36)=1 ' level 1 
			SC(PN,37)=0 ' 4 silly counters, could probably do it with 1
			SC(PN,38)=0
			SC(PN,39)=0
			SC(PN,40)=0
		End If
	End If



	If 	SS2=1 Then
		SS2=0
'		Debug.print "SS2 awarded"
		L059.timerenabled=False
		Skillshot2 ' extra scoring headshot value
		SLS(44,1)=2 ' set hs light on for the rest
	End If
		

	If Firstblood=0 Then FirstBloodX

	SC(PN,19)=SC(PN,19)+1
	CheckFastFrags

	If SLS(44,1)>1 Then
		HeadShot
		i = int(rnd(1)*3)
		If SC(PN,12+i)<5 Then
			SC(PN,12+i)=SC(PN,12+i)+1
		elseIf SC(PN,13+i)<5 then
			SC(PN,13+i)=SC(PN,13+i)+1
		elseIf SC(PN,14+i)<5 then
			SC(PN,14+i)=SC(PN,14+i)+1
		End If
		If SLS(67,1)=0 Then EnemyFlag
		
		SetlightsRedeemer
	Else
		TrippleHS=0
	End If

	HeadShotON
	FastFrags=FastFrags+1
	Frag
	If SLS(45,1)>1 Then

			SLS(173,1)=1'	collectables
			SC(PN,50)= SC(PN,50) Or 4
			SPB1 173,173,6,0,0,1

		Jackpot
	DOF 141,2 
'	If DOFdebug=1 Then debug.print "DOF 141,2 jackpot"
	End If

'	If SLS(65,1)=0 Then
	If locked1=1 or locked2=1 Then
		LockBolt1.Z=88
		LockBolt1.collidable=False
'		debug.print "BOLT DOWN NORMALRAMP"
	End If

	Objlevel(9) = 1 : FlasherFlash9_Timer :	playSound "fx_relay", 1,0.2*VolumeDial, AudioPan(Flasherbase9),0,0,0,0, AudioPan(Flasherbase9)
	DOF 110,2 
'	If DOFdebug=1 Then debug.print "DOF 110,2 flasher1"
End Sub


'**********************************************************************************************************
'* TargetBouncerthingys *
'**********************************************************************************************************
Const TargetBouncerFactor = 1.7 'Level of bounces. 0.2 - 2 is probably usable value.
'iaakki - TargetBouncer for standup targets
Dim zMultiplier
sub TargetBouncer(aBall,defvalue)
	dim xy
	i=BallSpeed(aBall)
		Select Case Int(Rnd * 4) + 1
			Case 1: zMultiplier = defvalue+1.1  : xy=0.70
			Case 2: zMultiplier = defvalue+1.05 : xy=0.74
			Case 3: zMultiplier = defvalue+0.7  : xy=0.83
			Case 4: zMultiplier = defvalue+0.3  : xy=0.93
		End Select
		aBall.velz = aBall.velz * zMultiplier * TargetBouncerFactor
		aBall.velx = aBall.velx * xy
		aBall.vely = aBall.vely * xy
'		debug.print "----> velz: " & activeball.velz
'		debug.print "----> velx: " & activeball.velx
'		debug.print "----> vely: " & activeball.vely
'	debug.print "1speed = " & int(i*100)/100
'	i=BallSpeed(aBall)-i
'	debug.print "1speed=" & int(i*100)/100+0.01 & " change=" & Int((BallSpeed(aBall)-i)*100)/100+0.01 & " zmulti=" & zMultiplier*TargetBouncerFactor
end sub
sub TargetBouncer2(aBall,defvalue)
		i=BallSpeed(aBall)
		Select Case Int(Rnd * 5) + 1
			Case 1: zMultiplier = defvalue+1.0 : xy=0.73
			Case 2: zMultiplier = defvalue+0.9 : xy=0.77
			Case 3: zMultiplier = defvalue+0.8 : xy=0.82
			Case 4: zMultiplier = defvalue+0.5 : xy=0.89
			Case 5: zMultiplier = defvalue+0.3 : xy=0.93
		End Select
		aBall.velz = aBall.velz * zMultiplier * TargetBouncerFactor
		aBall.velx = aBall.velx * xy
		aBall.vely = aBall.vely * xy
'	debug.print "2speed = " & int(i*100)/100
'	i=BallSpeed(aBall)-i
'	debug.print "2speed=" & int(i*100)/100+0.01 & " change=" & Int((BallSpeed(aBall)-i)*100)/100+0.01 & " zmulti=" & zMultiplier*TargetBouncerFactor

end sub


'**********************************************************************************************************
'* DROPTARGETS *
'**********************************************************************************************************
'	 5=DT1 Sw25
'	 6=DT2 Sw26
'	 7=DT3 Sw27
'	 8=DT4 Sw33
'	 9=DT5 Sw34
'	10=DT6 Sw35

Sub sw002_hit
	SparkyObjectX=(dt25.x+DT26.X)/2+9
	SparkyObjectY=(dt25.Y+DT26.Y)/2-5
	SetSparks

	TargetBouncer activeball,1
	If sw25.collidable=True Then sw25meat
	If sw26.collidable=True Then sw26meat
End Sub

Sub sw004_hit
	SparkyObjectX=(dt27.x+DT26.X)/2+9
	SparkyObjectY=(dt27.Y+DT26.Y)/2-5
	SetSparks


	TargetBouncer activeball,1
	If sw27.collidable=True Then sw27meat
	If sw26.collidable=True Then sw26meat
End Sub

Sub Drop25_Timer
	If 	Drop25.enabled=False Then
		Drop25.enabled=True
		DT25.transz=1
		DT25.ObjRotx=2
		DT25.ObjRoty=2
		DT25.uservalue=0
	Else
		DT25.uservalue=DT25.uservalue+1

		Select Case DT25.uservalue

			Case 1 : DT25.transz=2 : DT25.ObjRotx=4 : DT25.ObjRoty=4
			Case 2 : DT25.transz=3 : DT25.ObjRotx=6 : DT25.ObjRoty=6
			Case 3 : DT25.transz=4 : DT25.ObjRotx=7 : DT25.ObjRoty=7 : DT25.z=10   'org17
 			Case 4 : DT25.transz=4 : DT25.ObjRotx=7 : DT25.ObjRoty=7 : DT25.z=0   'org17
			Case 5 : DT25.transz=3 : DT25.ObjRotx=5 : DT25.ObjRoty=5 : DT25.z=-17   'org17
			Case 6 : DT25.transz=2 : DT25.ObjRotx=2 : DT25.ObjRoty=2 : DT25.z=-34   'org17
			Case 7 : DT25.transz=0 : DT25.ObjRotx=0 : DT25.ObjRoty=0 : DT25.z=-40
					 Drop25.enabled=False
		End Select

	End If
End Sub

Sub Drop26_Timer
	If 	Drop26.enabled=False Then
		Drop26.enabled=True
		DT26.transz=1
		DT26.ObjRotx=2
		DT26.ObjRoty=2
		DT26.uservalue=0
	Else
		DT26.uservalue=DT26.uservalue+1

		Select Case DT26.uservalue

			Case 1 : DT26.transz=2 : DT26.ObjRotx=4 : DT26.ObjRoty=4
			Case 2 : DT26.transz=3 : DT26.ObjRotx=6 : DT26.ObjRoty=6
			Case 3 : DT26.transz=4 : DT26.ObjRotx=7 : DT26.ObjRoty=7 : DT26.z=10   'org17
 			Case 4 : DT26.transz=4 : DT26.ObjRotx=7 : DT26.ObjRoty=7 : DT26.z=0   'org17
			Case 5 : DT26.transz=3 : DT26.ObjRotx=5 : DT26.ObjRoty=5 : DT26.z=-17   'org17
			Case 6 : DT26.transz=2 : DT26.ObjRotx=2 : DT26.ObjRoty=2 : DT26.z=-34   'org17
			Case 7 : DT26.transz=0 : DT26.ObjRotx=0 : DT26.ObjRoty=0 : DT26.z=-40
					 Drop26.enabled=False
		End Select

	End If
End Sub

Sub DropAllNoHit_Timer
	If 	DropAllNoHit.enabled=False Then
		DropAllNoHit.enabled=True
		DropAllNoHit.uservalue=0
	Else
		DropAllNoHit.uservalue=DropAllNoHit.uservalue+1
		Select Case DropAllNoHit.uservalue
			Case  4 : i= 10 : DT25.z=i : DT26.z=i : DT27.z=i
			PlaySoundAtLevelStatic SoundFX("DTDrop",DOFKnocker), 2, Sw25
 			Case  5 : i=  0 : DT25.z=i : DT26.z=i : DT27.z=i
			Case  6 : i=-17 : DT25.z=i : DT26.z=i : DT27.z=i 
			Case  7 : i=-34 : DT25.z=i : DT26.z=i : DT27.z=i 
			Case  8 : i=-40 : DT25.z=i : DT26.z=i : DT27.z=i 
			Case 30 : i= 10 : DT33.z=i : DT34.z=i : DT35.z=i  
			PlaySoundAtLevelStatic SoundFX("DTDrop",DOFKnocker), 2, Sw33
			Case 31 : i=  0 : DT33.z=i : DT34.z=i : DT35.z=i 
			Case 32 : i=-17 : DT33.z=i : DT34.z=i : DT35.z=i 
			Case 33 : i=-34 : DT33.z=i : DT34.z=i : DT35.z=i 
			Case 34 : i=-40 : DT33.z=i : DT34.z=i : DT35.z=i

			Case 110: DT25.z=17
					DT26.z=17
					DT27.z=17
					PlaySoundAtLevelStatic SoundFX("DTReset",DOFKnocker), 2, Sw25

			Case 140 : DT33.z=17
					DT34.z=17
					DT35.z=17
					PlaySoundAtLevelStatic SoundFX("DTReset",DOFKnocker), 2, Sw33
			Case 180 : sw40arm_Timer
					SoundSaucerKick 1, Sw40 
			Case 200 : sw32arm_Timer
					SoundSaucerKick 1, Sw32 
					DropAllNoHit.enabled=False
		End Select
	End If
End Sub



Sub Drop27_Timer
	If 	Drop27.enabled=False Then
		Drop27.enabled=True
		DT27.transz=1
		DT27.ObjRotx=2
		DT27.ObjRoty=2
		DT27.uservalue=0
	Else
		DT27.uservalue=DT27.uservalue+1

		Select Case DT27.uservalue

			Case 1 : DT27.transz=2 : DT27.ObjRotx=4 : DT27.ObjRoty=4
			Case 2 : DT27.transz=3 : DT27.ObjRotx=6 : DT27.ObjRoty=6
			Case 3 : DT27.transz=4 : DT27.ObjRotx=7 : DT27.ObjRoty=7 : DT27.z=10   'org17
 			Case 4 : DT27.transz=4 : DT27.ObjRotx=7 : DT27.ObjRoty=7 : DT27.z=0   'org17
			Case 5 : DT27.transz=3 : DT27.ObjRotx=5 : DT27.ObjRoty=5 : DT27.z=-17   'org17
			Case 6 : DT27.transz=2 : DT27.ObjRotx=2 : DT27.ObjRoty=2 : DT27.z=-34   'org17
			Case 7 : DT27.transz=0 : DT27.ObjRotx=0 : DT27.ObjRoty=0 : DT27.z=-40
					 Drop27.enabled=False
		End Select

	End If
End Sub



Sub Sw25_hit 'DT1
	SparkyObjectX=DT25.x+9
	SparkyObjectY=DT25.y-5
	SetSparks

	TargetBouncer activeball,1
	sw25meat
End Sub

Sub sw25meat
	sw25.collidable=False
	sw002.collidable=False
	'start animation primitive DT25
	Drop25_Timer
	'E128 middle DT
	'E129 right DT
	DOF 128,2 
'	If DOFdebug=1 Then debug.print "DOF 128,2 1/3 middle DT"
	MapBlinker_Timer 
	If SC(PN,5)=0 Then Scoring 1000,100
	SC(PN,5)=1 ' score (x,5) = dt nr 1
	PlaySoundAtLevelStatic SoundFX("DTDrop",DOFKnocker), 2, Sw25
	PlaySound "AAArmorUT", 1, 0.25 * BG_Volume, 0, 0,0,0, 0, 0
	sw25.timerenabled=True
	SPB1 35,37,3, 2,7,1  ' light 7,specialstate, 3 blinks,timer,special off after done
	SLS (35,1)=1
	L035.timerenabled=False
	L035.timerenabled=True
	SPB1 35,37,3,2, 7,1  ' light 7,specialstate, 3 blinks,timer,special off after done
	SLS (35,1)=1
	SLS(182,2)=33 '  blink middleDT GI
End Sub

Sub	L035_Timer  ' 15 sec an armor gone
	SLS(35,1)=0
	SPB1 35,35,1,2,7,1 
	L035.timerenabled=False
End Sub

Sub sw25_Timer ' 10sec
	DT25.z=17   'org17
	sw25.collidable=True
	sw002.collidable=True
	PlaySoundAtLevelStatic SoundFX("DTReset",DOFKnocker), 2, Sw25
	sw25.timerenabled=False
	SC(PN,5)=0
End Sub




Sub Sw26_hit 'DT2
	SparkyObjectX=DT26.x+9
	SparkyObjectY=DT26.y-5
	SetSparks

	TargetBouncer activeball,1
	sw26meat
End Sub

Sub sw26meat
	sw26.collidable=False
	Drop26_Timer
	DOF 128,2 
'	If DOFdebug=1 Then debug.print "DOF 128,2 2/3 middle DT"
	MapBlinker_Timer 
	If SC(PN,6)=0 Then Scoring 2000,400
	SC(PN,6)=1
	PlaySoundAtLevelStatic SoundFX("DTDrop",DOFKnocker), 2, Sw26
	PlaySound "AAAmpPickup", 1, 0.25 * BG_Volume, 0, 0,0,0, 0, 0
	Sw26.timerenabled=True
	SPB1 35,37,3, 2,7,1  ' light 7,specialstate, 3 blinks,timer,special off after done
	SLS (36,1)=1
	L036.timerenabled=False
	L036.timerenabled=True
	SLS(182,2)=33 ' blink middleDT GI
End Sub

Sub	L036_Timer  ' 15 sec an amp
	SLS(36,1)=0
	SPB1 36,36,1,2,7,1 
	L036.timerenabled=False
	PlaySound "AmpOut", 1, 0.25 * BG_Volume, 0, 0,0,0, 0, 0
End Sub

Sub sw26_Timer ' 15sec
	DT26.z=17 
	Sw26.collidable=True
	PlaySoundAtLevelStatic SoundFX("DTReset",DOFKnocker), 2, Sw26
	Sw26.timerenabled=False
	SC(PN,6)=0
End Sub




Sub Sw27_hit 'DT3
	SparkyObjectX=DT27.x+9
	SparkyObjectY=DT27.y-5
	SetSparks

	TargetBouncer activeball,1
	sw27meat
End Sub

Sub sw27meat
	sw27.collidable=False
	sw004.collidable=False
	Drop27_Timer
	DOF 128,2 
'	If DOFdebug=1 Then debug.print "DOF 128,2 3/3 middle DT"
	MapBlinker_Timer 
	If SC(PN,7)=0 Then Scoring 1000,100
	SC(PN,7)=1
	PlaySoundAtLevelStatic SoundFX("DTDrop",DOFKnocker), 2, Sw27
	PlaySound "AABootSnd", 1, 0.45 * BG_Volume, 0, 0,0,0, 0, 0
	Sw27.timerenabled=True
	SPB1 35,37,3, 2,7,1  ' light 7,specialstate, 3 blinks,timer,special off after done
	SLS (37,1)=1
	L037.timerenabled=False
	L037.timerenabled=True
	SLS(182,2)=33 ' blink middleDT GI
End Sub

Sub	L037_Timer  ' 15 sec shield
	SLS(37,1)=0
	SPB1 37,37,1,2,7,1 
	L037.timerenabled=False
End Sub

Sub sw27_Timer ' 7sec
	DT27.z=17 
	Sw27.collidable=True
	sw004.collidable=True
	PlaySoundAtLevelStatic SoundFX("DTReset",DOFKnocker), 2, Sw27
	Sw27.timerenabled=False
	SC(PN,7)=0
End Sub




' right DT's
'***********************
Sub Drop33_Timer
	If 	Drop33.enabled=False Then
		Drop33.enabled=True
		DT33.transz=1
		DT33.ObjRotx=2
		DT33.ObjRoty=2
		DT33.uservalue=0
	Else
		DT33.uservalue=DT33.uservalue+1

		Select Case DT33.uservalue

			Case 1 : DT33.transz=2 : DT33.ObjRotx=4 : DT33.ObjRoty=4
			Case 2 : DT33.transz=3 : DT33.ObjRotx=6 : DT33.ObjRoty=6
			Case 3 : DT33.transz=4 : DT33.ObjRotx=7 : DT33.ObjRoty=7 : DT33.z=10   'org17
 			Case 4 : DT33.transz=4 : DT33.ObjRotx=7 : DT33.ObjRoty=7 : DT33.z=0   'org17
			Case 5 : DT33.transz=3 : DT33.ObjRotx=5 : DT33.ObjRoty=5 : DT33.z=-17   'org17
			Case 6 : DT33.transz=2 : DT33.ObjRotx=2 : DT33.ObjRoty=2 : DT33.z=-34   'org17
			Case 7 : DT33.transz=0 : DT33.ObjRotx=0 : DT33.ObjRoty=0 : DT33.z=-40
					 Drop33.enabled=False
		End Select
	End If
End Sub

Sub Drop34_Timer
	If 	Drop34.enabled=False Then
		Drop34.enabled=True
		DT34.transz=1
		DT34.ObjRotx=2
		DT34.ObjRoty=2
		DT34.uservalue=0
	Else
		DT34.uservalue=DT34.uservalue+1

		Select Case DT34.uservalue

			Case 1 : DT34.transz=2 : DT34.ObjRotx=4 : DT34.ObjRoty=4
			Case 2 : DT34.transz=3 : DT34.ObjRotx=6 : DT34.ObjRoty=6
			Case 3 : DT34.transz=4 : DT34.ObjRotx=7 : DT34.ObjRoty=7 : DT34.z=10   'org17
 			Case 4 : DT34.transz=4 : DT34.ObjRotx=7 : DT34.ObjRoty=7 : DT34.z=0   'org17
			Case 5 : DT34.transz=3 : DT34.ObjRotx=5 : DT34.ObjRoty=5 : DT34.z=-17   'org17
			Case 6 : DT34.transz=2 : DT34.ObjRotx=2 : DT34.ObjRoty=2 : DT34.z=-34   'org17
			Case 7 : DT34.transz=0 : DT34.ObjRotx=0 : DT34.ObjRoty=0 : DT34.z=-40
					 Drop34.enabled=False
		End Select
	End If
End Sub

Sub Drop35_Timer
	If 	Drop35.enabled=False Then
		Drop35.enabled=True
		DT35.transz=1
		DT35.ObjRotx=2
		DT35.ObjRoty=2
		DT35.uservalue=0
	Else
		DT35.uservalue=DT35.uservalue+1

		Select Case DT35.uservalue

			Case 1 : DT35.transz=2 : DT35.ObjRotx=4 : DT35.ObjRoty=4
			Case 2 : DT35.transz=3 : DT35.ObjRotx=6 : DT35.ObjRoty=6
			Case 3 : DT35.transz=4 : DT35.ObjRotx=7 : DT35.ObjRoty=7 : DT35.z=10   'org17
 			Case 4 : DT35.transz=4 : DT35.ObjRotx=7 : DT35.ObjRoty=7 : DT35.z=0   'org17
			Case 5 : DT35.transz=3 : DT35.ObjRotx=5 : DT35.ObjRoty=5 : DT35.z=-17   'org17
			Case 6 : DT35.transz=2 : DT35.ObjRotx=2 : DT35.ObjRoty=2 : DT35.z=-34   'org17
			Case 7 : DT35.transz=0 : DT35.ObjRotx=0 : DT35.ObjRoty=0 : DT35.z=-40
					 Drop35.enabled=False
		End Select
	End If
End Sub


Sub sw005_hit
	SparkyObjectX=(dt33.x+DT34.X)/2+9
	SparkyObjectY=(dt33.Y+DT34.Y)/2-5
	SetSparks

	TargetBouncer activeball,1
	If sw33.collidable=True Then sw33meat
	If sw34.collidable=True Then sw34meat
End Sub

Sub sw006_hit
	SparkyObjectX=(dt35.x+DT34.X)/2+9
	SparkyObjectY=(dt35.Y+DT34.Y)/2-5
	SetSparks

	TargetBouncer activeball,1
	If sw35.collidable=True Then sw35meat
	If sw34.collidable=True Then sw34meat
End Sub



Sub Sw33_hit 'DT4
	SparkyObjectX=dt33.x+9
	SparkyObjectY=dt33.Y-5
	SetSparks

	TargetBouncer activeball,1
	sw33meat
End Sub

Sub Gi032_Timer
	Gi032.timerenabled=False
	Gi032.state=0
End Sub

Sub sw33meat
	Gi032.timerenabled=True
	Gi032.state=1

	Drop33_Timer
	sw33.collidable=False
	sw005.collidable=False
	DOF 129,2 
'	If DOFdebug=1 Then debug.print "DOF 129,2 1/3 right DT"
	MapBlinker_Timer 
	If SC(PN,8)=0 Then Scoring 1000,200
	SC(PN,8)=1
	PlaySoundAtLevelStatic SoundFX("DTDrop",DOFKnocker), 2, Sw33
	PlaySound "AArocketload", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
	Sw33.timerenabled=True
	SPB1 38,40,3,2, 7,1  ' light 7,specialstate, 3 blinks,timer,special off after done
	SLS (38,1)=1
	L038.timerenabled=False 
	L038.timerenabled=True
	SLS(185,2)=33
End Sub

Sub	L038_Timer  ' 15 sec shield
	SLS(38,1)=0
	SPB1 38,38,1,2,7,1 
	L038.timerenabled=False
End Sub

Sub sw33_Timer
	DT33.z=17 
	Sw33.collidable=True
	Sw005.collidable=True
	PlaySoundAtLevelStatic SoundFX("DTReset",DOFKnocker), 2, Sw33
	Sw33.timerenabled=False
	SC(PN,8)=0
End Sub




Sub Sw34_hit 'DT5
	SparkyObjectX=dt34.x+9
	SparkyObjectY=dt34.Y-5
	SetSparks

	TargetBouncer activeball,1
	sw34meat

End Sub

Sub sw34meat
	Gi032.timerenabled=True
	Gi032.state=1

	Drop34_Timer
	sw34.collidable=False
	DOF 129,2 
'	If DOFdebug=1 Then debug.print "DOF 129,2 2/3 right DT"
	MapBlinker_Timer 
	If SC(PN,9)=0 Then Scoring 1000,200

	SC(PN,9)=1
	PlaySoundAtLevelStatic SoundFX("DTDrop",DOFKnocker), 2, Sw34
	PlaySound "AAFlakload", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
	Sw34.timerenabled=True
	SPB1 38,40,3,2, 7,1  ' light 7,specialstate, 3 blinks,timer,special off after done
	SLS (39,1)=1
	L039.timerenabled=False
	L039.timerenabled=True
	SLS(185,2)=33
End Sub

Sub	L039_Timer  ' 15 sec shield
	SLS(39,1)=0
	SPB1 39,39,1,2,7,1 
	L039.timerenabled=False
End Sub

Sub Sw34_Timer
	DT34.z=17 
	Sw34.collidable=True
	PlaySoundAtLevelStatic SoundFX("DTReset",DOFKnocker), 2, Sw34
	Sw34.timerenabled=False
	SC(PN,9)=0
End Sub



Sub Sw35_hit 'DT6
	SparkyObjectX=dt35.x+9
	SparkyObjectY=dt35.Y-5
	SetSparkS

	TargetBouncer activeball,1
	sw35meat
End Sub

Sub sw35meat
	Gi032.timerenabled=True
	Gi032.state=1

	Drop35_Timer

	sw35.collidable=False
	sw006.collidable=False
	DOF 129,2 
'	If DOFdebug=1 Then debug.print "DOF 129,2 3/3 right DT"
	MapBlinker_Timer 
	If SC(PN,10)=0 Then Scoring 1000,200

	SC(PN,10)=1
	PlaySoundAtLevelStatic SoundFX("DTDrop",DOFKnocker), 2, Sw35
	PlaySound "AAReload", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
	sw35.timerenabled=True
	SPB1 38,40,3, 2,7,1  ' light 7,specialstate, 3 blinks,timer,special off after done
	SLS (40,1)=1
	L040.timerenabled=False
	L040.timerenabled=True 
	SLS(185,2)=33
End Sub

Sub	L040_Timer  ' 15 sec shield
	SLS(40,1)=0
	SPB1 40,40,1,2,7,1 
	L040.timerenabled=False
End Sub

Sub sw35_Timer
	DT35.z=17 
	sw35.collidable=True
	sw006.collidable=True
	PlaySoundAtLevelStatic SoundFX("DTReset",DOFKnocker), 2, Sw35
	sw35.timerenabled=False
	SC(PN,10)=0
End Sub
Sub Wall050_Hit
	RandomSoundMetal
	TargetBouncer activeball,.5
	activeball.vely=activeball.vely*0.2
	activeball.velx=activeball.velx*0.2
End Sub
Sub Wall051_Hit
	RandomSoundMetal
	activeball.vely=activeball.vely*0.2
	activeball.velx=activeball.velx*0.2
End Sub
Sub Wall012_Hit
	RandomSoundMetal
	TargetBouncer activeball,.5
	activeball.vely=activeball.vely*0.2
	activeball.velx=activeball.velx*0.2
End Sub




Dim SleeveSpeed6, SleeveSpeed4, SleeveSpeed3, SleeveSpeed2, SleeveSpeed1
const Slevespeedmax = 4
Sub zCol_Sleeves_001_Hit
	SparkyObjectX=zCol_Sleeves_001.x
	SparkyObjectY=zCol_Sleeves_001.y
	SetSparks


	SleeveSpeed1 =ballspeed(activeball)/4-1
'	debug.print "1speed/3 = " & Sleevespeed1

	TargetBouncer2 activeball,0.8

	if Sleevespeed1>Slevespeedmax Then Sleevespeed1=Slevespeedmax
	if Sleevespeed1>0 Then SleeveHit001.enabled=True
End Sub

Sub zCol_Sleeves_002_Hit

SparkyObjectX=zCol_Sleeves_002.x
SparkyObjectY=zCol_Sleeves_002.y
SetSparks

	Sleevespeed2=ballspeed(activeball)/4-1
'	debug.print "2speed/3 = " & Sleevespeed2

	TargetBouncer2 activeball,0.8

	if Sleevespeed2>Slevespeedmax Then Sleevespeed2=Slevespeedmax
	if Sleevespeed2>0 Then SleeveHit002.enabled=True
End Sub

Sub zCol_Sleeves_003_Hit

	SparkyObjectX=zCol_Sleeves_003.x
	SparkyObjectY=zCol_Sleeves_003.y
	SetSparks

	Sleevespeed3=ballspeed(activeball)/4-1
'	debug.print "3speed/3 = " & Sleevespeed3

	TargetBouncer2 activeball,0.8

	if Sleevespeed3>Slevespeedmax Then Sleevespeed3=Slevespeedmax
	if Sleevespeed3>0 Then SleeveHit003.enabled=True
End Sub

Sub zCol_Sleeves_004_Hit
	SparkyObjectX=zCol_Sleeves_004.x
	SparkyObjectY=zCol_Sleeves_004.y
	SetSparks
	Sleevespeed4=ballspeed(activeball)/4-1
'	debug.print "4speed/3 = " & Sleevespeed4

	TargetBouncer2 activeball,0.8

	if Sleevespeed4>Slevespeedmax Then Sleevespeed4=Slevespeedmax
	if Sleevespeed4>0 Then SleeveHit004.enabled=True
End Sub

Sub zCol_Sleeves_006_Hit
	SparkyObjectX=zCol_Sleeves_006.x
	SparkyObjectY=zCol_Sleeves_006.y
	SetSparks

	Sleevespeed6=ballspeed(activeball)/4-1
'	debug.print "6speed/3 = " & Sleevespeed6

	TargetBouncer2 activeball,0.8

	if Sleevespeed6>Slevespeedmax Then Sleevespeed6=Slevespeedmax
	if Sleevespeed6>0 Then SleeveHit006.enabled=True
End Sub

const sleeveframes=5
Sub SleeveHit001_Timer
	SleeveHit001.uservalue=SleeveHit001.uservalue+1
	zCol_Sleeves_001.rotx=Sleevespeed1*(sleeveframes - SleeveHit001.uservalue)
	zCol_Sleeves_001.roty=Sleevespeed1*(sleeveframes - SleeveHit001.uservalue)
	If SleeveHit001.uservalue=sleeveframes Then
		zCol_Sleeves_001.rotx=0
		zCol_Sleeves_001.roty=0
		SleeveHit001.uservalue=0
		SleeveHit001.enabled=False
	End If
End Sub

Sub SleeveHit002_Timer
	SleeveHit002.uservalue=SleeveHit002.uservalue+1
	zCol_Sleeves_002.rotx=Sleevespeed2*(sleeveframes - SleeveHit002.uservalue)
	zCol_Sleeves_002.roty=Sleevespeed2*(sleeveframes - SleeveHit002.uservalue)
	If SleeveHit002.uservalue=sleeveframes Then
		zCol_Sleeves_002.rotx=0
		zCol_Sleeves_002.roty=0
		SleeveHit002.uservalue=0
		SleeveHit002.enabled=False
	End If
End Sub

Sub SleeveHit003_Timer
	SleeveHit003.uservalue=SleeveHit003.uservalue+1
	zCol_Sleeves_003.rotx=Sleevespeed3*(sleeveframes - SleeveHit003.uservalue)
	zCol_Sleeves_003.roty=Sleevespeed3*(sleeveframes - SleeveHit003.uservalue)
	If SleeveHit003.uservalue=sleeveframes Then
		zCol_Sleeves_003.rotx=0
		zCol_Sleeves_003.roty=0
		SleeveHit003.uservalue=0
		SleeveHit003.enabled=False
	End If
End Sub

Sub SleeveHit004_Timer
	SleeveHit004.uservalue=SleeveHit004.uservalue+1
	zCol_Sleeves_004.rotx=Sleevespeed4*(sleeveframes - SleeveHit004.uservalue)
	zCol_Sleeves_004.roty=Sleevespeed4*(sleeveframes - SleeveHit004.uservalue)
	If SleeveHit004.uservalue=sleeveframes Then
		zCol_Sleeves_004.rotx=0
		zCol_Sleeves_004.roty=0
		SleeveHit004.uservalue=0
		SleeveHit004.enabled=False
	End If
End Sub

Sub SleeveHit006_Timer
	SleeveHit006.uservalue=SleeveHit006.uservalue+1
	zCol_Sleeves_006.rotx=Sleevespeed6*(4 - SleeveHit006.uservalue)
	zCol_Sleeves_006.roty=Sleevespeed6*(4 - SleeveHit006.uservalue)
	If SleeveHit006.uservalue=4 Then
		zCol_Sleeves_006.rotx=0
		zCol_Sleeves_006.roty=0
		SleeveHit006.uservalue=0
		SleeveHit006.enabled=False
	End If
End Sub

'zCol_Band003-x
'zCol_Band015-x
'zCol_Band017+x
Sub zCol_Band003_hit
	SparkyObjectX=zCol_Band003.x
	SparkyObjectY=zCol_Band003.y
	SetSparks
End Sub

Sub zCol_Band015_hit
	SparkyObjectX=zCol_Band015.x
	SparkyObjectY=zCol_Band015.y
	SetSparks
End Sub

Sub zCol_Band017_hit
	SparkyObjectX=zCol_Band017.x
	SparkyObjectY=zCol_Band017.y
	SetSparks
End Sub


Sub zCol_Band012_Hit
	SparkyObjectX=507
	SparkyObjectY=810
	SetSparks
End Sub


Sub zCol_Rubber_Corner_018_Hit
	SparkyObjectX=zCol_Rubber_Corner_018.x
	SparkyObjectY=zCol_Rubber_Corner_018.y
	SetSparks
End Sub



Sub zCol_Rubber_Corner_009_Hit
	SparkyObjectX=zCol_Rubber_Corner_009.x
	SparkyObjectY=zCol_Rubber_Corner_009.y
	SetSparks
	TargetBouncer2 activeball,0.8
End Sub


Sub zCol_Rubber_Corner_024_Hit
	SparkyObjectX=zCol_Rubber_Corner_024.x
	SparkyObjectY=zCol_Rubber_Corner_024.y
	SetSparks
	TargetBouncer2 activeball,0.8
End Sub


Sub zCol_Rubber_Corner_023_Hit
	SparkyObjectX=zCol_Rubber_Corner_023.x
	SparkyObjectY=zCol_Rubber_Corner_023.y
	SetSparks
	TargetBouncer2 activeball,0.8
End Sub


Sub zCol_Rubber_Corner_026_Hit
	SparkyObjectX=zCol_Rubber_Corner_026.x
	SparkyObjectY=zCol_Rubber_Corner_026.y
	SetSparks
	TargetBouncer2 activeball,0.8
End Sub


Sub zCol_Rubber_Corner_019_Hit
	SparkyObjectX=zCol_Rubber_Corner_019.x
	SparkyObjectY=zCol_Rubber_Corner_019.y
	SetSparks
	TargetBouncer2 activeball,0.8
End Sub


Sub zCol_Rubber_Peg_006_Hit
	SparkyObjectX=zCol_Rubber_Peg_006.x
	SparkyObjectY=zCol_Rubber_Peg_006.y
	SetSparks
	TargetBouncer2 activeball,0.8
End Sub


Sub zCol_Rubber_Corner_013_Hit
	SparkyObjectX=zCol_Rubber_Corner_013.x
	SparkyObjectY=zCol_Rubber_Corner_013.y
	SetSparks
	TargetBouncer2 activeball,0.8
End Sub


Sub zCol_Rubber_Corner_006_Hit ' slingshotposts
	SparkyObjectX=zCol_Rubber_Corner_006.x
	SparkyObjectY=zCol_Rubber_Corner_006.y
	SetSparks
	TargetBouncer2 activeball,0.8
End Sub


Sub zCol_Rubber_Corner_003_Hit
	SparkyObjectX=zCol_Rubber_Corner_003.x
	SparkyObjectY=zCol_Rubber_Corner_003.y
	SetSparks
	TargetBouncer2 activeball,0.8
End Sub


Sub zCol_Rubber_Corner_001_Hit
	SparkyObjectX=zCol_Rubber_Corner_001.x
	SparkyObjectY=zCol_Rubber_Corner_001.y
	SetSparks
End Sub


Sub zCol_Rubber_Corner_004_Hit
	SparkyObjectX=zCol_Rubber_Corner_004.x
	SparkyObjectY=zCol_Rubber_Corner_004.y
	SetSparks
End Sub




'**********************************************************************************************************
'* SWITCHES *
'**********************************************************************************************************

'skillshot lights
Sub sw20_Hit 'bottom one
	SparkyObjectX=137
	SparkyObjectY=947
	SetSparks

	sw20_Timer

	SPB2 153,153,4,0,0,1
	SLS(185,2)=20 '  GI blink short
'	TargetBouncer2 activeball,1 


	MapBlinker_Timer
	PlaySound "mclang2", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
	SLS(59,1)=1
	SPB1 59,59,3,2,8,1 
	CheckRedeemer
	Scoring 500,0
	DOF 152,2 
'	If DOFdebug=1 Then debug.print "DOF 152,2 4skillshot lights hit"

	If skill1>0 Then
		Select Case Skill1
			Case 1,2,10,11 : SkillshotClose : Exit Sub
			Case 3,4,8,9 : Skillshotgood : GiBlinkOnce : Exit Sub
			Case 5,6,7 : SkillShotPerfect :	GiBlinkOnce : Exit Sub
		End Select
		SkillshotBAD
	End If

End Sub

Sub sw19_Hit
	SparkyObjectX=128
	SparkyObjectY=893
	SetSparks

	sw19_Timer

	SPB3 152,152,4,0,0,1
	SLS(185,2)=20 '  GI blink short
'	TargetBouncer2 activeball,1 

	MapBlinker_Timer
	PlaySound "mclang2", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0 
	SLS(60,1)=1
	SPB1 60,60,3,2,8,1
	CheckRedeemer
	Scoring 500,0 
	DOF 152,2 
'	If DOFdebug=1 Then debug.print "DOF 152,2 4skillshot lights hit"

	If skill1>0 Then
		Select Case Skill1
			Case 1,2,10,11 : SkillshotClose : Exit Sub
			Case 3,4,8,9 : Skillshotgood : GiBlinkOnce : Exit Sub
			Case 5,6,7 : SkillShotPerfect :	GiBlinkOnce : Exit Sub
		End Select
		SkillshotBAD
	End If


End Sub

Sub sw18_Hit 
	SparkyObjectX=117
	SparkyObjectY=838
	SetSparks

	sw18_Timer

	SPB3 151,151,4,0,0,1
	SLS(185,2)=20 '  GI blink short
'	TargetBouncer2 activeball,1 

	MapBlinker_Timer
	PlaySound "mclang2", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
	SLS(61,1)=1
	SPB1 61,61,3,2,8,1 
	CheckRedeemer
	Scoring 500,0
	DOF 152,2 
'	If DOFdebug=1 Then debug.print "DOF 152,2 4skillshot lights hit"

	If skill1>0 Then
		Select Case Skill1
			Case 1,2,10,11 : SkillshotClose : Exit Sub
			Case 3,4,8,9 : Skillshotgood : GiBlinkOnce : Exit Sub
			Case 5,6,7 : SkillShotPerfect :	GiBlinkOnce : Exit Sub
		End Select
		SkillshotBAD
	End If


End Sub

Sub sw17_Hit 'top one
	SparkyObjectX=105
	SparkyObjectY=782
	SetSparks

	sw17_Timer
	SLS(185,2)=20 '  GI blink short
	SPB3 150,150,4,0,0,1
'	TargetBouncer2 activeball,1 

	MapBlinker_Timer
	PlaySound "mclang2", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
	SLS(62,1)=1
	SPB1 62,62,3,2,8,1 
	CheckRedeemer
	Scoring 500,0 
	DOF 152,2 
'	If DOFdebug=1 Then debug.print "DOF 152,2 4skillshot lights hit"
End Sub


Sub sw20_Timer
	If sw20.timerenabled=False Then 
		sw20.timerenabled=True
		psw20.transX=4
	Else
		psw20.transX=psw20.transX-1
		If psw20.transX <1 Then
			psw20.transX=0
			sw20.timerenabled=False
		End If
	End If
End Sub
Sub sw19_Timer
	If sw19.timerenabled=False Then 
		sw19.timerenabled=True
		psw19.transX=4
	Else
		psw19.transX=psw19.transX-1
		If psw19.transX <1 Then
			psw19.transX=0
			sw19.timerenabled=False
		End If
	End If
End Sub
Sub sw18_Timer
	If sw18.timerenabled=False Then 
		sw18.timerenabled=True
		psw18.transX=4
	Else
		psw18.transX=psw18.transX-1
		If psw18.transX <1 Then
			psw18.transX=0
			sw18.timerenabled=False
		End If
	End If
End Sub
Sub sw17_Timer
	If sw17.timerenabled=False Then 
		sw17.timerenabled=True
		psw17.transX=4
	Else
		psw17.transX=psw17.transX-1
		If psw17.transX <1 Then
			psw17.transX=0
			sw17.timerenabled=False
		End If
	End If
End Sub

Sub GiBlinkOnce
	for i = 179 to 190 : SLS(i,2)=33 : Next
End Sub




Sub CheckRedeemer
	If SLS(59,1)=1 And SLS(60,1)=1 And SLS(61,1)=1 And SLS(62,1)=1 Then

		GiBlinkOnce
		SPB2 150,153,7,0,0,1
		SPB1 59,62,5,2,1,1 ' 5 blinks
		SLS(59,1)=0 'turn off whities
		SLS(60,1)=0
		SLS(61,1)=0
		SLS(62,1)=0

		SLS(67,1)=2 ' TURN ON REDEEMER
		Addpopup "REDEEMER","IS READY",fontbig1

		PlaySound "AAlift3act", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
		If kickr5=0 Then Dividerwall1_Timer ' activate divider
		' WHEN ENTER KICK OUT behind tower
	End If

End Sub

Dim OrbDir
Sub Sw54_hit 'roundabout bothways
	SPB2 201,201,1,0,0,1

	SLS(181,2)=33 ' blink middletopgi  1 solid blink ``?

	If OrbDir=4 Then 
		PlaySound "AARocket_Exp", 1, 0.2 * BG_Volume, 0, 0,0,0, 0, 0
	Else
		PlaySound "AAShockalt_fire", 1, 0.2 * BG_Volume, 0, 0,0,0, 0, 0
	End If
	OrbDir=1
End Sub



'invisibilty (1) = sw40
'invisibilty (2) = 22
'invisibilty (3) = topvuk
'invisibilty (4) = 32
'invisibilty (5) = 21

Dim ComboRedbase
Dim ComboBluebase
Dim ComboOrbits
Dim ComboKickers
Dim CombosLastHit


'Dim Showcombo, ShowComboText1, ShowComboText2


Sub AwardComboRed
'	Debug.print "AwardRedCombo - Timer=" & ComboRedbase-Frame & " Left on 3sec"
	AwardComboSound
	Scoring 40000,6000
	Showcombo=1
	ShowComboText1 = "RED COMBO"
	ShowComboText2 = FormatScore(FFTscore)

End Sub

Sub AwardComboBlue
'	Debug.print "AwardBlueCombo - Timer=" & ComboBluebase-Frame & " Left on 3sec"
	AwardComboSound
	Scoring 40000,6000
	Showcombo=1
	ShowComboText1 = "BLUE COMBO"
	ShowComboText2 = FormatScore(FFTscore)

End Sub

Sub AwardComboOrbits
'	Debug.print "AwardOrbitCombo - Timer=" & ComboOrbits-Frame & " Left on 3sec"
	AwardComboSound
	Scoring 60000,8000
	Showcombo=1
	ShowComboText1 = "ORBITCOMBO"
	ShowComboText2 = FormatScore(FFTscore)

End Sub

Sub AwardComboKickers
'	Debug.print "AwardKickerCombo - Timer=" & ComboKickers-Frame & " Left on 3sec"
	AwardComboSound
	Scoring 75000,12000
	Showcombo=1
	ShowComboText1 = "KICKRCOMBO"
	ShowComboText2 = FormatScore(FFTscore)

End Sub

Sub AwardComboSound
	i= int(rnd(1)*2)
	If i = 1 Then
		playsound "gears",  BG_Volume , 0, 0,0,0, 0, 0
	Else
		playsound "bellend1",  BG_Volume , 0, 0,0,0, 0, 0
	End If
End Sub

Sub Sw21_Hit


	TrippleHS=0 '  turn off headshot triple
	If OrbDir=1 Then

		If MBActive=0 And pwnagemultiball=0 Then SPB1 103,101,3,1,3,1

'		AwardComboKickers
'		AwardComboBlue
'		AwardComboRed
'		AwardComboOrbits
		If MBActive=0 And pwnagemultiball=0 Then ' 1 ball combos !!

'			Debug.print "Redbase frame=" & Frame

			If Frame<ComboRedbase Then
				AwardComboRed
				SLS(187,2)=88
				SLS(188,2)=88
			End If				
			If frame<ComboOrbits And CombosLastHit=5 Then
				AwardComboOrbits
				SLS(187,2)=88
				SLS(188,2)=88
			End If

			ComboRedbase=Frame+300 ' 3 seconds .. is too mucho
			ComboOrbits=Frame+333
			CombosLastHit=2

		End If
		


		SPB2 118,112,1,0,3,1
		If SC(PN,44)=0 Then	'	LiandriGame
			SC(PN,44)=1		'	44= lane 2 done ' left orbit
			spb2 112,118,3,0,0,1
			SLS(142,1)=1
			spb2 142,142,3,0,0,1

			checkliandri
		End If


		If OntopEffect=0 Then OntopEffect=2
		DOF 135,2 
		'		If DOFdebug=1 Then debug.print "DOF 135,2 left orbit"
		'133 invisibility awarded
		'134 left saucer
		'135 left orbit
		'136 TopVUK
		'137 right saucer
		'138 right orbit
	
		If Invisiblilty(2)=1 Then
			Invisiblilty(1)=0
			Invisiblilty(2)=1
			Invisiblilty(3)=0
			Invisiblilty(4)=0
			Invisiblilty(5)=0
			SLS (78,1)=0
			SLS (79,1)=1 ' award first one and just delete all others
			SLS (80,1)=0
			SLS (81,1)=0
			SLS (82,1)=0
			SLS (83,1)=0
			SPB1 78,82,2,2,0,1
		Else
			Invisiblilty(2)=1
			SLS (79,1)=1
			SPB1 79,79,5,2,0,1

			If Invisiblilty(1)=1 And Invisiblilty(2)=1 And Invisiblilty(3)=1 And Invisiblilty(4)=1 And Invisiblilty(5)=1 Then SLS(83,1)=2 : SPB2 78,83,10,0,0,1


		End If


		OrbDir=3
		SPB1 107,104,3,2,3,1

		If Firstblood=0 Then FirstBloodX
		HeadShotON
		FastFrags=FastFrags+1
		Frag

		SC(PN,19)=SC(PN,19)+1
		CheckFastFrags


		' check to see if lock lights should be turned on
		If MBactive=0 Then 
			SC(PN,18) = SC(PN,18) + 1   ' 18 is lights done
			If SC(PN,18)=7 Then			
				DividerWall1_Timer ' divider=on ramp goes to tower
				PlaySound "AApointsecure" & Int(rnd(1)*4)+1 , 1, BG_Volume, 0, 0,0,0, 0, 0
				addpopup "CONTROLPOINT","1 SECURE",fontbig3
				SLS(65,1)=2
				SLS(66,1)=2
			LockBolt1.Z=140
			LockBolt1.collidable=True
'			debug.Print "Boltmoved UP"
			End If
		End If

		EnemyFlag
		GameTimerCheck


		SC(PN,12) = SC(PN,12) + 1
		If SC(PN,12) = 5 Then
			'!Turn on capture!
			SLS(42,1)=2 ' blinking
			If SLS(41,1)>1 Then SLS(42,1)=1
			SPB1 42,42,7,2,2,1
			PlaySound "wdend04" , 1, BG_Volume, 0, 0,0,0, 0, 0
			Addpopup "CAPTURE LIT","CAPTURE LIT",fontbig2
			PlaySound "AAassist", 1, BG_Volume, 0, 0,0,0, 0, 0
		elseif SC(PN,12) > 4 Then 
			SC(PN,12) = 5
		End If



 		Select Case SC(PN,12)
			Case 1: SLS(15,1)=1
			Case 2: SLS(16,1)=1
			Case 3: SLS(17,1)=1
			Case 4: SLS(18,1)=1
			PlaySound "AASpreeSound", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
			Case 5: SLS(19,1)=1
			Scoring 1000,100
		End Select

		SPB1 15,19,3,2, 7,1  ' light 7,specialstate, 3 blinks,timer,special off after done
	End If

	Objlevel(2) = 1 : FlasherFlash2_Timer :	playSound "fx_relay", 1,0.2*VolumeDial, AudioPan(Sling1),0,0,0,0, AudioPan(Sling1)
	DOF 112,2 
'	If DOFdebug=1 Then debug.print "DOF 112,2 flasherb2"
End Sub

Sub Sw55_hit 'roundabout both ways
	SLS(180,2)=33 ' blink middletopgi  1 solid blink ``?
	SPB2 202,202,1,0,0,1

	If OrbDir=3 Then
		PlaySound "AAShock_fire", 1, 0.2 * BG_Volume, 0, 0,0,0, 0, 0
	Else
		PlaySound "AARocket_fire", 1, 0.2 * BG_Volume, 0, 0,0,0, 0, 0
	End If
	OrbDir=2
End Sub

Sub Sw22_Hit ' BlueBase

	TrippleHS=0



	If OrbDir=2 Then

		If MBActive=0 And pwnagemultiball=0 Then SPB2 101,103,3,1,3,1
'		AwardComboKickers
'		AwardComboBlue
'		AwardComboRed
'		AwardComboOrbits
		If MBActive=0 And pwnagemultiball=0 Then ' 1 ball combos !!
'			Debug.print "Bluebase frame=" & Frame
			If Frame<ComboBluebase Then
				AwardComboBlue
				SLS(187,2)=88
				SLS(188,2)=88
			End If
			If Frame<ComboOrbits And CombosLastHit=2 Then
				AwardComboOrbits
				SLS(187,2)=88
				SLS(188,2)=88
			End If

			ComboBluebase=Frame+300 ' 3 seconds .. is too mucho
			ComboOrbits=Frame+333
			CombosLastHit=5
		End If
		


		SPB2 112,118,1,0,3,1
		If SC(PN,47)=0 Then	'	LiandriGame
			SC(PN,47)=1		'	46= right orbit done
			spb2 112,118,3,0,0,1
			SLS(145,1)=1
			spb2 145,145,3,0,0,1

			checkliandri
		End If

		If OntopEffect=0 Then OntopEffect=3
		DOF 138,2 
'		If DOFdebug=1 Then debug.print "DOF 138,2 right orbit"
'133 invisibility awarded
'134 left saucer
'135 left orbit
'136 TopVUK
'137 right saucer
'138 right orbit

'invisibilty (1) = sw40
'invisibilty (2) = 22
'invisibilty (3) = topvuk
'invisibilty (4) = 32
'invisibilty (5) = 21
	If Invisiblilty(5)=1 Then
		Invisiblilty(1)=0
		Invisiblilty(2)=0
		Invisiblilty(3)=0
		Invisiblilty(4)=0
		Invisiblilty(5)=1
		SLS (78,1)=0
		SLS (79,1)=0
		SLS (80,1)=0
		SLS (81,1)=0
		SLS (82,1)=1
		SLS (83,1)=0
		SPB1 78,82,2,2,0,1
	Else
		Invisiblilty(5)=1
		SLS (82,1)=1
		SPB1 82,82,5,2,0,1

		If Invisiblilty(1)=1 And Invisiblilty(2)=1 And Invisiblilty(3)=1 And Invisiblilty(4)=1 And Invisiblilty(5)=1 Then SLS(83,1)=2 : SPB2 78,83,10,0,0,1

	End If

		OrbDir=4
		SPB1 104,107,3,2,3,1



		If Firstblood=0 Then FirstBloodX
		HeadShotON
		FastFrags=FastFrags+1
		Frag

		SC(PN,19)=SC(PN,19)+1
		CheckFastFrags


		' check to see if lock lights should be turned on
		If MBactive=0 Then 
			SC(PN,18) = SC(PN,18) + 1   ' 18 is lights done
			If SC(PN,18)=7 Then			
				DividerWall1_Timer ' divider=on ramp goes to tower
				PlaySound "AApointsecure" & Int(rnd(1)*4)+1 , 1, BG_Volume, 0, 0,0,0, 0, 0
				addpopup "CONTROLPOINT","1 SECURE",fontbig3
				
				SLS(65,1)=2
				SLS(66,1)=2
				LockBolt1.Z=140
				LockBolt1.collidable=True
'				debug.Print "Boltmoved UP"

			End If
		End If



		EnemyFlag
		GameTimerCheck
		SC(PN,13) = SC(PN,13) + 1
		If SC(PN,13) = 5 Then
			'!Turn on capture!
			SLS(42,1)=2 ' blinking
			If SLS(41,1)>1 Then SLS(42,1)=1
			SPB1 42,42,7,2,2,1
			PlaySound "wdend04", 1, BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "CAPTURE LIT","CAPTURE LIT",fontbig2
			PlaySound "AAassist", 1, BG_Volume, 0, 0,0,0, 0, 0
		ElseIf SC(PN,13) > 4 Then
			SC(PN,13) = 5
		End If


		Select Case SC(PN,13)
			Case 1: SLS( 7,1)=1
			Case 2: SLS( 8,1)=1
			Case 3: SLS( 9,1)=1
			Case 4: SLS(10,1)=1
			PlaySound "AASpreeSound", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
			Case 5: SLS(11,1)=1
			Scoring 1000,100

		End Select

		SPB1  7,11,3, 2,7,1 ' light 7,specialstate, 3 blinks,timer,special off after done
	End If

	Objlevel(3) = 1 : FlasherFlash3_Timer :	playSound "fx_relay", 1,0.2*VolumeDial, AudioPan(Sling1),0,0,0,0, AudioPan(Sling1)
	DOF 109,2 
'	If DOFdebug=1 Then debug.print "DOF 109,2 flasher1"

End Sub



Dim Leftdrop
Sub Trigger001_Hit : Leftdrop=1 : End sub
Dim Rightdrop
Sub RampR_fx3_Hit : Rightdrop=1 : End Sub


Sub AwardComboTower
'	Debug.print "ComboTower " & ComboTower-Frame & " Left on 100frames"
	AwardComboSound
	Scoring 75000,12000
	Showcombo=1
	ShowComboText1 = "GUNSLINGER"
	ShowComboText2 = FormatScore(FFTscore)
End Sub


Dim ComboTower
Sub Sw29_hit
	ComboTower=Frame+120
	spb2 86,86,3,0,0,1 ' blink tower to show

	MapBlinker_Timer
	SPB2 139,120,1,0,1,1

	If SC(pn,12)>0 Then	SPB2 15,14+SC(pn,12),2,0,0,1
	If Leftdrop=1 Then Leftdrop=0 : RandomSoundDelayedBallDropOnPlayfield sw29

	Scoring 1000,0
	PlaySound "AAAmmoPick", 1, 0.4 * BG_Volume, 0, 0,0,0, 0, 0
End Sub


Sub Sw37_hit
	MapBlinker_Timer
	SPB2 120,139,1,0,1,1

	If SC(pn,13)>0 Then	SPB2 7,6+SC(pn,13),2,0,0,1
	If Rightdrop=1 Then Rightdrop=0 : RandomSoundDelayedBallDropOnPlayfield sw37

	Scoring 1000,0
	PlaySound "AAAmmoPick", 1, 0.4 * BG_Volume, 0, 0,0,0, 0, 0
End Sub


Dim KBstatus
Sub Sw28_hit
	MapBlinker_Timer

	If SLS(48,1)>1 Then
	' turn off enemyflag  l046 1500ms
		L041.timerenabled=True
		SLS(41,1)=0
		If SLS(42,1)=1 Then SLS(42,1)=2
		SLS(48,1)=0
		SLS(63,1)=0
		SLS(70,1)=0
		Addpopup "FLAG","RETURNED",fontbig2
		Scoring 5000,1000

	End If


	If KBStatus=1 Then

		If tilted=0 Then
			If L049.timerenabled=False Then
				L049.timerenabled=True
				SPB1 49,49,20,2,8,1 ' KB 12 blinks
			End If
			kickback.Fire
			Scoring 1000,100
			DOF 118,2
'			If DOFdebug=1 Then debug.print "DOF 118,2 Kickback Fire"
			kickback.pullback
			PlaySound "AAUTsuperHeal", 1, 0.3 * BG_Volume, 0, 0,0,0, 0, 0
			PlaySoundAtLevelStatic ("Plunger_Pull_1"), PlungerPullSoundLevel, kickback
		Else
			GiBlinkOnce
			PlaySound "mandown", 1, BG_Volume, 0, 0,0,0, 0, 0
			Scoring 50000,1000
		End If

	Else ' no kb so this was missing :Å
		GiBlinkOnce
		PlaySound "mandown", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
		Scoring 50000,1000
	End If
End Sub


Sub L041_Timer  ' return flag sound

	L041.timerenabled=False
	PlaySound "AAReturnSound", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0

End Sub


Sub L049_Timer 		'2sec then turn off KB
	L049.timerenabled=False
'	L047.timerenabled=True
	KBStatus=0
'    debug.print "kickback OFF"
	SLS(49,1)=0 ' KB Off
	SLS(49,5)=0 ' off with special too
End Sub


Dim LiteKBstatus
'Sub L047_Timer
'	L047.timerenabled=False
'	SLS(47,1)=2 ' litekickback On
'	LiteKBstatus=1
'End Sub

Dim permaspinners
Dim Superspi
Sub Superspinner_Timer
	If Tilted=0 Then
		Superspi=superspi+1
		l27a.uservalue=0
		L27a_timer
		PlaySound "fx_spinner"
		l27b.uservalue=0
		L27b_Timer
		If superspi>121 And permaspinners=0 Then 
			superspinner.enabled=False
			superspi=0
		End If
	Else
		superspinner.enabled=False
		superspi=0
	End If
End Sub


Dim BumpFlash
Sub BumperFlasher_Timer
	If BumperFlasher.enabled=False Then
		BumperFlasher.enabled=True
		BumpFlash=0
		SPB2 101,103,1,0,0,1
	Else
		BumpFlash=BumpFlash+1
		SPB2 101,103,1,0,0,1	
		If BumpFlash>3 Then BumperFlasher.enabled=False
	End If
End Sub


Sub sw39_Timer
	If sw39.timerenabled=False Then 
		sw39.timerenabled=True
		psw39.transX=4
	Else
		psw39.transX=psw39.transX-1
		If psw39.transX <1 Then
			psw39.transX=0
			sw39.timerenabled=False
		End If
	End If
End Sub


Dim pwnage, quickMBcounter, pwnageMBready,pwnageOLD
Sub sw39_hit

	SparkyObjectX=106
	SparkyObjectY=1255
	SetSparks

	TargetBouncer activeball,1.2 
'	debug.Print "VEL X=" & activeball.velx & " Y=" & activeball.vely  &" Z=" & activeball.velz  

	sw39_Timer

	MapBlinker_Timer
	SPB3 154,154,1,0,0,1 ' targetblink
	PlaySound "ReturnTarget", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0

	If SLS(46,1)>0 Or LiteKBstatus=1 Then SPB2 57,58,6,1,4,1 ' GiBlinkOnce

	'PWNAGE LIGHT   !!!
	If SLS(46,1)>0 Then
		SPB2 201,202,2,0,0,1 ' apronlights
		spb2 154,154,7,0,0,1
		spb2 1,1,5,0,0,1 : DOF 110,2 : DOF 113,2'top10 lights faster blinks
		DOF 130,2 
'		If DOFdebug=1 Then debug.print "DOF 130,2 Pwnage"
		'E130 pwnage
		'E131 lite Kickback
		SLS(46,1)=0
		SPB2 46,46,4,0,0,1
		PlaySound "ownage", 1, 0.45 * BG_Volume, 0, 0,0,0, 0, 0
		If quickMBcounter>6 And pwnagemultiball<2 And pwnageMBready=0 And SLS(96,1)=0 Then pwnageMBready=1

		pwnage=pwnage+1
'		Debug.print "Pwnage+1=" & pwnage
		If pwnage>14 then pwnage=8
' new modes ... reset timers if pwnage is triggerd before timers go out

'pwnage
' 1   1   - 60s superspinners
' 2   2   - superbumpers On
' 3   3   - EOB Multiplyer
' 4   4+5 - pwn jackpot= ramp in 15s
' 5   6   - EOB Multiplyer
' 6	  7   - pertmaspinners
' 7   8+9 - pwn jackpot
' 8	  10  - EOB Multiplyer
' 9   11  - opnly points
'10   12+13 JP
'11   godlike pwnage  last 3 repeats



		Select case pwnage

			Case 1:	If pwnageMBready=1 Then
						pwnMBgo
					Else
						Addpopup "PWNAGE 60s","SUPER SPINNERS",fontbig1
						superspinner.enabled=True
						scoring 20000,2000
						pwn1morelight
					End If

			Case 2:
					If pwnageMBready=1 Then
						pwnMBgo
					Else
						Superbumpers=16
						Addpopup "SUPERBUMPERS","ACTIVATED",fontbig1
						BumperFlasher_Timer
						scoring 20000,2000
						pwn1morelight
					End If

			Case 3,10:
					If pwnageMBready=1 Then
						pwnMBgo
					Else
						LiandriAddLetter
						SC(PN,11) = SC(PN,11)+1
						SPB2 2,6,7,0,0,1
	
						If SC(PN,11)>5 Then 
							SC(PN,11)=5  '  reward for extra bonus !!!! 
							scoring 50000,1000
							Addpopup "MULTI BONUS", FormatScore(FFTscore),fontbig1
						Else
							If SC(PN,11) = 1 Then  Addpopup "PWNAGE","BONUS X 2",fontbig1
							If SC(PN,11) = 2 Then  Addpopup "PWNAGE","BONUS X 3",fontbig1
							If SC(PN,11) = 3 Then  Addpopup "PWNAGE","BONUS X 4",fontbig1
							If SC(PN,11) = 4 Then  Addpopup "PWNAGE","BONUS X 6",fontbig1
							If SC(PN,11) = 5 Then  Addpopup "PWNAGE","BONUS X 8",fontbig1
							scoring 20000,2000
						End If
	
						SLS(2,1)=2 : SLS(2,9)=7
						If SC(PN,11)>1 Then SLS(3,1)=2 : SLS(3,9)=7
						If SC(PN,11)>2 Then SLS(4,1)=2 : SLS(4,9)=7
						If SC(PN,11)>3 Then SLS(5,1)=2 : SLS(5,9)=7
						If SC(PN,11)>4 Then SLS(6,1)=2 : SLS(6,9)=7
					End If
			Case 6:
					If pwnageMBready=1 Then
						pwnMBgo
					Else
						SC(PN,11) = SC(PN,11)+1
						SPB2 2,6,7,0,0,1
	
						If SC(PN,11)>5 Then 
							SC(PN,11)=5  '  reward for extra bonus !!!! 
							scoring 50000,1000
							Addpopup "MULTI BONUS", FormatScore(FFTscore),fontbig1
						Else
							If SC(PN,11) = 1 Then  Addpopup "PWNAGE","BONUS X 2",fontbig1
							If SC(PN,11) = 2 Then  Addpopup "PWNAGE","BONUS X 3",fontbig1
							If SC(PN,11) = 3 Then  Addpopup "PWNAGE","BONUS X 4",fontbig1
							If SC(PN,11) = 4 Then  Addpopup "PWNAGE","BONUS X 6",fontbig1
							If SC(PN,11) = 5 Then  Addpopup "PWNAGE","BONUS X 8",fontbig1
							scoring 20000,2000
						End If
	
						SLS(2,1)=2 : SLS(2,9)=7
						If SC(PN,11)>1 Then SLS(3,1)=2 : SLS(3,9)=7
						If SC(PN,11)>2 Then SLS(4,1)=2 : SLS(4,9)=7
						If SC(PN,11)>3 Then SLS(5,1)=2 : SLS(5,9)=7
						If SC(PN,11)>4 Then SLS(6,1)=2 : SLS(6,9)=7
					End If

			Case 4 :
					If pwnageMBready=1 Then
						pwnMBgo
					Else
						pwnJP=1
						SLS(96,1)=1 : spb2 96,96,3,0,0,1
						If SLS(46,1)>0 Then SLS(96,1)=2
						P045.material="InsertOrangeOnTri"
					End If

			Case 5 : pwnJP=1
					SLS(96,1)=1 : spb2 96,96,3,0,0,1
					If SLS(46,1)>0 Then SLS(96,1)=2
					P045.material="InsertOrangeOnTri"
					pwnage=4
					pwnJPtimer=15 'reset this
					pwnJPCounter=30
					pwn1morelight
					scoring 20000,2000


			Case 7:
					If pwnageMBready=1 Then
						pwnMBgo
					Elseif permaspinners=0 Then
						Addpopup "REST OF BALL","SUPER SPINNERS",fontbig1
						superspinner.enabled=True
						permaspinners=1
						scoring 20000,2000
						pwn1morelight
					Else
						scoring 250000,20000
						Addpopup "PWNAGE BONUS", FormatScore(FFTscore),fontbig1
						i = int(rnd(1)*3)
						pwn1morelight
					
					End If

			Case 8: If pwnageMBready=1 Then
						pwnMBgo
					Else
						pwnJP=1
						SLS(96,1)=1 : spb2 96,96,3,0,0,1
						If SLS(46,1)>0 Then SLS(96,1)=2
						P045.material="InsertOrangeOnTri"
	
					End If

			Case 9: pwnJP=1 
						SLS(96,1)=1 : spb2 96,96,3,0,0,1
						If SLS(46,1)>0 Then SLS(96,1)=2
					P045.material="InsertOrangeOnTri"
					pwnage=8
					pwnJPtimer=15 'reset this
					pwnJPCounter=30
					pwn1morelight
					scoring 20000,2000

			Case 11 :
					If pwnageMBready=1 Then
						pwnMBgo
					Else
						scoring 250000,20000
						Addpopup "PWNAGE BONUS", FormatScore(FFTscore),fontbig1
						i = int(rnd(1)*3)
						pwn1morelight
					End If

			Case 12: If pwnageMBready=1 Then
						pwnMBgo
					Else
						pwnJP=1
						SLS(96,1)=1 : spb2 96,96,3,0,0,1
						If SLS(46,1)>0 Then SLS(96,1)=2
						P045.material="InsertOrangeOnTri"
	
					End If

			Case 13: pwnJP=1 
						SLS(96,1)=1 : spb2 96,96,3,0,0,1
						If SLS(46,1)>0 Then SLS(96,1)=2
					P045.material="InsertOrangeOnTri"
					pwnage=12
					pwnJPtimer=15 'reset this
					pwnJPCounter=30
					pwn1morelight
					scoring 20000,2000

			Case 14 :
					If pwnageMBready=1 Then
						pwnMBgo
					Else
						SLS(119,1)=2 : SPB2 119,119,5,0,0,1
						PlaySound "godlike", 1, BG_Volume, 0, 0,0,0, 0, 0
						Dof 145,2
						SLS(149,1)=1
						SC(PN,50)= SC(PN,50) Or 64
						SPB1 149,149,6,0,0,1
						scoring 2000000,100000
						Addpopup "PWNAGE BONUS", FormatScore(FFTscore),fontbig1
						i = int(rnd(1)*3)
						pwn1morelight
					End If

			Case 100 : pwnMB=1
					pwnMBtimer=15
					SLS(55,1)=2
			Case 101 : pwnMB=1
					SLS(55,1)=2
					pwnage=100
					pwnMBtimer=15 'reset this
					pwnMBCounter=30
					Scoring 30000,3000
					pwn1morelight

		End Select
	End If

'	Debug.print "PwnageOut=" & pwnage

	If LiteKBstatus=1 Then
		Objlevel(1) = 1 : FlasherFlash1_Timer :	playSound "fx_relay", 1,0.2*VolumeDial, AudioPan(psw39),0,0,0,0, AudioPan(psw39)
						DOF 111,2 
'						If DOFdebug=1 Then debug.print "DOF 111,2 flasherR1" 
		SLS(47,1)=0 ' litekickback off
		LiteKBstatus=0
		SPB2 47,47,7,0,0,1 ' lithe 3 blinks
		SLS(49,1)=1 ' KB on
		SLS(49,5)=0 'SPstateoff too
		DOF 131,2 
'		If DOFdebug=1 Then debug.print "DOF 131,2 Lite kickback"
		SPB1 49,49,4,2,8,1 ' KB 3 blinks
		L049.timerenabled=False
		KBstatus=1
'		debug.print "kickback ON"

		Scoring 1000,0
	End If

End Sub

Sub pwnMBgo
	SLS(55,1)=2
	SLS(90,1)=1
	pwnageOLD=pwnage-1
	pwnage=100
	pwnMB=1
	pwnMBtimer=15
End Sub


Sub pwn1morelight
	i = int(rnd(1)*3)
	If SC(PN,12+i)<5 Then
		SC(PN,12+i)=SC(PN,12+i)+1
	elseIf SC(PN,13+i)<5 then
		SC(PN,13+i)=SC(PN,13+i)+1
	elseIf SC(PN,14+i)<5 then
		SC(PN,14+i)=SC(PN,14+i)+1
	End If
	SetlightsRedeemer
End Sub


Sub Sw36_hit
	MapBlinker_Timer

	If SLS(48,1)>1 Then
	' turn off enemyflag  l046 1500ms
		L041.timerenabled=True ' delaydsound only here
		SLS(41,1)=0
		If SLS(42,1)=1 Then SLS(42,1)=2
		SLS(48,1)=0
		SLS(63,1)=0
		SLS(70,1)=0
		Addpopup "FLAG","RETURNED",fontbig2

		Scoring 2500,1000


	End If

	SLS(185,2)=33
	PlaySound "AAeliminated", 1, 0.4 * BG_Volume, 0, 0,0,0, 0, 0
	Scoring 50000,1000
End Sub


'**********************************************************************************************************
'*  DRAIN  *
'**********************************************************************************************************

Dim lostballs  ' for multiball to end need to loose 3

Dim Respawnextrawait
Dim RespawnWaiting,RespawnT1
Sub Respawntimer_Timer ' 600 mSwcopy

	
'	if RespawnWaiting>0 then  debug.print "R_wait=" & RespawnWaiting

	If RespawnWaiting>0 And Respawnextrawait=1 Then
		If autokick=1 Then
			Respawnextrawait=0
			If RespawnT1=0 Then ' always wait 1200ms max
				RespawnT1=1
			ElseIf RespawnT1=1 Then
				RespawnT1=2
			Else
				RespawnT1=0
'				NExtBallGO=1
				RespawnWaiting=RespawnWaiting-1
				If RespawnWaiting>0 Then  PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease


				
				Gunflash_Timer
				Ballrelease.createball
				BallRelease.kick 0,int(rnd(1)*3)+35
				SPBallup 35,12,2  ' speed up, lightstayontime, blinks

				SPB1 100,100,5,2,0,1
'E117 2 autolaunch/lauchbutton Fire
				DOF 117,2
'				If DOFdebug=1 Then debug.print "DOF 117,2 EnforcerFire"
				PlaySound "Aenforcerfire", 0, 0.8 * BG_Volume, 0, 0.25
				SPB1 75,77,5,2,0,1
				L076.timerenabled=True
			End If
		Else
			plungertoolong.enabled=True
			DOF 114,1
'			If DOFdebug=1 Then debug.print "DOF 114,1 LaunchReady"

			
		End If
	End If

	If RespawnWaiting>0 Then Respawnextrawait=1

End Sub

Sub Trigger002_Hit
	activeball.z=128
	activeball.vely=-41
End Sub
Sub Trigger003_Hit
	activeball.z=218
End Sub
Sub Trigger004_Hit
	activeball.z=205
	activeball.y=200
	activeball.x=416
End Sub

Dim DrainmsCounter
Sub Drain_moresound_Timer
	DrainmsCounter=DrainmsCounter+1
	PlaySoundAtLevelStatic ("Drain_" & Int(Rnd*11)+1), DrainSoundLevel/(DrainmsCounter+2), drain
	PlaySoundAtLevelStatic ("Metal_Touch_" & Int(Rnd*13)+1), DrainSoundLevel/(DrainmsCounter+2), drain
	If DrainmsCounter = 4 Then DrainmsCounter=0 : Drain_moresound.enabled=False
End Sub

dim pwnagemultiball
dim StopAddingPlayers
Sub Drain_hit
		'E119 2 drain Hit
		'E120 2 ballsaved
		DOF 119,2
'		If DOFdebug=1 Then debug.print "DOF 119,2 Drain_Hit"
		Drain_moresound.enabled=True : DrainmsCounter=2
		RandomSoundDrain(drain)
		Drain.destroyball
		If startgame<>1 Then exit Sub
		For i = 179 to 190
			SLS(i,2)=33 ' blink GI
		Next
		If Tilted>0 Then L063.timerenabled=False : SLS(63,1)=0 : Respawn=0

		If Respawn>0 Then
			RespawnWaiting=RespawnWaiting+1
			PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease

			DOF 151,2 
'			If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"
			PlaySound "AARespawn", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
			If MBactive=0 Then respawning=1 ' Addpopup "RESPAWN","RESPAWN",fontbig1
			DOF 120,2
'			If DOFdebug=1 Then debug.print "DOF 120,2 BALLSAVED"
		ElseIf pwnagemultiball>0 Then
			pwnagemultiball=pwnagemultiball-1
			if pwnagemultiball<1 Then pwnagemultiball=0
		ElseIf MBActive=1 Then

			If tilted=0 Then PlaySound "AARespawn", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
			lostballs=lostballs+1

			If lostballs=2 Then
				'If SLS(65,1)=1 Then SLS(65,1)=2 : SLS(66,1)=2
				lostballs=0 ' must reset
				MBActive=0	' turn off multiball
				DOF 144,0 
	'			If DOFdebug=1 Then debug.print "DOF 144,0 multiball off"
				'E144 multiball
	
				SLS(45,1)=0 ' sniperspot offset
				If Tilted=0 Then
					SPB1 45,45,3,2,1,1 ' blinkit 3 times
					For i = 179 to 190
						SLS(i,2)=200 ' extra blinking GI
					Next
				End If
				SC(PN,18)=0 ' reset needed lights for starting lock again 
				SC(PN,17)=0 ' reset lockedballs
			End If

		Else
			Stoptilt=1
			If pwnJP=1 Then pwnJPCounter=3000
			If pwnMB=1 Then pwnMBCounter=3000 '  turns it off 
			AutoKick=0

			If tilted=0 Then PlaySound "AAfailed", 1, 0.27 * BG_Volume, 0, 0,0,0, 0, 0


			SavePlayerLights ' oofc this had to be moved in before urning everything off :P

			for i = 0 to 178 ' last ball out put all lights off for a few seconds ' probably done a few times too many but just o be sure one more for it needs to go dark
				SLS(i,1)=0
				SLS(i,5)=0 
			Next
			SLS(100,1)=1 ' plungerRed always on
			for i = 179 to 190 
				SLS(i,1)=0
				SLS(i,2)=0
			Next

			If Tilted=0 Then BonusTime_Timer 
			showRampEB=0
			DrainmsCounter=0
			SPB1 1,139,3,1,0,1
		End If

End Sub
Dim stoptilt



'**********************************************************************************************************
'* BUMPERS *
'**********************************************************************************************************
' obsolete ... not used anymore, moved to fade routine

'Sub L60a_Timer ' BUMPER1
'	If L60a.timerenabled=False Then
'		L60a.timerenabled=True
'		L60a.uservalue=0
'		If startgame>0 Then Bumper1cap.Z = 81.2
'	Else
'		i = L60a.uservalue
'		If startgame>0 Then Bumper1cap.Z = 81.2-i*0.2
'		Select Case i
'			Case 0 : L60a.intensity=7  : L60b.intensity=11 : Bumper1cap.blenddisablelighting=1   : If superbumpers>15 Then  L60c.intensity=25 
'			Case 1 : L60a.intensity=14 : L60b.intensity=22 : Bumper1cap.blenddisablelighting=2   : If superbumpers>15 Then  L60c.intensity=55 
'			Case 2 : L60a.intensity=12 : L60b.intensity=18 : Bumper1cap.blenddisablelighting=1.5 : If superbumpers>15 Then  L60c.intensity=40 
'			Case 3 : L60a.intensity=8  : L60b.intensity=11 : Bumper1cap.blenddisablelighting=1   : If superbumpers>15 Then  L60c.intensity=25 
'			Case 4 : L60a.intensity=4  : L60b.intensity=6  : Bumper1cap.blenddisablelighting=0.7 : If superbumpers>15 Then  L60c.intensity=12 
'			Case 5 : L60a.intensity=2  : L60b.intensity=3  : Bumper1cap.blenddisablelighting=0.3 : If superbumpers>15 Then  L60c.intensity=6 
'			Case 6 : L60a.intensity=0.5  : L60b.intensity=0.5  : Bumper1cap.blenddisablelighting=0   : L60c.intensity=0.5 
'					 L60a.timerenabled=False
'		End Select
'		L60a.uservalue=i+1
'		if i>5 Then L60a.timerenabled=False
'	End If
'End Sub
'Sub L34a_Timer ' BUMPER2
'	If L34a.timerenabled=False Then
'		L34a.timerenabled=True
'		L34a.uservalue=0
'		If startgame>0 Then Bumper2cap.Z = 81.2
'	Else
'		i = L34a.uservalue
'		If startgame>0 Then Bumper2cap.Z = 81.2-i*0.2
'		Select Case i
'			Case 0 : L34a.intensity=7  : L34b.intensity=11 : Bumper2cap.blenddisablelighting=1: If superbumpers>15 Then  L34c.intensity=25 
'			Case 1 : L34a.intensity=14 : L34b.intensity=22 : Bumper2cap.blenddisablelighting=2: If superbumpers>15 Then  L34c.intensity=50 
'			Case 2 : L34a.intensity=12 : L34b.intensity=18 : Bumper2cap.blenddisablelighting=1.5: If superbumpers>15 Then  L34c.intensity=40 
'			Case 3 : L34a.intensity=8  : L34b.intensity=11 : Bumper2cap.blenddisablelighting=1: If superbumpers>15 Then  L34c.intensity=25 
'		Case 4 : L34a.intensity=4  : L34b.intensity=6  : Bumper2cap.blenddisablelighting=0.7: If superbumpers>15 Then  L34c.intensity=12 
'			Case 5 : L34a.intensity=2  : L34b.intensity=3  : Bumper2cap.blenddisablelighting=0.3: If superbumpers>15 Then  L34c.intensity=6 
'			Case 6 : L34a.intensity=0.5  : L34b.intensity=0.5: Bumper2cap.blenddisablelighting=0:  L34C.intensity=0.5 
'					 
'		End Select
'		L34a.uservalue=i+1
'		if i>5 Then L34a.timerenabled=False
'	End If
'End Sub
'Sub L61a_Timer ' BUMPER1
'	If L61a.timerenabled=False Then
'		L61a.timerenabled=True
'		L61a.uservalue=0
'		If startgame>0 Then Bumper3cap.Z = 81.2
'	Else
'		i = L61a.uservalue
'		If startgame>0 Then Bumper3cap.Z = 81.2-i*0.2
'		Select Case i
'			Case 0 : L61a.intensity=7  : L61b.intensity=11 : Bumper3cap.blenddisablelighting=1: If superbumpers>15 Then  L61c.intensity=25 
'			Case 1 : L61a.intensity=14 : L61b.intensity=22 : Bumper3cap.blenddisablelighting=2: If superbumpers>15 Then  L61c.intensity=50 
'			Case 2 : L61a.intensity=12 : L61b.intensity=18 : Bumper3cap.blenddisablelighting=1.5: If superbumpers>15 Then  L61c.intensity=40 
'			Case 3 : L61a.intensity=8  : L61b.intensity=11 : Bumper3cap.blenddisablelighting=1: If superbumpers>15 Then  L61c.intensity=25 
'			Case 4 : L61a.intensity=4  : L61b.intensity=6  : Bumper3cap.blenddisablelighting=0.7: If superbumpers>15 Then  L61c.intensity=12 
'			Case 5 : L61a.intensity=2  : L61b.intensity=3  : Bumper3cap.blenddisablelighting=0.3: If superbumpers>15 Then  L61c.intensity=6 
'			Case 6 : L61a.intensity=0.5  : L61b.intensity=0.5  : Bumper3cap.blenddisablelighting=0: L61c.intensity=0.5
'					 
'		End Select
'		L61a.uservalue=i+1
'		if i>5 Then L61a.timerenabled=False
'	End If
'End Sub



'**********************************************************************************************************
'* LOCK BALLS *
'**********************************************************************************************************
Dim Kickr5

Sub Kicker005_Timer
	If Kickr5=100 Then
		Kickr5=0 
		If SLS(67,1)>0 Or SLS(65,1)>0 Then DividerWall1_Timer
	End If
	If kickr5>0 Then
		Dividerwall1.timerenabled=False
		Dividerwall0.timerenabled=False
		DividerWall0_Timer
		Kickr5=Kickr5-1
		If Kickr5<1 Then
			Kickr5=100
		End If
		kicker005.createball
		kicker005.kick 89,30
	End If
End Sub

Sub LockThisBall1_Timer
'	SPB1 1,139,3,12,0,1 ' megablinks

	LockThisBall1.enabled=False
	SC(PN,17)=SC(PN,17)+1 

	If SC(PN,17)=2 Then
		Locked2=1
		teamplaydelay.enabled=True
	Else
		addpopup "CONTROLPOINT","2 SECURE",fontbig3
	End If

	Kickr5=Kickr5+1
	SPBblueside 

	SoundSaucerKick 1, kicker001
	Lockingthisball=1
	PlaySound "searchdestroy" & int(rnd(1)*2)+1 , 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
End Sub

Dim Lockingthisball1b

Sub LockThisBall1b_Timer
'	SPB1 1,139,3,12,0,1 ' megablinks


	LockThisBall1b.enabled=False
	SC(PN,17)=SC(PN,17)+1 

	If SC(PN,17)=2 Then
		Locked2=1
		teamplaydelay.enabled=True
	Else
		addpopup "CONTROLPOINT","2 SECURE",fontbig3
	End If

	Kickr5=Kickr5+1
	SPBblueside 

	SoundSaucerKick 1, kicker001
	Lockingthisball1b=1
	PlaySound "searchdestroy" & int(rnd(1)*2)+1 , 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
End Sub


Dim Lockingthisball2

Sub LockThisBalL2_Timer
'	SPB1 1,139,3,12,0,1 ' megablinks
	LockThisBall2.enabled=False
	SC(PN,17)=SC(PN,17)+1 
	If SC(PN,17)=2 Then
		Locked2=1
		teamplaydelay.enabled=True
	Else
		addpopup "CONTROLPOINT","2 SECURE",fontbig3
	End If

	TOPVUK.destroyball
	Kickr5=Kickr5+1

	SPBblueside 

	SoundSaucerKick 1, kicker001

	Lockingthisball2=1
	PlaySound "searchdestroy" & int(rnd(1)*2)+1 , 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
End Sub

Dim Lockingthisball2b
Sub LockThisBalL2b_Timer
'	SPB1 1,139,3,12,0,1 ' megablinks
	LockThisBall2b.enabled=False
	SC(PN,17)=SC(PN,17)+1 
	If SC(PN,17)=2 Then
		Locked2=1
		teamplaydelay.enabled=True
	Else
		addpopup "CONTROLPOINT","2 SECURE",fontbig3
	End If

	TOPVUK.destroyball
	Kickr5=Kickr5+1

	SPBblueside 

	SoundSaucerKick 1, kicker001

	Lockingthisball2b=1
	PlaySound "searchdestroy" & int(rnd(1)*2)+1 , 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
End Sub


Sub teamplaydelay_Timer

	teamplaydelay.enabled=False

	Addpopup "TEAMPLAY","IS READY",fontbig3
	Objlevel(4) = 1 : Flasherflash4_Timer
	Objlevel(5) = 1 : Flasherflash5_Timer
	playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0

	DOF 156,2
	'turn off 2 locklights and start last one in kiicker 3
	SLS(65,1)=0
	SLS(66,1)=0
	SPB1 65,66,3,2,1,1  ' blinks,timer,special off after done
	SLS(68,1)=2 '  last for multiball set ! kicker 3?
End Sub

' wait for this before knocking out from ballrelease
Dim Lockingthisball



Sub sw003_hit
	moverampBlue.uservalue=0
	moverampBlue.enabled=True

	megapulsedir=1 : megapulsepos=-1
	MegaPulse.Enabled=True



	If Lockingthisball2=1 Then
		Lockingthisball2=0
		

		If pwnagemultiball=0 Then
			AutoKick=0
			Skillshotactive=1
		End If
		RespawnWaiting=RespawnWaiting+1
		PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease

		DOF 151,2 
'		If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"
		L062.timerenabled=False
		L062_Timer
'		RandomSoundBallRelease(BallRelease)
		PlaySound "AARespawn", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "READY SET GO","READY SET GO",fontbig1
	End If

	If Lockingthisball2b=1 Then
		Lockingthisball2b=0
		
		If pwnagemultiball=0 Then
			AutoKick=0
			Skillshotactive=1
		End If
		RespawnWaiting=RespawnWaiting+1
		PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease

		DOF 151,2 
'		If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"
		L062.timerenabled=False
		L062_Timer
'		RandomSoundBallRelease(BallRelease)
		PlaySound "AARespawn", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "READY SET GO","READY SET GO",fontbig1
	End If

	If Lockingthisball=1 Then
		Lockingthisball=0
		
		If pwnagemultiball=0 Then
			AutoKick=0
			Skillshotactive=1
		End If
		RespawnWaiting=RespawnWaiting+1
		PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease

		DOF 151,2 
'		If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"
		L062.timerenabled=False
		L062_Timer
'		RandomSoundBallRelease(BallRelease)
		PlaySound "AARespawn", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "READY SET GO","READY SET GO",fontbig1
	End If

	If Lockingthisball1b=1 Then
		Lockingthisball1b=0
		
		If pwnagemultiball=0 Then
			AutoKick=0
			Skillshotactive=1
		End If
		RespawnWaiting=RespawnWaiting+1
		PlaySoundAtLevelStatic ("KickerKick"), 1, BallRelease

		DOF 151,2 
'		If DOFdebug=1 Then debug.print "DOF 151,2 ballrelease"
		L062.timerenabled=False
		L062_Timer
'		RandomSoundBallRelease(BallRelease)
		PlaySound "AARespawn", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "READY SET GO","READY SET GO",fontbig1
	End If

End Sub



Sub L044_Timer
	L044.timerenabled=False
	SLS(44,1)=0
	FastFrags=0 '  turn off mmmonsterkill
	FFlevel=0
End Sub


Sub sw001_Hit
	If startgame=2 Then EXIT Sub

	If locked1>0 or Locked2>0 Then
			LockBolt1.Z=140
			LockBolt1.collidable=True
'			debug.print "BOLT UP ball goes over bolt"

	End If
End Sub



'**********************************************************************************************************
'* BUMPERS *
'**********************************************************************************************************
'E105 2 top bumper left ( blue )
'E106 2 top bumper center ( red )
'E107 2 top bumper right ( yellow )
Sub Bumper1_Hit
	spb2 184,184,1,0,0,1
	SparkyObjectX=bumper1.x
	SparkyObjectY=bumper1.y+15
	SetSparks
	VRBGFLBump


	TargetBouncer2 activeball,0.8

	If SC(PN,34)=1 Then ' ROC On
		If SC(PN,35)=4 Then '  mission 4
			SC(PN,40)=SC(PN,40)+1 '  add to flag counter
			If SC(PN,40) >= SC(PN,36)*20 Then ' next level
				Scoring SC(PN,36)*2000000,100000
				RocReward = formatscore(FFTscore)  ' / 20 !!! face give *20 : champtext2
				SC(PN,35)=5 ' nextlevel on
				SC(PN,40)=0
			End If
		End If
	End If


	DOF 105,2
'	If DOFdebug=1 Then debug.print "DOF 105,2 bumper1left"

	If Tilted=0 Then

		If superbumpers>15 Then
			Scoring 4000,100
			BumpOn1=20
		Else
			Scoring 400,0 
			BumpOn1=10
		End If

		MapBlinker_Timer 
		RandomSoundBumperTop Bumper1

		StopSound "Blade_Travel"
		PlaySound "Blade_Travel", 1, 0.08 * BG_Volume, 0, 0,0,0, 0, 0
		SPB2 101,101,1,0,0,1
		Bumper1Cap.uservalue=1
		SLS(179,2)=33 ' blink middletopgi  1 solid blink ``?

	End If
End Sub

Dim BumpSpeed1, BumpOn1
Sub	L60a_Timer
	If BumpOn1>0 Then
		BumpOn1=BumpOn1-1
		BumpSpeed1=BumpSpeed1+0.75
'		If BumpSpeed1>20 Then BumpSpeed1=20
	End If
	If BumpSpeed1>0 Then
		BumpSpeed1=BumpSpeed1*0.98
		Bumper1Cap.RotY= (Bumper1Cap.RotY+BumpSpeed1 mod 360)
		If BumpSpeed1<0.6 Then
			BumpSpeed1=0
			PlaySound "Blade_Ric", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
			Bumper1Cap.RotY=Bumper1Cap.RotY-2
		End If
	End If
End Sub

Dim BumpSpeed2, BumpOn2
Sub	L34a_Timer
	If BumpOn2>0 Then
		BumpOn2=BumpOn2-1
		BumpSpeed2=BumpSpeed2+0.75
'		If BumpSpeed2>20 Then BupSpeed2=20
	End If
	If BumpSpeed2>0 Then
		BumpSpeed2=BumpSpeed2*0.98
		Bumper2Cap.RotY= (Bumper2Cap.RotY+BumpSpeed2 mod 360)
		If BumpSpeed2<0.6 Then
			BumpSpeed2=0
			PlaySound "Blade_Ric", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
			Bumper2Cap.RotY=Bumper2Cap.RotY-2
		End If
	End If
End Sub

Dim BumpSpeed3, BumpOn3
Sub	L61a_Timer
	If BumpOn3>0 Then
		BumpOn3=BumpOn3-1
		BumpSpeed3=BumpSpeed3+0.75
'		If BumpSpeed3>20 Then BumpSpeed3=20
	End If
	If BumpSpeed3>0 Then
		BumpSpeed3=BumpSpeed3*0.98
		Bumper3Cap.RotY= (Bumper3Cap.RotY+BumpSpeed3 mod 360)
		If BumpSpeed3<0.6 Then
			BumpSpeed3=0
			PlaySound "Blade_Ric", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
			Bumper3Cap.RotY=Bumper3Cap.RotY-2
		End If
	End If
End Sub






Sub Bumper2_Hit
	spb2 184,184,1,0,0,1

	SparkyObjectX=bumper3.x
	SparkyObjectY=bumper3.y+15
	SetSparks
	VRBGFLBump

	TargetBouncer2 activeball,0.8
	If SC(PN,34)=1 Then ' ROC On
		If SC(PN,35)=4 Then '  mission 4
			SC(PN,40)=SC(PN,40)+1 '  add to flag counter
			If SC(PN,40) >= SC(PN,36)*20 Then ' next level
				Scoring SC(PN,36)*2000000,100000
				RocReward = formatscore(FFTscore)  ' / 20 !!! face give *20 : champtext2
				SC(PN,35)=5 ' nextlevel on
				SC(PN,40)=0
			End If
		End If
	End If

	DOF 107,2
'	If DOFdebug=1 Then debug.print "DOF 107,2 bumper3right"
	If Tilted=0 Then

		If superbumpers>15 Then
			Scoring 4000,100
			BumpOn2=20
		Else
			Scoring 400,0 
			BumpOn2=10
		End If 

		MapBlinker_Timer 
		RandomSoundBumperMiddle Bumper2
		StopSound "Blade_Travel"
		PlaySound "Blade_Travel", 1, 0.08 * BG_Volume, 0, 0,0,0, 0, 0
		SPB2 102,102,1,0,0,1
		Bumper2Cap.uservalue=1

		SLS(179,2)=33 ' blink middletopgi  1 solid blink ``?

	End If
End Sub

Sub Bumper3_Hit
	spb2 184,184,1,0,0,1

	SparkyObjectX=bumper3.x
	SparkyObjectY=bumper3.y+15
	SetSparks
	VRBGFLBump

	TargetBouncer2 activeball,0.8
	If SC(PN,34)=1 Then ' ROC On
		If SC(PN,35)=4 Then '  mission 4
			SC(PN,40)=SC(PN,40)+1 '  add to flag counter
			If SC(PN,40) >= SC(PN,36)*20 Then ' next level
				Scoring SC(PN,36)*2000000,100000
				RocReward = formatscore(FFTscore)  ' / 20 !!! face give *20 : champtext2
				SC(PN,35)=5 ' nextlevel on
				SC(PN,40)=0
			End If
		End If
	End If

	DOF 106,2
'	If DOFdebug=1 Then debug.print "DOF 106,2 bumper1bottom"
	If Tilted=0 Then
			If superbumpers>15 Then
			Scoring 4000,100
			BumpOn3=20
		Else
			Scoring 400,0 
			BumpOn3=10
		End If

		MapBlinker_Timer 
		RandomSoundBumperBottom Bumper3
		StopSound "Blade_Travel"
		PlaySound "Blade_Travel", 1, 0.08 * BG_Volume, 0, 0,0,0, 0, 0
		SPB2 103,103,1,0,0,1
		Bumper3Cap.uservalue=1

		SLS(179,2)=33 ' blink middletopgi  1 solid blink ``?

	End If
End Sub



'**********************************************************************************************************
'* SPINNERS *
'**********************************************************************************************************


Sub Sw47_Spin


	If SC(PN,34)=1 Then ' ROC On
		If SC(PN,35)=3 Then '  mission 3
			SC(PN,39)=SC(PN,39)+1 '  add to flag counter
			If SC(PN,39) >= SC(PN,36)*50 Then ' next level
				Scoring SC(PN,36)*1500000,75000
				RocReward = formatscore(FFTscore)  ' / 20 !!! face give *20 : champtext2
				SC(PN,35)=4 ' nextlevel on
				SC(PN,39)=0
				SC(PN,40)=0
			End If
		End If
	End If




'	E121 2 Left Spinner 
'	E122 2 Right spinner
	DOF 121,2
'	If DOFdebug=1 Then debug.print "DOF 121,2 left spinner"
	PlaySound "fx_spinner"
	l27a.uservalue=0
	L27a_timer
	If Superspi>0 Then scoring 4000,100 : Else : 	Scoring 400,0 
End sub



Sub Sw48_Spin

	If SC(PN,34)=1 Then ' ROC On
		If SC(PN,35)=3 Then '  mission 3
			SC(PN,39)=SC(PN,39)+1 '  add to flag counter
			If SC(PN,39) >= SC(PN,36)*50 Then ' next level
				Scoring SC(PN,36)*1500000,75000
				RocReward = formatscore(FFTscore)  ' / 20 !!! face give *20 : champtext2
				SC(PN,35)=4 ' nextlevel on
				SC(PN,39)=0
				SC(PN,40)=0
			End If
		End If
	End If



	DOF 122,2
'	If DOFdebug=1 Then debug.print "DOF 122,2 Right spinner"
	PlaySound "fx_spinner"
	l27b.uservalue=0
	L27b_Timer
	If Superspi>0 Then scoring  4000,100 : Else : 	Scoring 400,0 
 End sub

Sub L27a_timer
	If l27a.timerenabled=False Then l27a.timerenabled=True
	i=l27a.uservalue
	Select Case i
		Case 0 : l27a.intensity=12 : flasher27a.opacity=600  : Redbasesign.blenddisablelighting=0.5 + cabimage/29 : RedBaseLight.blenddisablelighting=4
		Case 1 : l27a.intensity=20 : flasher27a.opacity=1000 : Redbasesign.blenddisablelighting=1   + cabimage/29   : RedBaseLight.blenddisablelighting=8
		Case 2 : l27a.intensity=17 : flasher27a.opacity=800  : Redbasesign.blenddisablelighting=0.8 + cabimage/29 : RedBaseLight.blenddisablelighting=7
		Case 3 : l27a.intensity=14 : flasher27a.opacity=600  : Redbasesign.blenddisablelighting=0.6 + cabimage/29 : RedBaseLight.blenddisablelighting=5
		Case 4 : l27a.intensity=11 : flasher27a.opacity=400  : Redbasesign.blenddisablelighting=0.4 + cabimage/29 : RedBaseLight.blenddisablelighting=3
		Case 5 : l27a.intensity=8  : flasher27a.opacity=300  : Redbasesign.blenddisablelighting=0.2 + cabimage/29: RedBaseLight.blenddisablelighting=2
		Case 6 : l27a.intensity=4  : flasher27a.opacity=200  : Redbasesign.blenddisablelighting=0.1 + cabimage/29 : RedBaseLight.blenddisablelighting=1
		Case 7 : l27a.intensity=0  : flasher27a.opacity=0    : Redbasesign.blenddisablelighting=cabimage/29  : RedBaseLight.blenddisablelighting=0
				l27a.timerenabled=False
	End Select
	l27a.uservalue=i+1
End Sub
L27a_timer
L27b_timer
Sub L27b_timer
	If l27b.timerenabled=False Then l27b.timerenabled=True
		i=l27b.uservalue
		Select Case i
			Case 0 : l27b.intensity=17 : flasher27b.opacity=800  : Bluebasesign.blenddisablelighting=1   + cabimage/19  : BlueBaseLight.blenddisablelighting=5
			Case 1 : l27b.intensity=30 : flasher27b.opacity=1600 : Bluebasesign.blenddisablelighting=2   + cabimage/19  : BlueBaseLight.blenddisablelighting=10
			Case 2 : l27b.intensity=25 : flasher27b.opacity=1300 : Bluebasesign.blenddisablelighting=1.6 + cabimage/19: BlueBaseLight.blenddisablelighting=7
			Case 3 : l27b.intensity=20 : flasher27b.opacity=1000 : Bluebasesign.blenddisablelighting=1.2 + cabimage/19: BlueBaseLight.blenddisablelighting=5
			Case 4 : l27b.intensity=15 : flasher27b.opacity=700  : Bluebasesign.blenddisablelighting=0.8 + cabimage/19: BlueBaseLight.blenddisablelighting=3
			Case 5 : l27b.intensity=10 : flasher27b.opacity=400  : Bluebasesign.blenddisablelighting=0.4 + cabimage/19: BlueBaseLight.blenddisablelighting=2
			Case 6 : l27b.intensity=5  : flasher27b.opacity=200  : Bluebasesign.blenddisablelighting=0.2 + cabimage/19: BlueBaseLight.blenddisablelighting=1
			Case 7 : l27b.intensity=0  : flasher27b.opacity=0    : Bluebasesign.blenddisablelighting=cabimage/19: BlueBaseLight.blenddisablelighting=0
					l27b.timerenabled=False
		End Select
		l27b.uservalue=i+1
End Sub


'**********************************************************************************************************
'* RESPAWN TIMER 1000ms *
'**********************************************************************************************************


Dim Respawn
Sub L064_Timer

	If pwnJP>0 And pwnJPTimer>0 Then
		pwnJPTimer=pwnJPTimer-1
		spb2 45,45,5,0,0,1
	End If

	If pwnMB>0 And pwnMBTimer>0 Then
		pwnMBTimer=pwnMBTimer-1
		SLS(183,2)=30
		spb2 86,86,5,0,0,1
	End If

'	if respawn>0 then Debug.print "RESPAWNTIMER " & Respawn

	If LFinfo>0 Then LFinfo=LFinfo+1
	If RFinfo>0 Then RFinfo=RFinfo+1
	If LFinfo=0 And RFinfo=0 Then Flippinfo=0
'	If LFinfo>5 Or RFinfo>5 Then FLipperInfo

	Respawn=Respawn-1

	If tilted=0 Then
		Select case Respawn
			case  1 : SLS(120,1)=0 : 
			case  2 : SLS(121,1)=0 : SPB1 120,120,3,0,0,1
			case  3 : SLS(122,1)=0 : SPB1 121,121,3,0,0,1
			case  4 : SLS(123,1)=0 : SPB1 122,122,3,0,0,1
			case  5 : SLS(124,1)=0 : SPB1 123,123,3,0,0,1
			case  6 : SLS(125,1)=0 : SPB1 124,124,3,0,0,1
			case  7 : SLS(126,1)=0 : SPB1 125,125,3,0,0,1
			case  8 : SLS(127,1)=0 : SPB1 126,126,3,0,0,1
			case  9 : SLS(128,1)=0 : SPB1 127,127,3,0,0,1
			case 10 : For i = 129 to 139 : SLS(i,1)=0 : Next : SPB1 128,128,3,0,0,1  ' special for the doubletrouble thatonly add 11
			case 11 : SLS(130,1)=0 : SPB1 129,129,3,0,0,1
			case 12 : SLS(131,1)=0 : SPB1 130,130,3,0,0,1
			case 13 : SLS(132,1)=0 : SPB1 131,131,3,0,0,1
			case 14 : SLS(133,1)=0 : SPB1 132,132,3,0,0,1
			case 15 : SLS(134,1)=0 : SPB1 133,133,3,0,0,1
			case 16 : SLS(135,1)=0 : SPB1 134,134,3,0,0,1
			case 17 : SLS(136,1)=0 : SPB1 135,135,3,0,0,1
			case 18 : SLS(137,1)=0 : SPB1 136,136,3,0,0,1
			case 19 : SLS(138,1)=0 : SPB1 136,136,3,0,0,1 : SLS(139,1)=0
			case 20 : SLS(139,1)=0 : SPB1 136,136,3,0,0,1
		end Select
	End If

	If respawn<=0 Then
		respawn=0
'		L064.timerenabled=False
		SLS(64,1)=0 ' respawn off
'		If extraball=2 Then SLS(64,1)=1
	End If

End Sub




'**********************************************************************************************************
'*  Coin Booster
'**********************************************************************************************************

Dim AlphaAndOmega, lastAO
Sub coinextra_timer
	If AlphaAndOmega>99 Then
		AlphaAndOmega=0
		coinextra.enabled=False
		Exit Sub
	ElseIf AlphaAndOmega>19 Then
		AlphaAndOmega=AlphaAndOmega+1
		If AlphaAndOmega=25 Then
			PlaySound "gotit", 1, BG_Volume, 0,0,0,0,0,0 	
			AlphaAndOmega=100
		End If
		Exit Sub
	ElseIf AlphaAndOmega>1 Then
		AlphaAndOmega=20
		PlaySound "boom", 1, BG_Volume, 0,0,0,0,0,0 
		Exit Sub
	End If

	i=int(rnd(1)*6)
	If i = lastAO Then i=i+1 : if i=6 then i=0
	Select Case i
		case 0 : lastAO=0 : PlaySound "charlie", 1, BG_Volume, 0,0,0,0,0,0 
		case 1 : lastAO=1 :  PlaySound "zulu", 1, BG_Volume, 0,0,0,0,0,0 
		case 2 : lastAO=2 :  PlaySound "tango", 1, BG_Volume, 0,0,0,0,0,0 
		case 3 : lastAO=3 :  PlaySound "romeo", 1, BG_Volume, 0,0,0,0,0,0 
		case 4 : lastAO=4 :  PlaySound "baker", 1, BG_Volume, 0,0,0,0,0,0 
		case 5 : lastAO=5 :  PlaySound "victor", 1, BG_Volume, 0,0,0,0,0,0 
	End Select
	AlphaAndOmega=AlphaAndOmega-1
	If AlphaAndOmega<1 Then AlphaAndOmega=0 : coinextra.enabled=False
End Sub

Sub PlayersExtra_Timer
	If MaxPlayers=2 Then PlaySound "dm_2", 1, BG_Volume, 0,0,0,0,0,0
	If MaxPlayers=3 Then PlaySound "dm_3", 1, BG_Volume, 0,0,0,0,0,0
	If MaxPlayers=4 Then PlaySound "dm_4", 1, BG_Volume, 0,0,0,0,0,0
	PlayersExtra.enabled=False
End Sub



'**********************************************************************************************************
'*  KEYS / Flippers *
'**********************************************************************************************************

Sub Table1_KeyDown(ByVal KeyCode)

	If SNAKEGAMEON=1 Then
'		debug.print "snakedir" & SnakeDir
		If keycode = LeftFlipperKey And Snakeintro=1 Then Snakespeed=Snakespeed-1 : playSound "drip0" & int(Rnd(1)*7)+1 , 1, BG_Volume*0.57, 0,0,0,0,0,0 : If snakespeed<2 Then snakespeed=2
		If keycode = RightFlipperKey And Snakeintro=1 Then Snakespeed=Snakespeed+1 : playSound "drip0" & int(Rnd(1)*7)+1 , 1, BG_Volume*0.57, 0,0,0,0,0,0 : If snakespeed>20 Then snakespeed=20
		If keycode = LeftFlipperKey And Snakeintro=0 Then SnakeDir=SnakeDir-1 : playSound "drip0" & int(Rnd(1)*7)+1 , 1, BG_Volume*0.57, 0,0,0,0,0,0 : If SnakeDir<0 Then SnakeDir=3
		If keycode = RightFlipperKey And Snakeintro=0 Then SnakeDir=SnakeDir+1 : playSound "drip0" & int(Rnd(1)*7)+1 , 1, BG_Volume*0.57, 0,0,0,0,0,0 : If SnakeDir>3 Then SnakeDir=0
		If keycode = PlungerKey And Snakeintro=1 Then SNAKEGAMEON=0 : CreateIntroVideo2 : FoggymcFoggerson=1
		If keycode = StartGameKey And SnakeIntro=1 Then	snakelength=10 : SnakeHideIntro 
		Exit Sub
	End If 
	If DMDmode = 4 And Frame<770 Then
		If keycode = LeftFlipperKey or keycode = RightFlipperKey Then Frame = 770
	End If


	If keycode = 19 then ScoreCard=1 : CardTimer.enabled=True

	If keycode = PlungerKey Then

		If DMDmode=2 Then snakelength=0 : CreateSnakeDMD : Exit Sub

		If AutoKick=0 and RespawnWaiting>0 and gamereadytostart>1 Then
			NewPlayerNewBall=2
			AutoKick=1
			SPB2 201,202,1,0,0,1
			L061.timerenabled=False
			L061.timerenabled=True ' activate Skillshotturnoff 2500ms
			Skillshotactive=1
			Gunflash_Timer
			RespawnWaiting=RespawnWaiting-1
			BallRelease.createball
			BallRelease.kick 0,int(rnd(1)*3)+35

				Stoptilt=0

			SPBallup 40,10,1  ' speed up, lightstayontime, blinks
			plungertoolong.enabled=False
			DOF 117,2
'			If DOFdebug=1 Then debug.print "DOF 117,2 EnforcerFire"
			DOF 114,0
'			If DOFdebug=1 Then debug.print "DOF 114,0 AutoLaunchOn"
			PlaySound "Aenforcerfire", 0, 0.8 * BG_Volume, 0, 0.25
			SPB1 75,77,5,2,0,1
			L076.timerenabled=True
			Respawn=Respawn+15 ' L064   ' respawn timer on each plunger that is not autokicker
			SPB1 120,139,5,0,3,1
			For i = 0 to 19
					If respawn-1 > i Then  SLS(120+i,1)=1
			Next
			SLS(64,1)=2 ' respawn blinks
			SLS(64,3)=6
			L064.timerenabled=True
			'startlastcountdown if it was turned off somewhere
			If SC(pn,33)>999 Then
				lastcd=SC(PN,33)-1000
				SC(pn,33)=0
'				debug.print "lastcountdownreset " & lastcd & "sec left P" & PN 
				countdown30.enabled=True
			End If
			ProgressBarReset
		Else
			PlaySound "AEmptyGun", 0, 0.8 * BG_Volume, 0, 0.25
		End If
	End If


	If keycode = StartGameKey And checkHS>8 Then

		If Startgame>0 And LFinfo>1 And Stoptilt=0 Then   ' LF down 1 sec
			'If leftis down then gameover here
			tiltedwait.enabled=True
			RampEB=0
			EXTRAEXTRALIFE=0
			Extraball=0
			Ballinplay=3
			PN=4
			StopTilt=1
			TiltGame
			Exit Sub
		End If


		soundStartButton()
		If credits>0 and gamereadytostart>0 Then
			if gamereadytostart<2 then gamereadytostart=2 
			If startgame=0 Then
				startgame=1
				SPB2 201,202,7,0,0,1
				Objlevel(5) = 1 : Flasherflash5_Timer
				Objlevel(4) = 1 : Flasherflash5_Timer
				playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0
				DOF 156,2
				GameOverTimer.enabled=False
				Attract1.enabled=False
				SPB1 1,139,4,3,0,1 ' megablinks

				DOF 115,0
'				If DOFdebug=1 Then debug.print "DOF 115,0 StartbuttonOff"
				Credits=Credits-1
				PlaySound "dm_1", 1, BG_Volume, 0,0,0,0,0,0

'				GAMESTARTER
				GamesPlayd=GamesPlayd+1		
				DOF 116,2
'				If DOFdebug=1 Then debug.print "DOF 116,2 Gamestarted"

			Else
				If ballinplay=1 And StopAddingPlayers=0 Then  ' more players
					Maxplayers=MaxPlayers+1 
					GamesPlayd=GamesPlayd+1		
					If MaxPlayers>4 Then
						MaxPlayers=4
					Else
						Objlevel(5) = 1 : Flasherflash5_Timer
						Objlevel(4) = 1 : Flasherflash5_Timer
						playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.15, 0,0,0,0,0,0
						DOF 156,2

						Addpopup "PLAYERS = " & MaxPlayers,"PLAYERS = " & MaxPlayers,fontbig1
						PlaySound "Ric" & Int(rnd(1)*3)+1, 0, 0.9 * BG_Volume, 0, 0.25
						Credits=Credits-1
						PlayersExtra.enabled=True
						SPB2 201,202,3,0,0,1
					End If

				End If

			End If
		Else
			PlaySound "call4", 0, 0.8 * BG_Volume, 0, 0.25
		End If
	End If

	If autokick=1 And Tilted=0 and BonusTime.enabled=False And GunFL=0 Then  
		If keycode = LeftTiltKey   Then Nudge  90, 5 : SoundNudgeLeft()   : Tilting 
		If keycode = RightTiltKey  Then Nudge 270, 5 : SoundNudgeRight()  : Tilting
		If keycode = CenterTiltKey Then Nudge   0, 3 : SoundNudgeCenter() : Tilting
		If keycode = MechanicalTilt Then SoundNudgeCenter() : Tilting	
	End If

    If keycode = AddCreditKey or keycode = AddCreditKey2 Then

		AlphaAndOmega=AlphaAndOmega+1
		coinextra.enabled=True
		SPB2 201,202,3,0,0,1
		DOF 127,2 
'		If DOFdebug=1 Then debug.print "DOF 127,2 add credits"
		Credits=Credits+1
		If credits>30 Then Credits=30 Else For i = 179 to 190 : SLS(i,2)=28 : Next
		Select Case Int(rnd*3)
			Case 0: PlaySound ("Coin_In_1"), 0, CoinSoundLevel, 0, 0.25
			Case 1: PlaySound ("Coin_In_2"), 0, CoinSoundLevel, 0, 0.25
			Case 2: PlaySound ("Coin_In_3"), 0, CoinSoundLevel, 0, 0.25
		End Select
	End If

	If Tilted=0 And Startgame=1 Then
		'nFozzy begin
		If keycode = LeftFlipperKey Then

'			debug.print "LFpos " & LeftFlipper.currentangle

			If LeftFlipper.currentangle > 110 Then Lflipperflash=0.5
			LFinfo=1
			DOF 101,1
'			If DOFdebug=1 Then debug.print "DOF 101,1 leftflipperdown"
			'E101 0/1 LeftFlipper
			'E102 0/1 RightFlipper
			FlipperActivate LeftFlipper, LFPress
			LF.fire 'LeftFlipper.RotateToEnd
			If leftflipper.currentangle < leftflipper.endangle + ReflipAngle Then 
				RandomSoundReflipUpLeft LeftFlipper
			Else 
				SoundFlipperUpAttackLeft LeftFlipper
				RandomSoundFlipperUpLeft LeftFlipper
			End If 

			If VRRoom >0 and VRRoom <3 then
			VRFlipperLeft.x = VRFlipperLeft.x + 6
			End If

		End If

		If keycode = RightFlipperKey Then
'			debug.print "RFpos " & RightFlipper.currentangle
			If RightFlipper.currentangle <-110 Then Rflipperflash=0.5
			RFinfo=1
			DOF 102,1
'			If DOFdebug=1 Then debug.print "DOF 102,1 rightflipperdown"
			FlipperActivate RightFlipper, RFPress
			RF.fire 'RightFlipper.RotateToEnd
			If RightFlipper.currentangle > RightFlipper.endangle - ReflipAngle Then 
				RandomSoundReflipUpRight RightFlipper
			Else 
				SoundFlipperUpAttackRight RightFlipper
				RandomSoundFlipperUpRight RightFlipper
			End If 

			If VRRoom >0 and VRRoom <3 then
			VRFlipperRight.x = VRFlipperRight.x - 6
			End If


		End If
	End If
	'nFozzy finish
End Sub




'*******************
'*****  KEY UP *****
'*******************

Dim LFinfo,RFinfo
Sub Table1_KeyUp(ByVal KeyCode)
	If SNAKEGAMEON=1 then Exit Sub

	if keycode = 19 then ScoreCard=0

	If Tilted=0 Then

		If keycode= leftmagnasave Then

			SPB1 120,139,5,0,4,1

			If startgame>0 Then
				SPB1 86,86,2,5,0,1
				MusicON  ' just random music
				Team(PN)=Team(PN)+1
				If Team(PN)>3 Then Team(PN)=0
				SetTeamColors
				RedDisplay SC(PN,28)
				BlueDisplay SC(PN,29)
			Else
				If DisableLUTchanges=0 Then
					LUTSet = LUTSet  - 1
					if LutSet < 0 then LUTSet = 14
					SetLUT
					ShowLUT
					playsound "bird" & Int(Rnd(1)*7)+1
				End If
			End If
		End If


		If keycode= rightmagnasave Then

			SPB1 139,120,5,0,4,1

			If startgame>0 Then
				SC(PN,20)=SC(PN,20)+1 ' tauting ingame 	
				If SC(PN,20)=4 Then SC(PN,20)=0
				Taunt(PN)=SC(PN,20)
				Taunting.enabled=True ' on first, cause we dont want delay here
				Taunting_Timer
			Else
				If DisableLUTchanges=0 Then
					LUTSet = LUTSet  + 1
					if LutSet > 14 then LUTSet = 0
					SetLUT
					ShowLUT
					playsound "bird" & Int(Rnd(1)*7)+1
				End If
			End If
		End If


		'nFozzy begin
		If Startgame=1 Then
			If keycode = LeftFlipperKey Then
				LFinfo=0

				DOF 101,0
'				If DOFdebug=1 Then debug.print "DOF 101,0 leftflipperup"

				TempNr=SC(PN,2)' swapping bonuslights at top when releasing flippers
				SC(PN,2)= SC(PN,3)
				SC(PN,3)= SC(PN,4)
				SC(PN,4)=tempnr
				MultiplyerUpdate 


				FlipperDeActivate LeftFlipper, LFPress
				LeftFlipper.RotateToStart
				If LeftFlipper.currentangle < LeftFlipper.startAngle - 5 Then
					RandomSoundFlipperDownLeft LeftFlipper
				End If
				FlipperLeftHitParm = FlipperUpSoundLevel


			If VRRoom >0 and VRRoom <3 then
			VRFlipperLeft.x = VRFlipperLeft.x - 6
			End If


			End If


			If keycode = RightFlipperKey Then
				RFinfo=0
				DOF 102,0
'				If DOFdebug=1 Then debug.print "DOF 102,0 rightflipperup"

				TempNr=SC(PN,4)' swapping bonuslights at top when releasing flippers
				SC(PN,4)=SC(PN,3)
				SC(PN,3)=SC(PN,2)
				SC(PN,2)=tempnr
				MultiplyerUpdate 

				FlipperDeActivate RightFlipper, RFPress
				RightFlipper.RotateToStart
				If RightFlipper.currentangle > RightFlipper.startAngle + 5 Then
					RandomSoundFlipperDownRight RightFlipper
				End If
				FlipperRightHitParm = FlipperUpSoundLevel


			If VRRoom >0 and VRRoom <3 then
			VRFlipperRight.x = VRFlipperRight.x + 6
			End If


			End If
				'nFozzy finish
		End If

	End If ' end if tilted=0


	If checkHS>0 and checkHS<9 Then   'fixign  enterinitial status
		If keycode = LeftFlipperKey Then
			playSound "drip0" & int(Rnd(1)*7)+1 , 1, BG_Volume*0.57, 0,0,0,0,0,0
			EnterCurrent=EnterCurrent-1
			If EnterCurrent<1 Then EnterCurrent=37
			
		End If
		If keycode = RightFlipperKey Then
			playSound "drip0" & int(Rnd(1)*7)+1 , 1, BG_Volume*0.57, 0,0,0,0,0,0
			EnterCurrent=EnterCurrent+1
			If EnterCurrent>37 Then EnterCurrent=1
		End If
		If keycode = StartGameKey and EnterCurrent>0 Then
			If len(EnteredName)<3 Then
				playSound "AABigselect" , 1, BG_Volume*0.57, 0,0,0,0,0,0
				EnteredName=EnteredName+ mid ( "ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789",EnterCurrent,1)
			End If 
		End If
	End If
End Sub


Dim plungershake
Sub L076_Timer
	If Gunshake=1 Then
		plungershake=plungershake+1

		select case plungershake
			case 1 : Nudge 0,4
			case 2 : Nudge 0,2
			case 3 : Nudge 0,1 : L076.timerenabled=False : plungershake=0
		End Select
	Else
		L076.timerenabled=False
	End If
End Sub





'Bonus lights at Top
Sub sw41_unhit
	MapBlinker_Timer 
	Scoring 200,0 

	If SC(PN,2)=0 Then
		SC(PN,2)=1
		PlaySound "AANewBeep", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
	Else
		PlaySound "AAAmmoPick", 1, 0.3 * BG_Volume, 0, 0,0,0, 0, 0
	End If
	' special blink state on these
	MultiplyerUpdate
	SLS(12,5)=3 : SLS(12,10)=45   ' 2 ON NORMAL 3 ON SPECIAL OVERRIDE

End Sub
Sub sw42_unhit
	MapBlinker_Timer 
	Scoring 200,0 

	If SC(PN,3)=0 Then
		SC(PN,3)=1
		PlaySound "AANewBeep", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
	Else
		PlaySound "AAAmmoPick", 1, 0.3 * BG_Volume, 0, 0,0,0, 0, 0
	End If
	MultiplyerUpdate
		SLS(13,5)=3 : SLS(13,10)=45

End Sub
Sub sw43_unhit
	MapBlinker_Timer 
	Scoring 200,0 

	If SC(PN,4)=0 Then
		SC(PN,4)=1
		PlaySound "AANewBeep", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
	Else
		PlaySound "AAAmmoPick", 1, 0.3 * BG_Volume, 0, 0,0,0, 0, 0
	End If
	MultiplyerUpdate
		SLS(14,5)=3 : SLS(14,10)=45
End Sub

Sub MultiplyerUpdate 
	SLS(12,1)=SC(PN,2) 
	SLS(13,1)=SC(PN,3)
	SLS(14,1)=SC(PN,4)
	' check for all 3 and add multiplyer
	If SC(PN,2)=1 And SC(PN,3)=1 And SC(PN,4)=1 Then
		SPB1 12,14,10,1,1,1
		SPB1 104,107,3,2,3,1
		SPB2 2,6,7,0,0,1

		SC(PN,2) = 0
		SC(PN,3) = 0
		SC(PN,4) = 0
		SLS(12,1)=0
		SLS(13,1)=0
		SLS(14,1)=0
		SLS(12,5)=3 : SLS(12,10)=45
		SLS(13,5)=3 : SLS(13,10)=45
		SLS(14,5)=3 : SLS(14,10)=45
		
		SC(PN,11) = SC(PN,11)+1
		If SC(PN,11)>5 Then 
			SC(PN,11)=5  '  reward for extra bonus !!!! 
			PlaySound "proceed", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
			scoring 50000,1000
			FFT=FFTscore
			Addpopup "MULTI BONUS", FormatScore(FFT),fontbig1


		Else
			PlaySound "nicecatch", 1, 0.8 * BG_Volume, 0, 0,0,0, 0, 0
			If SC(PN,11) = 1 Then Addpopup "BONUS X 2","BONUS X 2",fontbig1
			If SC(PN,11) = 2 Then Addpopup "BONUS X 3","BONUS X 3",fontbig1
			If SC(PN,11) = 3 Then Addpopup "BONUS X 4","BONUS X 4",fontbig1
			If SC(PN,11) = 4 Then Addpopup "BONUS X 6","BONUS X 6",fontbig1
			If SC(PN,11) = 5 Then Addpopup "BONUS X 8","BONUS X 8",fontbig1
			scoring 5000,500
		End If

							SLS(2,1)=2 : SLS(2,9)=7
		If SC(PN,11)>1 Then SLS(3,1)=2 : SLS(3,9)=7
		If SC(PN,11)>2 Then SLS(4,1)=2 : SLS(4,9)=7
		If SC(PN,11)>3 Then SLS(5,1)=2 : SLS(5,9)=7
		If SC(PN,11)>4 Then SLS(6,1)=2 : SLS(6,9)=7


	End If	
End Sub





' #####################################
' ###### Fluppers Domes V2.2 #####
' #####################################



Dim TestFlashers, TableRef, FlasherLightIntensity, FlasherFlareIntensity, FlasherBloomIntensity, FlasherOffBrightness

								' *********************************************************************
TestFlashers = 0				' *** set this to 1 to check position of flasher object 			***
Set TableRef = Table1   		' *** change this, if your table has another name       			***
FlasherLightIntensity = 0.25	' *** lower this, if the VPX lights are too bright (i.e. 0.1)		***
FlasherFlareIntensity = 0.9		' *** lower this, if the flares are too bright (i.e. 0.1)			***
FlasherBloomIntensity = 0.9
FlasherOffBrightness = 0.5		' *** brightness of the flasher dome when switched off (range 0-2)	***
								' *********************************************************************

Dim ObjLevel(20), objbase(20), objlit(20), objflasher(20), objbloom(20), objlight(20)
Dim tablewidth, tableheight : tablewidth = TableRef.width : tableheight = TableRef.height
'initialise the flasher color, you can only choose from "green", "red", "purple", "blue", "white" and "yellow"
InitFlasher 1, "red" : 
InitFlasher 2, "red" : 
InitFlasher 3, "blue"
InitFlasher 4, "white" : 
InitFlasher 5, "white" : 
'InitFlasher 6, "blue"
InitFlasher 7, "red" : 
InitFlasher 8, "blue"
InitFlasher 9, "blue" : 
'InitFlasher 10, "red"
'InitFlasher 11, "white"

Sub InitFlasher(nr, col)
	' store all objects in an array for use in FlashFlasher subroutine
	Set objbase(nr) = Eval("Flasherbase" & nr) : Set objlit(nr) = Eval("Flasherlit" & nr)
	Set objflasher(nr) = Eval("Flasherflash" & nr) : Set objlight(nr) = Eval("Flasherlight" & nr)
	Set objbloom(nr) = Eval("Flasherbloom" & nr)
	' If the flasher is parallel to the playfield, rotate the VPX flasher object for POV and place it at the correct height
	If objbase(nr).RotY = 0 Then
		objbase(nr).ObjRotZ =  atn( (tablewidth/2 - objbase(nr).x) / (objbase(nr).y - tableheight*1.1)) * 180 / 3.14159
		objflasher(nr).RotZ = objbase(nr).ObjRotZ : objflasher(nr).height = objbase(nr).z + 60
	End If
	' set all effects to invisible and move the lit primitive at the same position and rotation as the base primitive
	objlight(nr).IntensityScale = 0 : objlit(nr).visible = 0 : objlit(nr).material = "Flashermaterial" & nr
	objlit(nr).RotX = objbase(nr).RotX : objlit(nr).RotY = objbase(nr).RotY : objlit(nr).RotZ = objbase(nr).RotZ
	objlit(nr).ObjRotX = objbase(nr).ObjRotX : objlit(nr).ObjRotY = objbase(nr).ObjRotY : objlit(nr).ObjRotZ = objbase(nr).ObjRotZ
	objlit(nr).x = objbase(nr).x : objlit(nr).y = objbase(nr).y : objlit(nr).z = objbase(nr).z
	objbase(nr).BlendDisableLighting = FlasherOffBrightness
	' set the texture and color of all objects
	select case objbase(nr).image
		Case "dome2basewhite" : objbase(nr).image = "dome2base" & col : objlit(nr).image = "dome2lit" & col : 
		Case "ronddomebasewhite" : objbase(nr).image = "ronddomebase" & col : objlit(nr).image = "ronddomelit" & col
		Case "domeearbasewhite" : objbase(nr).image = "domeearbase" & col : objlit(nr).image = "domeearlit" & col
	end select
	If TestFlashers = 0 Then objflasher(nr).imageA = "domeflashwhite" : objflasher(nr).visible = 0 : End If
	select case col
		Case "blue" :  objflasher(nr).imageA = "domeblueflash" :  objlight(nr).color = RGB(4,120,255) : objflasher(nr).color = RGB(200,255,255) : objlight(nr).intensity = 5000
		Case "green" :  objlight(nr).color = RGB(12,255,4) : objflasher(nr).color = RGB(12,255,4)
		Case "red" : objflasher(nr).imageA = "domeredflash" :  objlight(nr).color = RGB(255,32,4) : objflasher(nr).color = RGB(255,32,4): objlight(nr).intensity = 3900
		Case "purple" : objlight(nr).color = RGB(230,49,255) : objflasher(nr).color = RGB(255,64,255) 
		Case "yellow" : objlight(nr).color = RGB(200,173,25) : objflasher(nr).color = RGB(255,200,50)
		Case "white" :  objlight(nr).color = RGB(255,240,150) : objflasher(nr).color = RGB(100,86,59)
	end select
	objlight(nr).colorfull = objlight(nr).color
	If TableRef.ShowDT and ObjFlasher(nr).RotX = -45 Then 
		objflasher(nr).height = objflasher(nr).height - 20 * ObjFlasher(nr).y / tableheight
		ObjFlasher(nr).y = ObjFlasher(nr).y + 10
	End If
End Sub

Sub RotateFlasher(nr, angle) : angle = ((angle + 360 - objbase(nr).ObjRotZ) mod 180)/30 : objbase(nr).showframe(angle) : objlit(nr).showframe(angle) : End Sub

Sub FlashFlasher(nr)
	
	If not objflasher(nr).TimerEnabled Then 
		objflasher(nr).TimerEnabled = True
		objflasher(nr).visible = 1
		objbloom(nr).visible = 1
		objlit(nr).visible = 1
	End If
	Select case nr
		Case 1:
			If VRRoom > 0 and VRRoom < 3 Then
				If startgame = 0 Then
					VRBGFL1_1.visible = 0 'red low
					VRBGFL1_2.visible = 0
					VRBGFL1_3.visible = 0
					VRBGFL1_4.visible = 0
					VRBGFL1_5.visible = 0
				Else
					VRBGFL1_1.visible = 1 'red low
					VRBGFL1_2.visible = 1
					VRBGFL1_3.visible = 1
					VRBGFL1_4.visible = 1
					VRBGFL1_5.visible = 1
				End If
			End If
		Case 2:
			If VRRoom > 0 and VRRoom < 3 Then
				VRBGFL2_1.visible = 1 ' red mid
				VRBGFL2_2.visible = 1
				VRBGFL2_3.visible = 1
				VRBGFL2_4.visible = 1
				VRBGFL2_5.visible = 1
			End If
		Case 3:
			If VRRoom > 0 and VRRoom < 3 Then
				If startgame = 0 Then
					VRBGFL3_1.visible = 0 'blue mid
					VRBGFL3_2.visible = 0
					VRBGFL3_3.visible = 0
					VRBGFL3_4.visible = 0
					VRBGFL3_5.visible = 0
				Else
					VRBGFL3_1.visible = 1 'blue mid
					VRBGFL3_2.visible = 1
					VRBGFL3_3.visible = 1
					VRBGFL3_4.visible = 1
					VRBGFL3_5.visible = 1
				End If
			End If
		Case 4:
			If VRRoom > 0 and VRRoom < 3 Then
				VRBGFL4_1.visible = 1 'White
				VRBGFL4_2.visible = 1
				VRBGFL4_3.visible = 1
				VRBGFL4_4.visible = 1
				VRBGFL4_5.visible = 1
				VRBGFL4_6.visible = 1
				VRBGFL4_7.visible = 1
			End If
		Case 7:
			If VRRoom > 0 and VRRoom < 3 Then
				VRBGFL7_1.visible = 1 'face
				VRBGFL7_2.visible = 1
				VRBGFL7_3.visible = 1
				VRBGFL7_4.visible = 1
			End If
		Case 8:
			If VRRoom > 0 and VRRoom < 3 Then
				VRBGFL8_1.visible = 1 'blue low
				VRBGFL8_2.visible = 1
				VRBGFL8_3.visible = 1
				VRBGFL8_4.visible = 1
				VRBGFL8_5.visible = 1
			End If
	End Select
	objflasher(nr).opacity = 1000 *  FlasherFlareIntensity * ObjLevel(nr)^2.5
	objbloom(nr).opacity = 100 *  FlasherBloomIntensity * ObjLevel(nr)^2.5
	objlight(nr).IntensityScale = 0.5 * FlasherLightIntensity * ObjLevel(nr)^3
	objbase(nr).BlendDisableLighting =  FlasherOffBrightness + 50 * ObjLevel(nr)^3	
	objlit(nr).BlendDisableLighting = 50 * ObjLevel(nr)^2

'*** Ramp flash with color flashers   blue=prim034   red=prim062
	If nr=3 or nr=8 or nr=9 Then Pflash34=6 * ObjLevel(nr)^2 
	If nr=1 or nr=2 or nr=7 Then Pflash62=4 * ObjLevel(nr)^2 
'  primitive034.BlendDisableLighting=2 * ObjLevel(nr)^2 : primitive129.BlendDisableLighting=7* ObjLevel(nr)^2+cabimage/10
' primitive062.BlendDisableLighting=4 * ObjLevel(nr)^2 : primitive130.BlendDisableLighting=12 * ObjLevel(nr)^2+cabimage/5
	If nr=4 Then cab.BlendDisableLighting=0.5+ObjLevel(nr)^2*2

	UpdateMaterial "Flashermaterial" & nr,0,0,0,0,0,0,ObjLevel(nr),RGB(255,255,255),0,0,False,True,0,0,0,0 
	ObjLevel(nr) = ObjLevel(nr) * 0.8 - 0.01
	select case nr
		Case 1:
			If VRRoom > 0 and VRRoom < 3 Then
				VRBGFL1_1.opacity = 100 * ObjLevel(nr)^3
				VRBGFL1_2.opacity = 100 * ObjLevel(nr)^3
				VRBGFL1_3.opacity = 100 * ObjLevel(nr)^3
				VRBGFL1_4.opacity = 100 * ObjLevel(nr)^3
				VRBGFL1_5.opacity = 100 * ObjLevel(nr)^3
			End If
		Case 2:
			If VRRoom > 0 and VRRoom < 3 Then
				VRBGFL2_1.opacity = 100 * ObjLevel(nr)^3
				VRBGFL2_2.opacity = 100 * ObjLevel(nr)^3
				VRBGFL2_3.opacity = 100 * ObjLevel(nr)^3
				VRBGFL2_4.opacity = 100 * ObjLevel(nr)^3
				VRBGFL2_5.opacity = 100 * ObjLevel(nr)^3
			End If
		Case 3:
			If VRRoom > 0 and VRRoom < 3 Then
				VRBGFL3_1.opacity = 100 * ObjLevel(nr)^3
				VRBGFL3_2.opacity = 100 * ObjLevel(nr)^3
				VRBGFL3_3.opacity = 100 * ObjLevel(nr)^3
				VRBGFL3_4.opacity = 100 * ObjLevel(nr)^3
				VRBGFL3_5.opacity = 100 * ObjLevel(nr)^3
			End If
		Case 4:
			If VRRoom > 0 and VRRoom < 3 Then
				VRBGFL4_1.opacity = 100 * ObjLevel(nr)^2
				VRBGFL4_2.opacity = 100 * ObjLevel(nr)^2
				VRBGFL4_3.opacity = 100 * ObjLevel(nr)^2
				VRBGFL4_4.opacity = 100 * ObjLevel(nr)^2
				VRBGFL4_5.opacity = 100 * ObjLevel(nr)^2
				VRBGFL4_6.opacity = 100 * ObjLevel(nr)^2
				VRBGFL4_7.opacity = 100 * ObjLevel(nr)^2
			End If
		Case 7:
			If VRRoom > 0 and VRRoom < 3 Then
				VRBGFL7_1.opacity = 100 * ObjLevel(nr)^3
				VRBGFL7_2.opacity = 100 * ObjLevel(nr)^3
				VRBGFL7_3.opacity = 100 * ObjLevel(nr)^3
				VRBGFL7_4.opacity = 100 * ObjLevel(nr)^3
			End If
		Case 8:
			If VRRoom > 0 and VRRoom < 3 Then
				VRBGFL8_1.opacity = 100 * ObjLevel(nr)^3
				VRBGFL8_2.opacity = 100 * ObjLevel(nr)^3
				VRBGFL8_3.opacity = 100 * ObjLevel(nr)^3
				VRBGFL8_4.opacity = 100 * ObjLevel(nr)^3
				VRBGFL8_5.opacity = 100 * ObjLevel(nr)^3
			End If
	End Select

	If ObjLevel(nr) < 0 Then
		objflasher(nr).TimerEnabled = False
		objflasher(nr).visible = 0
		objbloom(nr).visible = 0
		objlit(nr).visible = 0
		select case nr
			Case 1:
				If VRRoom > 0 and VRRoom < 3 Then
					VRBGFL1_1.visible = 0
					VRBGFL1_2.visible = 0
					VRBGFL1_3.visible = 0
					VRBGFL1_4.visible = 0
					VRBGFL1_5.visible = 0
				End If
			Case 2:
				If VRRoom > 0 and VRRoom < 3 Then
					VRBGFL2_1.visible = 0
					VRBGFL2_2.visible = 0
					VRBGFL2_3.visible = 0
					VRBGFL2_4.visible = 0
					VRBGFL2_5.visible = 0
				End If
			Case 3:
				If VRRoom > 0 and VRRoom < 3 Then
					VRBGFL3_1.visible = 0
					VRBGFL3_2.visible = 0
					VRBGFL3_3.visible = 0
					VRBGFL3_4.visible = 0
					VRBGFL3_5.visible = 0
				End If
			Case 4:
				If VRRoom > 0 and VRRoom < 3 Then
					VRBGFL4_1.visible = 0
					VRBGFL4_2.visible = 0
					VRBGFL4_3.visible = 0
					VRBGFL4_4.visible = 0
					VRBGFL4_5.visible = 0
					VRBGFL4_6.visible = 0
					VRBGFL4_7.visible = 0
				End If
			Case 7:
			If VRRoom > 0 and VRRoom < 3 Then
					VRBGFL7_1.visible = 0
					VRBGFL7_2.visible = 0
					VRBGFL7_3.visible = 0
					VRBGFL7_4.visible = 0
				End If
			Case 8:
				If VRRoom > 0 and VRRoom < 3 Then
					VRBGFL8_1.visible = 0
					VRBGFL8_2.visible = 0
					VRBGFL8_3.visible = 0
					VRBGFL8_4.visible = 0
					VRBGFL8_5.visible = 0
				End If
		End Select
	End If
End Sub


Sub FlashFlasher5(nr)
	If not objflasher(nr).TimerEnabled Then objflasher(nr).TimerEnabled = True :  objbloom(nr).visible = 1 : Light001.state=1 : End If
	objbloom(nr).opacity = 100 *  FlasherBloomIntensity * ObjLevel(nr)^2.5
	objlight(nr).IntensityScale = 0.5 * FlasherLightIntensity * ObjLevel(nr)^3
	ObjLevel(nr) = ObjLevel(nr) * 0.93- 0.01
	Light001.Intensity = ObjLevel(nr)^2
	Primitive126.blenddisablelighting=0.07 * (cabimage-1 + cab3blend/20)+ObjLevel(nr)^2*2
	If ObjLevel(nr) < 0 Then
		objflasher(nr).TimerEnabled = False : objbloom(nr).visible = 0 : Light001.state=0 : Light002.state=0
	End If
End Sub

Sub FlasherFlash1_Timer() : FlashFlasher(1) : End Sub 
Sub FlasherFlash2_Timer() : FlashFlasher(2) : End Sub 
Sub FlasherFlash3_Timer() : FlashFlasher(3) : End Sub 
Sub FlasherFlash4_Timer() : FlashFlasher(4) : End Sub 
Sub FlasherFlash5_Timer() : FlashFlasher5(5) : End Sub 
Sub FlasherFlash6_Timer() : FlashFlasher(6) : End Sub 
Sub FlasherFlash7_Timer() : FlashFlasher(7) : End Sub
Sub FlasherFlash8_Timer() : FlashFlasher(8) : End Sub
Sub FlasherFlash9_Timer() : FlashFlasher(9) : End Sub
Sub FlasherFlash10_Timer() : FlashFlasher(10) : End Sub
Sub FlasherFlash11_Timer() : FlashFlasher(11) : End Sub

'**********Sling Shot Animations
' Rstep and Lstep  are the variables that increment the animation
'****************
Dim RStep, Lstep
Rstep=14
Lstep=14

Sub RightSlingShot_Slingshot
	SparkyObjectX=SLING1.x-25
	SparkyObjectY=sLING1.y
	SetSparks

	TargetBouncer2 activeball,0.7
	Objlevel(5) = 1 : Flasherflash5_Timer

	If SC(pn,13)>0 Then	SPB2 7,6+SC(pn,13),2,0,0,1


'	E103 2 Leftslingshot
'	E104 2 Rightslingshot
	DOF 104,2
'	If DOFdebug=1 Then debug.print "DOF 104,2 rightslingshot"
	Scoring 50,0 

	RSling.Visible = 0
	RSling1.Visible = 1
	sling1.rotx = 20
	RStep = 0
	RightSlingShot.TimerEnabled = True
	Primitive131.TransY= -7
	Primitive082.TransZ= -7

	If Tilted=0 Then
		
		SLS(58,1)=0
		SLS(57,1)=1
		SPB1 57,57,2,2,1,1

		ownage=ownage+1
		If ownage>2 Then
			ownage=0
			SLS(46,1)=2

 			If SLS(90,1)>0 And SLS(96,1)=0 Then
				SLS(90,1)=2 : SPB2 90,90,3,0,0,1
				If SLS(55,1)=0 Then SLS(55,1)=1 : SPB2 55,55,2,0,0,1
			End If

			If SLS(96,1)>0 Then SLS(96,1)=2 : SPB2 96,96,3,0,0,1
			SPB2 46,46,7,0,0,1

		End If

		MapBlinker_Timer 

		Objlevel(8) = 1 : FlasherFlash8_Timer :	playSound "fx_relay", 1,0.2*VolumeDial, AudioPan(Sling1),0,0,0,0, AudioPan(Sling1)
						DOF 108,2 
'						If DOFdebug=1 Then debug.print "DOF 108,2 flasher1"
		RandomSoundSlingshotRight Sling1

		SLS(190,2)=33 : SLS(188,2)=33  ' blink bottom R GI for 33 updates = 1 solid blink ``?

		PlaySound "fx_relay", 1,0.1*VolumeDial,0,0,0,0,0,0	
	End If
End Sub

Sub RightSlingShot_Timer
    Select Case RStep
        Case 3:RSLing1.Visible = 0:RSLing2.Visible = 1:sling1.rotx = 3 : Primitive131.TransY= -3 : Primitive082.TransZ= -3 

        Case 4:RSLing2.Visible = 0:RSLing.Visible = 1:sling1.rotx = 0: Primitive131.TransY= 0 : Primitive082.TransZ= 0
				Primitive131.RotY= -12
		Case 5:  Primitive131.RotY= -8
		Case 6:  Primitive131.RotY= -5
		Case 7:  Primitive131.RotY= -2
		Case 8:  Primitive131.RotY= 1
		Case 9:  Primitive131.RotY= 4
		Case 10:  Primitive131.RotY= 7
		Case 11:  Primitive131.RotY= 6
		Case 12:  Primitive131.RotY= 4
		Case 13:  Primitive131.RotY= 2
		Case 14:  Primitive131.RotY= 0
				RightSlingShot.TimerEnabled = False 


    End Select
    RStep = RStep + 1
End Sub

Sub LeftSlingShot_Slingshot
	SparkyObjectX=SLING2.x+25
	SparkyObjectY=sLING2.y
	SetSparks

	TargetBouncer2 activeball,0.7
	Objlevel(5) = 1 : Flasherflash5_Timer

	If SC(pn,12)>0 Then	SPB2 15,14+SC(pn,12),2,0,0,1

	DOF 103,2
'	If DOFdebug=1 Then debug.print "DOF 103,2 leftslingshot"
	Scoring 50,0 

	LSling.Visible = 0
	LSling1.Visible = 1
	sling2.rotx = 20
	LStep = 0
	LeftSlingShot.TimerEnabled = True

	If Tilted=0 Then

		SLS(58,1)=1
		SLS(57,1)=0
		SPB1 58,58,2,2,1,1

		ownage=ownage+1
		If ownage>2 Then
			ownage=0
			SLS(46,1)=2
 			If SLS(90,1)>0 And SLS(96,1)=0 Then
				SLS(90,1)=2 : SPB2 90,90,3,0,0,1
				If SLS(55,1)=0 Then SLS(55,1)=1 : SPB2 55,55,2,0,0,1
			End If

			If SLS(96,1)>0 Then SLS(96,1)=2 : SPB2 96,96,3,0,0,1
			SPB2 46,46,7,0,0,1
		End If

		MapBlinker_Timer 

		Objlevel(1) = 1 : FlasherFlash1_Timer :	playSound "fx_relay", 1,0.2*VolumeDial, AudioPan(Sling2),0,0,0,0, AudioPan(Sling2)
						DOF 111,2 
'						If DOFdebug=1 Then debug.print "DOF 111,2 flasherR1" 
		RandomSoundSlingshotLeft Sling2

		SLS(190,2)=33 : SLS(187,2)=33  ' blink bottom L GI for 33 updates = 1 solid blink ``?

		LSling.Visible = 0
		LSling1.Visible = 1
		sling2.rotx = 20
		LStep = 0
		LeftSlingShot.TimerEnabled = True
	Primitive149.TransY= -7
	Primitive148.TransZ= -7


	End If
End Sub

Sub LeftSlingShot_Timer
    Select Case LStep

        Case 3:LSLing1.Visible = 0:LSLing2.Visible = 1:sling2.rotx = 10 : Primitive149.TransY= -3 : Primitive148.TransZ= -3 

        Case 4:LSLing2.Visible = 0:LSLing.Visible = 1:sling2.rotx = 0: Primitive149.TransY= 0 : Primitive048.TransZ= 0
				Primitive149.RotY= 12
		Case 5:  Primitive149.RotY= 8
		Case 6:  Primitive149.RotY= 5
		Case 7:  Primitive149.RotY= 2
		Case 8:  Primitive149.RotY= -1
		Case 9:  Primitive149.RotY= -4
		Case 10:  Primitive149.RotY= -7
		Case 11:  Primitive149.RotY= -6
		Case 12:  Primitive149.RotY= -4
		Case 13:  Primitive149.RotY= -2
		Case 14:  Primitive149.RotY= 0
				LeftSlingShot.TimerEnabled = False 


    End Select
    LStep = LStep + 1
End Sub

Sub BallRelease_Hit
	BallRelease.kick 180,10
End Sub


'******************************************************
'		BALL ROLLING AND DROP SOUNDS
'******************************************************
Const tnob = 5
ReDim rolling(tnob)
InitRolling
Dim isBallOnWireRamp : isBallOnWireRamp = False

Dim DropCount
ReDim DropCount(tnob)

Sub InitRolling
	Dim i
	For i = 0 to (tnob)
		rolling(i) = False
	Next
End Sub


Dim ballglow
If BallFlasher<2 then ballglow=Array(Shadow1,Shadow2,Shadow3,Shadow4,Shadow5)
If BallFlasher=2 then ballglow=Array(Shadow001,Shadow002,Shadow003,Shadow004,Shadow005)
If BallFlasher=3 then ballglow=Array(Shadow011,Shadow012,Shadow013,Shadow014,Shadow015)
If BallFlasher>3 then ballglow=Array(Shadow006,Shadow007,Shadow008,Shadow009,Shadow010)


Sub RollingTimer()

	Dim BOT, b
	Dim xx,xxx,xxxx

	BOT = GetBalls
	TiltedBalls = Ubound(BOT)

	' stop the sound of deleted balls
	For b = UBound(BOT) + 1 to tnob-1
		rolling(b) = False
		StopSound "BallRoll_" & b
        StopSound "fx_plasticrolling" & b
		StopSound "fx_metalrolling" & b
		ballglow(b).visible=False
	Next
	' exit the sub if no balls on the table
	If UBound(BOT) = -1 Then 
		If startgame=3 Then RespawnWaiting=0 : Startgame=0
		If credits>0 Then 
				DOF 115,1
'				If DOFdebug=1 Then debug.print "DOF 115,1 Startbuttonready"
		End If
		Exit Sub
	End If

' change ball stuff

	For b = 0 to UBound(BOT)
		
		If BallFlasher>0 Then
			xxxx=1
			xx = BOT(b).x+BOT(b).VelX
			ballglow(b).x=xx
			ballglow(b).y = BOT(b).y+BOT(b).VelY+4
			i= BOT(b).z - 15
			If i > 140 Or i < 9 Then
				i=i+45
				xxxx=0
			ElseIf xx>500 Or xx< 107 Then
				If i>76 Then i=i+45
				xxxx=0
			End If
			ballglow(b).height = i

			xxx= BOT(b).ID
			If xxx <30000 Then						' no color
				xx=165 								' no need to change anything if this is True
			ElseIf xxx<60000 Then		 			' red|
				ballglow(b).color= RGB (233,38,22)
				xx=200
			ElseIf xxx<90000 Then	 				'blue
				ballglow(b).color= RGB (22,38,255)
				xx=215
			ElseIf xxx<120000 Then 					'gold
				ballglow(b).color= RGB (200,180,5)
				xx=155
			Else 									'green
				ballglow(b).color= RGB (22,200,22)
				xx=160
			End If

			If BOT(b).VelZ<1 And i<70 Then
				ballglow(b).opacity=( xx+120+ i )* cabimage *0.12
			Else
				ballglow(b).opacity=( xx + i*2 )* cabimage *0.12
			End If

			i=(BOT(b).z-20)/3
			If i>18 then i=18
			If xxxx=1 Then ballglow(b).RotX = -i Else ballglow(b).RotX = 0
			ballglow(b).visible=True
		End If

		If Bot(b).X>875 And Bot(b).Y>1360 And Bot(b).vely > -2 Then Kicker006.Enabled=True

'		debug.print "BALL X Y Z POS" & BOT(b).x &" "& BOT(b).y &" "& BOT(b).z
		If BOT(b).y > 2060 Then 
			BOT(b).x = 439
			BOT(b).y = 2000
			BOT(b).z = 25
		End If
		If BOT(b).y > 1600 then if BOT(b).velz>10 Then BOT(b).velz=10

		If NormalBalls=0 Then
			If BOT(b).ID<30000 Then
				BOT(b).ID = BOT(b).ID+30000*(Team(PN)+1)
'				debug.print "Ballid" & BOT(b).ID
				If Team(PN)=0 then
					BOT(b).color = RGB (255,48,32)	' Red
				End If
				If Team(PN)=1 then
					BOT(b).color = RGB (32,48,255)	' blue
				End If
				If Team(PN)=2 then
					BOT(b).color = RGB (255,215,10)	' gold
				End If
				If Team(PN)=3 then
					BOT(b).color = RGB (32,255,32)	' green
				End If
			End If
		End If


' play the rolling sound for each ball
			If BallVel(BOT(b)) > 1.5 Then
				rolling(b) = True
				If BOT(b).Z > 28 Then
					' ball on wire ramp
					StopSound "BallRoll_" & b
					StopSound "fx_plasticrolling" & b
'					PlaySound "fx_metalrolling" & b, -1, VolPlayfieldRoll(BOT(b)) * 4 * VolumeDial, AudioPan(BOT(b)), 0, PitchPlayfieldRoll(BOT(b)), 1, 0, AudioFade(BOT(b))
					PlaySound "fx_plasticrolling" & b, -1, VolPlayfieldRoll(BOT(b)) * 18 * VolumeDial, AudioPan(BOT(b)), 0, PitchPlayfieldRoll(BOT(b)), 1, 0, AudioFade(BOT(b))
				Else
					' ball on playfield
					StopSound "fx_plasticrolling" & b
					StopSound "fx_metalrolling" & b
					PlaySound "BallRoll_" & b, -1, VolPlayfieldRoll(BOT(b)) * 2 * VolumeDial, AudioPan(BOT(b)), 0, PitchPlayfieldRoll(BOT(b)), 1, 0, AudioFade(BOT(b))
				End If
			Else
				If rolling(b) = True Then
					StopSound "BallRoll_" & b 
					StopSound "fx_plasticrolling" & b
					StopSound "fx_metalrolling" & b
					rolling(b) = False
				End If
			End If
		
			'***Ball Drop Sounds***
			If BOT(b).VelZ < -1 and BOT(b).z < 55 and BOT(b).z > 27 Then 'height adjust for ball drop sounds
				If DropCount(b) >= 5 Then
					DropCount(b) = 0
					If BOT(b).velz > -7 Then
						RandomSoundBallBouncePlayfieldSoft BOT(b)
					Else
						RandomSoundBallBouncePlayfieldHard BOT(b)
					End If				
				End If
			End If
			If DropCount(b) < 5 Then
				DropCount(b) = DropCount(b) + 1
			End If
	Next
End Sub

Sub Kicker006_Hit
	Kicker006.kick 350,30
	Kicker006.enabled=False
End Sub

'******************************************************
'		FLIPPER CORRECTION INITIALIZATION
'******************************************************

dim LF : Set LF = New FlipperPolarity
dim RF : Set RF = New FlipperPolarity

InitPolarity

Sub InitPolarity()
	dim x, a : a = Array(LF, RF)
	for each x in a
		x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1	'disabled
		x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1
		x.enabled = True
		x.TimeDelay = 60
	Next

	AddPt "Polarity", 0, 0, 0
	AddPt "Polarity", 1, 0.05, -5.5
	AddPt "Polarity", 2, 0.4, -5.5
	AddPt "Polarity", 3, 0.6, -5.0
	AddPt "Polarity", 4, 0.65, -4.5
	AddPt "Polarity", 5, 0.7, -4.0
	AddPt "Polarity", 6, 0.75, -3.5
	AddPt "Polarity", 7, 0.8, -3.0
	AddPt "Polarity", 8, 0.85, -2.5
	AddPt "Polarity", 9, 0.9,-2.0
	AddPt "Polarity", 10, 0.95, -1.5
	AddPt "Polarity", 11, 1, -1.0
	AddPt "Polarity", 12, 1.05, -0.5
	AddPt "Polarity", 13, 1.1, 0
	AddPt "Polarity", 14, 1.3, 0

	addpt "Velocity", 0, 0, 	1
	addpt "Velocity", 1, 0.16, 1.06
	addpt "Velocity", 2, 0.41, 	1.05
	addpt "Velocity", 3, 0.53, 	1'0.982
	addpt "Velocity", 4, 0.702, 0.968
	addpt "Velocity", 5, 0.95,  0.968
	addpt "Velocity", 6, 1.03, 	0.945

	LF.Object = LeftFlipper	
	LF.EndPoint = EndPointLp
	RF.Object = RightFlipper
	RF.EndPoint = EndPointRp
End Sub

Sub TriggerLF_Hit() : LF.Addball activeball : End Sub
Sub TriggerLF_UnHit() : LF.PolarityCorrect activeball : End Sub
Sub TriggerRF_Hit() : RF.Addball activeball : End Sub
Sub TriggerRF_UnHit() : RF.PolarityCorrect activeball : End Sub



'******************************************************
'			FLIPPER CORRECTION FUNCTIONS
'******************************************************

Sub AddPt(aStr, idx, aX, aY)	'debugger wrapper for adjusting flipper script in-game
	dim a : a = Array(LF, RF)
	dim x : for each x in a
		x.addpoint aStr, idx, aX, aY
	Next
End Sub

Class FlipperPolarity
	Public DebugOn, Enabled
	Private FlipAt	'Timer variable (IE 'flip at 723,530ms...)
	Public TimeDelay	'delay before trigger turns off and polarity is disabled TODO set time!
	private Flipper, FlipperStart,FlipperEnd, FlipperEndY, LR, PartialFlipCoef
	Private Balls(20), balldata(20)
	
	dim PolarityIn, PolarityOut
	dim VelocityIn, VelocityOut
	dim YcoefIn, YcoefOut
	Public Sub Class_Initialize 
		redim PolarityIn(0) : redim PolarityOut(0) : redim VelocityIn(0) : redim VelocityOut(0) : redim YcoefIn(0) : redim YcoefOut(0)
		Enabled = True : TimeDelay = 50 : LR = 1:  dim x : for x = 0 to uBound(balls) : balls(x) = Empty : set Balldata(x) = new SpoofBall : next 
	End Sub
	
	Public Property let Object(aInput) : Set Flipper = aInput : StartPoint = Flipper.x : End Property
	Public Property Let StartPoint(aInput) : if IsObject(aInput) then FlipperStart = aInput.x else FlipperStart = aInput : end if : End Property
	Public Property Get StartPoint : StartPoint = FlipperStart : End Property
	Public Property Let EndPoint(aInput) : FlipperEnd = aInput.x: FlipperEndY = aInput.y: End Property
	Public Property Get EndPoint : EndPoint = FlipperEnd : End Property	
	Public Property Get EndPointY: EndPointY = FlipperEndY : End Property
	
	Public Sub AddPoint(aChooseArray, aIDX, aX, aY) 'Index #, X position, (in) y Position (out) 
		Select Case aChooseArray
			case "Polarity" : ShuffleArrays PolarityIn, PolarityOut, 1 : PolarityIn(aIDX) = aX : PolarityOut(aIDX) = aY : ShuffleArrays PolarityIn, PolarityOut, 0
			Case "Velocity" : ShuffleArrays VelocityIn, VelocityOut, 1 :VelocityIn(aIDX) = aX : VelocityOut(aIDX) = aY : ShuffleArrays VelocityIn, VelocityOut, 0
			Case "Ycoef" : ShuffleArrays YcoefIn, YcoefOut, 1 :YcoefIn(aIDX) = aX : YcoefOut(aIDX) = aY : ShuffleArrays YcoefIn, YcoefOut, 0
		End Select
		if gametime > 100 then Report aChooseArray
	End Sub 

	Public Sub Report(aChooseArray) 	'debug, reports all coords in tbPL.text
		if not DebugOn then exit sub
		dim a1, a2 : Select Case aChooseArray
			case "Polarity" : a1 = PolarityIn : a2 = PolarityOut
			Case "Velocity" : a1 = VelocityIn : a2 = VelocityOut
			Case "Ycoef" : a1 = YcoefIn : a2 = YcoefOut 
			case else :tbpl.text = "wrong string" : exit sub
		End Select
		dim str, x : for x = 0 to uBound(a1) : str = str & aChooseArray & " x: " & round(a1(x),4) & ", " & round(a2(x),4) & vbnewline : next
		tbpl.text = str
	End Sub
	
	Public Sub AddBall(aBall) : dim x : for x = 0 to uBound(balls) : if IsEmpty(balls(x)) then set balls(x) = aBall : exit sub :end if : Next  : End Sub

	Private Sub RemoveBall(aBall)
		dim x : for x = 0 to uBound(balls)
			if TypeName(balls(x) ) = "IBall" then 
				if aBall.ID = Balls(x).ID Then
					balls(x) = Empty
					Balldata(x).Reset
				End If
			End If
		Next
	End Sub
	
	Public Sub Fire() 
		Flipper.RotateToEnd
		processballs
	End Sub

	Public Property Get Pos 'returns % position a ball. For debug stuff.
		dim x : for x = 0 to uBound(balls)
			if not IsEmpty(balls(x) ) then
				pos = pSlope(Balls(x).x, FlipperStart, 0, FlipperEnd, 1)
			End If
		Next		
	End Property

	Public Sub ProcessBalls() 'save data of balls in flipper range
		FlipAt = GameTime
		dim x : for x = 0 to uBound(balls)
			if not IsEmpty(balls(x) ) then
				balldata(x).Data = balls(x)
			End If
		Next
		PartialFlipCoef = ((Flipper.StartAngle - Flipper.CurrentAngle) / (Flipper.StartAngle - Flipper.EndAngle))
		PartialFlipCoef = abs(PartialFlipCoef-1)
	End Sub
	Private Function FlipperOn() : if gameTime < FlipAt+TimeDelay then FlipperOn = True : End If : End Function	'Timer shutoff for polaritycorrect
	
	Public Sub PolarityCorrect(aBall)
		if FlipperOn() then 
			dim tmp, BallPos, x, IDX, Ycoef : Ycoef = 1

			'y safety Exit
			if aBall.VelY > -8 then 'ball going down
				RemoveBall aBall
				exit Sub
			end if

			'Find balldata. BallPos = % on Flipper
			for x = 0 to uBound(Balls)
				if aBall.id = BallData(x).id AND not isempty(BallData(x).id) then 
					idx = x
					BallPos = PSlope(BallData(x).x, FlipperStart, 0, FlipperEnd, 1)
					if ballpos > 0.65 then  Ycoef = LinearEnvelope(BallData(x).Y, YcoefIn, YcoefOut)				'find safety coefficient 'ycoef' data
				end if
			Next

			If BallPos = 0 Then 'no ball data meaning the ball is entering and exiting pretty close to the same position, use current values.
				BallPos = PSlope(aBall.x, FlipperStart, 0, FlipperEnd, 1)
				if ballpos > 0.65 then  Ycoef = LinearEnvelope(aBall.Y, YcoefIn, YcoefOut)						'find safety coefficient 'ycoef' data
			End If

			'Velocity correction
			if not IsEmpty(VelocityIn(0) ) then
				Dim VelCoef
	 : 			VelCoef = LinearEnvelope(BallPos, VelocityIn, VelocityOut)

				if partialflipcoef < 1 then VelCoef = PSlope(partialflipcoef, 0, 1, 1, VelCoef)

				if Enabled then aBall.Velx = aBall.Velx*VelCoef
				if Enabled then aBall.Vely = aBall.Vely*VelCoef
			End If

			'Polarity Correction (optional now)
			if not IsEmpty(PolarityIn(0) ) then
				If StartPoint > EndPoint then LR = -1	'Reverse polarity if left flipper
				dim AddX : AddX = LinearEnvelope(BallPos, PolarityIn, PolarityOut) * LR
	
				if Enabled then aBall.VelX = aBall.VelX + 1 * (AddX*ycoef*PartialFlipcoef)
				'playsound "knocker"
			End If
		End If
		RemoveBall aBall
	End Sub
End Class

'******************************************************
'		FLIPPER POLARITY AND RUBBER DAMPENER
'			SUPPORTING FUNCTIONS 
'******************************************************

' Used for flipper correction and rubber dampeners
Sub ShuffleArray(ByRef aArray, byVal offset) 'shuffle 1d array
	dim x, aCount : aCount = 0
	redim a(uBound(aArray) )
	for x = 0 to uBound(aArray)	'Shuffle objects in a temp array
		if not IsEmpty(aArray(x) ) Then
			if IsObject(aArray(x)) then 
				Set a(aCount) = aArray(x)
			Else
				a(aCount) = aArray(x)
			End If
			aCount = aCount + 1
		End If
	Next
	if offset < 0 then offset = 0
	redim aArray(aCount-1+offset)	'Resize original array
	for x = 0 to aCount-1		'set objects back into original array
		if IsObject(a(x)) then 
			Set aArray(x) = a(x)
		Else
			aArray(x) = a(x)
		End If
	Next
End Sub

' Used for flipper correction and rubber dampeners
Sub ShuffleArrays(aArray1, aArray2, offset)
	ShuffleArray aArray1, offset
	ShuffleArray aArray2, offset
End Sub

' Used for flipper correction, rubber dampeners, and drop targets
Function BallSpeed(ball) 'Calculates the ball speed
    BallSpeed = SQR(ball.VelX^2 + ball.VelY^2 + ball.VelZ^2)
End Function

' Used for flipper correction and rubber dampeners
Function PSlope(Input, X1, Y1, X2, Y2)	'Set up line via two points, no clamping. Input X, output Y
	dim x, y, b, m : x = input : m = (Y2 - Y1) / (X2 - X1) : b = Y2 - m*X2
	Y = M*x+b
	PSlope = Y
End Function

' Used for flipper correction
Class spoofball 
	Public X, Y, Z, VelX, VelY, VelZ, ID, Mass, Radius 
	Public Property Let Data(aBall)
		With aBall
			x = .x : y = .y : z = .z : velx = .velx : vely = .vely : velz = .velz
			id = .ID : mass = .mass : radius = .radius
		end with
	End Property
	Public Sub Reset()
		x = Empty : y = Empty : z = Empty  : velx = Empty : vely = Empty : velz = Empty 
		id = Empty : mass = Empty : radius = Empty
	End Sub
End Class

' Used for flipper correction and rubber dampeners
Function LinearEnvelope(xInput, xKeyFrame, yLvl)
	dim y 'Y output
	dim L 'Line
	dim ii : for ii = 1 to uBound(xKeyFrame)	'find active line
		if xInput <= xKeyFrame(ii) then L = ii : exit for : end if
	Next
	if xInput > xKeyFrame(uBound(xKeyFrame) ) then L = uBound(xKeyFrame)	'catch line overrun
	Y = pSlope(xInput, xKeyFrame(L-1), yLvl(L-1), xKeyFrame(L), yLvl(L) )

	if xInput <= xKeyFrame(lBound(xKeyFrame) ) then Y = yLvl(lBound(xKeyFrame) ) 	'Clamp lower
	if xInput >= xKeyFrame(uBound(xKeyFrame) ) then Y = yLvl(uBound(xKeyFrame) )	'Clamp upper

	LinearEnvelope = Y
End Function

' Used for drop targets and flipper tricks
Function Distance(ax,ay,bx,by)
	Distance = SQR((ax - bx)^2 + (ay - by)^2)
End Function


'******************************************************
'			FLIPPER TRICKS
'******************************************************

RightFlipper.timerinterval=1
Rightflipper.timerenabled=True

sub RightFlipper_timer()
	FlipperTricks LeftFlipper, LFPress, LFCount, LFEndAngle, LFState
	FlipperTricks RightFlipper, RFPress, RFCount, RFEndAngle, RFState
	FlipperNudge RightFlipper, RFEndAngle, RFEOSNudge, LeftFlipper, LFEndAngle
	FlipperNudge LeftFlipper, LFEndAngle, LFEOSNudge,  RightFlipper, RFEndAngle
end sub

Dim LFEOSNudge, RFEOSNudge

Sub FlipperNudge(Flipper1, Endangle1, EOSNudge1, Flipper2, EndAngle2)
	Dim BOT, b

	If abs(Flipper1.currentangle) < abs(Endangle1) + 3 and EOSNudge1 <> 1 Then
		EOSNudge1 = 1
		If Flipper2.currentangle = EndAngle2 Then 
			BOT = GetBalls
			For b = 0 to Ubound(BOT)
				If FlipperTrigger(BOT(b).x, BOT(b).y, Flipper1) Then
					'Debug.Print "ball in flip1. exit"
 					exit Sub
				end If
			Next
			For b = 0 to Ubound(BOT)
				If FlipperTrigger(BOT(b).x, BOT(b).y, Flipper2) Then
					'debug.print "flippernudge!!"
					BOT(b).velx = BOT(b).velx /1.5
					BOT(b).vely = BOT(b).vely - 1
				end If
			Next
		End If
	Else 
		If abs(Flipper1.currentangle) > abs(Endangle1) + 30 then EOSNudge1 = 0
	End If
End Sub

'*************************************************
' Check ball distance from Flipper for Rem
'*************************************************

Function Distance(ax,ay,bx,by)
	Distance = SQR((ax - bx)^2 + (ay - by)^2)
End Function

Function DistancePL(px,py,ax,ay,bx,by) ' Distance between a point and a line where point is px,py
	DistancePL = ABS((by - ay)*px - (bx - ax) * py + bx*ay - by*ax)/Distance(ax,ay,bx,by)
End Function

Function Radians(Degrees)
	Radians = Degrees * PI /180
End Function

Function AnglePP(ax,ay,bx,by)
	AnglePP = Atn2((by - ay),(bx - ax))*180/PI
End Function

Function DistanceFromFlipper(ballx, bally, Flipper)
	DistanceFromFlipper = DistancePL(ballx, bally, Flipper.x, Flipper.y, Cos(Radians(Flipper.currentangle+90))+Flipper.x, Sin(Radians(Flipper.currentangle+90))+Flipper.y)
End Function

Function FlipperTrigger(ballx, bally, Flipper)
	Dim DiffAngle
	DiffAngle  = ABS(Flipper.currentangle - AnglePP(Flipper.x, Flipper.y, ballx, bally) - 90)
	If DiffAngle > 180 Then DiffAngle = DiffAngle - 360

	If DistanceFromFlipper(ballx,bally,Flipper) < 48 and DiffAngle <= 90 and Distance(ballx,bally,Flipper.x,Flipper.y) < Flipper.Length Then
		FlipperTrigger = True
	Else
		FlipperTrigger = False
	End If	
End Function

' Used for drop targets and stand up targets
Function Atn2(dy, dx)
	dim pi
	pi = 4*Atn(1)

	If dx > 0 Then
		Atn2 = Atn(dy / dx)
	ElseIf dx < 0 Then
		If dy = 0 Then 
			Atn2 = pi
		Else
			Atn2 = Sgn(dy) * (pi - Atn(Abs(dy / dx)))
		end if
	ElseIf dx = 0 Then
		if dy = 0 Then
			Atn2 = 0
		else
			Atn2 = Sgn(dy) * pi / 2
		end if
	End If
End Function

'*****************
' Maths
'*****************
Const Pi = 3.1415927

Function dSin(degrees)
	dsin = sin(degrees * Pi/180)
End Function

Function dCos(degrees)
	dcos = cos(degrees * Pi/180)
End Function

'*************************************************
' End - Check ball distance from Flipper for Rem
'*************************************************


dim LFPress, RFPress, LFCount, RFCount
dim LFState, RFState
dim EOST, EOSA,Frampup, FElasticity,FReturn
dim RFEndAngle, LFEndAngle

EOST = leftflipper.eostorque
EOSA = leftflipper.eostorqueangle
Frampup = LeftFlipper.rampup
FElasticity = LeftFlipper.elasticity
FReturn = LeftFlipper.return
Const EOSTnew = 0.8 
Const EOSAnew = 1
Const EOSRampup = 0
Dim SOSRampup
SOSRampup = 2.5
Const LiveCatch = 24
Const LiveElasticity = 0.45
Const SOSEM = 0.815
Const EOSReturn = 0.033

LFEndAngle = Leftflipper.endangle
RFEndAngle = RightFlipper.endangle

Sub FlipperActivate(Flipper, FlipperPress)
	FlipperPress = 1
	Flipper.Elasticity = FElasticity

	Flipper.eostorque = EOST 	
	Flipper.eostorqueangle = EOSA 	
End Sub

Sub FlipperDeactivate(Flipper, FlipperPress)
	FlipperPress = 0
	Flipper.eostorqueangle = EOSA
	Flipper.eostorque = EOST*EOSReturn/FReturn

	
	If Abs(Flipper.currentangle) <= Abs(Flipper.endangle) + 0.1 Then
		Dim BOT, b
		BOT = GetBalls
			
		For b = 0 to UBound(BOT)
			If Distance(BOT(b).x, BOT(b).y, Flipper.x, Flipper.y) < 55 Then 'check for cradle
				If BOT(b).vely >= -0.4 Then BOT(b).vely = -0.4
			End If
		Next
	End If
End Sub

Sub FlipperTricks (Flipper, FlipperPress, FCount, FEndAngle, FState) 
	Dim Dir
	Dir = Flipper.startangle/Abs(Flipper.startangle)	'-1 for Right Flipper

	If Abs(Flipper.currentangle) > Abs(Flipper.startangle) - 0.05 Then
		If FState <> 1 Then
			Flipper.rampup = SOSRampup 
			Flipper.endangle = FEndAngle - 3*Dir
			Flipper.Elasticity = FElasticity * SOSEM
			FCount = 0 
			FState = 1
		End If
	ElseIf Abs(Flipper.currentangle) <= Abs(Flipper.endangle) and FlipperPress = 1 then
		if FCount = 0 Then FCount = GameTime

		If FState <> 2 Then
			Flipper.eostorqueangle = EOSAnew
			Flipper.eostorque = EOSTnew
			Flipper.rampup = EOSRampup			
			Flipper.endangle = FEndAngle
			FState = 2
		End If
	Elseif Abs(Flipper.currentangle) > Abs(Flipper.endangle) + 0.01 and FlipperPress = 1 Then 
		If FState <> 3 Then
			Flipper.eostorque = EOST	
			Flipper.eostorqueangle = EOSA
			Flipper.rampup = Frampup
			Flipper.Elasticity = FElasticity
			FState = 3
		End If

	End If
End Sub

Const LiveDistanceMin = 30  'minimum distance in vp units from flipper base live catch dampening will occur
Const LiveDistanceMax = 114  'maximum distance in vp units from flipper base live catch dampening will occur (tip protection)

Sub CheckLiveCatch(ball, Flipper, FCount, parm) 'Experimental new live catch
	Dim Dir
	Dir = Flipper.startangle/Abs(Flipper.startangle)    '-1 for Right Flipper
	Dim LiveCatchBounce															'If live catch is not perfect, it won't freeze ball totally
	Dim CatchTime : CatchTime = GameTime - FCount

	if CatchTime <= LiveCatch and parm > 6 and ABS(Flipper.x - ball.x) > LiveDistanceMin and ABS(Flipper.x - ball.x) < LiveDistanceMax Then
		if CatchTime <= LiveCatch*0.8 Then						'Perfect catch only when catch time happens in the beginning of the window
			LiveCatchBounce = 0
		else
			LiveCatchBounce = Abs((LiveCatch/2) - CatchTime)	'Partial catch when catch happens a bit late
		end If
'		debug.print "Live catch! Bounce: " & LiveCatchBounce

		If LiveCatchBounce = 0 and ball.velx * Dir > 0 Then ball.velx = 0
		ball.vely = LiveCatchBounce * (16 / LiveCatch) ' Multiplier for inaccuracy bounce
		ball.angmomx= 0
		ball.angmomy= 0
		ball.angmomz= 0
	End If
End Sub

'*****************************************************************************************************
'*******************************************************************************************************
'END nFOZZY FLIPPERS'


Sub LeftFlipper_Collide(parm)
	LeftFlipperCollide parm
	CheckLiveCatch Activeball, LeftFlipper, LFCount, parm
	Rubberizer(parm)
End Sub

Sub RightFlipper_Collide(parm)
	RightFlipperCollide parm
	CheckLiveCatch Activeball, RightFlipper, RFCount, parm
	Rubberizer(parm)
End Sub



sub Rubberizer(parm)

	if parm < 10 And parm > 2 And Abs(activeball.angmomz) < 10 then
		'debug.print "parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = activeball.angmomz * 2
		activeball.vely = activeball.vely * 1.2
		'debug.print ">> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	Elseif parm <= 2 and parm > 0.1 Then
'		debug.print "* parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = activeball.angmomz * 0.5 * ( int(Rnd(1)*3) -1)
		activeball.vely = activeball.vely * (1.2 + rnd(1)*0.33 )
		'debug.print "**** >> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	end if
end sub


'****************************************************************************
'PHYSICS DAMPENERS
'****************************************************************************

'These are data mined bounce curves, 
'dialed in with the in-game elasticity as much as possible to prevent angle / spin issues.
'Requires tracking ballspeed to calculate COR


Sub dPosts_Hit(idx) 
	RubbersD.dampen Activeball
End Sub

Sub dSleeves_Hit(idx) 
	SleevesD.Dampen Activeball
End Sub


dim RubbersD : Set RubbersD = new Dampener	'frubber
RubbersD.name = "Rubbers"
RubbersD.debugOn = False	'shows info in textbox "TBPout"
RubbersD.Print = False	'debug, reports in debugger (in vel, out cor)
'cor bounce curve (linear)
'for best results, try to match in-game velocity as closely as possible to the desired curve
'RubbersD.addpoint 0, 0, 0.935	'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 0, 0, 0.96	'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 1, 3.77, 0.96
RubbersD.addpoint 2, 5.76, 0.967	'dont take this as gospel. if you can data mine rubber elasticitiy, please help!
RubbersD.addpoint 3, 15.84, 0.874
RubbersD.addpoint 4, 56, 0.64	'there's clamping so interpolate up to 56 at least

dim SleevesD : Set SleevesD = new Dampener	'this is just rubber but cut down to 85%...
SleevesD.name = "Sleeves"
SleevesD.debugOn = False	'shows info in textbox "TBPout"
SleevesD.Print = False	'debug, reports in debugger (in vel, out cor)
SleevesD.CopyCoef RubbersD, 0.85

Class Dampener
	Public Print, debugOn 'tbpOut.text
	public name, Threshold 	'Minimum threshold. Useful for Flippers, which don't have a hit threshold.
	Public ModIn, ModOut
	Private Sub Class_Initialize : redim ModIn(0) : redim Modout(0): End Sub 

	Public Sub AddPoint(aIdx, aX, aY) 
		ShuffleArrays ModIn, ModOut, 1 : ModIn(aIDX) = aX : ModOut(aIDX) = aY : ShuffleArrays ModIn, ModOut, 0
		if gametime > 100 then Report
	End Sub

	public sub Dampen(aBall)
		if threshold then if BallSpeed(aBall) < threshold then exit sub end if end if
		dim RealCOR, DesiredCOR, str, coef
		DesiredCor = LinearEnvelope(cor.ballvel(aBall.id), ModIn, ModOut )
		RealCOR = BallSpeed(aBall) / cor.ballvel(aBall.id)
		coef = desiredcor / realcor 
		if debugOn then str = name & " in vel:" & round(cor.ballvel(aBall.id),2 ) & vbnewline & "desired cor: " & round(desiredcor,4) & vbnewline & _
		"actual cor: " & round(realCOR,4) & vbnewline & "ballspeed coef: " & round(coef, 3) & vbnewline 
'		if Print then debug.print Round(cor.ballvel(aBall.id),2) & ", " & round(desiredcor,3)
		
		aBall.velx = aBall.velx * coef : aBall.vely = aBall.vely * coef
		if debugOn then TBPout.text = str
	End Sub

	Public Sub CopyCoef(aObj, aCoef) 'alternative addpoints, copy with coef
		dim x : for x = 0 to uBound(aObj.ModIn)
			addpoint x, aObj.ModIn(x), aObj.ModOut(x)*aCoef
		Next
	End Sub


	Public Sub Report() 	'debug, reports all coords in tbPL.text
		if not debugOn then exit sub
		dim a1, a2 : a1 = ModIn : a2 = ModOut
		dim str, x : for x = 0 to uBound(a1) : str = str & x & ": " & round(a1(x),4) & ", " & round(a2(x),4) & vbnewline : next
		TBPout.text = str
	End Sub
	

End Class


'******************************************************
'                TRACK ALL BALL VELOCITIES
'                 FOR RUBBER DAMPENER AND DROP TARGETS
'******************************************************

dim cor : set cor = New CoRTracker

Class CoRTracker
        public ballvel, ballvelx, ballvely

        Private Sub Class_Initialize : redim ballvel(0) : redim ballvelx(0): redim ballvely(0) : End Sub 

        Public Sub Update()        'tracks in-ball-velocity
                dim str, b, AllBalls, highestID : allBalls = getballs

                for each b in allballs
                        if b.id >= HighestID then highestID = b.id
                Next

                if uBound(ballvel) < highestID then redim ballvel(highestID)        'set bounds
                if uBound(ballvelx) < highestID then redim ballvelx(highestID)        'set bounds
                if uBound(ballvely) < highestID then redim ballvely(highestID)        'set bounds

                for each b in allballs
                        ballvel(b.id) = BallSpeed(b)
                        ballvelx(b.id) = b.velx
                        ballvely(b.id) = b.vely
                Next
        End Sub
End Class


Sub RDampen()
Cor.Update
End Sub








'////////////////////////////  MECHANICAL SOUNDS  ///////////////////////////
'//  This part in the script is an entire block that is dedicated to the physics sound system.
'//  Various scripts and sounds that may be pretty generic and could suit other WPC systems, but the most are tailored specifically for this table.

'///////////////////////////////  SOUNDS PARAMETERS  //////////////////////////////
Dim GlobalSoundLevel, CoinSoundLevel, PlungerReleaseSoundLevel, PlungerPullSoundLevel, NudgeLeftSoundLevel
Dim NudgeRightSoundLevel, NudgeCenterSoundLevel, StartButtonSoundLevel, RollingSoundFactor

CoinSoundLevel = 2                                                                                                                'volume level; range [0, 1]
NudgeLeftSoundLevel = 2                                                                                                        'volume level; range [0, 1]
NudgeRightSoundLevel = 2                                                                                               'volume level; range [0, 1]
NudgeCenterSoundLevel = 2                                                                                                'volume level; range [0, 1]
StartButtonSoundLevel = 0.2                                                                                                'volume level; range [0, 1]
PlungerReleaseSoundLevel = 0.8 '1 wjr                                                                                        'volume level; range [0, 1]
PlungerPullSoundLevel = 1                                                                                                'volume level; range [0, 1]
RollingSoundFactor = 1.1/5                

'///////////////////////-----Solenoids, Kickers and Flash Relays-----///////////////////////
Dim FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel, FlipperUpAttackLeftSoundLevel, FlipperUpAttackRightSoundLevel
Dim FlipperUpSoundLevel, FlipperDownSoundLevel, FlipperLeftHitParm, FlipperRightHitParm
Dim SlingshotSoundLevel, BumperSoundFactor, KnockerSoundLevel

FlipperUpAttackMinimumSoundLevel = 0.010                                                           'volume level; range [0, 1]
FlipperUpAttackMaximumSoundLevel = 0.635                                                                'volume level; range [0, 1]
FlipperUpSoundLevel = 1.0                                                                        'volume level; range [0, 1]
FlipperDownSoundLevel = 0.45                                                                      'volume level; range [0, 1]
FlipperLeftHitParm = FlipperUpSoundLevel                                                                'sound helper; not configurable
FlipperRightHitParm = FlipperUpSoundLevel                                                                'sound helper; not configurable
SlingshotSoundLevel = 0.95                                                                                                'volume level; range [0, 1]
BumperSoundFactor = 4.25                                                                                                'volume multiplier; must not be zero
KnockerSoundLevel = 1                                                                                                         'volume level; range [0, 1]

'///////////////////////-----Ball Drops, Bumps and Collisions-----///////////////////////
Dim RubberStrongSoundFactor, RubberWeakSoundFactor, RubberFlipperSoundFactor,BallWithBallCollisionSoundFactor
Dim BallBouncePlayfieldSoftFactor, BallBouncePlayfieldHardFactor, PlasticRampDropToPlayfieldSoundLevel, WireRampDropToPlayfieldSoundLevel, DelayedBallDropOnPlayfieldSoundLevel
Dim WallImpactSoundFactor, MetalImpactSoundFactor, SubwaySoundLevel, SubwayEntrySoundLevel, ScoopEntrySoundLevel
Dim SaucerLockSoundLevel, SaucerKickSoundLevel

BallWithBallCollisionSoundFactor = 3.2                                                                        'volume multiplier; must not be zero
RubberStrongSoundFactor = 0.026                                                                                        'volume multiplier; must not be zero
RubberWeakSoundFactor = 0.035                                                                                        'volume multiplier; must not be zero
RubberFlipperSoundFactor = 0.1                                                                               'volume multiplier; must not be zero
BallBouncePlayfieldSoftFactor = 0.05                                                                        'volume multiplier; must not be zero
BallBouncePlayfieldHardFactor = 0.07                                                                        'volume multiplier; must not be zero
DelayedBallDropOnPlayfieldSoundLevel = 0.8                                                                        'volume level; range [0, 1]
WallImpactSoundFactor = 0.0055                                                                                        'volume multiplier; must not be zero
MetalImpactSoundFactor = 0.7
SaucerLockSoundLevel = 4
SaucerKickSoundLevel = 4

'///////////////////////-----Gates, Spinners, Rollovers and Targets-----///////////////////////

Dim GateSoundLevel, TargetSoundFactor, SpinnerSoundLevel, RolloverSoundLevel, DTSoundLevel

GateSoundLevel = 0.08                                                                                                        'volume level; range [0, 1]
TargetSoundFactor = 1.00                                                                                         'volume multiplier; must not be zero
DTSoundLevel = 1                                                                                                                'volume multiplier; must not be zero
RolloverSoundLevel = 0.8                                                                      'volume level; range [0, 1]

'///////////////////////-----Ball Release, Guides and Drain-----///////////////////////
Dim DrainSoundLevel, BallReleaseSoundLevel, BottomArchBallGuideSoundFactor, FlipperBallGuideSoundFactor 

DrainSoundLevel = 1                                                                                                                'volume level; range [0, 1]
BallReleaseSoundLevel = 1                                                                                                'volume level; range [0, 1]
BottomArchBallGuideSoundFactor = 0.2                                                                        'volume multiplier; must not be zero
FlipperBallGuideSoundFactor = 0.015                                                                                'volume multiplier; must not be zero

'///////////////////////-----Loops and Lanes-----///////////////////////
Dim ArchSoundFactor
ArchSoundFactor = 0.025/5                                                                                                        'volume multiplier; must not be zero


'/////////////////////////////  SOUND PLAYBACK FUNCTIONS  ////////////////////////////
'/////////////////////////////  POSITIONAL SOUND PLAYBACK METHODS  ////////////////////////////
' Positional sound playback methods will play a sound, depending on the X,Y position of the table element or depending on ActiveBall object position
' These are similar subroutines that are less complicated to use (e.g. simply use standard parameters for the PlaySound call)
' For surround setup - positional sound playback functions will fade between front and rear surround channels and pan between left and right channels
' For stereo setup - positional sound playback functions will only pan between left and right channels
' For mono setup - positional sound playback functions will not pan between left and right channels and will not fade between front and rear channels

' PlaySound full syntax - PlaySound(string, int loopcount, float volume, float pan, float randompitch, int pitch, bool useexisting, bool restart, float front_rear_fade)
' Note - These functions will not work (currently) for walls/slingshots as these do not feature a simple, single X,Y position
Sub PlaySoundAtLevelStatic(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelExistingStatic(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 1, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelStaticLoop(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, -1, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelExistingLoop(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, -1, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 1, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelStaticRandomPitch(playsoundparams, aVol, randomPitch, tableobj)
    PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), randomPitch, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelActiveBall(playsoundparams, aVol)
        PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ActiveBall), 0, 0, 0, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtLevelExistingActiveBall(playsoundparams, aVol)
        PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ActiveBall), 0, 0, 1, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtLeveTimerActiveBall(playsoundparams, aVol, ballvariable)
        PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ballvariable), 0, 0, 0, 0, AudioFade(ballvariable)
End Sub

Sub PlaySoundAtLevelTimerExistingActiveBall(playsoundparams, aVol, ballvariable)
        PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ballvariable), 0, 0, 1, 0, AudioFade(ballvariable)
End Sub

Sub PlaySoundAtLevelRoll(playsoundparams, aVol, pitch)
    PlaySound playsoundparams, -1, aVol * VolumeDial, AudioPan(tableobj), randomPitch, 0, 0, 0, AudioFade(tableobj)
End Sub

' Previous Positional Sound Subs

Sub PlaySoundAt(soundname, tableobj)
    PlaySound soundname, 1, 1 * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub

Sub PlaySoundAtVol(soundname, tableobj, aVol)
    PlaySound soundname, 1, aVol * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub

Sub PlaySoundAtBall(soundname)
    PlaySoundAt soundname, ActiveBall
End Sub

Sub PlaySoundAtBallVol (Soundname, aVol)
        Playsound soundname, 1,aVol * VolumeDial, AudioPan(ActiveBall), 0,0,0, 1, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtBallVolM (Soundname, aVol)
        Playsound soundname, 1,aVol * VolumeDial, AudioPan(ActiveBall), 0,0,0, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtVolLoops(sound, tableobj, Vol, Loops)
        PlaySound sound, Loops, Vol * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub




' *********************************************************************
'                     Fleep  Supporting Ball & Sound Functions
' *********************************************************************

Function AudioFade(tableobj) ' Fades between front and back of the table (for surround systems or 2x2 speakers, etc), depending on the Y position on the table. "table1" is the name of the table
	Dim tmp
	tmp = tableobj.y * 2 / tableheight-1

	if tmp > 7000 Then
		tmp = 7000
	elseif tmp < -7000 Then
		tmp = -7000
	end if

    	If tmp > 0 Then
		AudioFade = Csng(tmp ^10)
	Else
		AudioFade = Csng(-((- tmp) ^10) )
	End If
End Function

Function AudioPan(tableobj) ' Calculates the pan for a tableobj based on the X position on the table. "table1" is the name of the table
	Dim tmp
	tmp = tableobj.x * 2 / tablewidth -1

	if tmp > 7000 Then
		tmp = 7000
	elseif tmp < -7000 Then
		tmp = -7000
	end if

	If tmp > 0 Then
		AudioPan = Csng(tmp ^10)
	Else
		AudioPan = Csng(-((- tmp) ^10) )
	End If
End Function

Function Vol(ball) ' Calculates the volume of the sound based on the ball speed
        Vol = Csng(BallVel(ball) ^2)
End Function

Function Volz(ball) ' Calculates the volume of the sound based on the ball speed
        Volz = Csng((ball.velz) ^2)
End Function

Function Pitch(ball) ' Calculates the pitch of the sound based on the ball speed
    Pitch = BallVel(ball) * 20
End Function

Function BallVel(ball) 'Calculates the ball speed
    BallVel = INT(SQR((ball.VelX ^2) + (ball.VelY ^2) ) )
End Function

Function VolPlayfieldRoll(ball) ' Calculates the roll volume of the sound based on the ball speed
        VolPlayfieldRoll = RollingSoundFactor * 0.0005 * Csng(BallVel(ball) ^3)
End Function

Function PitchPlayfieldRoll(ball) ' Calculates the roll pitch of the sound based on the ball speed
    PitchPlayfieldRoll = BallVel(ball) ^2 * 15
End Function

Function RndInt(min, max)
    RndInt = Int(Rnd() * (max-min + 1) + min)' Sets a random number integer between min and max
End Function

Function RndNum(min, max)
    RndNum = Rnd() * (max-min) + min' Sets a random number between min and max
End Function

'/////////////////////////////  GENERAL SOUND SUBROUTINES  ////////////////////////////
Sub SoundStartButton()
        PlaySound ("Start_Button"), 0, StartButtonSoundLevel, 0, 0.25
End Sub

Sub SoundNudgeLeft()
        PlaySound ("Nudge_" & Int(Rnd*2)+1), 0, NudgeLeftSoundLevel * VolumeDial, -0.1, 0.25
End Sub

Sub SoundNudgeRight()
        PlaySound ("Nudge_" & Int(Rnd*2)+1), 0, NudgeRightSoundLevel * VolumeDial, 0.1, 0.25
End Sub

Sub SoundNudgeCenter()
        PlaySound ("Nudge_" & Int(Rnd*2)+1), 0, NudgeCenterSoundLevel * VolumeDial, 0, 0.25
End Sub


Sub SoundPlungerPull()
        PlaySoundAtLevelStatic ("Plunger_Pull_1"), PlungerPullSoundLevel, kickback
End Sub'

Sub SoundPlungerReleaseBall()
        PlaySoundAtLevelStatic ("Plunger_Release_Ball"), PlungerReleaseSoundLevel, kickback        
End Sub

Sub SoundPlungerReleaseNoBall()
        PlaySoundAtLevelStatic ("Plunger_Release_No_Ball"), PlungerReleaseSoundLevel, kickback
End Sub


'/////////////////////////////  KNOCKER SOLENOID  ////////////////////////////
Sub KnockerSolenoid()
        PlaySoundAtLevelStatic SoundFX("Knocker_1",DOFKnocker), KnockerSoundLevel, KnockerPosition
End Sub

'/////////////////////////////  DRAIN SOUNDS  ////////////////////////////
Sub RandomSoundDrain(drainswitch)
        PlaySoundAtLevelStatic ("Drain_" & Int(Rnd*11)+1), DrainSoundLevel, drainswitch
End Sub

'/////////////////////////////  TROUGH BALL RELEASE SOLENOID SOUNDS  ////////////////////////////

Sub RandomSoundBallRelease(drainswitch)
        PlaySoundAtLevelStatic SoundFX("BallRelease" & Int(Rnd*7)+1,DOFContactors), BallReleaseSoundLevel, drainswitch
End Sub

'/////////////////////////////  SLINGSHOT SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundSlingshotLeft(sling)
        PlaySoundAtLevelStatic SoundFX("Sling_L" & Int(Rnd*10)+1,DOFContactors), SlingshotSoundLevel, Sling
		If tilted=0 Then        PlaySoundAtLevelStatic "AAimpactdraw", 0.06, Sling
End Sub

Sub RandomSoundSlingshotRight(sling)
        PlaySoundAtLevelStatic SoundFX("Sling_R" & Int(Rnd*8)+1,DOFContactors), SlingshotSoundLevel, Sling
		If tilted=0 Then PlaySoundAtLevelStatic "AAimpactdraw", 0.06, Sling
End Sub

'/////////////////////////////  BUMPER SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundBumperTop(Bump)
        PlaySoundAtLevelStatic SoundFX("Bumpers_Top_" & Int(Rnd*5)+1,DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bump
        PlaySoundAtLevelStatic SoundFX("AAimpactfire",DOFContactors), 0.06 , Bump


End Sub

Sub RandomSoundBumperMiddle(Bump)
        PlaySoundAtLevelStatic SoundFX("Bumpers_Middle_" & Int(Rnd*5)+1,DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bump
        PlaySoundAtLevelStatic SoundFX("AAimpactfire",DOFContactors), 0.06 , Bump
End Sub

Sub RandomSoundBumperBottom(Bump)
        PlaySoundAtLevelStatic SoundFX("Bumpers_Bottom_" & Int(Rnd*5)+1,DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bump
        PlaySoundAtLevelStatic SoundFX("AAimpactfire",DOFContactors), 0.06 , Bump
End Sub

'/////////////////////////////  FLIPPER BATS SOUND SUBROUTINES  ////////////////////////////
'/////////////////////////////  FLIPPER BATS SOLENOID ATTACK SOUND  ////////////////////////////
Sub SoundFlipperUpAttackLeft(flipper)
        FlipperUpAttackLeftSoundLevel = RndNum(FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel)
        PlaySoundAtLevelStatic ("Flipper_Attack-L01"), FlipperUpAttackLeftSoundLevel, flipper
End Sub

Sub SoundFlipperUpAttackRight(flipper)
        FlipperUpAttackRightSoundLevel = RndNum(FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel)
                PlaySoundAtLevelStatic ("Flipper_Attack-R01"), FlipperUpAttackLeftSoundLevel, flipper
End Sub

'/////////////////////////////  FLIPPER BATS SOLENOID CORE SOUND  ////////////////////////////
Sub RandomSoundFlipperUpLeft(flipper)
        PlaySoundAtLevelStatic SoundFX("Flipper_L0" & Int(Rnd*9)+1,DOFFlippers), FlipperLeftHitParm, Flipper
End Sub

Sub RandomSoundFlipperUpRight(flipper)
        PlaySoundAtLevelStatic SoundFX("Flipper_R0" & Int(Rnd*9)+1,DOFFlippers), FlipperRightHitParm, Flipper
End Sub

Sub RandomSoundReflipUpLeft(flipper)
        PlaySoundAtLevelStatic SoundFX("Flipper_ReFlip_L0" & Int(Rnd*3)+1,DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, Flipper
End Sub

Sub RandomSoundReflipUpRight(flipper)
        PlaySoundAtLevelStatic SoundFX("Flipper_ReFlip_R0" & Int(Rnd*3)+1,DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, Flipper
End Sub

Sub RandomSoundFlipperDownLeft(flipper)
        PlaySoundAtLevelStatic SoundFX("Flipper_Left_Down_" & Int(Rnd*7)+1,DOFFlippers), FlipperDownSoundLevel, Flipper
End Sub

Sub RandomSoundFlipperDownRight(flipper)
        PlaySoundAtLevelStatic SoundFX("Flipper_Right_Down_" & Int(Rnd*8)+1,DOFFlippers), FlipperDownSoundLevel, Flipper
End Sub

'/////////////////////////////  FLIPPER BATS BALL COLLIDE SOUND  ////////////////////////////

Sub LeftFlipperCollide(parm)
        FlipperLeftHitParm = parm/10
        If FlipperLeftHitParm > 1 Then
                FlipperLeftHitParm = 1
        End If
        FlipperLeftHitParm = FlipperUpSoundLevel * FlipperLeftHitParm
        RandomSoundRubberFlipper(parm)
End Sub

Sub RightFlipperCollide(parm)
        FlipperRightHitParm = parm/10
        If FlipperRightHitParm > 1 Then
                FlipperRightHitParm = 1
        End If
        FlipperRightHitParm = FlipperUpSoundLevel * FlipperRightHitParm
         RandomSoundRubberFlipper(parm)
End Sub

Sub RandomSoundRubberFlipper(parm)
        PlaySoundAtLevelActiveBall ("Flipper_Rubber_" & Int(Rnd*7)+1), parm  * RubberFlipperSoundFactor
End Sub

'/////////////////////////////  ROLLOVER SOUNDS  ////////////////////////////
Sub RandomSoundRollover()
        PlaySoundAtLevelActiveBall ("Rollover_" & Int(Rnd*4)+1), RolloverSoundLevel
End Sub

Sub Rollovers_Hit(idx)
        RandomSoundRollover
End Sub

'/////////////////////////////  VARIOUS PLAYFIELD SOUND SUBROUTINES  ////////////////////////////
'/////////////////////////////  RUBBERS AND POSTS  ////////////////////////////
'/////////////////////////////  RUBBERS - EVENTS  ////////////////////////////
Sub Rubbers_Hit(idx)
         dim finalspeed
          finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
         If finalspeed > 5 then                
                 RandomSoundRubberStrong 1
        End if
        If finalspeed <= 5 then
                 RandomSoundRubberWeak()
         End If        
End Sub




'/////////////////////////////  RUBBERS AND POSTS - STRONG IMPACTS  ////////////////////////////
Sub RandomSoundRubberStrong(voladj)
        Select Case Int(Rnd*10)+1
                Case 1 : PlaySoundAtLevelActiveBall ("Rubber_Strong_1"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
                Case 2 : PlaySoundAtLevelActiveBall ("Rubber_Strong_2"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
                Case 3 : PlaySoundAtLevelActiveBall ("Rubber_Strong_3"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
                Case 4 : PlaySoundAtLevelActiveBall ("Rubber_Strong_4"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
                Case 5 : PlaySoundAtLevelActiveBall ("Rubber_Strong_5"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
                Case 6 : PlaySoundAtLevelActiveBall ("Rubber_Strong_6"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
                Case 7 : PlaySoundAtLevelActiveBall ("Rubber_Strong_7"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
                Case 8 : PlaySoundAtLevelActiveBall ("Rubber_Strong_8"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
                Case 9 : PlaySoundAtLevelActiveBall ("Rubber_Strong_9"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
                Case 10 : PlaySoundAtLevelActiveBall ("Rubber_1_Hard"), Vol(ActiveBall) * RubberStrongSoundFactor * 0.6*voladj
        End Select
End Sub

'/////////////////////////////  RUBBERS AND POSTS - WEAK IMPACTS  ////////////////////////////
Sub RandomSoundRubberWeak()
'        PlaySoundAtLevelActiveBall ("Rubber_" & Int(Rnd*9)+1), Vol(ActiveBall) * RubberWeakSoundFactor
        PlaySoundAtLevelActiveBall ("Rubber_" & Int(Rnd*9)+1), Vol(ActiveBall) * RubberWeakSoundFactor


End Sub

'/////////////////////////////  WALL IMPACTS  ////////////////////////////
Sub Walls_Hit(idx)
      RandomSoundWall()  
End Sub

Sub RandomSoundWall()
         dim finalspeed
          finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
         If finalspeed > 16 then 
                Select Case Int(Rnd*5)+1
                        Case 1 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_1"), Vol(ActiveBall) * WallImpactSoundFactor
                        Case 2 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_2"), Vol(ActiveBall) * WallImpactSoundFactor
                        Case 3 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_5"), Vol(ActiveBall) * WallImpactSoundFactor
                        Case 4 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_7"), Vol(ActiveBall) * WallImpactSoundFactor
                        Case 5 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_9"), Vol(ActiveBall) * WallImpactSoundFactor
                End Select
        End if
        If finalspeed >= 6 AND finalspeed <= 16 then
                Select Case Int(Rnd*4)+1
                        Case 1 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_3"), Vol(ActiveBall) * WallImpactSoundFactor
                        Case 2 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_4"), Vol(ActiveBall) * WallImpactSoundFactor
                        Case 3 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_6"), Vol(ActiveBall) * WallImpactSoundFactor
                        Case 4 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_8"), Vol(ActiveBall) * WallImpactSoundFactor
                End Select
         End If
        If finalspeed < 6 Then
                Select Case Int(Rnd*3)+1
                        Case 1 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_4"), Vol(ActiveBall) * WallImpactSoundFactor
                        Case 2 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_6"), Vol(ActiveBall) * WallImpactSoundFactor
                        Case 3 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_8"), Vol(ActiveBall) * WallImpactSoundFactor
                End Select
        End if
End Sub

'/////////////////////////////  METAL TOUCH SOUNDS  ////////////////////////////
Sub RandomSoundMetal()
        PlaySoundAtLevelActiveBall ("Metal_Touch_" & Int(Rnd*13)+1), Vol(ActiveBall)/2 * MetalImpactSoundFactor
End Sub

'/////////////////////////////  METAL - EVENTS  ////////////////////////////

Sub Metals_Hit (idx)
        RandomSoundMetal
End Sub

Sub ShooterDiverter_collide(idx)
        RandomSoundMetal
End Sub

'/////////////////////////////  BOTTOM ARCH BALL GUIDE  ////////////////////////////
'/////////////////////////////  BOTTOM ARCH BALL GUIDE - SOFT BOUNCES  ////////////////////////////
Sub RandomSoundBottomArchBallGuide()
         dim finalspeed
          finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
         If finalspeed > 16 then 
                PlaySoundAtLevelActiveBall ("Apron_Bounce_"& Int(Rnd*2)+1), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
        End if
        If finalspeed >= 6 AND finalspeed <= 16 then
                 Select Case Int(Rnd*2)+1
                        Case 1 : PlaySoundAtLevelActiveBall ("Apron_Bounce_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
                        Case 2 : PlaySoundAtLevelActiveBall ("Apron_Bounce_Soft_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
                End Select
         End If
        If finalspeed < 6 Then
                 Select Case Int(Rnd*2)+1
                        Case 1 : PlaySoundAtLevelActiveBall ("Apron_Bounce_Soft_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
                        Case 2 : PlaySoundAtLevelActiveBall ("Apron_Medium_3"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
                End Select
        End if
End Sub

'/////////////////////////////  BOTTOM ARCH BALL GUIDE - HARD HITS  ////////////////////////////
Sub RandomSoundBottomArchBallGuideHardHit()
        PlaySoundAtLevelActiveBall ("Apron_Hard_Hit_" & Int(Rnd*3)+1), BottomArchBallGuideSoundFactor * 0.25
End Sub

Sub Apron_Hit (idx)
        If Abs(cor.ballvelx(activeball.id) < 4) and cor.ballvely(activeball.id) > 7 then
                RandomSoundBottomArchBallGuideHardHit()
        Else
                RandomSoundBottomArchBallGuide
        End If
End Sub

'/////////////////////////////  FLIPPER BALL GUIDE  ////////////////////////////
Sub RandomSoundFlipperBallGuide()
         dim finalspeed
          finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
         If finalspeed > 16 then 
                 Select Case Int(Rnd*2)+1
                        Case 1 : PlaySoundAtLevelActiveBall ("Apron_Hard_1"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
                        Case 2 : PlaySoundAtLevelActiveBall ("Apron_Hard_2"),  Vol(ActiveBall) * 0.8 * FlipperBallGuideSoundFactor
                End Select
        End if
        If finalspeed >= 6 AND finalspeed <= 16 then
                PlaySoundAtLevelActiveBall ("Apron_Medium_" & Int(Rnd*3)+1),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
         End If
        If finalspeed < 6 Then
                PlaySoundAtLevelActiveBall ("Apron_Soft_" & Int(Rnd*7)+1),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
        End If
End Sub

'/////////////////////////////  TARGET HIT SOUNDS  ////////////////////////////
Sub RandomSoundTargetHitStrong()
        PlaySoundAtLevelActiveBall SoundFX("Target_Hit_" & Int(Rnd*4)+5,DOFTargets), TargetSoundFactor
End Sub

Sub RandomSoundTargetHitWeak()                
        PlaySoundAtLevelActiveBall SoundFX("Target_Hit_" & Int(Rnd*4)+1,DOFTargets), TargetSoundFactor
End Sub

Sub PlayTargetSound()
         dim finalspeed
          finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
         If finalspeed > 10 then
                 RandomSoundTargetHitStrong()
                RandomSoundBallBouncePlayfieldSoft Activeball
        Else 
                 RandomSoundTargetHitWeak()
         End If        
End Sub

Sub Targets_Hit (idx)
        PlayTargetSound        
End Sub

'/////////////////////////////  BALL BOUNCE SOUNDS  ////////////////////////////
Sub RandomSoundBallBouncePlayfieldSoft(aBall)
        Select Case Int(Rnd*9)+1
                Case 1 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_1"), volz(aBall) * BallBouncePlayfieldSoftFactor, aBall
                Case 2 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_2"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.5, aBall
                Case 3 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_3"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.8, aBall
                Case 4 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_4"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.5, aBall
                Case 5 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_5"), volz(aBall) * BallBouncePlayfieldSoftFactor, aBall
                Case 6 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_1"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.2, aBall
                Case 7 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_2"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.2, aBall
                Case 8 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_5"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.2, aBall
                Case 9 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_7"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.3, aBall
        End Select
End Sub

Sub RandomSoundBallBouncePlayfieldHard(aBall)
        PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_" & Int(Rnd*7)+1), volz(aBall) * BallBouncePlayfieldHardFactor, aBall
End Sub

'/////////////////////////////  DELAYED DROP - TO PLAYFIELD - SOUND  ////////////////////////////
Sub RandomSoundDelayedBallDropOnPlayfield(aBall)
        Select Case Int(Rnd*5)+1
                Case 1 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_1_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
                Case 2 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_2_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
                Case 3 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_3_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
                Case 4 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_4_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
                Case 5 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_5_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
        End Select
End Sub



'/////////////////////////////  BALL GATES AND BRACKET GATES SOUNDS  ////////////////////////////

Sub SoundPlayfieldGate()                        
        PlaySoundAtLevelStatic ("Gate_FastTrigger_" & Int(Rnd*2)+1), GateSoundLevel, Activeball
End Sub

Sub SoundHeavyGate()
        PlaySoundAtLevelStatic ("Gate_2"), GateSoundLevel, Activeball
End Sub

Sub Gates_hit(idx)
        SoundHeavyGate
End Sub

Sub GatesWire_hit(idx)        
        SoundPlayfieldGate        
End Sub        

'/////////////////////////////  LEFT LANE ENTRANCE - SOUNDS  ////////////////////////////

Sub RandomSoundLeftArch()
        PlaySoundAtLevelActiveBall ("Arch_L" & Int(Rnd*4)+1), Vol(ActiveBall) * ArchSoundFactor
End Sub

Sub RandomSoundRightArch()
        PlaySoundAtLevelActiveBall ("Arch_R" & Int(Rnd*4)+1), Vol(ActiveBall) * ArchSoundFactor
End Sub


Sub Arch1_hit()
        If Activeball.velx > 1 Then SoundPlayfieldGate
        StopSound "Arch_L1"
        StopSound "Arch_L2"
        StopSound "Arch_L3"
        StopSound "Arch_L4"
End Sub

Sub Arch1_unhit()
        If activeball.velx < -8 Then
                RandomSoundRightArch
        End If
End Sub

Sub Arch2_hit()
        If Activeball.velx < 1 Then SoundPlayfieldGate
        StopSound "Arch_R1"
        StopSound "Arch_R2"
        StopSound "Arch_R3"
        StopSound "Arch_R4"
End Sub

Sub Arch2_unhit()
        If activeball.velx > 10 Then
                RandomSoundLeftArch
        End If
End Sub

'/////////////////////////////  SAUCERS (KICKER HOLES)  ////////////////////////////

Sub SoundSaucerLock()
        PlaySoundAtLevelStatic ("Saucer_Enter_" & Int(Rnd*2)+1), 2, Activeball
        PlaySoundAtLevelStatic ("Saucer_Empty"), 2, Activeball
End Sub

Sub SoundSaucerKick(scenario, saucer)
        Select Case scenario
                Case 0: PlaySoundAtLevelStatic SoundFX("Saucer_Empty", DOFContactors), 1, saucer
                Case 1: PlaySoundAtLevelStatic SoundFX("Saucer_Kick", DOFContactors), 2, saucer
						PlaySoundAtLevelStatic SoundFX("fx_kicker", DOFContactors), 2, saucer
        End Select
End Sub

'/////////////////////////////  BALL COLLISION SOUND  ////////////////////////////
Sub OnBallBallCollision(ball1, ball2, velocity)
'Debug.print velocity

    Dim snd
	If velocity>1 Then
        Select Case Int(Rnd*7)+1
                Case 1 : snd = "Ball_Collide_1"
                Case 2 : snd = "Ball_Collide_2"
                Case 3 : snd = "Ball_Collide_3"
                Case 4 : snd = "Ball_Collide_4"
                Case 5 : snd = "Ball_Collide_5"
                Case 6 : snd = "Ball_Collide_6"
                Case 7 : snd = "Ball_Collide_7"
        End Select
        PlaySound (snd), 0, Csng(velocity) ^2 / 200 * BallWithBallCollisionSoundFactor * VolumeDial, AudioPan(ball1), 0, Pitch(ball1), 0, 0, AudioFade(ball1)
	End If
End Sub


'/////////////////////////////////////////////////////////////////
'                                        End Mechanical Sounds
'/////////////////////////////////////////////////////////////////




'**********************************************************************************************************
'* MUSIC *
'**********************************************************************************************************

Dim initialmusic
Sub Table1_musicdone
	If initialmusic=0 or playchamp=1 Then
		playchamp=2
		initialmusic=1
		Playmusic "UnrealTournament/UT-Menu.mp3"
		MusicVolume=Music_Volume
	Else
		MusicOn
	End If
End Sub

Sub MusicON
	EndMusic
	StopSound "AAOpeningVO" 
	PlayMusic "UnrealTournament/UT" & int(rnd(1)*13)+1 & ".mp3"
	MusicVolume=Music_Volume*0.6
End	Sub
Dim voiceoveronce


'**********************************************************************************************************
'* InstructionCard *
'**********************************************************************************************************

Dim CardCounter, ScoreCard
Sub CardTimer_Timer
        If scorecard=1 Then
                CardCounter=CardCounter+2
                If CardCounter>50 Then CardCounter=50
        Else
                CardCounter=CardCounter-4
                If CardCounter<0 Then CardCounter=0
        End If
        InstructionCard.transX = CardCounter*6
        InstructionCard.transY = CardCounter*6
        InstructionCard.transZ = -cardcounter*2
'        InstructionCard.objRotX = -cardcounter/2
        InstructionCard.size_x = 1+CardCounter/25
        InstructionCard.size_y = 1+CardCounter/25
        If CardCounter=0 Then 
                CardTimer.Enabled=False
                InstructionCard.visible=0
        Else
                InstructionCard.visible=1
        End If 
End Sub



'**********************************************************************************************************
'* Raining Effect *
'**********************************************************************************************************

Dim Raining
Sub RainingMod
	Raining=Raining+1
	if Raining>8 then Raining=0
	RainFlasher.imageA="rain" & Raining
End Sub



'**********************************************************************************************************
'* Gun Flasher *
'**********************************************************************************************************

Dim GunFL
Sub GunFlash_timer
	If GunFlash.timerenabled=False Then
		GunFlash.timerenabled=True
		GunFL=100
		Objlevel(4) = 1 : Flasherflash4_Timer
		DOF 156,2
		playSound "thund" & int(Rnd(1)*4)+1 , 1, BG_Volume*0.45, 0,0,0,0,0,0
	Else
		GunFL=GunFL-10
		GunFlash.opacity=GunFL
		If GunFL =0 Then
			GunFlash.timerenabled=False
			Objlevel(5) = 1 : Flasherflash5_Timer ' little delayd
		End If
	End If
End Sub




'**********************************************************************************************************
'* Lane Divider *
'**********************************************************************************************************

Sub DividerWall1_Timer ' divider=on ramp goes to tower 

	If DividerWall1.timerenabled=False Then
		DividerWall1.timerenabled=True
		DividerWall0.timerenabled=False
		DividerWall1.collidable=1
		DividerWall0.collidable=0
		DividerWall3.collidable=0
		If Primitive100.rotY<180 Then playSound "AAldoorsopen", 1, BG_Volume*0.4, 0,0,0,0,0,0
	Else
		DividerWall1.collidable=1
		DividerWall0.collidable=0
		DividerWall3.collidable=0
		i = Primitive100.rotY
		i = i + 10
		If i > 180 Then i = 180
		Primitive100.rotY = i
		If i = 180 Then
			DividerWall1.timerenabled=False
		End If
	End If
End Sub


Sub DividerWall0_Timer ' divider=off ramp goes normal

	If DividerWall0.timerenabled=False Then
		DividerWall0.timerenabled=True
		DividerWall1.timerenabled=False
		DividerWall1.collidable=0
		DividerWall0.collidable=1
		DividerWall3.collidable=1
		If Primitive100.rotY>115 Then playSound "AAldoorsopen", 1, BG_Volume*0.4, 0,0,0,0,0,0
	Else
		DividerWall1.collidable=0
		DividerWall0.collidable=1
		DividerWall3.collidable=1
		i = Primitive100.rotY
		i = i - 10
		If i < 115 Then i = 115
		Primitive100.rotY = i
		If i = 115 Then
			DividerWall0.timerenabled=False
		End If
	End If
End Sub




'**********************************************************************************************************
'* Enemy Flag *
'**********************************************************************************************************

Sub EnemyFlag

	SC(PN,30)=SC(PN,30)+1 ' counter for get flag back
'	debug.print "enemyflag"&SC(pn,30)
	If SC(PN,30)>=SC(PN,32) Then  ' get flag back level
		If SLS(41,1)>1 Then
			PlaySound "AACaptureSound" & int(rnd(1)*3)+1 , 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
			Addpopup "ENEMY","CAPTURE",fontbig2
			'E154 2 ENEMY Capture
			DOF 154,2 
'			If DOFdebug=1 Then debug.print "DOF 154,2 enemy capture"
			If SC(PN,28)=SC(PN,29)+1 Then LOSTLEAD.enabled=True

			SC(PN,29)=SC(PN,29)+1

			BlueDisplay SC(PN,29)
			SPB1 72,72,7,2,1,1
			SPB1 73,74,5,2,1,1
			PlaySound "getflag" & int(rnd(1)*5)+1, 1, 0.7 * BG_Volume, 0, 0,0,0, 0, 0
			SC(PN,30)=0
			FlagOn10=0 ' RESET AUTOCAP
			Exit Sub
		End If
'	28= map score left Counter
'	29= map score Right Counter
		PlaySound "getflag" & int(rnd(1)*5)+1, 1, 0.33 * BG_Volume, 0, 0,0,0, 0, 0
		SC(PN,30)=0
'		debug.print "enemyflag"&SC(pn,30)&"reset"
		'light enemy flags 
		SLS(41,1)=2

		If Team(PN)=0 Then
			BarB=int(rnd(1)*2)+1
		Else
			BarR=int(rnd(1)*2)+1
		End If

		If SLS(42,1)>1 Then SLS(42,1)=1
		SLS(48,1)=2
		SLS(63,1)=2
		SLS(70,1)=2
		L063.timerenabled=True
	End If

End Sub



Sub MapBlinker_Timer
	If startgame>0 And Tilted=0 Then
		if SC(PN,27)=0 Then SPB1 50,50,1,0,0,1 : SLS(50,1)=1
		if SC(PN,27)=1 Then SPB1 53,53,1,0,0,1 : SLS(53,1)=1
		if SC(PN,27)=2 Then SPB1 52,52,1,0,0,1 : SLS(52,1)=1
		if SC(PN,27)=3 Then SPB1 51,51,1,0,0,1 : SLS(51,1)=1
	End If
End Sub

Sub Monsterkill_Timer
	monsterkill.enabled=False
End Sub

Dim FFlevel, KSlevel
Sub CheckFastFrags

	Taunting_Timer

	Select Case KSlevel
		case 0 :
			If SC(PN,19)>4 Then
				delayspree.enabled=True
			End If
		case 1 :
			If SC(PN,19)>9 Then
				delayspree.enabled=True
			End If
		case 2 :
			If SC(PN,19)>14 Then
				delayspree.enabled=True
			End If
		case 3 :
			If SC(PN,19)>19 Then
				delayspree.enabled=True
			End If
		case 4 :
			If SC(PN,19)>24 Then
				delayspree.enabled=True
				SLS(119,1)=2 : spb2 119,119,5,0,0,1
			End If
	End Select


	Select Case FFlevel

		case 3 :
			If FastFrags > 4.99 Then 

				SLS(171,1)=1'	50= collectables
				SC(PN,50)= SC(PN,50) Or 1
'				debug.print "monsterkill" & ( SC(PN,50) And 1) & " PN,50=" & SC(PN,50)
				SPB2 171,171,3,0,0,1

				PlaySound "monsterkill", 1,  BG_Volume, 0, 0,0,0, 0, 0
				DOF 146,2 
'				If DOFdebug=1 Then debug.print "DOF 146,2 mmonsterkill"
'				E145 godlike
'				E146 monsterkill	
				If monsterkill.enabled=False Then 
					Scoring 5000,1000
					Addpopup "-MONSTERKILL-","-MONSTERKILL-",fontbig2
					monsterkill.enabled=True
				End If
				FastFrags=FastFrags-1
				Scoring 3000,600 
				Exit Sub
			End If

		case 2 :
			If FastFrags > 3.99 Then 
				PlaySound "ultrakill", 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0
					Addpopup "-ULTRA KILL-","-ULTRA KILL-",fontbig1
				FFlevel=3
				Scoring 2500,500
				Exit Sub
			End If

		case 1 :
			If FastFrags > 2.99 Then 
				PlaySound "AAmultikill", 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0
					Addpopup "MULTI KILL","MULTI KILL",fontbig1

				FFlevel=2
				Scoring 1500,300 
				Exit Sub
			End If

		case 0 :
			If FastFrags > 1.99 Then 
				PlaySound "doublekill", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
				Addpopup "DOUBLE KILL","DOUBLE KILL",fontbig1
				FFlevel=1
				Scoring 1000,200
				Exit Sub
			End If
	End Select

End Sub
Dim Extraball

Sub Delayspree_Timer
	delayspree.enabled=False
	
	Select Case KSlevel
		case 0 : PlaySound "killingspree", 1, 0.6 * BG_Volume, 0, 0,0,0, 0, 0
					Addpopup "KILLINGSPREE","KILLINGSPREE",fontbig1

		case 1 : PlaySound "rampage", 1, 0.7 * BG_Volume, 0, 0,0,0, 0, 0
				If Extraball=0 And TournamentMode=0 Then ExtraBall=1 : SLS(43,1)=2 :	L043.timerenabled=True ' : Debug.Print "ExtraBall=" & Extraball
					Addpopup "RAMPAGE"   ,"RAMPAGE",fontbig3

		case 2 : PlaySound "AAdominating", 1, 0.75 * BG_Volume, 0, 0,0,0, 0, 0
					Addpopup "DOMINATING"  ,"DOMINATING",fontbig1

		case 3 : PlaySound "unstoppable", 1, 0.88 * BG_Volume, 0, 0,0,0, 0, 0
					Addpopup "UNSTOPPABLE","UNSTOPPABLE"  ,fontbig1

		case 4 : PlaySound "godlike", 1, BG_Volume, 0, 0,0,0, 0, 0
					Addpopup "GODLIKE" ,"GODLIKE" ,fontbig2
'	50= collectables
'	and 1 = Moonsterkill	' 171
'	and 2 = Level 1			' 172 
'	and 4 = Level 2			' 173
'	and 8 = Level 3			' 174
'	and 16= Level godlike	' 147
'	and 32= Level godlike EL' 148
'	and 64= Level god pwnage' 149
			SLS(147,1)=1
			SC(PN,50)= SC(PN,50) Or 16
			SPB1 147,147,6,0,0,1

 
	DOF 145,2 
'	If DOFdebug=1 Then debug.print "DOF 145,2 GODLIKE"
'E145 godlike

	End Select
	KSlevel=KSlevel+1
End Sub

Dim FlagOn4
Dim FlagOn10 'autocap no new flag taken

Sub L063_Timer   ' enemyflag alarm
	If SLS(63,1)=0 Then
		L063.timerenabled=False
		FlagOn10=0
	Else
		PlaySound "Aflagtaken", 1, 0.6 * BG_Volume, 0, 0,0,0, 0, 0

		FlagOn10=FlagOn10+1
		If FlagOn10>9 Then  ' AUTOCAP TIMER AROUND 32 SEC 
			PlaySound "AACaptureSound" & int(rnd(1)*3)+1 , 1, 0.45 * BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "ENEMY","CAPTURE",fontbig2
			SC(PN,29)=SC(PN,29)+1
			'E154 2 ENEMY Capture
			DOF 154,2 
'			If DOFdebug=1 Then debug.print "DOF 154,2 enemy capture"

			BlueDisplay SC(PN,29)
			SPB1 72,72,7,2,1,1
			SPB1 73,74,5,2,1,1
			SC(PN,30)=0
			FlagOn10=0 ' RESET AUTOCAP
				' WILL CAP AGAIN IN 32 SEC IF NOT TURNED OFF
			Exit Sub
		End If

		FlagOn4=FlagOn4+1 
		If FlagOn4= 4 Then
			FlagOn4=0
			PlaySound "getflag" & int(rnd(1)*5)+1, 1, 0.55 * BG_Volume, 0, 0,0,0, 0, 0
		Addpopup "GET OUR","FLAG BACK",fontbig1
		End If
		
	End If
End Sub



Sub	L043_Timer  ' start extraballlight 1300ms nali at rampage
	L043.timerenabled=False
	PlaySound "AANali" & Int(rnd(1)*6)+1 , 1, BG_Volume, 0, 0,0,0, 0, 0
End Sub





'**********************************************************************************************************
'* TilT *
'**********************************************************************************************************

Sub Tilting    'Nudge comes here

	If Tilted=0 Then

		If Tilt > 115 Then 
			TiltGame
			Exit Sub
		End If

		Tilt = Tilt + TiltSens  
		If Tilt > TiltSens Then 
		PlaySound "Danger", 1, 0.7 * BG_Volume, 0, 0,0,0, 0, 0
		End if

	End If

End Sub


Sub TiltGame
	
	SavePlayerLights

	StopSound "Danger"
	PlaySound "Tilt"

'	debug.print"Tilted=1"
	SC(PN,0)=0 ' no bouns for you
	Tilted=1 ' set it to 2 so everything is off, control putting it on at end of ball stuff
	tiltedwait.enabled=True ' .. wait for no balls in play ( excluded the ones in lockup )

	Tilt=200

	Leftflipper.RotateTOStart
	Rightflipper.RotateTOStart
	For i = 1 to 200
		SLS(i,5)=0
		SLS(i,1)=0
	Next

	EndMusic

End Sub

Sub TiltedWait_Timer
	
	If tilt=0 Then
		If TiltedBalls - Locked1 - Locked2 = -1 Then
			Tilted=0
'			debug.print"Tilted=0"
			tiltedwait.enabled=False 
			musicon  ' need to restart this
			StartNewPlayer
		End If
	End If


End Sub




'**********************************************************************************************************
'* ADD PLAYER SCORE AND BONUS * WITH BONUS FROM DROPTARGETS *
'**********************************************************************************************************

DIM FFTscore
Sub Scoring ( byval addtoscore , byval addtobonus )

	tempnr=2
	If SC(PN,27)=0 Then tempnr=2  ' coret
	If SC(PN,27)=1 Then tempnr=5  'november
	If SC(PN,27)=2 Then tempnr=10 'dreary
	If SC(PN,27)=3 Then tempnr=20 'face
	
	tempnr2=10
	If SLS(35,1) > 0 Then tempnr2=tempnr2+2
	If SLS(36,1) > 0 Then tempnr2=tempnr2+7
	If SLS(37,1) > 0 Then tempnr2=tempnr2+2
	If SLS(38,1) > 0 Then tempnr2=tempnr2+4
	If SLS(39,1) > 0 Then tempnr2=tempnr2+4
	If SLS(40,1) > 0 Then tempnr2=tempnr2+4

	FFTscore=int(addtoscore * tempnr * tempnr2 / 10 )
	SC(PN,1)=SC(PN,1) + FFTscore
'	debug.print "addtoscore/fftscore  " & addtoscore & "/" & FFTscore
	If gottenreplay(PN)=0 then If SC(PN,1) > replaytarget Then AwardReplay

	If addtobonus>0 Then 
		SC(PN,0)=SC(PN,0) + int(addtobonus * tempnr * tempnr2/10)
'		debug.print "AB " & addtobonus & "*" & tempnr*tempnr2/10 & "=" & addtobonus * tempnr * tempnr2  & " TOT=" & SC(PN,0)
	End If
End Sub



Dim gottenreplay(4)
Dim ReplayTarget
Sub AwardReplay
	Wonreplays=Wonreplays+1
	gottenreplay(PN)=1
	KnockerReplay1.enabled=True ' 2000
	credits=credits+1
	replaywin=1
End Sub


Sub Award2xReplay
	KnockerReplay2.enabled=True ' 2700
	credits=credits+1
	replaywin=2
End Sub


Sub KnockerReplay1_Timer
	PlaySoundAtLevelStatic ("Knocker_1"), 2, Primitive002
	dof 157,2
	KnockerReplay1.enabled=False
End Sub


Sub KnockerReplay2_Timer
	PlaySoundAtLevelStatic ("Knocker_1"), 2, Primitive002
	KnockerReplay2.enabled=False
	dof 157,2
End Sub




Sub SetReplaytarget ' reset beforegamestarts .
	If Wonreplays *10<= GamesPlayd Then replaytarget= 10000000
	If Wonreplays *10 > GamesPlayd Then replaytarget= 20000000
	If Wonreplays * 8 > GamesPlayd Then replaytarget= 40000000
	If Wonreplays * 7 > GamesPlayd Then replaytarget= 60000000
	If Wonreplays * 6 > GamesPlayd Then replaytarget= 80000000
	If Wonreplays * 5 > GamesPlayd Then replaytarget=120000000
	If Wonreplays * 4 > GamesPlayd Then replaytarget=200000000
	If Wonreplays * 3 > GamesPlayd Then replaytarget=300000000
End Sub




'**********************************************************************************************************
'* FLEX DMD*
'**********************************************************************************************************
' FlexDMD constants
Const 	FlexDMD_RenderMode_DMD_GRAY = 0, _
		FlexDMD_RenderMode_DMD_GRAY_4 = 1, _
		FlexDMD_RenderMode_DMD_RGB = 2, _
		FlexDMD_RenderMode_SEG_2x16Alpha = 3, _
		FlexDMD_RenderMode_SEG_2x20Alpha = 4, _
		FlexDMD_RenderMode_SEG_2x7Alpha_2x7Num = 5, _
		FlexDMD_RenderMode_SEG_2x7Alpha_2x7Num_4x1Num = 6, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_4x1Num = 7, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_10x1Num = 8, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_4x1Num_gen7 = 9, _
		FlexDMD_RenderMode_SEG_2x7Num10_2x7Num10_4x1Num = 10, _
		FlexDMD_RenderMode_SEG_2x6Num_2x6Num_4x1Num = 11, _
		FlexDMD_RenderMode_SEG_2x6Num10_2x6Num10_4x1Num = 12, _
		FlexDMD_RenderMode_SEG_4x7Num10 = 13, _
		FlexDMD_RenderMode_SEG_6x4Num_4x1Num = 14, _
		FlexDMD_RenderMode_SEG_2x7Num_4x1Num_1x16Alpha = 15, _
		FlexDMD_RenderMode_SEG_1x16Alpha_1x16Num_1x7Num = 16

Const 	FlexDMD_Align_TopLeft = 0, _
		FlexDMD_Align_Top = 1, _
		FlexDMD_Align_TopRight = 2, _
		FlexDMD_Align_Left = 3, _
		FlexDMD_Align_Center = 4, _
		FlexDMD_Align_Right = 5, _
		FlexDMD_Align_BottomLeft = 6, _
		FlexDMD_Align_Bottom = 7, _
		FlexDMD_Align_BottomRight = 8


'*****************************************************************************************************
'
' FlexDMD scripts
'
Dim Displaycolor


Sub Addpopup ( addpop,addpop2,colcol )
	Displaycolor=colcol
	If DB2S_on Then B2STimer1_Timer  ' or b2stimer2 for big one
	i=(14-len(Addpop))/2
	if i>0 then addpop = space(i) + addpop  
	i=(14-len(Addpop2))/2
	if i>0 then addpop2 = space(i) + addpop2
	DisplayTop = addpop	
	DisplayBot = addpop2
End Sub



Dim Fontchanger
Dim oldcredits
Dim shortutlogo3
Dim gamereadytostart
Dim DisplayTop
Dim DisplayBot
Dim DisplayTopTime
Dim DisplayBotTime
Dim Skillshotactive
Dim Skillshotresult
Dim extralife
Dim Capture
Dim mapvideo
Dim tiltimage
Dim ShowRoc
Dim HideRoc
Dim framneskip
Dim doubleheadshots, doublehscounter
Dim invisireward, invisicounter
Dim respawning, respawncounter
Dim OntopEffect, Ontopcounter
Dim BarR
Dim BarB
Dim SparkleEffect, sparklecounter
Dim LockedAnim, lockedcounter
Dim MultiAnim, MultiCounter
Dim endofmapreward, MaprewardCounter,Endofmaptext1,Endofmaptext2
Dim EnterRoc,EnterRocCounter

Dim	pwnJP,pwnJPCounter,pwnJPtimer,pwnJPscore
Dim	pwnMB,pwnMBCounter,pwnMBtimer
pwnJPtimer=15
pwnMBtimer=15
Dim LiandriReward, LiandriCounter, LiandriText

Dim GameDMDdelay
Dim Showcombo, ShowComboText1, ShowComboText2


Sub DMDTimer_Timer
	Dim i, n, x, y, label
	Dim title, af,list

	If vrroom > 0 And DMDmode >0 Then DMD_Timer


	Frame=Frame+1 
	
	Select Case DMDmode
		Case 1 : 


			If Frame = 330 Then	Playmusic "UnrealTournament/UT-Title.mp3" :	MusicVolume = Music_Volume

 			If Frame >475 Then 
				CreateIntroVideo2
				gamereadytostart=1
				allDTdrop 
				SignTurnOFF.enabled=True
				nl001.image="gameover"


				SLS(146,1)=2
			End If
	
		Case 2 :
			if frame>10 Then
			FlexDMD.LockRenderThread
			If (Frame Mod 10) = 0 Then Fontchanger=Fontchanger+1 : if Fontchanger>4 Then Fontchanger=0
			Set label = FlexDMD.Stage.GetLabel("credits")

			if Fontchanger=0 then FlexDMD.Stage.GetLabel("credits").Font = FontOrange
			if Fontchanger=1 then label.Font = FontScoreActive2
			if Fontchanger=2 then label.Font = FontScoreActive3
			if Fontchanger=3 then label.Font = FontScoreActive4
			if Fontchanger=4 then label.Font = FontScoreActive5
			label.Text = "CREDITS "&credits 

			Set label = FlexDMD.Stage.GetLabel("insert")
			if Fontchanger=0 then label.Font = FontOrange
			if Fontchanger=1 then label.Font = FontScoreActive2
			if Fontchanger=2 then label.Font = FontScoreActive3
			if Fontchanger=3 then label.Font = FontScoreActive4
			if Fontchanger=4 then label.Font = FontScoreActive5

			if credits>0 Then
				label.Text = "START TO PLAY"
			Else
				label.Text = "INSERT  COINS" 
			End If

			If oldcredits<credits Or (Frame Mod 200)=0 Then
				oldcredits=Credits
				Set title = FlexDMD.Stage.GetLabel("credits")
				Set af = title.ActionFactory
				Set list = af.Sequence()
				list.Add af.Show(True)
				list.Add af.Wait(0.1)
				list.Add af.Show(False)
				list.Add af.Wait(0.1)
				title.AddAction af.Repeat(list, 4)

				Set title = FlexDMD.Stage.GetLabel("insert")
				Set af = title.ActionFactory
				Set list = af.Sequence()
				list.Add af.Show(True)
				list.Add af.Wait(0.1)
				list.Add af.Show(False)
				list.Add af.Wait(0.1)
				title.AddAction af.Repeat(list, 4)
			End If
		
			FlexDMD.UnlockRenderThread

			If startgame=1 Then	
				If gameDMDdelay=0 Then Lightsout
				If gameDMDdelay<20 Then
					gameDMDdelay=gameDMDdelay+1
				Else
					gameDMDdelay=0
					shortutlogo3=1
					CreateScoreSceneSternStyle
					GAMESTARTER
				End If
			End If 
End If


		Case 3 :
			FlexDMD.LockRenderThread

			If tilt>TiltSens and tilted=0 Then
				If (Frame Mod 10) = 0 then
					Set title = FlexDMD.Stage.GetImage("danger")
					Set af = title.ActionFactory
					Set list = af.Sequence()
					list.Add af.Show(True)
					list.Add af.Wait(0.1)
					list.Add af.Show(False)
					list.Add af.Wait(0.02)
					title.AddAction af.Repeat(list, 2)
				End If
			End If

			If tilted>0 Then
				If (Frame Mod 30) = 0 then
					Set title = FlexDMD.Stage.GetImage("tilt")
					Set af = title.ActionFactory
					Set list = af.Sequence()
					list.Add af.Show(True)
					list.Add af.Show(True)
					list.Add af.Wait(0.28)
					list.Add af.Show(False)
					list.Add af.Wait(0.28)
					title.AddAction af.Repeat(list, 2)


					Set title = FlexDMD.Stage.GetImage("tilt2")
					Set af = title.ActionFactory
					Set list = af.Sequence()
					list.Add af.Show(False)
					list.Add af.Wait(0.28)
					list.Add af.Show(True)
					list.Add af.Wait(0.28)
					list.Add af.Show(False)
					title.AddAction af.Repeat(list, 2)
				End If
			End If

			If tiltimage <> tilted Then
				tiltimage=tilted
				If tiltimage=0 Then
					Set title = FlexDMD.Stage.GetImage("tilt")
					Set af = title.ActionFactory
					Set list = af.Sequence()
					list.Add af.Show(False)
					list.Add af.Wait(0.7)
					title.AddAction af.Repeat(list, 1)
					Set title = FlexDMD.Stage.GetImage("tilt2")
					Set af = title.ActionFactory
					Set list = af.Sequence()
					list.Add af.Show(False)
					list.Add af.Wait(0.7)
					title.AddAction af.Repeat(list, 1)
				End If
			End If

	if tilted=0 Then



			If EnterRoc=1 Then
				i = ( EnterRocCounter mod 8 )
				FlexDMD.Stage.GetImage("EnterRoc" & i).visible=False

				EnterRocCounter=EnterRocCounter+1
				If EnterRocCounter=1 Then
					for i = 179 to 190 : sls(i,2)=100 : Next
					spb2 1,1,15,0,0,1 : DOF 110,2 : DOF 113,2
					PlaySound "Omega" , 1, BG_Volume, 0, 0,0,0, 0, 0
				End If

				If EnterRocCounter> 300 Then
					EnterRocCounter=0				
					EnterRoc=0
				Else
					i = ( EnterRocCounter mod 8 )
					FlexDMD.Stage.GetImage("EnterRoc" & i).visible=True
				End If
			End If


	 		If endofmapreward=1 Then
					MaprewardCounter=MaprewardCounter+1
					Select Case MaprewardCounter
						case  2 : FlexDMD.Stage.GetImage("Endmap6").visible=True
						for i = 179 to 190 : sls(i,2)=100 : Next
						spb2 1,1,15,0,0,1
						DOF 110,2
						DOF 113,2
						case  5 : FlexDMD.Stage.GetImage("Endmap5").Visible=True : FlexDMD.Stage.GetImage("Endmap6").Visible=False
						case  8 : FlexDMD.Stage.GetImage("Endmap4").Visible=True : FlexDMD.Stage.GetImage("Endmap5").Visible=False
						case 11 : FlexDMD.Stage.GetImage("Endmap3").Visible=True : FlexDMD.Stage.GetImage("Endmap4").Visible=False
						case 14 : FlexDMD.Stage.GetImage("Endmap2").Visible=True : FlexDMD.Stage.GetImage("Endmap3").Visible=False
						case 17 : FlexDMD.Stage.GetImage("Endmap1").Visible=True : FlexDMD.Stage.GetImage("Endmap2").Visible=False
						case 20 : FlexDMD.Stage.GetImage("Endmap0").Visible=True : FlexDMD.Stage.GetImage("Endmap1").Visible=False
						case 21 : FlexDMD.Stage.GetImage("Endmap10").Visible=True
						case 25 : 
								  Set label = FlexDMD.Stage.GetLabel("Endtext1")
								  label.Text = Endofmaptext1
								  label.SetAlignedPosition 64, 8 , FlexDMD_Align_Center
								  label.Visible=True
								  Set label = FlexDMD.Stage.GetLabel("Endtext2")
								  label.Text = Endofmaptext2
								  label.SetAlignedPosition 64, 24 , FlexDMD_Align_Center
								  label.Visible=True
					
						case 35 : FlexDMD.Stage.GetImage("Endmap11").Visible=True : FlexDMD.Stage.GetImage("Endmap10").Visible=False
						case 38 : FlexDMD.Stage.GetImage("Endmap12").Visible=True : FlexDMD.Stage.GetImage("Endmap11").Visible=False
						case 41 : FlexDMD.Stage.GetImage("Endmap13").Visible=True : FlexDMD.Stage.GetImage("Endmap12").Visible=False
						case 44 : FlexDMD.Stage.GetImage("Endmap14").Visible=True : FlexDMD.Stage.GetImage("Endmap13").Visible=False
						case 47 : FlexDMD.Stage.GetImage("Endmap15").Visible=True : FlexDMD.Stage.GetImage("Endmap14").Visible=False
						case 50 : FlexDMD.Stage.GetImage("Endmap16").Visible=True : FlexDMD.Stage.GetImage("Endmap15").Visible=False
						case 53 : 													FlexDMD.Stage.GetImage("Endmap16").Visible=False
		
						case 70 : Set label = FlexDMD.Stage.GetLabel("Endtext2") : label.Text = " "
						case 80 : Set label = FlexDMD.Stage.GetLabel("Endtext2") : label.Text = Endofmaptext2
						case 100: Set label = FlexDMD.Stage.GetLabel("Endtext2") : label.Text = " "
						case 110: Set label = FlexDMD.Stage.GetLabel("Endtext2") : label.Text = Endofmaptext2
						case 130: Set label = FlexDMD.Stage.GetLabel("Endtext2") : label.Text = " "
						case 140: Set label = FlexDMD.Stage.GetLabel("Endtext2") : label.Text = Endofmaptext2
						case 160: Set label = FlexDMD.Stage.GetLabel("Endtext2") : label.Text = " "
						case 170: Set label = FlexDMD.Stage.GetLabel("Endtext2") : label.Text = Endofmaptext2
						case 190: Set label = FlexDMD.Stage.GetLabel("Endtext2") : label.Text = " "
						case 200: Set label = FlexDMD.Stage.GetLabel("Endtext2") : label.Text = Endofmaptext2

						case 215: FlexDMD.Stage.GetImage("Endmap16").Visible=True
						case 218: FlexDMD.Stage.GetImage("Endmap15").Visible=True : FlexDMD.Stage.GetImage("Endmap16").Visible=False
						case 221: FlexDMD.Stage.GetImage("Endmap14").Visible=True : FlexDMD.Stage.GetImage("Endmap15").Visible=False
						case 224: FlexDMD.Stage.GetImage("Endmap13").Visible=True : FlexDMD.Stage.GetImage("Endmap14").Visible=False
						case 227: FlexDMD.Stage.GetImage("Endmap12").Visible=True : FlexDMD.Stage.GetImage("Endmap13").Visible=False
						case 230: FlexDMD.Stage.GetImage("Endmap11").Visible=True : FlexDMD.Stage.GetImage("Endmap12").Visible=False
						case 233: FlexDMD.Stage.GetImage("Endmap10").Visible=True : FlexDMD.Stage.GetImage("Endmap11").Visible=False
								  Set label = FlexDMD.Stage.GetLabel("Endtext1") : label.Visible=false
								  Set label = FlexDMD.Stage.GetLabel("Endtext2") : label.Visible=false
						case 236: 												    FlexDMD.Stage.GetImage("Endmap10").Visible=False

						case 239: FlexDMD.Stage.GetImage("Endmap1").Visible=True : FlexDMD.Stage.GetImage("Endmap0").Visible=False
						case 242: FlexDMD.Stage.GetImage("Endmap2").Visible=True : FlexDMD.Stage.GetImage("Endmap1").Visible=False
						case 245: FlexDMD.Stage.GetImage("Endmap3").Visible=True : FlexDMD.Stage.GetImage("Endmap2").Visible=False
						case 248: FlexDMD.Stage.GetImage("Endmap4").Visible=True : FlexDMD.Stage.GetImage("Endmap3").Visible=False
						case 251: FlexDMD.Stage.GetImage("Endmap5").Visible=True : FlexDMD.Stage.GetImage("Endmap4").Visible=False
						case 254: FlexDMD.Stage.GetImage("Endmap6").Visible=True : FlexDMD.Stage.GetImage("Endmap5").Visible=False
						case 257: 												   FlexDMD.Stage.GetImage("Endmap6").Visible=False
								MaprewardCounter=0
								endofmapreward=0
					End Select
			End If




			If LiandriReward>0 Then
				LiandriCounter=LiandriCounter+1
				Select Case LiandriCounter
					case  2								  : FlexDMD.Stage.GetImage("Liandri1").Visible=True
					case  7,37,67, 97,127,157,187,217,247 : FlexDMD.Stage.GetImage("Liandri2").Visible=True : FlexDMD.Stage.GetImage("Liandri1").Visible=False
					case 12,42,72,102,132,162,192,222,252 : FlexDMD.Stage.GetImage("Liandri3").Visible=True : FlexDMD.Stage.GetImage("Liandri2").Visible=False
					case 17,47,77,107,137,167,197,227,257 : FlexDMD.Stage.GetImage("Liandri4").Visible=True : FlexDMD.Stage.GetImage("Liandri3").Visible=False
					case 22,52,82,112,142,172,202,232,262 : FlexDMD.Stage.GetImage("Liandri3").Visible=True : FlexDMD.Stage.GetImage("Liandri4").Visible=False
							  Set label = FlexDMD.Stage.GetLabel("LiandriText")
							  label.Text = LiandriText
							  label.SetAlignedPosition 64, 24 , FlexDMD_Align_Center
							  label.Visible=True
					case 27,57,87,117,147,177,207,237,267 : FlexDMD.Stage.GetImage("Liandri2").Visible=True : FlexDMD.Stage.GetImage("Liandri3").Visible=False
					case 32,62,92,122,152,182,212,242,272 : FlexDMD.Stage.GetImage("Liandri1").Visible=True : FlexDMD.Stage.GetImage("Liandri2").Visible=False



				End Select
				If LiandriCounter>274 Then
					LiandriCounter=0
					LiandriReward=0
					FlexDMD.Stage.GetImage("Liandri1").Visible=False
					FlexDMD.Stage.GetImage("Liandri2").Visible=False
					FlexDMD.Stage.GetImage("Liandri3").Visible=False
					FlexDMD.Stage.GetImage("Liandri4").Visible=False
					FlexDMD.Stage.GetLabel("LiandriText").Visible=False
				End If
			End If



			If rocReward<>"" Then
				FlexDMD.Stage.GetLabel("champtext2").text = RocReward
				
				SPB2 201,202,3,0,0,1
				RocReward=""
				ShowRoc=Frame+140
				HideRoc=Frame+380
				SignTurnON.enabled=True
				nl001.image="champ"
				spb1 146,146,20,2,2,1

			End If

			If Showroc>0 Then
				If ShowRoc<Frame Then 
					Thunderstorm_Timer
					Showroc=0 
					FlexDMD.Stage.GetGroup("champs").Visible = True
					If SC(pn,35)<>1 Then
						PlaySound JP1(int(Rnd(1)*12)) , 1, 0.9 * BG_Volume, 0, 0,0,0, 0, 0
					Else
						PlaySound "Holyshit" , 1, BG_Volume, 0, 0,0,0, 0, 0 
						PlaySound "Holyshit" , 1, BG_Volume, 0, 0,0,0, 0, 0 
					End If

					SPB1 54,54,35,0,0,1
				End If
			End If

			If Hideroc>0 Then
				If Hideroc<Frame Then 
					Hideroc=0 
					FlexDMD.Stage.GetGroup("champs").Visible = False
				End If
			End If

			For i = 1 to Maxplayers
				Set label = FlexDMD.Stage.GetLabel("Score_" & i)
				label.SetAlignedPosition 40, 1 + (i - 1) * 8, FlexDMD_Align_TopRight
				If i = PN Then
					label.Font = FontScoreActive
					label.Text = SC(i,1)
				Else
					label.Font = FontScoreInactive
					label.Text = SC(i,1)
				End If
			Next

			If frame>265 And shortutlogo3=1 Then
				shortutlogo3=0
				FlexDMD.Stage.GetGroup("introvid").Visible=false

				gamereadytostart=3
			End If

			If mapvideo<> SC(PN,27) And MoviesIngame=1 Then
				mapvideo=SC(PN,27)
				Set title = FlexDMD.Stage.GetVideo("test")
				Set af = title.ActionFactory
				Set list = af.Sequence()
				If Mapvideo=0 Then	
					list.Add af.Show(True)
				Else
					list.Add af.Show(False)
				End If
				list.Add af.Wait(0.2)
				title.AddAction af.Repeat(list, 1)

				Set title = FlexDMD.Stage.GetVideo("test2")
				Set af = title.ActionFactory
				Set list = af.Sequence()
				If Mapvideo=1 Then	
					list.Add af.Show(True)
				Else
					list.Add af.Show(False)
				End If
				list.Add af.Wait(0.2)
				title.AddAction af.Repeat(list, 1)

				Set title = FlexDMD.Stage.GetVideo("test3")
				Set af = title.ActionFactory
				Set list = af.Sequence()
				If Mapvideo=2 Then	
					list.Add af.Show(True)
				Else
					list.Add af.Show(False)
				End If
				list.Add af.Wait(0.2)
				title.AddAction af.Repeat(list, 1)

				Set title = FlexDMD.Stage.GetVideo("test4")
				Set af = title.ActionFactory
				Set list = af.Sequence()
				If Mapvideo=3 Then	
					list.Add af.Show(True)
				Else
					list.Add af.Show(False)
				End If
				list.Add af.Wait(0.2)
				title.AddAction af.Repeat(list, 1)
			End If

			i=1
			If NewPlayerNewBall>0 Then
				If NewPlayerNewBall>1 Then NewPlayerNewBall=NewPlayerNewBall+1 : If NewPlayerNewBall>82 Then NewPlayerNewBall=0
				If ( frame mod 15 )<8 Then
					FlexDMD.Stage.GetLabel("Content_1").Font = fontbigwhite
					FlexDMD.Stage.GetLabel("Content_1").Text = "PLAYER " & PN
					FlexDMD.Stage.GetLabel("Content_1").SetAlignedPosition 43, 17 , FlexDMD_Align_Center
				Else					
					FlexDMD.Stage.GetLabel("Content_1").Font = fontbigwhite
					FlexDMD.Stage.GetLabel("Content_1").Text = "PLAYER "
				End If

			Elseif Showcombo>0 Then
				Showcombo=Showcombo+1 : If Showcombo>179 Then Showcombo=0
				If ( Showcombo mod 40 )<20 Then
					FlexDMD.Stage.GetLabel("Content_1").Font = fontbigGreen
					FlexDMD.Stage.GetLabel("Content_1").Text = ShowComboText1
					FlexDMD.Stage.GetLabel("Content_1").SetAlignedPosition 43, 17 , FlexDMD_Align_Center
				Else
					FlexDMD.Stage.GetLabel("Content_1").Font = fontbigGreen
					FlexDMD.Stage.GetLabel("Content_1").Text = ShowComboText2
					FlexDMD.Stage.GetLabel("Content_1").SetAlignedPosition 43, 17 , FlexDMD_Align_Center
				End If

			Elseif ShowRampEB>Frame And TournamentMode=0 Then
				FlexDMD.Stage.GetLabel("Content_1").Font = fontbig
				FlexDMD.Stage.GetLabel("Content_1").Text = 25-RampEB & " MORE=EL"
				FlexDMD.Stage.GetLabel("Content_1").SetAlignedPosition 43, 17 , FlexDMD_Align_Center

			Else
				FlexDMD.Stage.GetLabel("Content_1").Font = fontbig
				FlexDMD.Stage.GetLabel("Content_1").Text = formatscore(SC(PN,1))
				FlexDMD.Stage.GetLabel("Content_1").SetAlignedPosition 43, 17 , FlexDMD_Align_Center
			End If


' MultiAnim
				If MultiAnim>0 Then
					MultiCounter=MultiCounter+1
					Select Case MultiCounter
						case  2 : FlexDMD.Stage.GetImage("Multiball0").Visible=True
						SLS(185,2)=100 '  GI blink 2
						SLS(1,0)=1 : spb1 1,1,5,0,0,1 : DOF 110,2 : DOF 113,2
						case  7 : FlexDMD.Stage.GetImage("Multiball1").Visible=True : FlexDMD.Stage.GetImage("Multiball0").Visible=False
						case 12 : FlexDMD.Stage.GetImage("Multiball2").Visible=True : FlexDMD.Stage.GetImage("Multiball1").Visible=False
						case 17 : FlexDMD.Stage.GetImage("Multiball3").Visible=True : FlexDMD.Stage.GetImage("Multiball2").Visible=False
						case 22 : FlexDMD.Stage.GetImage("Multiball4").Visible=True : FlexDMD.Stage.GetImage("Multiball3").Visible=False
						case 27 : FlexDMD.Stage.GetImage("Multiball5").Visible=True : FlexDMD.Stage.GetImage("Multiball4").Visible=False
						case 32 : FlexDMD.Stage.GetImage("Multiball6").Visible=True : FlexDMD.Stage.GetImage("Multiball5").Visible=False
						case 37 : FlexDMD.Stage.GetImage("Multiball7").Visible=True : FlexDMD.Stage.GetImage("Multiball6").Visible=False
						case 42 : FlexDMD.Stage.GetImage("Multiball8").Visible=True : FlexDMD.Stage.GetImage("Multiball7").Visible=False
						case 47 : FlexDMD.Stage.GetImage("Multiball9").Visible=True : FlexDMD.Stage.GetImage("Multiball8").Visible=False
						case 52 : 													  FlexDMD.Stage.GetImage("Multiball9").Visible=False
								MultiCounter=0
								If MultiAnim>0 Then MultiAnim=MultiAnim-1

					End Select
				End If
' lockedball
				If lockedanim>0 Then
					lockedcounter=lockedcounter+1
					Select Case lockedcounter
						case  2 : FlexDMD.Stage.GetImage("Locked0").Visible=True
						SLS(185,2)=33 '  GI blink 2
						SLS(1,0)=1 : spb1 1,1,5,0,0,1 : DOF 110,2 : DOF 113,2
						case  6 : FlexDMD.Stage.GetImage("Locked1").Visible=True : FlexDMD.Stage.GetImage("Locked0").Visible=False
						case 10 : FlexDMD.Stage.GetImage("Locked2").Visible=True : FlexDMD.Stage.GetImage("Locked1").Visible=False
						case 14 : FlexDMD.Stage.GetImage("Locked3").Visible=True : FlexDMD.Stage.GetImage("Locked2").Visible=False
						case 18 : FlexDMD.Stage.GetImage("Locked4").Visible=True : FlexDMD.Stage.GetImage("Locked3").Visible=False
						case 22 : FlexDMD.Stage.GetImage("Locked5").Visible=True : FlexDMD.Stage.GetImage("Locked4").Visible=False
						case 26 : FlexDMD.Stage.GetImage("Locked6").Visible=True : FlexDMD.Stage.GetImage("Locked5").Visible=False
						case 30 : FlexDMD.Stage.GetImage("Locked7").Visible=True : FlexDMD.Stage.GetImage("Locked6").Visible=False
						case 34 : FlexDMD.Stage.GetImage("Locked8").Visible=True : FlexDMD.Stage.GetImage("Locked7").Visible=False
						case 38 : FlexDMD.Stage.GetImage("Locked9").Visible=True : FlexDMD.Stage.GetImage("Locked8").Visible=False
						case 42 : FlexDMD.Stage.GetImage("Locked10").Visible=True : FlexDMD.Stage.GetImage("Locked9").Visible=False
						case 46 : FlexDMD.Stage.GetImage("Locked11").Visible=True : FlexDMD.Stage.GetImage("Locked10").Visible=False
						case 50 :													FlexDMD.Stage.GetImage("Locked11").Visible=False
								lockedcounter=0
								If lockedanim>0 Then lockedanim=lockedanim-1
					End Select
				End If

' respawn !
				If respawning=1 Then
					respawncounter=respawncounter+1
					Select Case respawncounter
						case 12 : FlexDMD.Stage.GetImage("respawn14").Visible=True
						SLS(185,2)=68 '  GI blink 2
						SLS(1,0)=1 : spb1 1,1,5,0,0,1 : DOF 110,2 : DOF 113,2
						case 19 : FlexDMD.Stage.GetImage("respawn13").Visible=True : FlexDMD.Stage.GetImage("respawn14").Visible=False
						case 26 : FlexDMD.Stage.GetImage("respawn12").Visible=True : FlexDMD.Stage.GetImage("respawn13").Visible=False
						case 33 : FlexDMD.Stage.GetImage("respawn11").Visible=True : FlexDMD.Stage.GetImage("respawn12").Visible=False
						case 40 : FlexDMD.Stage.GetImage("respawn10").Visible=True : FlexDMD.Stage.GetImage("respawn11").Visible=False
						case 47 : FlexDMD.Stage.GetImage("respawn9").Visible=True  : FlexDMD.Stage.GetImage("respawn10").Visible=False
						case 54 : FlexDMD.Stage.GetImage("respawn8").Visible=True  : FlexDMD.Stage.GetImage("respawn9").Visible=False
						case 61 : FlexDMD.Stage.GetImage("respawn7").Visible=True  : FlexDMD.Stage.GetImage("respawn8").Visible=False
						case 68 : FlexDMD.Stage.GetImage("respawn6").Visible=True  : FlexDMD.Stage.GetImage("respawn7").Visible=False
						case 75 : FlexDMD.Stage.GetImage("respawn5").Visible=True  : FlexDMD.Stage.GetImage("respawn6").Visible=False
						case 82 : FlexDMD.Stage.GetImage("respawn4").Visible=True  : FlexDMD.Stage.GetImage("respawn5").Visible=False
						case 89 : FlexDMD.Stage.GetImage("respawn3").Visible=True  : FlexDMD.Stage.GetImage("respawn4").Visible=False
						case 96 : FlexDMD.Stage.GetImage("respawn2").Visible=True  : FlexDMD.Stage.GetImage("respawn3").Visible=False
						case 103: FlexDMD.Stage.GetImage("respawn1").Visible=True  : FlexDMD.Stage.GetImage("respawn2").Visible=False
						case 110: FlexDMD.Stage.GetImage("respawn0").Visible=True  : FlexDMD.Stage.GetImage("respawn1").Visible=False
						case 117: 												   : FlexDMD.Stage.GetImage("respawn0").Visible=False
								respawncounter=0
								respawning=0
								SparkleEffect=1
					End Select
				End If

' Bar red+Blue
				If BarR>0 Then
					Select case BarR ' up or down
						case  1 : ' up
							Set title = FlexDMD.Stage.GetImage("barr")
							Set af = title.ActionFactory
							Set list = af.Sequence()
							list.Add af.MoveTo(0, 32, 0)
							List.Add af.Show(True)
							list.Add af.MoveTo(0, -32, 0.2)
							List.Add af.Show(False)
							title.AddAction af.Repeat(list, 4)
							BarR=0
						case  2 : ' up
							Set title = FlexDMD.Stage.GetImage("barr")
							Set af = title.ActionFactory
							Set list = af.Sequence()
							list.Add af.MoveTo(0, -32, 0)
							List.Add af.Show(True)
							list.Add af.MoveTo(0, 32, 0.2)
							List.Add af.Show(False)
							title.AddAction af.Repeat(list, 4)
							BarR=0
					End Select
				End If
				If BarB>0 Then
					Select case BarB ' up or down
						case  1 : ' up
							Set title = FlexDMD.Stage.GetImage("barb")
							Set af = title.ActionFactory
							Set list = af.Sequence()
							list.Add af.MoveTo(0, 32, 0)
							List.Add af.Show(True)
							list.Add af.MoveTo(0, -32, 0.2)
							List.Add af.Show(False)
							title.AddAction af.Repeat(list, 4)
							BarB=0
						case  2 : ' up
							Set title = FlexDMD.Stage.GetImage("barb")
							Set af = title.ActionFactory
							Set list = af.Sequence()
							list.Add af.MoveTo(0, -32, 0)
							List.Add af.Show(True)
							list.Add af.MoveTo(0, 32, 0.2) ' speed  lower = faster
							List.Add af.Show(False)
							title.AddAction af.Repeat(list, 4)
							BarB=0
					End Select
				End If

' on top effects
				If OntopEffect>0 Then
					Select case OntopEffect
						case 1 : tempstr="round"
						case 2 : tempstr="roundr"
						case 3 : tempstr="roundb"
					End Select
					ONtopcounter=ONtopcounter+1
					Select Case ONtopcounter
						case  2 : FlexDMD.Stage.GetImage(tempstr & "0").Visible=True
						case  4 : FlexDMD.Stage.GetImage(tempstr & "1").Visible=True : FlexDMD.Stage.GetImage(tempstr & "0").Visible=False
						case  6 : FlexDMD.Stage.GetImage(tempstr & "2").Visible=True : FlexDMD.Stage.GetImage(tempstr & "1").Visible=False
						case  8 : FlexDMD.Stage.GetImage(tempstr & "3").Visible=True : FlexDMD.Stage.GetImage(tempstr & "2").Visible=False
						case 10 : FlexDMD.Stage.GetImage(tempstr & "4").Visible=True : FlexDMD.Stage.GetImage(tempstr & "3").Visible=False
						case 12 : FlexDMD.Stage.GetImage(tempstr & "5").Visible=True : FlexDMD.Stage.GetImage(tempstr & "4").Visible=False
						case 14 : FlexDMD.Stage.GetImage(tempstr & "6").Visible=True : FlexDMD.Stage.GetImage(tempstr & "5").Visible=False
						case 16 : FlexDMD.Stage.GetImage(tempstr & "7").Visible=True : FlexDMD.Stage.GetImage(tempstr & "6").Visible=False
						case 18 : FlexDMD.Stage.GetImage(tempstr & "8").Visible=True : FlexDMD.Stage.GetImage(tempstr & "7").Visible=False
						case 20 : 		  											: FlexDMD.Stage.GetImage(tempstr & "8").Visible=False
								ONtopcounter=0
								OntopEffect=0
					End Select
				End If
'SparkleEffect
				If SparkleEffect>0 Then
					sparklecounter=sparklecounter+1
					Select Case sparklecounter
						case  2 : FlexDMD.Stage.GetImage("sparkle0").Visible=True
						case  4 : FlexDMD.Stage.GetImage("sparkle1").Visible=True : FlexDMD.Stage.GetImage("sparkle0").Visible=False
						case  6 : FlexDMD.Stage.GetImage("sparkle2").Visible=True : FlexDMD.Stage.GetImage("sparkle1").Visible=False
						case  8 : FlexDMD.Stage.GetImage("sparkle3").Visible=True : FlexDMD.Stage.GetImage("sparkle2").Visible=False
						case 10 : FlexDMD.Stage.GetImage("sparkle4").Visible=True : FlexDMD.Stage.GetImage("sparkle3").Visible=False
						case 12 : FlexDMD.Stage.GetImage("sparkle5").Visible=True : FlexDMD.Stage.GetImage("sparkle4").Visible=False
						case 13 : FlexDMD.Stage.GetImage("sparkle6").Visible=True : FlexDMD.Stage.GetImage("sparkle5").Visible=False
						case 14 : FlexDMD.Stage.GetImage("sparkle7").Visible=True : FlexDMD.Stage.GetImage("sparkle6").Visible=False
						case 16 : FlexDMD.Stage.GetImage("sparkle8").Visible=True : FlexDMD.Stage.GetImage("sparkle7").Visible=False
						case 18 : FlexDMD.Stage.GetImage("sparkle9").Visible=True : FlexDMD.Stage.GetImage("sparkle8").Visible=False
						case 20 : FlexDMD.Stage.GetImage("sparkle10").Visible=True : FlexDMD.Stage.GetImage("sparkle9").Visible=False
						case 22 : FlexDMD.Stage.GetImage("sparkle11").Visible=True : FlexDMD.Stage.GetImage("sparkle10").Visible=False
						case 24 : FlexDMD.Stage.GetImage("sparkle12").Visible=True : FlexDMD.Stage.GetImage("sparkle11").Visible=False
						case 26 : FlexDMD.Stage.GetImage("sparkle13").Visible=True : FlexDMD.Stage.GetImage("sparkle12").Visible=False
						case 28 : FlexDMD.Stage.GetImage("sparkle14").Visible=True : FlexDMD.Stage.GetImage("sparkle13").Visible=False
						case 30 : FlexDMD.Stage.GetImage("sparkle15").Visible=True : FlexDMD.Stage.GetImage("sparkle14").Visible=False
						case 32 : FlexDMD.Stage.GetImage("sparkle16").Visible=True : FlexDMD.Stage.GetImage("sparkle15").Visible=False
						case 34 : FlexDMD.Stage.GetImage("sparkle17").Visible=True : FlexDMD.Stage.GetImage("sparkle16").Visible=False
						case 36 : FlexDMD.Stage.GetImage("sparkle18").Visible=True : FlexDMD.Stage.GetImage("sparkle17").Visible=False
						case 38 : FlexDMD.Stage.GetImage("sparkle19").Visible=True : FlexDMD.Stage.GetImage("sparkle18").Visible=False
						case 40 : FlexDMD.Stage.GetImage("sparkle20").Visible=True : FlexDMD.Stage.GetImage("sparkle19").Visible=False
						case 42 : FlexDMD.Stage.GetImage("sparkle21").Visible=True : FlexDMD.Stage.GetImage("sparkle20").Visible=False
						case 44 : FlexDMD.Stage.GetImage("sparkle22").Visible=True : FlexDMD.Stage.GetImage("sparkle21").Visible=False
						case 46 : FlexDMD.Stage.GetImage("sparkle23").Visible=True : FlexDMD.Stage.GetImage("sparkle22").Visible=False
						case 48 : 												  : FlexDMD.Stage.GetImage("sparkle23").Visible=False
								If SparkleEffect>1 Then
									SparkleEffect=SparkleEffect-1
									FlexDMD.Stage.GetImage("sparkle0").Visible=True
									sparklecounter=2
								Else
									sparklecounter=0
									SparkleEffect=0
								End If
					End Select
				End If
	



'pwnage MUltiball taower 15 s
			If pwnMB=1 Then
				pwnMBCounter=pwnMBCounter+1
'				debug.print "pwnMBcounter=" & pwnMBCounter & "pwnMB=" & pwnMB

				If pwnMBCounter>22 And pwnMBCounter<1000 Then
					If ( pwnMBCounter mod 20 ) > 17 Then FlexDMD.Stage.GetImage("pwnjp").Visible=True Else FlexDMD.Stage.GetImage("pwnjp").Visible=False
					Set Label = FlexDMD.Stage.GetLabel("pwntext2")
					If ( pwnMBCounter mod 60 ) < 45 Then
						label.text="TOWER IN " & pwnMBtimer
					Else
						label.text="TOWER IN   "
					End If
				End If

				If pwnMBtimer=0 And pwnMBCounter<1000 Then pwnMBCounter=1000

				Select Case pwnMBCounter
					case  2 : FlexDMD.Stage.GetImage("pwnjp2").Visible=True
							  FlexDMD.Stage.GetImage("pwnjp").Visible=True
					case 8  : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="D"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
							  label.Visible=True
					case 11  : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DO"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 13 : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DOU"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 15 : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DOUB"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 17 : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DOUBL"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 19 : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DOUBLE"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 21 : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DOUBLE T"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 23 : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DOUBLE TR"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 25 : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DOUBLE TRO"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 27 : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DOUBLE TROU"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 29 : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DOUBLE TROUB"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 31 : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DOUBLE TROUBL"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 33  : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="DOUBLE TROUBLE"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
					case 35 : Set Label = FlexDMD.Stage.GetLabel("pwntext2")
							  label.text="TOWER IN 15"
							  label.SetAlignedPosition 64, 25, FlexDMD_Align_Center
							  label.Visible=True
							  pwnMBtimer=15
					case 1155 : FlexDMD.Stage.GetLabel("pwntext2").Visible=Fasle
					case 1160 : FlexDMD.Stage.GetLabel("pwntext").Visible=Fasle
					case 1165 : FlexDMD.Stage.GetImage("pwnjp").Visible=Fasle
								FlexDMD.Stage.GetImage("pwnjp2").Visible=Fasle
								pwnMB=0 : pwnMBtimer=15 : pwnMBCounter=0
								pwnage=100
								SPB2 90,90,3,0,0,1

				End Select

				If pwnMBCounter>1000 And pwnMBCounter<1150 Then
					SLS(90,1)=1
					SLS(55,1)=1
					Set Label = FlexDMD.Stage.GetLabel("pwntext2")
					If ( pwnMBCounter mod 25 ) < 20 Then
						label.text="PWNAGE = RETRY"
						label.SetAlignedPosition 64, 25, FlexDMD_Align_Center
					Else
						label.text=" "
					End If
				End If

				If pwnMBCounter>2000 And pwnMBCounter<2150 Then
					Set Label = FlexDMD.Stage.GetLabel("pwntext2")

					If ( pwnMBCounter mod 25 ) < 20 Then
						label.text="HERE IT COMES"
						label.SetAlignedPosition 64, 25, FlexDMD_Align_Center
					Else
						label.text=" "
					End If
				End If

				If pwnMBCounter>2150 Then
					FlexDMD.Stage.GetLabel("pwntext2").Visible=Fasle
					FlexDMD.Stage.GetLabel("pwntext").Visible=Fasle
					FlexDMD.Stage.GetImage("pwnjp").Visible=Fasle
					FlexDMD.Stage.GetImage("pwnjp2").Visible=Fasle
					pwnMB=0 : pwnMBtimer=15 : pwnMBCounter=0
					SPB2 90,90,7,0,0,1
	
					SignTurnON.enabled=True
					nl001.image="pwnage"
					spb1 146,146,20,2,2,1

					crazyteamscore1.enabled=True
				End If
			End If



'pwnage JACKPOT 15s ramp
			If pwnJP=1 Then
				pwnJPCounter=pwnJPCounter+1
				If ( pwnJPCounter mod 60 ) = 50 Then SPB2 97,97,1,0,0,1
'				debug.print "pwnjpcoutner=" & pwnJPCounter & "pwnJP=" & pwnJP

				If pwnJPCounter>22 And pwnJPCounter<1000 Then
					If ( pwnJPCounter mod 20 ) > 17 Then FlexDMD.Stage.GetImage("pwnjp").Visible=True Else FlexDMD.Stage.GetImage("pwnjp").Visible=False
					Set Label = FlexDMD.Stage.GetLabel("pwntext2")
					If ( pwnJPCounter mod 60 ) < 45 Then
						label.text="RAMP IN " & pwnJPtimer
					Else
						label.text="RAMP IN   "
					End If
				End If

				If pwnJPtimer=0 And pwnJPCounter<1000 Then pwnJPCounter=1000

				Select Case pwnJPCounter
					case  2 : FlexDMD.Stage.GetImage("pwnjp2").Visible=True
							  FlexDMD.Stage.GetImage("pwnjp").Visible=True
					case 10 : Set Label = FlexDMD.Stage.GetLabel("pwntext")
							  label.text="INHUMAN PWNAGE"
							  label.SetAlignedPosition 64, 11, FlexDMD_Align_Center
							  label.Visible=True
					case 22 : Set Label = FlexDMD.Stage.GetLabel("pwntext2")
							  label.text="RAMP IN 15"
							  label.SetAlignedPosition 64, 25, FlexDMD_Align_Center
							  label.Visible=True
							  pwnJPtimer=15
					case 1155 : FlexDMD.Stage.GetLabel("pwntext2").Visible=Fasle
					case 1160 : FlexDMD.Stage.GetLabel("pwntext").Visible=Fasle
					case 1165 : FlexDMD.Stage.GetImage("pwnjp").Visible=Fasle
								FlexDMD.Stage.GetImage("pwnjp2").Visible=Fasle
								pwnJP=0 : pwnJPtimer=15 : pwnJPCounter=0
								SLS(96,1)=1 : spb2 96,96,3,0,0,1
								P045.material="InsertWhiteOnTri"
								If pwnage=4 or pwnage=5 Then pwnage=3
								If pwnage=8 or pwnage=9 Then pwnage=7
				End Select

				If pwnJPCounter>1000 And pwnJPCounter<1150 Then
					Set Label = FlexDMD.Stage.GetLabel("pwntext2")
					If ( pwnJPCounter mod 25 ) < 20 Then
						label.text="PWNAGE = RETRY"
						label.SetAlignedPosition 64, 25, FlexDMD_Align_Center
					Else
						label.text=" "
					End If
				End If

				If pwnJPCounter>2000 And pwnJPCounter<2150 Then
					Set Label = FlexDMD.Stage.GetLabel("pwntext2")
					If ( pwnJPCounter mod 25 ) < 20 Then
						label.text=formatscore (pwnJPscore)
						label.SetAlignedPosition 64, 25, FlexDMD_Align_Center
					Else
						label.text=" "
					End If
				End If

				If pwnJPCounter>2150 Then
					FlexDMD.Stage.GetLabel("pwntext2").Visible=Fasle
					FlexDMD.Stage.GetLabel("pwntext").Visible=Fasle
					FlexDMD.Stage.GetImage("pwnjp").Visible=Fasle
					FlexDMD.Stage.GetImage("pwnjp2").Visible=Fasle
					pwnJP=0 : pwnJPtimer=15 : pwnJPCounter=0
					SLS(96,1)=0 : spb2 96,96,3,0,0,1
					SignTurnON.enabled=True
					nl001.image="pwnage"
					spb1 146,146,20,2,2,1

					P045.material="InsertWhiteOnTri"

				End If

			End If





	
			If Skillshotactive=1 then
				Skillshotactive=2
				Set title = FlexDMD.Stage.GetLabel("Killing")
				title.font=Fontbig1
				title.Text = "   SKILLSHOT   "	
				DisplayTop=""
				Set af = title.ActionFactory
				Set list = af.Sequence()
				list.Add af.MoveTo(-2, 0, 0.1)
				list.Add af.Wait(0.2)
				list.Add af.MoveTo(-2, -20, 0)
				list.Add af.Wait(0.2)
				list.Add af.MoveTo(-2, 0, 0)
				list.Add af.Wait(0.2)
				list.Add af.MoveTo(-2, -20, 0)
				list.Add af.Wait(0.2)
				list.Add af.MoveTo(-2, 0, 0)	
				list.Add af.Wait(0.2)
				list.Add af.MoveTo(-2, -20, 0)
				list.Add af.Wait(0.2)
				list.Add af.MoveTo(-2, 0, 0)
				title.AddAction af.Repeat(list, 1)
			Elseif Skillshotactive=3 Then
				Skillshotactive=4
				Set title = FlexDMD.Stage.GetLabel("Killing")
				title.font=Fontbig1
				If Skillshotresult=1 Then title.Text = "-    MISSED    -"
				If Skillshotresult=2 Then title.Text = "-    ALMOST    -"
				If Skillshotresult=3 Then title.Text = "-     GOOD     -" : SparkleEffect=1
				If Skillshotresult=4 Then title.Text = "-   PERFECT   -" : SparkleEffect=1
				DisplayTop=""
				Set af = title.ActionFactory
				Set list = af.Sequence()
				list.Add af.MoveTo(-2, -20, 0)
				list.Add af.Wait(0.2)
				list.Add af.MoveTo(-2, 0, 0)
				list.Add af.Wait(0.2)
				list.Add af.MoveTo(-2, -20, 0)
				list.Add af.Wait(0.2)
				list.Add af.MoveTo(-2, 0, 0)	
				list.Add af.Wait(0.2)
				list.Add af.MoveTo(-2, -20, 0)
				list.Add af.Wait(0.2)
				list.Add af.MoveTo(-2, 0, 0)
				list.Add af.Wait(2)
				list.Add af.MoveTo(0, -20, 0.1)
				title.AddAction af.Repeat(list, 1)
				Skillshotactive=0
				If skillshotresult>2 Then
					Set title = FlexDMD.Stage.GetLabel("Killing2")
					title.font=Fontbig3
					title.Text = "  SKILLSHOT 2  "	
					DisplayTop=""
					Set af = title.ActionFactory
					Set list = af.Sequence()
					list.Add af.MoveTo(-2, 22, 0.1)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 42, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 22, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 42, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 22, 0)	
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 42, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 22, 0)
					title.AddAction af.Repeat(list, 1)
					Skillshotactive=4

				End If

				Skillshotresult=0
				DisplayTop=""
				DisplayTopTime=100
				DisplayBot=""
				DisplayBotTime=100


			Elseif Skillshotactive=5 Then
				Set title = FlexDMD.Stage.GetLabel("Killing2")
				title.font=Fontbig3
				If Skillshotresult=1 Then title.Text = "-    MISSED    -"
				If Skillshotresult=2 Then title.Text = "-    ALMOST    -"
				If Skillshotresult=3 Then title.Text = "-     GOOD     -" : SparkleEffect=1
				If Skillshotresult=4 Then title.Text = "-   PERFECT   -" : SparkleEffect=1

					Set af = title.ActionFactory
					Set list = af.Sequence()
					list.Add af.MoveTo(-2, 42, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 22, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 42, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 22, 0)	
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 42, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 22, 0)
					list.Add af.Wait(2)
					list.Add af.MoveTo(-2, 42, 0.1)
					title.AddAction af.Repeat(list, 1)
					Skillshotactive=0
					Skillshotresult=0
					DisplayTop=""
					DisplayTopTime=100
					DisplayBot=""

			Elseif Skillshotactive<1 Then


				If DisplayTopTime>0 Then DisplayTopTime=DisplayTopTime-1
				If DisplayTop <> "" And DisplayTopTime<1 Then
					DisplayTopTime=150
					Set title = FlexDMD.Stage.GetLabel("Killing")
					title.font=Displaycolor
					title.Text = DisplayTop	
					DisplayTop=""
					Set af = title.ActionFactory
					Set list = af.Sequence()
					list.Add af.MoveTo(-2, 0, 0.1)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, -20, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 0, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, -20, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 0, 0)	
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, -20, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 0, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, -20, 0.1)
					title.AddAction af.Repeat(list, 1)

					Set title = FlexDMD.Stage.GetLabel("Killing2")
					title.font=Displaycolor
					title.Text = DisplayBot	
					DisplayBot=""
					Set af = title.ActionFactory
					Set list = af.Sequence()
					list.Add af.MoveTo(-2, 22, 0.1)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 42, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 22, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 42, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 22, 0)	
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 42, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 22, 0)
					list.Add af.Wait(0.2)
					list.Add af.MoveTo(-2, 42, 0.1)
					title.AddAction af.Repeat(list, 1)
				End If

			
				if extralife=1 Then
					SignTurnON.enabled=True
					nl001.image="extralife"
					extralife=0
					SLS(185,2)=68 '  GI blink 2
					SLS(1,0)=1 : spb1 1,1,5,0,0,1
					DOF 110,2
					DOF 113,2
					for i = 1 to 30
						Set title= FlexDMD.Stage.GetImage("EL_" & i )
						Set af = title.ActionFactory
						Set list = af.Sequence()
						List.Add af.Wait(0.07 * (i - 1))
						List.Add af.Show(True)
						List.Add af.Wait(0.072)
						List.Add af.Show(False)
						List.Add af.Wait(0.07)
						title.AddAction af.Repeat(list, 1)
					Next
				End If

				if capture=1 Then
					capture=0
					for i = 1 to 26
						SLS(185,2)=68 '  GI blink 2
						SLS(1,0)=1 : spb1 1,1,5,0,0,1
	DOF 110,2
	DOF 113,2
						Set title= FlexDMD.Stage.GetImage("CAP_" & i )
						Set af = title.ActionFactory
						Set list = af.Sequence()
						List.Add af.Wait(0.07 * (i - 1))
						List.Add af.Show(True)
						List.Add af.Wait(0.072)
						List.Add af.Show(False)
						List.Add af.Wait(0.07)
						title.AddAction af.Repeat(list, 1)
					Next
				End If


' double headshots
				If doubleheadshots=1 Then
					doublehscounter=doublehscounter+1
					Select Case doublehscounter
						case  2 : FlexDMD.Stage.GetImage("doubleHS0").Visible=True 
						SLS(185,2)=68 '  GI blink 2
						spb2 1,1,7,0,0,1
	DOF 110,2
	DOF 113,2
						case  6 : FlexDMD.Stage.GetImage("doubleHS1").Visible=True : FlexDMD.Stage.GetImage("doubleHS0").Visible=False
						case 10 : FlexDMD.Stage.GetImage("doubleHS2").Visible=True : FlexDMD.Stage.GetImage("doubleHS1").Visible=False
						case 14 : FlexDMD.Stage.GetImage("doubleHS3").Visible=True : FlexDMD.Stage.GetImage("doubleHS2").Visible=False
						case 18 : FlexDMD.Stage.GetImage("doubleHS4").Visible=True : FlexDMD.Stage.GetImage("doubleHS3").Visible=False
						case 22 : FlexDMD.Stage.GetImage("doubleHS5").Visible=True : FlexDMD.Stage.GetImage("doubleHS4").Visible=False
						case 24 : PlaySound "wstartc" & int(rnd(1)*2) , 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
						case 26,42,58,73 : FlexDMD.Stage.GetImage("doubleHS6").Visible=True : FlexDMD.Stage.GetImage("doubleHS5").Visible=False
						case 30,46,62,76 : FlexDMD.Stage.GetImage("doubleHS5").Visible=True : FlexDMD.Stage.GetImage("doubleHS6").Visible=False
						case 34,50,66,79 : FlexDMD.Stage.GetImage("doubleHS7").Visible=True : FlexDMD.Stage.GetImage("doubleHS5").Visible=False
						case 38,54,70,82 : FlexDMD.Stage.GetImage("doubleHS5").Visible=True : FlexDMD.Stage.GetImage("doubleHS7").Visible=False

						case 86 : FlexDMD.Stage.GetImage("doubleHS4").Visible=True : FlexDMD.Stage.GetImage("doubleHS5").Visible=False
						case 90 : FlexDMD.Stage.GetImage("doubleHS3").Visible=True : FlexDMD.Stage.GetImage("doubleHS4").Visible=False
						case 94 : FlexDMD.Stage.GetImage("doubleHS2").Visible=True : FlexDMD.Stage.GetImage("doubleHS3").Visible=False
						case 98 : FlexDMD.Stage.GetImage("doubleHS1").Visible=True : FlexDMD.Stage.GetImage("doubleHS2").Visible=False
						case 102: FlexDMD.Stage.GetImage("doubleHS0").Visible=True : FlexDMD.Stage.GetImage("doubleHS1").Visible=False
						case 106 :													 FlexDMD.Stage.GetImage("doubleHS0").Visible=False
								doublehscounter=0
								doubleheadshots=0
								SparkleEffect=1
					End Select
				End If

' invisibility
				If invisireward=1 Then
					invisicounter=invisicounter+1
					Select Case invisicounter
						case  2 : FlexDMD.Stage.GetImage("invisibility0").Visible=True
						SLS(185,2)=68 '  GI blink 2
						SLS(1,0)=1 : spb1 1,1,5,0,0,1
						SPB1 201,202,10,0,0,1

	DOF 110,2
	DOF 113,2
						case  6 : FlexDMD.Stage.GetImage("invisibility1").Visible=True : FlexDMD.Stage.GetImage("invisibility0").Visible=False
						case 10 : FlexDMD.Stage.GetImage("invisibility2").Visible=True : FlexDMD.Stage.GetImage("invisibility1").Visible=False
						case 14 : FlexDMD.Stage.GetImage("invisibility3").Visible=True : FlexDMD.Stage.GetImage("invisibility2").Visible=False
						case 18 : FlexDMD.Stage.GetImage("invisibility4").Visible=True : FlexDMD.Stage.GetImage("invisibility3").Visible=False
						case 20 : PlaySound "wstartc" & int(rnd(1)*2), 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
						case 22 : FlexDMD.Stage.GetImage("invisibility5").Visible=True : FlexDMD.Stage.GetImage("invisibility4").Visible=False

						case 26,34,42,50,58,66,74 : FlexDMD.Stage.GetImage("invisibility6").Visible=True : FlexDMD.Stage.GetImage("invisibility5").Visible=False
						case 30,38,46,54,62,70,78 : FlexDMD.Stage.GetImage("invisibility5").Visible=True : FlexDMD.Stage.GetImage("invisibility6").Visible=False

						case 82 : FlexDMD.Stage.GetImage("invisibility4").Visible=True : FlexDMD.Stage.GetImage("invisibility5").Visible=False
						case 86 : FlexDMD.Stage.GetImage("invisibility3").Visible=True : FlexDMD.Stage.GetImage("invisibility4").Visible=False
						case 90 : FlexDMD.Stage.GetImage("invisibility2").Visible=True : FlexDMD.Stage.GetImage("invisibility3").Visible=False
						case 94 : FlexDMD.Stage.GetImage("invisibility1").Visible=True : FlexDMD.Stage.GetImage("invisibility2").Visible=False
						case 98 : FlexDMD.Stage.GetImage("invisibility0").Visible=True : FlexDMD.Stage.GetImage("invisibility1").Visible=False
						case 102 :													 FlexDMD.Stage.GetImage("invisibility0").Visible=False
								invisicounter=0
								invisireward=0
								SparkleEffect=1
					End Select
				End If

			End If



			FlexDMD.Stage.GetLabel("Ball").Text = "Ball "& BallInPlay
			FlexDMD.Stage.GetLabel("Credit").Text = "Credits "& Credits

		If ( Frame mod 15 ) = 3 Then
			If SC(pn,34)=1 Then 
				FlexDMD.Stage.GetLabel("Title").Font = FontScoreActive
			Elseif LFinfo>5 Or RFinfo>5 Then
				FlexDMD.Stage.GetLabel("Title").Font = FONTSCROLLERgreen
			Else
				FlexDMD.Stage.GetLabel("Title").Font = FONTSCROLLER
			End If
		End If

		If ( Frame mod 15 ) = 0 Then FlexDMD.Stage.GetLabel("Title").Font = FontScoreInActive

		If ( Frame mod 370) = 219 Then
				SPB1 112,118,1,0,1,1
 
'				debug.print "scrollertext" & scrollerText
				
			Set title = FlexDMD.Stage.GetLabel("Title")
			Set af = title.ActionFactory
			Set list = af.Sequence()
			list.Add af.Wait(0.1)
			List.Add af.Show(True)
			list.Add af.Wait(2.3)
			List.Add af.Show(False)
			list.Add af.Wait(0.1)
			title.AddAction af.Repeat(list, 1)


			If SC(pn,34)=1 Then ' Room of champions  34=1=ON ... 35=level
				Flippinfo=0
				scrollerText=0
				ROCcounter=ROCcounter+1

				Select Case ROCcounter
					Case 1 : FlexDMD.Stage.GetLabel("Title").Text = " ROOM OF CHAMPIONS "  & SC(PN,35) + SC(PN,36)*5 - 5


					Case 2 : 
				If SC(PN,35)=1 Then FlexDMD.Stage.GetLabel("Title").Text = "CAPTURE "& SC(PN,36)-SC(PN,37) &" FLAG/S MORE"
				If SC(PN,35)=2 Then FlexDMD.Stage.GetLabel("Title").Text = "GET " & SC(PN,36)*5-SC(PN,38) & " HEADSHOTS MORE"
				If SC(PN,35)=3 Then FlexDMD.Stage.GetLabel("Title").Text = " SPINNERS " & SC(PN,36)*50-SC(PN,39) & " LEFT"
				If SC(PN,35)=4 Then FlexDMD.Stage.GetLabel("Title").Text = "  BUMPERS " & SC(PN,36)*20-SC(PN,40) & " LEFT"
				If SC(PN,35)=5 Then FlexDMD.Stage.GetLabel("Title").Text = "  GAIN INVISIBILITY  "

					Case 3 :
					' mission 
				If SC(PN,35)=1 Then FlexDMD.Stage.GetLabel("Title").Text = " REWARD " & SC(PN,36)*10 & " MILLIONS  "
				If SC(PN,35)=2 Then FlexDMD.Stage.GetLabel("Title").Text = " REWARD " & SC(PN,36)*20 & " MILLIONS  "
				If SC(PN,35)=3 Then FlexDMD.Stage.GetLabel("Title").Text = " REWARD " & SC(PN,36)*30 & " MILLIONS  "
				If SC(PN,35)=4 Then FlexDMD.Stage.GetLabel("Title").Text = " REWARD " & SC(PN,36)*40 & " MILLIONS  "
				If SC(PN,35)=5 Then FlexDMD.Stage.GetLabel("Title").Text = " REWARD " & SC(PN,36)*100 & " MILLIONS  "
							ROCcounter=0
				End Select

			Else
				ROCcounter=0

				If LFinfo>5 Or RFinfo>5 Then
					scrollerText=0

					flippinfo=Flippinfo+1
					Select case Flippinfo
					Case 1 : FlexDMD.Stage.GetLabel("Title").Text = "< GAME INFORMATION >"
					Case 2 : FlexDMD.Stage.GetLabel("Title").Text = "BONUS = " & formatscore(SC(PN,0))
						 PlaySound "AAUTHealth", 1, 0.2 * BG_Volume, 0, 0,0,0, 0, 0

					Case 3 : If SC(PN,18) < 7 Then
							FlexDMD.Stage.GetLabel("Title").Text = "LOCKING START IN "& (7 - SC(PN,18))
						Else
							if MBActive=0 Then
								FlexDMD.Stage.GetLabel("Title").Text = "LOCKING IS ACTIVE  "
							Else
								FlexDMD.Stage.GetLabel("Title").Text = "MULTIBALL IS ACTIVE"
							End If
						End If

					Case 4 : IF SC(PN,19) < 10 Then
							 FlexDMD.Stage.GetLabel("Title").Text = "EXTRA LIFE LIT IN "& (10 - SC(PN,19))
						Else
							FlexDMD.Stage.GetLabel("Title").Text =  "EXTRA LIFE ALREADY GOTTEN"
					End If
					Case 5 : FlexDMD.Stage.GetLabel("Title").Text =   "PWNAGES " & pwnage & " (3+6= 2X)"
					Case 6 : FlexDMD.Stage.GetLabel("Title").Text =   "GET BACK IN THERE"
					Case 7 : FlexDMD.Stage.GetLabel("Title").Text =   "THE TEAM NEED YOU"
							Flippinfo=0
					End Select

				Else
					Flippinfo=0

					If Respawn > 21 Then
						FlexDMD.Stage.GetLabel("Title").Text = ">  RESPAWN TIMER " & Respawn & "  <"	
					Else
						scrollerText=scrollerText+1 
						If TournamentMode=1 Then
							If scrollerText=2 Or scrollerText=5 Then FlexDMD.Stage.GetLabel("Title").Text = " < TOURNAMENT  MODE > " 
						Else
							select case scrollerText
							case 1 : FlexDMD.Stage.GetLabel("Title").Text = "< UNREAL  TOURNAMENT >"	
	
							case 2 : 
								If gottenreplay(PN)=0 Then
									FlexDMD.Stage.GetLabel("Title").Text = "REPLAY AT:" & FormatScore(ReplayTarget) 	
								Else
									FlexDMD.Stage.GetLabel("Title").Text = "CHAMPION:" & FormatScore(hScore(1))
									scrollerText=3
								End If
			
							case 3 : FlexDMD.Stage.GetLabel("Title").Text = "CHAMPION:" & FormatScore(hScore(1))
	
							case 4 :
								If pwnage>1 then
									FlexDMD.Stage.GetLabel("Title").Text = "SUPER BUMPERS ACTIVE"	
								Elseif DoubleHS>0 Then
									FlexDMD.Stage.GetLabel("Title").Text = "DOUBLEHEADSHOT ACTIVE"				
								Else
									FlexDMD.Stage.GetLabel("Title").Text = "HOLD FLIPPER FOR INFO"
									scrollerText=5
								End If
	
							case 5 :
									If doubleHS>0 and pwnage>1 then
										FlexDMD.Stage.GetLabel("Title").Text = "DOUBLEHEADSHOT ACTIVE"	
									Else
										FlexDMD.Stage.GetLabel("Title").Text = "HOLD FLIPPER FOR INFO"
									End If
							case 6 : 
									If doubleHS>0 and pwnage>1 then
										FlexDMD.Stage.GetLabel("Title").Text = "HOLD FLIPPER FOR INFO"
									Else
										FlexDMD.Stage.GetLabel("Title").Text = "L/MAGNAKEY: MUSIC/TEAM"
									End If	
							case 7 : 
									FlexDMD.Stage.GetLabel("Title").Text = "R/MAGNAKEY: MAIN TAUNT"
									scrollerText=0
							End Select
						End If
					End If
				End If
			End If
		End If

			tempnr2=1
			If SLS(35,1) > 0 Then tempnr2=tempnr2+0.20
			If SLS(36,1) > 0 Then tempnr2=tempnr2+0.70
			If SLS(37,1) > 0 Then tempnr2=tempnr2+0.20
			If SLS(38,1) > 0 Then tempnr2=tempnr2+0.40
			If SLS(39,1) > 0 Then tempnr2=tempnr2+0.40
			If SLS(40,1) > 0 Then tempnr2=tempnr2+0.40
			if tempnr2 > 1 and (Frame Mod 10) > 0 then 
				FlexDMD.Stage.GetLabel("xscore").Text = "x"&tempnr2
			Else
				FlexDMD.Stage.GetLabel("xscore").Text = "   "
			End If
		End if
		
		If replaywin=1 Then
				replaywin=2
				Set title= FlexDMD.Stage.GetImage("replay0" )
				Set af = title.ActionFactory
				Set list = af.Sequence()
				list.add af.Show(True)
				list.Add af.MoveTo(0, 0, 1)
				list.Add af.Wait(1)
				list.Add af.MoveTo(-128, 0, 1)
				list.Add af.Wait(0.2)
				list.add af.Show(False)
				list.Add af.MoveTo(128, 0, 1)
				title.AddAction af.Repeat(list, 1)
				Set title= FlexDMD.Stage.GetImage("replay1" )
				Set af = title.ActionFactory
				Set list = af.Sequence()
				list.add af.Show(True)
				list.Add af.MoveTo(0, 0, 1)
				list.Add af.Wait(1)
				list.Add af.MoveTo(128, 0, 1)
				list.Add af.Wait(0.2)
				list.add af.Show(False)
				list.Add af.MoveTo(-128, 0, 1) ' rneed to be ready for nextplayer getting replay
				title.AddAction af.Repeat(list, 1)
			End If

			FlexDMD.UnlockRenderThread


		Case 4 :

			if frame>780 Then createvidEnter2: GameOverTimer_Timer

		Case 5:

			FlexDMD.LockRenderThread


			If Len( EnteredName )>0 Then FlexDMD.Stage.GetLabel("name1").Text = mid(EnteredName,1,1)
			If Len( EnteredName )>1 Then FlexDMD.Stage.GetLabel("name2").Text = mid(EnteredName,2,1)
			If Len( EnteredName )>2 Then FlexDMD.Stage.GetLabel("name3").Text = mid(EnteredName,3,1)

			If (Frame MOD 20) = 10 Then FlexDMD.Stage.GetLabel("arrows").font = FontScoreActive
			If (Frame MOD 20) =  0 Then FlexDMD.Stage.GetLabel("arrows").font = FontScoreinActive

			tempstr="ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789"
			FlexDMD.Stage.GetLabel("letters").Text = mid(tempstr,entercurrent+23,14) + " " + mid(tempstr,entercurrent+37,1)+" " + mid(tempstr,entercurrent+38,14)

			FlexDMD.Stage.GetLabel("score").Text = "PLAYER " & entertemp & " : " & FormatScore(SC(entertemp,1))
			FlexDMD.Stage.GetLabel("score").SetAlignedPosition 64, 14, FlexDMD_Align_Center



			FlexDMD.UnlockRenderThread

		Case 6:
		Case 7:
			If frame>30 then Snakeupdate
	End Select


End Sub

Dim scrollerText
Dim entertemp
Dim replaywin
Dim Flippinfo
Dim ROCcounter


Dim FontScoreActive2
Dim FontScoreActive3
Dim FontScoreActive4
Dim FontScoreActive5
Dim FontOrange
Dim fontbig1
Dim fontbig2
Dim fontbig3

Sub	createvidEnter2
	frame=0 ' USED AS TIMER
	DMDmode=6 ' enternamevideo


	Set scene = FlexDMD.NewGroup("tempenter")
	dim vidvid
	set vidvid=FlexDMD.Newvideo ("enter",FlexPath & "enterBG2.gif")
	scene.AddActor vidvid
	scene.Getvideo("enter").SetBounds 0, 0, 128, 32
	scene.Getvideo("enter").Visible = True

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode =  FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	If VRroom > 0 Then FlexDMD.Show = False Else FlexDMD.Show = True
	FlexDMD.Run = True
	FlexDMD.UnlockRenderThread
End Sub

dim fontbig
Sub	createvidEnter
	frame=0 ' USED AS TIMER
	DMDmode=5 ' enternamevideo

	Dim title, af,list
	Dim scene 



	Set FontScoreActive = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", vbWhite, RGB(0, 0, 0), 0)
	Set FontScoreInactive = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(64, 64, 64), RGB(0, 0, 0), 0)
	Set FontScoreCredits = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(4, 88, 4),  RGB(0, 0, 0), 0)
	Set FontBig = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(255, 155, 0), vbWhite, 0)
	Set FontBig1 = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(255, 255, 0), vbBLACK, 1)	
	Set FontBig2 = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(255, 0, 0), vbBLACK, 1)
	Set FontBig3 = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(0, 255, 0), vbBLACK, 1)
	Dim FontSUper : Set FontSuper =  FlexDMD.NewFont("FlexDMD.Resources.udmd-f7by13.fnt", RGB(255, 155, 0), vbBLACK, 1)



	Set scene = FlexDMD.NewGroup("enterhigh")

	dim vidvid
	set vidvid=FlexDMD.Newvideo ("enter",FlexPath & "enterBG2.gif")
	scene.AddActor vidvid
	scene.Getvideo("enter").SetBounds 0, 0, 128, 32
	scene.Getvideo("enter").Visible = True

'	scene.AddActor FlexDMD.NewGroup("underlay")

		PlaySound "UTlogo3", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
'		scene.AddActor FlexDMD.NewGroup("Content")

		Set title = FlexDMD.NewLabel("toptext", FontBig, "NEW HIGHSCORE" )
		title.Visible=false	
		Set af = title.ActionFactory
		Set list = af.Sequence()
		list.Add af.MoveTo(8, -20, 0)
		list.add af.Show(True)
		list.Add af.MoveTo(8, 0, 1)
		list.Add af.Wait(1)
		title.AddAction af.Repeat(list, 1)
		scene.AddActor title

		Set title = FlexDMD.NewLabel("score", FontScoreActive, "             " )
		title.Visible=false	
		Set af = title.ActionFactory
		Set list = af.Sequence()
		list.Add af.Wait(2)
		list.add af.Show(True)
		list.Add af.Wait(0.1)
		list.add af.Show(False)
		list.Add af.Wait(0.1)
		list.add af.Show(True)
		list.Add af.Wait(0.1)
		list.add af.Show(False)
		list.Add af.Wait(0.1)
		list.add af.Show(True)
		list.Add af.Wait(0.1)
		list.add af.Show(False)
		list.Add af.Wait(0.1)
		list.add af.Show(True)
		list.Add af.Wait(0.1)
		list.add af.Show(False)
		list.Add af.Wait(0.1)
		list.add af.Show(True)
		list.Add af.Wait(0.1)
		list.add af.Show(False)
		list.Add af.Wait(0.1)
		list.add af.Show(True)
		list.Add af.Wait(0.1)
		title.AddAction af.Repeat(list, 1)
		scene.AddActor title
		scene.GetLabel("score").SetAlignedPosition 64, 13, FlexDMD_Align_Center

		Set title = FlexDMD.NewLabel("name1", FontBig1, "_" )
		title.Visible=false	
		Set af = title.ActionFactory
		Set list = af.Sequence()
		list.Add af.MoveTo(48, 16, 0)
		list.Add af.Wait(2.5)
		list.add af.Show(True)
		list.Add af.Wait(1)
		title.AddAction af.Repeat(list, 1)
		scene.AddActor title
	
		Set title = FlexDMD.NewLabel("name2", FontBig1, "_" )
		title.Visible=false	
		Set af = title.ActionFactory
		Set list = af.Sequence()
		list.Add af.MoveTo(60, 16, 0)
		list.Add af.Wait(2.5)
		list.add af.Show(True)
		list.Add af.Wait(1)
		title.AddAction af.Repeat(list, 1)
		scene.AddActor title
	
		Set title = FlexDMD.NewLabel("name3", FontBig1, "_" )
		title.Visible=false	
		Set af = title.ActionFactory
		Set list = af.Sequence()
		list.Add af.MoveTo(72, 16, 0)
		list.Add af.Wait(2.5)
		list.add af.Show(True)
		list.Add af.Wait(1)
		title.AddAction af.Repeat(list, 1)
		scene.AddActor title


		Set title = FlexDMD.NewLabel("letters", FontScoreActive, "WXYZ-123456789 A BCDEFGHIJKLMNO" )
		title.Visible=false	
		Set af = title.ActionFactory
		Set list = af.Sequence()
		list.Add af.MoveTo(2, 33, 0)
		list.Add af.Wait(3)
		list.add af.Show(True)
		list.Add af.MoveTo(2, 27, 1)
		list.Add af.Wait(1)
		title.AddAction af.Repeat(list, 1)
		scene.AddActor title
	

		Set title = FlexDMD.NewLabel("arrows", FontScoreInactive, "              > <" )
		title.Visible=false	
		Set af = title.ActionFactory
		Set list = af.Sequence()
		list.Add af.MoveTo(2, 33, 0)
		list.Add af.Wait(3)
		list.add af.Show(True)
		list.Add af.MoveTo(2, 27, 1)
		list.Add af.Wait(1)
		title.AddAction af.Repeat(list, 1)
		scene.AddActor title

		if replaywin > 0 Then
			Set title = FlexDMD.NewImage("replay0", flexpath & "replay1.png")
			title.SetBounds 0, 0, 128, 32
			title.Visible = False
			Set af = title.ActionFactory
			Set list = af.Sequence()
			list.Add af.MoveTo(128, 0, 0)
			list.Add af.Wait(1)
			list.add af.Show(True)
			list.Add af.MoveTo(0, 0, 1)
			list.Add af.Wait(1)
			list.Add af.MoveTo(-128, 0, 1)
			list.Add af.Wait(1)
			title.AddAction af.Repeat(list, 1)
		scene.AddActor title

			Set title = FlexDMD.NewImage("replay1", flexpath & "replay2.png")
			title.SetBounds 0, 0, 128, 32
			title.Visible = False
			Set af = title.ActionFactory
			Set list = af.Sequence()
			list.Add af.MoveTo(-128, 0, 0)
			list.Add af.Wait(1)
			list.add af.Show(True)
			list.Add af.MoveTo(0, 0, 1)
			list.Add af.Wait(1)
			list.Add af.MoveTo(128, 0, 1)
			list.Add af.Wait(1)
			title.AddAction af.Repeat(list, 1)
		scene.AddActor title

		End If


		if replaywin=2 Then
			Set title = FlexDMD.NewImage("replay2", flexpath & "double.png")
			title.SetBounds 0, 0, 128, 32
			title.Visible = False
			Set af = title.ActionFactory
			Set list = af.Sequence()
			list.Add af.MoveTo(0, -32, 0)
			list.Add af.Wait(1)
			list.add af.Show(True)
			list.Add af.MoveTo(0, 0, 1)
			list.Add af.Wait(1)
			list.Add af.MoveTo(0, 32, 1)
			list.Add af.Wait(1)
			title.AddAction af.Repeat(list, 1)
		scene.AddActor title
			
		End If



	FlexDMD.LockRenderThread
	FlexDMD.RenderMode =  FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	If VRroom > 0 Then FlexDMD.Show = False Else FlexDMD.Show = True
	FlexDMD.Run = True
	FlexDMD.UnlockRenderThread


End Sub



Dim FontBig4
DIM FONTSCROLLER
Dim FONTSCROLLERgreen



Sub CreateScoreSceneSternStyle()

	frame=0
	DMDmode=3
	scrollerText=0

	CreateGameDMD


End Sub

dim fontbigwhite
Dim FontBigGreen
Sub CreateGameDMD

	Dim title, af,list

	Set FontScoreActive = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", vbWhite, RGB(0, 0, 0), 0)
	Set FontScoreInactive = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(64, 64, 64), RGB(0, 0, 0), 0)
	Set FONTSCROLLERgreen = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(0, 100, 0), RGB(0, 0, 0), 0)
	Set FONTSCROLLER = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(140, 123, 0), RGB(0, 0, 0), 0)
	Set FontScoreCredits = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(16, 118, 27),  RGB(0, 0, 0), 0)
	Set FontBig = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(255, 155, 0), vbWhite, 0)
	Set FontBigGreen = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(77,255, 50), vbWhite, 0)

	Set fontbigwhite = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(255, 255, 255), vbBLACK, 0)
	Set FontBig1 = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(255, 255, 0), vbBLACK, 1)	
	Set FontBig2 = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(255, 0, 0), vbBLACK, 1)
	Set FontBig3 = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(0, 255, 0), vbBLACK, 1)
	Set FontBig4 = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(0, 99, 99), vbBLACK, 1)
	Dim FontSUper : Set FontSuper =  FlexDMD.NewFont("FlexDMD.Resources.udmd-f7by13.fnt", RGB(255, 155, 0), vbBLACK, 1)

	Dim scene 
	Set scene = FlexDMD.NewGroup("Score")

	dim vidvid

If MoviesIngame=1 Then
	set vidvid=FlexDMD.Newvideo ("test",FlexPath & "coret.gif")
	scene.AddActor vidvid
	scene.Getvideo("test").SetBounds 0, 0, 128, 32
	scene.Getvideo("test").Visible = True

	set vidvid=FlexDMD.Newvideo ("test2",FlexPath & "november.gif")
	scene.AddActor vidvid
	scene.Getvideo("test2").SetBounds 0, 0, 128, 32
	scene.Getvideo("test2").Visible = False

	set vidvid=FlexDMD.Newvideo ("test3",FlexPath & "dreary.gif")
	scene.AddActor vidvid
	scene.Getvideo("test3").SetBounds 0, 0, 128, 32
	scene.Getvideo("test3").Visible = False

	set vidvid=FlexDMD.Newvideo ("test4",FlexPath & "face.gif")
	scene.AddActor vidvid
	scene.Getvideo("test4").SetBounds 0, 0, 128, 32
	scene.Getvideo("test4").Visible = False
End If


	For i = 1 to 4
		scene.AddActor FlexDMD.NewLabel("Score_" & i, FontScoreInactive, " ")
	Next

	scene.AddActor FlexDMD.NewFrame("VSeparator")
	scene.GetFrame("VSeparator").Thickness = 1
	scene.GetFrame("VSeparator").SetBounds 40, 0, 1, 32

	Dim scene1 
	Set scene1 = FlexDMD.NewGroup("Content")
	scene1.Clip = True
	scene1.SetBounds 41, 0, 128-41, 32
	scene1.AddActor FlexDMD.NewLabel("Ball", FontScoreCredits, " ")
	scene1.AddActor FlexDMD.NewLabel("Credit", FontScoreCredits, " ")
	scene1.AddActor FlexDMD.NewLabel("xscore", FontScoreActive, " ")
	scene1.GetLabel("Credit").SetAlignedPosition 52, 27, FlexDMD_Align_TopRight
	scene1.GetLabel("xscore").SetAlignedPosition 32, 27 , FlexDMD_Align_TopRight
	scene1.GetLabel("Ball").SetAlignedPosition 0, 27, FlexDMD_Align_TopLeft


	Set title = FlexDMD.NewLabel("Title", FONTSCROLLER, "< UNREAL  TOURNAMENT >")
	title.Visible = False
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(128, 0, 0)
	list.Add af.Show(True)
	list.Add af.Wait(0.1)
	list.Add af.MoveTo(-200, 0, 4.0)
	list.Add af.Wait(0.1)
	list.Add af.MoveTo(0, 0, 0)
	title.AddAction af.Repeat(list, 1)
	scene1.AddActor title

	Set title = FlexDMD.NewLabel("Content_1", FontBig, " ")
	Set af = title.ActionFactory
	Set list = af.Sequence()
	title.AddAction af.Repeat(list, 1)
	scene1.AddActor title
	
	Dim scene2 
	Set scene2 = FlexDMD.NewGroup("Velcap")

	Set title = FlexDMD.NewLabel("Killing", FontBig1, " " )
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, -20, 0)

	title.AddAction af.Repeat(list, 1)
	scene2.AddActor title


	Set title = FlexDMD.NewLabel("Killing2", FontBig1, " " )
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, 42, 0)
	title.AddAction af.Repeat(list, 1)
	scene2.AddActor title



		Set title = FlexDMD.NewImage("pwnjp2", flexpath & "pwnageJPdark.png")
		title.Visible = False
		Scene2.AddActor title
		Set title = FlexDMD.NewImage("pwnjp", flexpath & "pwnageJP.png")
		title.Visible = False
		Scene2.AddActor title


		Set title = FlexDMD.NewLabel("pwntext", FontBigWHITE, "DOUBLE PWNAGE" )
		title.SetAlignedPosition 64, 11, FlexDMD_Align_Center
		title.Visible=False 
		scene2.AddActor title
		Set title = FlexDMD.NewLabel("pwntext2", FontBigWHITE, "TOWER IN 15" )
		title.SetAlignedPosition 64, 25, FlexDMD_Align_Center
		title.Visible=False
		scene2.AddActor title




	For i = 1 to 30
		Set title = FlexDMD.NewImage("EL_" & i, flexpath & "EL/EL" & i & ".png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		scene2.AddActor title
	Next
	For i = 1 to 26
		Set title = FlexDMD.NewImage("CAP_" & i, flexpath & "CAP/CAP" & i & ".png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		scene2.AddActor title
	Next

	for i = 0 to 7 
		Set title = FlexDMD.NewImage("doubleHS" & i, flexpath & "DOU/doubleHS" & i & ".png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		scene2.AddActor title
	Next

	for i = 0 to 6
		Set title = FlexDMD.NewImage("invisibility" & i, flexpath & "INV/invisibility" & i & ".png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		scene2.AddActor title
	Next

	for i = 0 to 14
		Set title = FlexDMD.NewImage("respawn" & i, flexpath & "RES/respawn" & i & ".png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		scene2.AddActor title
	Next
	for i = 0 to 11 ' ball locked anim
		If i=0 Then Set title = FlexDMD.NewImage("Locked0" , flexpath & "barg.png") Else Set title = FlexDMD.NewImage("Locked" & i, flexpath & "LOC/Locked" & i & ".png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		scene2.AddActor title
	Next

	for i = 0 to 9 ' multiball
		If i=0 Then Set title = FlexDMD.NewImage("Multiball0" , flexpath & "barg.png") Else	Set title = FlexDMD.NewImage("Multiball" & i, flexpath & "MUL/Multiball" & i & ".png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		scene2.AddActor title
	Next

	for i = 0 to 8
		Set title = FlexDMD.NewImage("round" & i, flexpath & "ROU/round" & i & ".png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		scene2.AddActor title
		Set title = FlexDMD.NewImage("roundr" & i, flexpath & "ROU/roundr" & i & ".png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		scene2.AddActor title
		Set title = FlexDMD.NewImage("roundb" & i, flexpath & "ROU/roundb" & i & ".png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		scene2.AddActor title
	Next
	for i = 0 to 23
		Set title = FlexDMD.NewImage("sparkle" & i, flexpath & "SPA/sparkle" & i & ".png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		scene2.AddActor title
	Next

		Set title = FlexDMD.NewImage("barb", flexpath & "barb.png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		Set af = title.ActionFactory
		Set list = af.Sequence()
		list.Add af.MoveTo(0,32, 0)
		title.AddAction af.Repeat(list, 1)
		scene2.AddActor title

		Set title = FlexDMD.NewImage("barr", flexpath & "barr.png")
		title.SetBounds 0, 0, 128, 32
		title.Visible = False
		Set af = title.ActionFactory
		Set list = af.Sequence()
		list.Add af.MoveTo(0,32, 0)
		title.AddAction af.Repeat(list, 1)
		scene2.AddActor title




	Set title = FlexDMD.NewImage("replay0", flexpath & "replay1.png")
	title.SetBounds 0, 0, 128, 32
	title.Visible = False
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(128, 0, 0)
	list.Add af.Wait(1)
	title.AddAction af.Repeat(list, 1)
	scene2.AddActor title

	Set title = FlexDMD.NewImage("replay1", flexpath & "replay2.png")
	title.SetBounds 0, 0, 128, 32
	title.Visible = False
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(-128, 0, 0)
	list.Add af.Wait(1)
	title.AddAction af.Repeat(list, 1)
	scene2.AddActor title

	Dim scene3 
	Set scene3 = FlexDMD.NewGroup("champs")

	scene.AddActor FlexDMD.NewGroup("champs")
	Set title = FlexDMD.NewImage("under", flexpath & "new1.png")
	title.SetBounds 0, 0, 128, 32
'	title.Visible = False
	scene3.AddActor title
	
	Set title = FlexDMD.NewLabel("champtext1", FontScoreActive, "ROOM OF CHAMPIONS " )
'	title.Visible = False
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(31, 9, 0)
	list.Add af.Show(True)
	list.Add af.Wait(1.0)
	list.Add af.Show(False)
	list.Add af.Wait(0.1)
	title.AddAction af.Repeat(list, -1)
	scene3.AddActor title

	Set title = FlexDMD.NewLabel("champtext2", FontScoreActive, "200.000.000" )
'	title.Visible = False
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(43, 18, 0)
	list.Add af.Show(True)
	list.Add af.Wait(0.3)
	list.Add af.Show(False)
	list.Add af.Wait(0.2)
	title.AddAction af.Repeat(list, -1)
	scene3.AddActor title

	scene3.Visible = False


	Dim scene4 
	Set scene4 = FlexDMD.NewGroup("tilting")


	scene.AddActor FlexDMD.NewGroup("tilting")
	Set title = FlexDMD.NewImage("danger", flexpath & "danger.png")
	title.SetBounds 0, 0, 128, 32
	title.Visible = False
	scene4.AddActor title

	Set title = FlexDMD.NewImage("tilt", flexpath & "tilt.png")
	title.SetBounds 0, 0, 128, 32
	title.Visible = False
	scene4.AddActor title

	Set title = FlexDMD.NewImage("tilt2", flexpath & "tilt2.png")
	title.SetBounds 0, 0, 128, 32
	title.Visible = False
	scene4.AddActor title

	Dim scene5 
	Set scene5 = FlexDMD.NewGroup("introvid")
	If shortutlogo3=0 or int(rnd(1)*2)=1 Then
		set vidvid=FlexDMD.Newvideo ("intro",FlexPath & "utlogo3.gif")
	Else
		set vidvid=FlexDMD.Newvideo ("intro",FlexPath & "epic.gif")
	End If
	PlaySound "UTlogo3", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
	scene5.addActor vidvid
	scene5.Getvideo("intro").SetBounds 0, 0, 128, 32
	scene5.Getvideo("intro").Visible = True

	Dim scene6 
	Set scene6 = FlexDMD.NewGroup("underendtext")
'FontBig4 = teal
'3=green
	Set title = FlexDMD.NewImage("Endmap0", flexpath & "END/EndmapBG0.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap1", flexpath & "END/EndmapBG1.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap2", flexpath & "END/EndmapBG2.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap3", flexpath & "END/EndmapBG3.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap4", flexpath & "END/EndmapBG4.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap5", flexpath & "END/EndmapBG5.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap6", flexpath & "END/EndmapBG6.png")
	title.Visible = False
	scene6.AddActor title

	Set title = FlexDMD.NewLabel("Endtext1", FontBig4, " ")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewLabel("Endtext2", FontBig3, " ")
	title.Visible = False
	scene6.AddActor title


	Set title = FlexDMD.NewImage("Liandri1", flexpath & "Liandri1.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Liandri2", flexpath & "Liandri2.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Liandri3", flexpath & "Liandri3.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Liandri4", flexpath & "Liandri4.png")
	title.Visible = False
	scene6.AddActor title

	Set title = FlexDMD.NewLabel("LiandriText", FontBig3, " ")
	title.Visible = False
	scene6.AddActor title



	Set title = FlexDMD.NewImage("Endmap10", flexpath & "END/EndmapBG0.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap11", flexpath & "END/EndmapBG1.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap12", flexpath & "END/EndmapBG2.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap13", flexpath & "END/EndmapBG3.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap14", flexpath & "END/EndmapBG4.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap15", flexpath & "END/EndmapBG5.png")
	title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("Endmap16", flexpath & "END/EndmapBG6.png")
	title.Visible = False
	scene6.AddActor title

	Set title = FlexDMD.NewImage("EnterRoc0", flexpath & "ROC/Roc0.png") : title.Visible = False 
	scene6.AddActor title
	Set title = FlexDMD.NewImage("EnterRoc1", flexpath & "ROC/Roc1.png") : title.Visible = False 
	scene6.AddActor title
	Set title = FlexDMD.NewImage("EnterRoc2", flexpath & "ROC/Roc2.png") : title.Visible = False 
	scene6.AddActor title
	Set title = FlexDMD.NewImage("EnterRoc3", flexpath & "ROC/Roc3.png") : title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("EnterRoc4", flexpath & "ROC/Roc4.png") : title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("EnterRoc5", flexpath & "ROC/Roc5.png") : title.Visible = False 
	scene6.AddActor title
	Set title = FlexDMD.NewImage("EnterRoc6", flexpath & "ROC/Roc6.png") : title.Visible = False 
	scene6.AddActor title
	Set title = FlexDMD.NewImage("EnterRoc7", flexpath & "ROC/Roc7.png") : title.Visible = False
	scene6.AddActor title
	Set title = FlexDMD.NewImage("EnterRoc8", flexpath & "ROC/Roc8.png") : title.Visible = False 
	scene6.AddActor title



	FlexDMD.LockRenderThread
	FlexDMD.RenderMode =  FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Stage.AddActor scene1
	FlexDMD.Stage.AddActor scene2
	FlexDMD.Stage.AddActor scene3
	FlexDMD.Stage.AddActor scene4
	FlexDMD.Stage.AddActor scene5
	FlexDMD.Stage.AddActor scene6
	If DMDmode=0 then
		FlexDMD.Show = False
	Else
		If VRRoom = 0 Then FlexDMD.Show = True Else FlexDMD.Show = False
	End If
	FlexDMD.Run = True
	FlexDMD.UnlockRenderThread
End Sub





Sub	createvidGAMEOVER
	frame=0 ' USED AS TIMER
	DMDmode=4 ' gameover

	Dim title, af,list
	Dim scene 

	Set scene = FlexDMD.NewGroup("Score")

	dim vidvid
	set vidvid=FlexDMD.Newvideo ("gameover",FlexPath & "gameoverslow.gif")
	PlaySound "UTlogo3", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
	scene.AddActor vidvid
	scene.Getvideo("gameover").SetBounds 0, 0, 128, 32
	scene.Getvideo("gameover").Visible = True
	PlaySound "epiclogo", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0


	scene.AddActor FlexDMD.NewLabel("Ball", FontScoreCredits, " ")
	scene.AddActor FlexDMD.NewLabel("Credit", FontScoreCredits, " ")
	scene.AddActor FlexDMD.NewLabel("xscore", FontScoreActive, " ")
	scene.GetLabel("Credit").SetAlignedPosition 52, 27, FlexDMD_Align_TopRight
	scene.GetLabel("xscore").SetAlignedPosition 32, 27 , FlexDMD_Align_TopRight
	scene.GetLabel("Ball").SetAlignedPosition 0, 27, FlexDMD_Align_TopLeft

	scene.AddActor FlexDMD.NewLabel("Last1", FontScoreCredits,"       LAST WARRIOR SCORES       ")
	scene.GetLabel("Last1").SetAlignedPosition 64, 4, FlexDMD_Align_Center

	scene.AddActor FlexDMD.NewLabel("Last2", FontScoreActive6,"P1-" & formatscore (SC(1,1)))
	scene.GetLabel("Last2").SetAlignedPosition 64, 10, FlexDMD_Align_Center

	If sc(2,1)>0 Then
		scene.AddActor FlexDMD.NewLabel("Last3", FontScoreActive6,"P2-" & formatscore (SC(2,1)))
		scene.GetLabel("Last3").SetAlignedPosition 64, 16, FlexDMD_Align_Center
	End If
	If sc(3,1)>0 Then
		scene.AddActor FlexDMD.NewLabel("Last4", FontScoreActive6,"P3-" & formatscore (SC(3,1)))
		scene.GetLabel("Last4").SetAlignedPosition 64, 22, FlexDMD_Align_Center
	End If
	If sc(4,1)>0 Then
		scene.AddActor FlexDMD.NewLabel("Last5", FontScoreActive6,"P4-" & formatscore (SC(4,1)))
		scene.GetLabel("Last5").SetAlignedPosition 64, 28, FlexDMD_Align_Center
	End If


	FlexDMD.LockRenderThread
	FlexDMD.RenderMode =  FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	If VRroom > 0 Then FlexDMD.Show = False Else FlexDMD.Show = True
	FlexDMD.Run = True
	FlexDMD.UnlockRenderThread


End Sub




Sub CreateIntroVideo1
	Dim title, af,list
	DMDmode=1
	frame=0 ' USED AS TIMER

	Set FontScoreActive = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", vbWhite, RGB(0, 0, 0), 0)

	Set FontScoreInactive = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(122, 122, 64), RGB(0, 0, 0), 0)
	Set FontScoreCredits = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(64, 200, 64),  RGB(0, 0, 0), 0)
	Dim FontBig : Set FontBig = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(255, 64, 0), vbWhite, 0)
	Dim FontOrange : Set FontOrange = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(255, 255, 0), vbBLACK, 1)
	Dim FontSUper : Set FontSuper =  FlexDMD.NewFont("FlexDMD.Resources.udmd-f7by13.fnt", RGB(255, 155, 0), vbBLACK, 1)


	Dim scene 

	Set scene = FlexDMD.NewGroup("Score")

	dim vidvid

	If shortutlogo3=0 or int(rnd(1)*2)=1 Then
		set vidvid=FlexDMD.Newvideo ("test",FlexPath & "utlogo3.gif")
	Else
		set vidvid=FlexDMD.Newvideo ("test",FlexPath & "epic.gif")
	End If
	PlaySound "UTlogo3", 1, 0.8*BG_Volume, 0, 0,0,0, 0, 0
	scene.AddActor vidvid
	scene.Getvideo("test").SetBounds 0, 0, 128, 32
	scene.Getvideo("test").Visible = True


	If shortutlogo3=0 Then


	Set title = FlexDMD.NewLabel("Version", FontScoreInActive, cGameVersion )
	title.Visible=false
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(77, -20, 0)
	list.Add af.Show(True)
	list.Add af.Wait(1.0)
	list.Add af.MoveTo(77, 2, 0.8)
	list.Add af.Wait(3.0)
	list.Add af.MoveTo(77, -20, 0.8)
	list.Add af.Wait(0.5)
	title.AddAction af.Repeat(list, 1)
	scene.AddActor title

	If HSreset=1 Then
		HSreset=0
		
			Set title = FlexDMD.NewLabel("HSreset", FontScoreActive, "HIGHSCORE RESET" )

		title.Visible=false
		Set af = title.ActionFactory
		Set list = af.Sequence()
		list.Add af.MoveTo(44, 42, 0)
		list.Add af.Show(True)
		list.Add af.Wait(1.0)
		list.Add af.MoveTo(44, 25, 0.8)
		list.Add af.Wait(3.0)
		list.Add af.MoveTo(44, 42, 0.8)
		list.Add af.Wait(0.5)
		title.AddAction af.Repeat(list, 1)
	scene.AddActor title

	End If


End If

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode =  FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	If VRroom > 0 Then FlexDMD.Show = False Else FlexDMD.Show = True
	FlexDMD.Run = True
	FlexDMD.UnlockRenderThread

End Sub


Dim fontscoreactive6

Sub CreateIntroVideo2
	DMDmode=2
	frame=0 ' USED AS TIMER

	Set FontScoreActive  = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(0,250,0), RGB(0, 0, 0), 0)
	Set FontScoreActive2 = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(0,200,0), RGB(0, 0, 0), 0)
	Set FontScoreActive3 = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(0,150,0), RGB(0, 0, 0), 0)
	Set FontScoreActive4 = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(0,100,0), RGB(0, 0, 0), 0)
	Set FontScoreActive5 = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(0,175,0), RGB(0, 0, 0), 0)
	Set FontScoreActive6 = FlexDMD.NewFont("FlexDMD.Resources.udmd-f4by5.fnt", RGB(255,205,0), RGB(0, 0, 15), 1)

	Set FontScoreInactive = FlexDMD.NewFont("FlexDMD.Resources.udmd-f4by5.fnt", RGB(255, 255, 22 ), RGB(0, 0, 70), 1)
	Set FontScoreCredits = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(64, 200, 64),  RGB(0, 0, 0), 0)
	Set FontBig = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(255, 64, 0), vbWhite, 0)
	Set FontOrange = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(255, 255, 0), vbBLACK, 0)
	Dim FontSUper : Set FontSuper =  FlexDMD.NewFont("FlexDMD.Resources.udmd-f7by13.fnt", RGB(255, 155, 0), vbBLACK, 1)


	Dim scene 
	
	Set scene = FlexDMD.NewGroup("Score")

	dim vidvid
	set vidvid=FlexDMD.Newvideo ("test",FlexPath & "intro.gif")
	If voiceoveronce=0 Then
		PlaySound "AAOpeningVO", 1, 0.74 * BG_Volume, 0, 0,0,0, 0, 0
		voiceoveronce=1
	End If

	scene.AddActor vidvid
	scene.Getvideo("test").SetBounds 0, 0, 128, 32
	scene.Getvideo("test").Visible = True



	Dim title, af,list,main

	scene.AddActor FlexDMD.NewImage("logo1",FlexPath &  "Logo1.png")
	scene.GetImage("logo1").Visible=false
	Set af = scene.GetImage("logo1").ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(0.3)
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(18.3)
	Set main = af.Sequence()
	main.Add af.Repeat(list, -1)
	scene.GetImage("logo1").AddAction main

	scene.AddActor FlexDMD.NewImage("logo3",FlexPath &  "Logo3.png")
	scene.GetImage("logo3").Visible=false
	Set af = scene.GetImage("logo3").ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(2.3) '+1.0
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(18.6-2.3)
	Set main = af.Sequence()
	main.Add af.Repeat(list, -1)
	scene.GetImage("logo3").AddAction main


	Set title = FlexDMD.NewLabel("author", FontScoreactive3,     "    ORIGINAL 2021 BY TARTZANI    " )
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(4.3)
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(18.6-4.3)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	If Not Thisistheday=Month(Now())&Day(Now()) Then
		TodaysBest=0
		Thisistheday=Month(Now())&Day(Now()) 
	End If

	Set title = FlexDMD.NewLabel("todaysbest2", FontScoreactive3, "        TODAYS BEST SCORE        ")
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(7.0)
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(18.6-7)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("todaysbest", FontScoreActive6, formatscore (TodaysBest))
	title.Visible=false	 
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(32, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(7.7)
	list.Add af.MoveTo(32, -32, 4.4)
	list.Add af.Wait(18.6-7.7)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("lastscores", FontScoreactive2, "       LAST WARRIOR SCORES       ")
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(True) 
	list.Add af.Wait(8.8)
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(18.6-8.8)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("p1score", FontScoreActive6, "P1-" & formatscore (Lastscore(1)))
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(20, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(9.3)
	list.Add af.MoveTo(20, -32, 4.4)
	list.Add af.Wait(18.6-9.3)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

If LastScore(2)>0 Then
	Set title = FlexDMD.NewLabel("p2score", FontScoreActive6, "P2-" & formatscore (Lastscore(2)))
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(20, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(9.8)
	list.Add af.MoveTo(20, -32, 4.4)
	list.Add af.Wait(18.6-9.8)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title
End If

If LastScore(3)>0 Then
	Set title = FlexDMD.NewLabel("p3score", FontScoreActive6, "P3-" & formatscore (Lastscore(3)))
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(20, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(10.3)
	list.Add af.MoveTo(20, -32, 4.4)
	list.Add af.Wait(18.6-10.3)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title
End If

If LastScore(4)>0 Then
	Set title = FlexDMD.NewLabel("p4score", FontScoreActive6, "P4-" & formatscore (Lastscore(4)))
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(20, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(10.8)
	list.Add af.MoveTo(20, -32, 4.4)
	list.Add af.Wait(18.6-10.8)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title
End If

	Set title = FlexDMD.NewLabel("highscores", FontScoreactive3, "            CHAMPIONS           ")
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(12.7)
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(18.6-12.7)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("hs1", FontScoreInactive, "NR 1-  " &  highscorename(1))
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(27, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(13.2)
	list.Add af.MoveTo(27, -32, 4.4)
	list.Add af.Wait(18.6-13.2)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("hs1p", FontScoreActive6, formatscore(hScore(1)))
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(30, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(13.7)
	list.Add af.MoveTo(30, -32, 4.4)
	list.Add af.Wait(18.6-13.7)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title



	Set title = FlexDMD.NewLabel("hs2", FontScoreInactive, "NR 2-  "& highscorename(2))
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(27, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(14.4)
	list.Add af.MoveTo(27, -32, 4.4)
	list.Add af.Wait(18.6-14.4)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("hs1p", FontScoreActive6, formatscore(hScore(2)))
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(30, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(14.9)
	list.Add af.MoveTo(30, -32, 4.4)
	list.Add af.Wait(18.6-14.9)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("hs3", FontScoreInactive, "NR 3-  "& highscorename(3))
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(27, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(15.6)
	list.Add af.MoveTo(27, -32, 4.4)
	list.Add af.Wait(18.6-15.6)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("hs1p", FontScoreActive6, formatscore(hScore(3)))
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(30, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(16.1)
	list.Add af.MoveTo(30, -32, 4.4)
	list.Add af.Wait(18.6-16.1)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("sayno", FontScoreactive2, "       PLUNGER FOR SNAKE    ")

	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(17.5)
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(18.6-17.5)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("playmore", FontScoreactive2, "       'R' MAGNIFY RULES    ")
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(18.0)
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(0.6)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("sayno2", FontScoreactive, "        SAY NO TO DRUGS        ")
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(18.5)
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(0.1)
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(False)
	list.Add af.Wait(18.5)
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(0.1)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title

	Set title = FlexDMD.NewLabel("sayno3", FontScoreactive, "      DONT DRINK AND DRIVE     ")
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(False)
	list.Add af.Wait(18.5)
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(0.1)
	list.Add af.MoveTo(0, 33, 0)
	list.add af.Show(True)
	list.Add af.Wait(18.5)
	list.Add af.MoveTo(0, -32, 4.4)
	list.Add af.Wait(0.1)
	title.AddAction af.Repeat(list, -1)
	scene.AddActor title



	Set title = FlexDMD.NewLabel("credits", FontScoreActive, " " )
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(48, -20, 0)
	list.add af.Show(True)
	list.Add af.Wait(1.0)
	list.Add af.MoveTo(48, 1, 2)
	list.Add af.Wait(1.0)
	title.AddAction af.Repeat(list, 1)
	scene.GetGroup("Score").AddActor title

	Set title = FlexDMD.NewLabel("insert", FontScoreActive, " " )
	title.Visible=false	
	Set af = title.ActionFactory
	Set list = af.Sequence()
	list.Add af.MoveTo(40, 40, 0)
	list.add af.Show(True)
	list.Add af.Wait(1.0)
	list.Add af.MoveTo(40, 26, 2)
	list.Add af.Wait(1.0)
	title.AddAction af.Repeat(list, 1)
	scene.AddActor title




	FlexDMD.LockRenderThread
	FlexDMD.RenderMode =  FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	If VRroom > 0 Then FlexDMD.Show = False Else FlexDMD.Show = True
	FlexDMD.Run = True
	FlexDMD.UnlockRenderThread

End sub


Sub Table1_Exit()
	SaveHighScore
    If Not FlexDMD is Nothing Then
		FlexDMD.Show = False
		FlexDMD.Run = False
		FlexDMD = NULL
    End If
End Sub

Function Min(a, b)
  If a < b Then Min = a Else Min = b
End Function



Dim Thunderaward
Sub	Thunderstorm_Timer  ' ROC AWARDS
	If Thunderstorm.enabled=False Then
		Thunderstorm.enabled=True
		Objlevel(4) = 1 : FlasherFlash4_Timer
		Objlevel(5) = 1 : FlasherFlash5_Timer
		playSound "thund" & int(Rnd(1)*4)+1 , 1, 0.45*BG_Volume, 0,0,0,0,0,0
		Thunderaward=0
	Else	
		Thunderaward=Thunderaward+1

		Select Case Thunderaward
			Case 1,3,5,7,8,10,11,13,14,15,16 : Objlevel(5) = 1 : FlasherFlash5_Timer
			Case 2,4,6 : 
				Objlevel(4) = 1 : FlasherFlash4_Timer
				Objlevel(5) = 1 : FlasherFlash5_Timer
				playSound "thund" & int(Rnd(1)*4)+1 , 1, 0.46*BG_Volume, 0,0,0,0,0,0
			Case 17 : Objlevel(5) = 1 : FlasherFlash5_Timer
				Thunderstorm.enabled=False
		End Select

	End If
End Sub




'**********************************************************************************************************
'* Set Team colors on miniscoreboard bottom pf *
'**********************************************************************************************************

'E147 0/1 redundercab
'E148 0/1 blueundercab
'E149 0/1 goldundercab
'E150 0/1 greenundercab



Sub SetTeamColors


	If Team(PN)=0 Then

		towerBOTopacity=6
		Gi020.color=RGB(221,34,34)
		Gi020.colorFull=RGB(251,174,174)
		Flasher001.color=RGB(255,28,26)
		Flasher002.color=RGB(255,28,26)
		Flasher003.color=RGB(255,28,26)

		DOF 147,1 ':	If DOFdebug=1 Then debug.print "DOF 147,1 RED UNDERCAB ON"
		DOF 148,0
		DOF 149,0
		DOF 150,0
		LT071.ColorFull= RGB(255,0,0)
		L073.ColorFull= RGB(255,0,0)
		p071.material="InsertRedOnTridark"
'		p071off.material="InsertRedOFFTridark"
		PR1.material="Plastic laneguides Red1"
		PR2.material="Plastic laneguides Red1"
		PR3.material="Plastic laneguides Red1"
		PR4.material="Plastic laneguides Red1"
		PR5.material="Plastic laneguides Red1"
		PR6.material="Plastic laneguides Red1"
		PR7.material="Plastic laneguides Red1"
		displayhome=0.1
		displayaway=2

		Redbaselight001.image="Led_Red"
		Redbaselight002.image="Led_Red"
		Redbaselight003.image="Led_Red"
		Redbaselight004.image="Led_Red"
		Redbaselight001.material="Plastic laneguides Red"
		Redbaselight002.material="Plastic laneguides Red"
		Redbaselight003.material="Plastic laneguides Red"
		RedBaseLight004.material="Plastic laneguides Red"
		p042.material="insertRedonTri"
		LT042.colorfull=RGB(200,0,0)
		L042.colorfull=RGB(200,0,0)


		LT072.ColorFull= RGB(0,0,255) 'Opponent Side
		L074.ColorFull= RGB(0,0,255)
		p072.material="insertBlueonTri"
'		p072off.material="InsertDarkBlueOffTri"
		PB1.material="Plastic laneguides Blue"
		PB2.material="Plastic laneguides Blue"
		PB3.material="Plastic laneguides Blue"
		PB4.material="Plastic laneguides Blue"
		PB5.material="Plastic laneguides Blue"
		PB6.material="Plastic laneguides Blue"
		PB7.material="Plastic laneguides Blue"

		p067.material="insertBlueonTri"
		p070.material="insertBlueonTri"
		p048.material="insertBlueonTri"
		p063.material="insertBlueonTri"
		p041.material="insertBlueonTri"

		LT067.colorfull=RGB(0,0,255)
		LT070.colorfull=RGB(0,0,255)
		LT048.colorfull=RGB(0,0,255)
		LT063.colorfull=RGB(0,0,255)
		LT041.colorfull=RGB(0,0,255)
		L067.colorfull=RGB(0,0,255)
		L070.colorfull=RGB(0,0,255)
		L048.colorfull=RGB(0,0,255)
		L063.colorfull=RGB(0,0,255)
		L041.colorfull=RGB(0,0,255)


	End If

	If Team(PN)=1 Then

		towerBOTopacity=9
		Gi020.color=RGB(41,140,214)
		Gi020.colorFull=RGB(173,222,252)
		Flasher001.color=RGB(27,72,255)
		Flasher002.color=RGB(27,72,255)
		Flasher003.color=RGB(27,72,255)

		DOF 147,0
		DOF 148,1 ':	If DOFdebug=1 Then debug.print "DOF 148,1 BLUE UNDERCAB ON"
		DOF 149,0
		DOF 150,0
		LT071.ColorFull= RGB(0,0,255)
		L073.ColorFull= RGB(0,0,255)
		p071.material="insertBlueonTri"
'		p071off.material="InsertDarkBlueOffTri"
		PR1.material="Plastic laneguides Blue"
		PR2.material="Plastic laneguides Blue"
		PR3.material="Plastic laneguides Blue"
		PR4.material="Plastic laneguides Blue"
		PR5.material="Plastic laneguides Blue"
		PR6.material="Plastic laneguides Blue"
		PR7.material="Plastic laneguides Blue"
		displayhome=2
		displayaway=0.3

		Redbaselight001.image="Led_Blue"
		Redbaselight002.image="Led_Blue"
		Redbaselight003.image="Led_Blue"
		Redbaselight004.image="Led_Blue"
		Redbaselight001.material="Plastic laneguides Blue"
		Redbaselight002.material="Plastic laneguides Blue"
		Redbaselight003.material="Plastic laneguides Blue"
		RedBaseLight004.material="Plastic laneguides Blue"
		p042.material="insertBlueonTri"
		LT042.colorfull=RGB(0,0,255)
		L042.colorfull=RGB(0,0,255)

		LT072.ColorFull= RGB(255,0,0) 'Opponent Side
		L074.ColorFull= RGB(255,0,0)
		p072.material="InsertRedOnTri"
'		p072off.material="InsertRedOFFTridark"
		PB1.material="Plastic laneguides Red1"
		PB2.material="Plastic laneguides Red1"
		PB3.material="Plastic laneguides Red1"
		PB4.material="Plastic laneguides Red1"
		PB5.material="Plastic laneguides Red1"
		PB6.material="Plastic laneguides Red1"
		PB7.material="Plastic laneguides Red1"
		p067.material="insertRedonTri"
		p070.material="insertRedonTri"
		p048.material="insertRedonTri"
		p063.material="insertRedonTri"
		p041.material="insertRedonTri"

		LT067.colorfull=RGB(200,0,0)
		LT070.colorfull=RGB(200,0,0)
		LT048.colorfull=RGB(200,0,0)
		LT063.colorfull=RGB(200,0,0)
		LT041.colorfull=RGB(200,0,0)
		L067.colorfull=RGB(200,0,0)
		L070.colorfull=RGB(200,0,0)
		L048.colorfull=RGB(200,0,0)
		L063.colorfull=RGB(200,0,0)
		L041.colorfull=RGB(200,0,0)
	End If

	If Team(PN)=2 Then ' GOLD VS Red

		towerBOTopacity=5
		Gi020.color=RGB(207,211,44)
		Gi020.colorFull=RGB(242,253,172)
		Flasher001.color=RGB(255,238,26)
		Flasher002.color=RGB(255,238,26)
		Flasher003.color=RGB(255,238,26)

		DOF 147,0
		DOF 148,0
		DOF 149,1' :	If DOFdebug=1 Then debug.print "DOF 149,1 gold UNDERCAB ON"
		DOF 150,0
		LT071.ColorFull= RGB(255,215,0)
		L073.ColorFull= RGB(255,215,0)
		p071.material="InsertDarkYellowOnTri"
'		p071off.material="InsertDarkYellowOffTri"
		PR1.material="Plastic laneguides Yellow"
		PR2.material="Plastic laneguides Yellow"
		PR3.material="Plastic laneguides Yellow"
		PR4.material="Plastic laneguides Yellow"
		PR5.material="Plastic laneguides Yellow"
		PR6.material="Plastic laneguides Yellow"
		PR7.material="Plastic laneguides Yellow"
		displayhome=0.8
		displayaway=0.3

		Redbaselight001.image="Led_Yellow"
		Redbaselight002.image="Led_Yellow"
		Redbaselight003.image="Led_Yellow"
		Redbaselight004.image="Led_Yellow"
		Redbaselight001.material="Plastic laneguides Yellow"
		Redbaselight002.material="Plastic laneguides Yellow"
		Redbaselight003.material="Plastic laneguides Yellow"
		RedBaseLight004.material="Plastic laneguides Yellow"
		p042.material="insertYellowonTri"
		LT042.colorfull=RGB(200,215,0)
		L042.colorfull=RGB(200,215,0)

		LT072.ColorFull= RGB(255,0,0) 'Opponent Side
		L074.ColorFull= RGB(255,0,0)
		p072.material="InsertRedOnTri"
'		p072off.material="InsertRedOFFTridark"
		PB1.material="Plastic laneguides Red1"
		PB2.material="Plastic laneguides Red1"
		PB3.material="Plastic laneguides Red1"
		PB4.material="Plastic laneguides Red1"
		PB5.material="Plastic laneguides Red1"
		PB6.material="Plastic laneguides Red1"
		PB7.material="Plastic laneguides Red1"
		p067.material="insertRedonTri"
		p070.material="insertRedonTri"
		p048.material="insertRedonTri"
		p063.material="insertRedonTri"
		p041.material="insertRedonTri"

		LT067.colorfull=RGB(200,0,0)
		LT070.colorfull=RGB(200,0,0)
		LT048.colorfull=RGB(200,0,0)
		LT063.colorfull=RGB(200,0,0)
		LT041.colorfull=RGB(200,0,0)
		L067.colorfull=RGB(200,0,0)
		L070.colorfull=RGB(200,0,0)
		L048.colorfull=RGB(200,0,0)
		L063.colorfull=RGB(200,0,0)
		L041.colorfull=RGB(200,0,0)
	End If

	If Team(PN)=3 Then ' gREEN VS Red

		towerBOTopacity=7
		Gi020.color=RGB(111,211,44)
		Gi020.colorFull=RGB(184,253,172)
		Flasher001.color=RGB(26,255,140)
		Flasher002.color=RGB(26,255,140)
		Flasher003.color=RGB(26,255,140)

		DOF 147,0
		DOF 148,0
		DOF 149,0 
		DOF 150,1' :	If DOFdebug=1 Then debug.print "DOF 150,1 GREEN UNDERCAB ON"
		LT071.ColorFull= RGB(0,255,0)
		L073.ColorFull= RGB(0,255,0)
		p071.material="InsertDarkGreenOnTri"
'		p071off.material="InsertDarkGreenOffTri"
		PR1.material="Plastic Greenish"
		PR2.material="Plastic Greenish"
		PR3.material="Plastic Greenish"
		PR4.material="Plastic Greenish"
		PR5.material="Plastic Greenish"
		PR6.material="Plastic Greenish"
		PR7.material="Plastic Greenish"
		displayhome=0.2
		displayaway=0.3

		Redbaselight001.image="Led_Green"
		Redbaselight002.image="Led_Green"
		Redbaselight003.image="Led_Green"
		Redbaselight004.image="Led_Green"
		Redbaselight001.material="Plastic Greenish"
		Redbaselight002.material="Plastic Greenish"
		Redbaselight003.material="Plastic Greenish"
		RedBaseLight004.material="Plastic Greenish"
		p042.material="insertGreenonTri"
		LT042.colorfull=RGB(0,200,0)
		L042.colorfull=RGB(0,200,0)

		LT072.ColorFull= RGB(255,0,0) 'Opponent Side
		L074.ColorFull= RGB(255,0,0)
		p072.material="InsertRedOnTri"
'		p072off.material="InsertRedOFFTridark"
		PB1.material="Plastic laneguides Red1"
		PB2.material="Plastic laneguides Red1"
		PB3.material="Plastic laneguides Red1"
		PB4.material="Plastic laneguides Red1"
		PB5.material="Plastic laneguides Red1"
		PB6.material="Plastic laneguides Red1"
		PB7.material="Plastic laneguides Red1"
		p067.material="insertRedonTri"
		p070.material="insertRedonTri"
		p048.material="insertRedonTri"
		p063.material="insertRedonTri"
		p041.material="insertRedonTri"

		LT067.colorfull=RGB(200,0,0)
		LT070.colorfull=RGB(200,0,0)
		LT048.colorfull=RGB(200,0,0)
		LT063.colorfull=RGB(200,0,0)
		LT041.colorfull=RGB(200,0,0)
		L067.colorfull=RGB(200,0,0)
		L070.colorfull=RGB(200,0,0)
		L048.colorfull=RGB(200,0,0)
		L063.colorfull=RGB(200,0,0)
		L041.colorfull=RGB(200,0,0)
	End If

End Sub



'**********************************************************************************************************
'* LOAD/SAVE HIGHSCORES *
'**********************************************************************************************************
Dim Thisistheday
Sub LoadHighScore
	Dim FileObj, ScoreFile, TextStr
	Dim i2, i3
	Dim SavedDataTemp(18) 

    Set FileObj=CreateObject("Scripting.FileSystemObject")
	If Not FileObj.FolderExists(UserDirectory) then 
		Exit Sub
	End if
	If Not FileObj.FileExists(UserDirectory & "UT99.txt") then
		DefaultHighScores
		Exit Sub
	End if
	Set ScoreFile=FileObj.GetFile(UserDirectory & "UT99.txt")
	Set TextStr=ScoreFile.OpenAsTextStream(1,0)
		If (TextStr.AtEndOfStream=True) then
			DefaultHighScores
			Exit Sub
		End if
		For i = 1 to 17
			If (TextStr.AtEndOfStream=True) then
				TextStr.Close
				DefaultHighScores
				Set ScoreFile = Nothing 
				Set FileObj = Nothing 
				Exit Sub
			End if
			SavedDataTemp(i)=TextStr.ReadLine 
			If SavedDataTemp(i)="" Then 
				TextStr.Close
				DefaultHighScores
				Set ScoreFile = Nothing 
				Set FileObj = Nothing 
				Exit Sub
			End If
		Next
		If (TextStr.AtEndOfStream=True) then
			LUTset=6
		Else
			SavedDataTemp(18)=TextStr.ReadLine 
			if SavedDataTemp(18)="" Then LUTset=6 else LUTset=Int ( SavedDataTemp(18))
		End If
		If (TextStr.AtEndOfStream=True) then
			Wonreplays=0
		Else
			SavedDataTemp(18)=TextStr.ReadLine 
			if SavedDataTemp(18)="" Then Wonreplays=int(GamesPlayd/10) else Wonreplays=Int ( SavedDataTemp(18))
		End If

		If (TextStr.AtEndOfStream=True) then
			snakehigh=50
		Else
			SavedDataTemp(18)=TextStr.ReadLine 
			if SavedDataTemp(18)="" Then snakehigh=50 else snakehigh=Int ( SavedDataTemp(18))
		End If

		If (TextStr.AtEndOfStream=True) then
			snakespeed=5
		Else
			SavedDataTemp(18)=TextStr.ReadLine 
			if SavedDataTemp(18)="" Then snakespeed=5 else snakespeed=Int ( SavedDataTemp(18))
		End If

		If (TextStr.AtEndOfStream=True) then
			Thisistheday=Month(Now())&Day(Now())
		Else
			SavedDataTemp(18)=TextStr.ReadLine 
			if SavedDataTemp(18)="" Then 
				Thisistheday=Month(Now())&Day(Now())
			else
				Thisistheday=SavedDataTemp(18)
			End If
		End If


		If (TextStr.AtEndOfStream=True) then
			TodaysBest=0
		Else
			SavedDataTemp(18)=TextStr.ReadLine 
			if SavedDataTemp(18)="" Then TodaysBest=0 else TodaysBest= int(SavedDataTemp(18))
		End If

		If (TextStr.AtEndOfStream=True) then
			LastScore(2)=0
		Else
			SavedDataTemp(18)=TextStr.ReadLine 
			if SavedDataTemp(18)="" Then LastScore(2)=0 else LastScore(2)= int(SavedDataTemp(18))
		End If


		If (TextStr.AtEndOfStream=True) then
			LastScore(3)=0
		Else
			SavedDataTemp(18)=TextStr.ReadLine 
			if SavedDataTemp(18)="" Then LastScore(3)=0 else LastScore(3)= int(SavedDataTemp(18))
		End If


		If (TextStr.AtEndOfStream=True) then
			LastScore(4)=0
		Else
			SavedDataTemp(18)=TextStr.ReadLine 
			if SavedDataTemp(18)="" Then LastScore(4)=0 else LastScore(4)= int(SavedDataTemp(18))
		End If


		TextStr.Close
		Set ScoreFile = Nothing
	    Set FileObj = Nothing

		hScore(1)   =int ( SavedDataTemp(1) )
		highscorename(1)=SavedDataTemp(2)
		hScore(2)   =int ( SavedDataTemp(3) )
		highscorename(2)=SavedDataTemp(4)
		hScore(3)   =int ( SavedDataTemp(5) )
		highscorename(3)=SavedDataTemp(6)
			
		GamesPlayd  =int ( SavedDataTemp(7) )
	    LastScore(1)=int ( SavedDataTemp(8) )
		Credits    = int ( SavedDataTemp(9) )

		Team(1)   = int ( SavedDataTemp(10) )
		Team(2)   = int ( SavedDataTemp(11) )
		Team(3)   = int ( SavedDataTemp(12) )
		Team(4)   = int ( SavedDataTemp(13) )

		Taunt(1)  = int ( SavedDataTemp(14) )
		Taunt(2)  = int ( SavedDataTemp(15) )
		Taunt(3)  = int ( SavedDataTemp(16) )
		Taunt(4)  = int ( SavedDataTemp(17) )
		SetLUT
		SetReplaytarget
End Sub

Dim HSreset

Sub DefaultHighScores
	'highscore reset  . errors unavoidable

	HSreset=1
	highscorename(1)="VPX"
	highscorename(2)="VPX"
    highscorename(3)="VPX"
	hscore(1)=10000000
	hscore(2)=5000000
	hscore(3)=1000000

	Credits=0
	GamesPlayd=0
	

	Team(1)=0  ' 0-3 for each player ( 0=red 1blue 2gold 3green)
	Team(2)=1
	Team(3)=2
	Team(4)=3

	Taunt(1)=0
	Taunt(2)=1
	Taunt(3)=2
	Taunt(4)=3
	LUTset=6
	Wonreplays=0
	snakehigh=50 
	snakespeed=5
	Thisistheday=Month(Now())&Day(Now())
	TodaysBest=0

	SetLUT
	ShowLUT
	SetReplaytarget
End Sub

Dim ReplayGoals,ReplayGoalDown,Wonreplays
Sub SaveHighScore

		Dim FileObj
		Dim ScoreFile
		Set FileObj=CreateObject("Scripting.FileSystemObject")
		If Not FileObj.FolderExists(UserDirectory) then 
			Exit Sub
		End if
		Set ScoreFile=FileObj.CreateTextFile(UserDirectory & "UT99.txt",True)
	
			ScoreFile.WriteLine hscore(1)
			ScoreFile.WriteLine highscorename(1)
			ScoreFile.WriteLine hscore(2)
			ScoreFile.WriteLine highscorename(2)
			ScoreFile.WriteLine hscore(3)
			ScoreFile.WriteLine highscorename(3)
			ScoreFile.WriteLine GamesPlayd
			ScoreFile.WriteLine LastScore(1)
			ScoreFile.WriteLine Credits
			ScoreFile.WriteLine team(1)
			ScoreFile.WriteLine team(2)
			ScoreFile.WriteLine team(3)
			ScoreFile.WriteLine team(4)
			ScoreFile.WriteLine Taunt(1)
			ScoreFile.WriteLine Taunt(2)
			ScoreFile.WriteLine Taunt(3)
			ScoreFile.WriteLine Taunt(4)
			ScoreFile.WriteLine LUTset
			Scorefile.WriteLine WonReplays
			Scorefile.WriteLine snakehigh
			Scorefile.WriteLine snakespeed
			Scorefile.WriteLine Thisistheday
			Scorefile.WriteLine TodaysBest
			ScoreFile.WriteLine LastScore(2)
			ScoreFile.WriteLine LastScore(3)
			ScoreFile.WriteLine LastScore(4)
			
			ScoreFile.Close	
		Set ScoreFile=Nothing
		Set FileObj=Nothing
End Sub



Sub Wall043_Hit  ' glass hit 100h where it should not be
'	debug.print "wall43hit ( glass-mid)"
	activeball.z=65 : activeball.velz=0
	PlaySound "AXSGlassHit3a", 1, 0.5 * BG_Volume, 0, 0,0,0, 0, 0
End Sub

'Sub Wall042_Hit
'	debug.print "wall42hit(right)"
'End Sub
'
'Sub Wall047_Hit 
'	debug.print "wall47hit(left)"
'End Sub
'
'Sub Wall007_Hit 
'	debug.print "wall007hit(over ramp top middle)"
'End Sub
'
'Sub Wall020_Hit 
'	debug.print "wall20hit(leftborder)"
'End Sub
'
'Sub Wall015_Hit 
'	debug.print "wall15hit(big one left/top)"
'End Sub



'*Scoring ( some are changed alittle, but bigger reawrds are out there so kinda pocket change most of this
'
'CamperBonus 150000,15000
'headshot 25000,4000
'Frag 1000,200
'Redeemer 20000,4000
'return flag 5000,1000
'assist 1000,100
'lockball 2000,1000
'startMB 10000,2000
'endmap   20000 X caps,0
'winner  50000,0
'capture 50000,5000
'DT LightTimers Mid=30,30,30 Right=60,60,60sec
'DT 1000,100
'Amp 2000,400
'skillshotlights 500,0
'inlanes 1000,0
'outlanedrain 50000,0
'kickback fire 1000,100
'pwnage various values and bonuses
'enable KB 1000,0
'superbumpers 4000,100 else 400,0p
'superspinnner = 4000,100 else 400,0
'ownage 2 = superbumpers until ball lost
'ownage 3,6 = award bonusmultiplyer
'ownage 5,7,9,11,13,15,17,19 = superspinners 60 seconds
'ownage 4,8,10,12,14,16,18,20 = extra light
'bonuslight 200 rollover
'3x bonuslight = 5000,500 + bonusmultiplyer
'more than 8x = 50000,1000
'slingshot 50
'double 1000,200
'multi  1500,300
'ultra  2500,500
'monstr 5000,1000
'skillshot 
'bad     500,50
'almost  3000,300
'good    10000,1000
'perfect 20000,2000
'2nd skillshot mainramp 50000,5000 If good+ ss, possible to do more than once in 9,5 seconds
'invisibility minigame  200000,30000 + 30 second respawn
'max one each 5 lanes then main ramp ( 2 on any lane = restart, no restart on main ramp anymore )
'
'wizard mode
' lvl 1 -  1/2m  1m 1.5m  2m  5m   ( remember x 20 !! ) so 10m 20m 30m 40m 100m
' lvl 2 -    1m  2m   3m  4m  10m 
' lvl 3 -    2m  4m   6m  8m  20m
' lvl 4 -    3m  6m   9m 12m  30m ... and so on
' Coret  2x all scores
' november 5x
' dreary 10x
' face 20x


'*********************
'LUT changer
'*********************
Dim LUTset
Sub SetLUT 
		SPB2 101,103,1,0,0,1
	Table1.ColorGradeImage = "LUT" & LUTset

	If DarkRoom>0 Then
		Table1.EnvironmentEmissionScale=DarkRoom
	Else
		Select case LUTset
			Case 0,1,2,4,5,6,7,13,14 :	Table1.EnvironmentEmissionScale=3
			Case 3 :					Table1.EnvironmentEmissionScale=2
			Case 8 : 					Table1.EnvironmentEmissionScale=2
			Case 9 : 					Table1.EnvironmentEmissionScale=2
			Case 10,11,12 :				Table1.EnvironmentEmissionScale=7
		End Select
	End If
End Sub


Sub LUTBox_Timer
	LUTBox.TimerEnabled = False 
	LUTBox.Visible = 0
End Sub


Sub ShowLUT
	LUTBox.Visible = 1
	Select Case LUTSet
		Case 0: LUTBox.text = "Fleep Natural Dark 1"
		Case 1: LUTBox.text = "Fleep Natural Dark 2"
		Case 2: LUTBox.text = "Fleep Warm Dark"
		Case 3: LUTBox.text = "Fleep Warm Bright"
		Case 4: LUTBox.text = "Fleep Warm Vivid Soft"
		Case 5: LUTBox.text = "Fleep Warm Vivid Hard"
		Case 6: LUTBox.text = "Skitso Natural and Balanced"
		Case 7: LUTBox.text = "Skitso Natural High Contrast"
		Case 8: LUTBox.text = "3rdaxis Referenced THX Standard"
		Case 9: LUTBox.text = "CalleV Punchy Brightness and Contrast"
		Case 10: LUTBox.text = "TT & Ninuzzu Original"
  		Case 11: LUTBox.text = "*VPin Workshop Original"
        Case 12: LUTBox.text = "1on1"
        Case 13: LUTBox.text = "blacklight"
        Case 14: LUTBox.text = "bassgeige"
	End Select
	LUTBox.TimerEnabled = True
	LUTBox.TimerEnabled = True
	LUTBox.TimerEnabled = True
End Sub


'*********************
'VR Mode
'*********************
DIM VRThings
If VRRoom > 0 Then
	scoretext.Visible = 0
	DMD.Visible = 1
	PinCab_Backglass.blenddisablelighting = 3
	PinCab_Rails.Visible = 1
	Flasher006.Visible = 0
	Flasher007.Visible = 0

	If VRRoom = 1 Then
		for each VRThings in VR_Cab:VRThings.Visible = 1:Next
		for each VRThings in VR_Tournament:VRThings.Visible = 1:Next
		SetBackglass : BGdark.visible = 1 : BGBright.visible = 1
		'Set animations on here...
			VRLightsTimer.enabled = true
			VRTimer.enabled = true
	End If


	If VRRoom = 2 Then
		for each VRThings in VR_Cab:VRThings.Visible = 1:Next
		for each VRThings in VR_Min:VRThings.Visible = 1:Next
		SetBackglass : BGdark.visible = 1 : BGBright.visible = 1
	End If



	If VRRoom = 3 Then
		for each VRThings in VR_Cab:VRThings.Visible = 0:Next
		for each VRThings in VR_Min:VRThings.Visible = 0:Next
	PinCab_Backbox.Visible=1
	PinCab_Backglass.Visible=1
	End If
Else
		for each VRThings in VR_Cab:VRThings.Visible = 0:Next
		for each VRThings in VR_Min:VRThings.Visible = 0:Next
	if DesktopMode then
		scoretext.Visible = 1
		PinCab_Rails.Visible = 1
	else
		scoretext.Visible = 0
		PinCab_Rails.Visible = 0
	End if
End If


Sub DMD_Timer
	Dim DMDp
		DMDp = FlexDMD.DmdColoredPixels
		If Not IsEmpty(DMDp) Then
			DMDWidth = FlexDMD.Width
			DMDHeight = FlexDMD.Height
			DMDColoredPixels = DMDp
		End If
End Sub



'Tournament Room animations...*************************************************************************************

Dim FighterSpeed: FighterSpeed = 30
Dim FighterSpeed3: FighterSpeed3 = 20
Dim FighterSpeed4: FighterSpeed4 = 20
Dim FighterSpeed6: FighterSpeed6 = 20

Dim Fire3:Fire3 = false
Dim Fire4:Fire4 = false
Dim Fire6:Fire6 = false

Dim VRLightson: VRLightsOn = false

EarthGlow.Blenddisablelighting = 12
LazerFire1.Blenddisablelighting = 40
LazerFire2.Blenddisablelighting = 40
LazerFire3.Blenddisablelighting = 40
LazerFire4.Blenddisablelighting = 40
LazerFire5.Blenddisablelighting = 40
LazerFire6.Blenddisablelighting = 40
LazerFire7.Blenddisablelighting = 40
EarthGlow.Blenddisablelighting = 25

Sub VRTimer_timer()
Earth.objrotx = Earth.objrotx + 0.018
EarthGlow.objrotx = EarthGlow.objrotx + 0.018
Earth.objroty = Earth.objroty + 0.014
EarthGlow.objroty = EarthGlow.objroty + 0.014
VRSpace.objroty = VRSpace.objroty + 0.006
VRMeteor1.objroty = VRMeteor1.objroty + 0.095
VRMeteor1.objrotz = VRMeteor1.objrotz + 0.065
VRMeteor2.objroty = VRMeteor2.objroty + 0.15
VRMeteor2.objrotz = VRMeteor2.objrotz + 0.085
VRMeteor3.objroty = VRMeteor3.objroty + 0.09
VRMeteor3.objrotz = VRMeteor3.objrotz + 0.04
VRMeteor4.objroty = VRMeteor4.objroty + 0.08
VRMeteor4.objrotz = VRMeteor4.objrotz + 0.09

'Entrance dude moving
VRFighter1.x = VRFighter1.x + FighterSpeed
if VRFighter1.x > 1500 then FighterSpeed = -30
if VRFighter1.x < -12500 then FighterSpeed = 30


'Laser1 Blue
LazerFire1.y = LazerFire1.y - 1200
LazerFire1.z = LazerFire1.z - 80

if LazerFire1.y < - 93000 then 
LazerFire1.y = 74500
LazerFire1.z = 60000
End If

'Laser2 aim down
LazerFire2.y = LazerFire2.y - 1200
LazerFire2.z = LazerFire2.z - 700

if LazerFire2.y < - 103000 then 
LazerFire2.y = 74500
LazerFire2.z = 62000
End If

'Laser5 aim straight
LazerFire5.y = LazerFire5.y + 1200
LazerFire5.z = LazerFire5.z + 70

if LazerFire5.y >  303000 then 
LazerFire5.y = -75000
LazerFire5.z = 20000
End If

'Laser7
LazerFire7.y = LazerFire7.y - 1200
LazerFire7.z = LazerFire7.z - 440
LazerFire7.x = LazerFire7.x - 190

if LazerFire7.y < - 493000 then 
LazerFire7.y = 74500
LazerFire7.z = 35000
LazerFire7.x = 5000
End If

'Lasers and dudes..
'***********************************************************************************************************************
'Laser3 aim down
If Fire3 = true then
LazerFire3.y = LazerFire3.y + 1200
LazerFire3.z = LazerFire3.z - 630
end If

if LazerFire3.y >  303000 then 
Fire3 = false
LazerFire3.y = -75000
LazerFire3.z = 42000
LazerFire3.visible = false
End If

VRFighter3.y = VRFighter3.y + FighterSpeed3 
if VRFighter3.y < -95000 then FighterSpeed3 = 20 
if VRFighter3.y > -87000 then FighterSpeed3 = -20 :LazerFire3.visible = true : Fire3 = true
'***********************************************************************************************************************

'Laser4 aim down
If Fire4 = true then
LazerFire4.y = LazerFire4.y + 1200
LazerFire4.z = LazerFire4.z - 630
end If

if LazerFire4.y >  303000 then 
Fire4 = false
LazerFire4.y = -75000
LazerFire4.z = 42000
LazerFire4.visible = false
End If

VRFighter4.y = VRFighter4.y + FighterSpeed4 
if VRFighter4.y < -95000 then FighterSpeed4 = 20
if VRFighter4.y > -87000 then FighterSpeed4 = -20 :LazerFire4.visible = true : Fire4 = true
'***********************************************************************************************************************

If Fire6 = true then
LazerFire6.y = LazerFire6.y + 1200
LazerFire6.z = LazerFire6.z + 345
LazerFire6.x = LazerFire6.x + 383
end If

if LazerFire6.y >  303000 then 
Fire6 = false
LazerFire6.y = -74820
LazerFire6.z = -20000
LazerFire6.x = -24400
LazerFire6.visible = false
End If

VRFighter6.x = VRFighter6.x + FighterSpeed6
if VRFighter6.x > -14000 then FighterSpeed6 = -20
if VRFighter6.x < -23900 then FighterSpeed6 = 20 : LazerFire6.visible = true : Fire6 = true
End Sub
'************************************************************************************************************************

'VRLights
Sub VRLightsTimer_Timer
if VRLightsOn = false then
VRRedBaseLight001.BlendDisableLighting = 15
VRRedBaseLight002.BlendDisableLighting = 15
VRRedBaseLight003.BlendDisableLighting = 0
VRBlueBaseLight001.BlendDisableLighting = 10
VRBlueBaseLight002.BlendDisableLighting = 10
VRBlueBaseLight003.BlendDisableLighting = 0
VRLightsOn = True
Else
VRRedBaseLight001.BlendDisableLighting = 0
VRRedBaseLight002.BlendDisableLighting = 0
VRRedBaseLight003.BlendDisableLighting = 15
VRBlueBaseLight001.BlendDisableLighting = 0
VRBlueBaseLight002.BlendDisableLighting = 0
VRBlueBaseLight003.BlendDisableLighting = 10
VRLightsOn = false
end if
End Sub


'******************************************************
'*******	Set VR Backglass Flashers	*******
'******************************************************

Sub SetBackglass()
	Dim obj

	For Each obj In VRBackglass
		obj.x = obj.x
		obj.height = - obj.y + 335
		obj.y = -65 'adjusts the distance from the backglass towards the user
		obj.rotx = -89
	Next

End Sub

dim VRBGFLBumplvl

sub VRBGFLBump
	If VRRoom > 0 and VRRoom < 3 Then
		VRBGFLBumplvl = 1
		VRBGFLBumptimer_timer
	End If
end sub

sub VRBGFLBumptimer_timer							
	if Not VRBGFLBumptimer.enabled then
		VRBGFLBump_1.visible = true
		VRBGFLBump_2.visible = true
		VRBGFLBump_3.visible = true
		VRBGFLBump_4.visible = true
		VRBGFLBumptimer.enabled = true
	end if
	VRBGFLBumplvl = 0.8 * VRBGFLBumplvl - 0.01
	if VRBGFLBumplvl < 0 then VRBGFLBumplvl = 0
	VRBGFLBump_1.opacity = 100 * VRBGFLBumplvl^1.5
	VRBGFLBump_2.opacity = 100 * VRBGFLBumplvl^1.5
	VRBGFLBump_3.opacity = 100 * VRBGFLBumplvl^1.5
	VRBGFLBump_4.opacity = 100 * VRBGFLBumplvl^2
	if VRBGFLBumplvl =< 0 Then
		VRBGFLBump_1.visible = false
		VRBGFLBump_2.visible = false
		VRBGFLBump_3.visible = false
		VRBGFLBump_4.visible = false
		VRBGFLBumptimer.enabled = false
	end if
end sub






