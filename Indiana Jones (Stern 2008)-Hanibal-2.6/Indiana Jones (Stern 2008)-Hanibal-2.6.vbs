

Option Explicit
Randomize

On Error Resume Next
ExecuteGlobal GetTextFile("controller.vbs")
If Err Then MsgBox "You need the controller.vbs in order to run this table, available in the vp10 package"
On Error Goto 0

'******************* Options *********************

dim DivValue:DivValue = 2 '**** Change Value to 4 if LED array does not display properly on your system

LoadVPM "01560000", "sam.VBS", 3.43

 BSize = 25.5
' BMass = ((BSize*2)^3)/95000
 
'********************
'Standard definitions
'********************

	Const cGameName = "ij4_210" 'change the romname here

     Const UseSolenoids = 1
     Const UseLamps = 0
     Const UseSync = 1
     Const HandleMech = 0 

     'Standard Sounds
     Const SSolenoidOn = "Schuetz-An"
     Const SSolenoidOff = "Schuetz-Aus"
     Const SCoin = "coin"

'************
' Table init.
'************
   'Variables
    Dim xx
    Dim Bump1,Bump2,Bump3,Mech3bank,bsTrough,bsVUK,visibleLock,bsTEject,bsMapVUK,bsRScoop
	Dim dtUDrop,dtLDropLower,dtLDropUpper,dtRDrop
	Dim PlungerIM
	Dim PMag
    Dim mLockMagnet
    Dim TBall1, TBALL2, PulserBall, Hiter
    Dim Lift, Frei
    Dim DesktopMode:DesktopMode = Table.ShowDT

'
  Sub Table_Init
    tablelaunch.visible = 1 'Turn On Ball Info
'    Controller.Switch(51) = 0 'ark position unknown
	Controller.Switch(51) = 0 'ark position unknown
	Sw39_Init 'ark enter opto
	Controller.Switch(40) = 1 'ark hit opto

    ' Misc. Initialisation
    LeftSLing.IsDropped = 1:LeftSLing2.IsDropped = 1:LeftSLing3.IsDropped = 1
    RightSLing.IsDropped = 1:RightSLing2.IsDropped = 1:RightSLing3.IsDropped = 1
    LeftTopSling1.IsDropped = 1:LeftTopSLing2.IsDropped = 1:LeftTopSLing3.IsDropped = 1
    RightTopSLing1.IsDropped = 1:RightTopSLing2.IsDropped = 1:RightTopSLing3.IsDropped = 1


	'Ark Init
	MAP1.CreateBall
	MAP2.CreateBall
	MAP1.Kick 0,0
	MAP2.Kick 0,0
     Set PulserBall = MAP3.Createsizedball(25):PulserBall.image = "blank":MAP3.Kick 0,0

if table.showDT=false then
Ramp15.visible=0
Ramp16.visible=0
else 
Ramp15.visible=1
Ramp16.visible=1
end if


	'TOD1.Enabled = false
	'TOD2.Enabled = false
	MAP1.Enabled = false
	MAP2.Enabled = false
	MAP3.Enabled = false
	'MAP4.Enabled = false
	ArkLoading.Enabled = 1
'*****
	With Controller
		.GameName = cGameName
		If Err Then MsgBox "Can't start Game " & cGameName & vbNewLine & Err.Description:Exit Sub
		.SplashInfoLine = "Indiana Jones (Stern 2008) by Hanibal"
		.HandleKeyboard = 0
		.ShowTitle = 0
		.ShowDMDOnly = 1
		.ShowFrame = 0
		.HandleMechanics = 1
		.Hidden = 0
        .Games(cGameName).Settings.Value("sound") = 1
		On Error Resume Next
		.Run GetPlayerHWnd
		If Err Then MsgBox Err.Description
	End With

    On Error Goto 0
 
'**Trough
    Set bsTrough = New cvpm8BallStack
    bsTrough.InitSw 0, 21, 20, 19, 18, 17, 0, 0, 0
    bsTrough.InitKick BallRelease, 90, 8
    bsTrough.InitExitSnd SoundFX("ballrelease",DOFContactors), SoundFX("Schuetz-An",DOFContactors)
    bsTrough.Balls = 8

	Set PMag=New cvpmMagnet
	PMag.InitMagnet ArkMag,120
	PMag.GrabCenter=True

    ' Lock Magnet
    Set mLockMagnet = New cvpmMagnet
    With mLockMagnet
 '       .InitMagnet TempelMag4, 50
        .InitMagnet Trigger3, 500
        .GrabCenter = 1
 '       .Size = 300
 '       .CreateEvents "mLockMagnet"
     End With

	mLockMagnet.addball PulserBall

     Set TBall1 = MAP4.Createsizedball(24):TBall1.image = "blank":'MAP4.Kick 0,0':mLockMagnet.addball TBall1

     Set TBall2 = MAP5.Createsizedball(24):TBall2.image = "blank":'MAP4.Kick 0,0':mLockMagnet.addball TBALL2

     Frei = 1


	Set bsVUK=New cvpmBallStack
	bsVUK.InitSw 0,11,0,0,0,0,0,0
	bsVUK.InitKick sw11,160,7
	bsVUK.InitExitSnd SoundFX("Ball-im-Target",DOFContactors), SoundFX("rail",DOFContactors)

    Set bsMapVUK=New cvpmBallStack
	bsMapVUK.InitSw 0,45,0,0,0,0,0,0
   	bsMapVUK.InitSaucer sw45kick,250,10,13
    bsMapVUK.InitAddSnd"Ball-im-Target"
    bsMapVUK.InitExitSnd SoundFX("Ball-im-Target",DOFContactors), SoundFX("rail",DOFContactors) 'SoundFX("Ball-im-Target",DOFContactors),SoundFX("solenoid",DOFContactors)
	bsMapVUK.CreateEvents "bsMapVUK", sw45kick
	
	
'**Nudging
    	vpmNudge.TiltSwitch=-7
   	vpmNudge.Sensitivity=1
   	vpmNudge.TiltObj=Array(Bumper1b,Bumper2b,Bumper3b,Bumper4b,LeftSlingshot,RightSlingshot)


      '**Main Timer init
	PinMAMETimer.Interval = PinMAMEInterval
	PinMAMETimer.Enabled = 1

  End Sub

'MAP Newballid assignment
Sub trigger1_hit: NewBallID :trigger1.enabled = 0:End sub
Sub trigger2_hit: NewBallID :trigger2.enabled = 0:End sub
Sub trigger3_hit: NewBallID :trigger3.enabled = 0:End sub

Dim ArkLoadingCnt
Sub ArkLoading_Timer
	if controller.switch(17) = False then 
		ArkLoadingCnt = ArkLoadingCnt + 1
	elseif controller.switch(17) = True then
		ArkLoadingCnt = 0
	end if

	if ArkLoadingCnt = 4 Then
		'MsgBox "Play Ball!"
		tablelaunch.visible = False
		ArkLoading.Enabled = 0
	End if
End Sub

'*****Keys
Sub Table_KeyDown(ByVal Keycode)
'	If keycode = 30 then sw60p1.Transz = -48
'	If keycode = 31 then sw60p1.Transz = 0

	If keycode = 3 Then
		drainwall.isdropped = True
	End If

    If keycode = PlungerKey Then Plunger.Pullback:PlaySound "PlungerPull", 0, 40 / (15*Rnd), 0.05, 0.15
  	If keycode = LeftTiltKey Then LeftNudge 80, 1, 20:nudgebobble(keycode):End If
   If keycode = RightTiltKey Then RightNudge 280, 1, 20:nudgebobble(keycode):End If
   If keycode = CenterTiltKey Then CenterNudge 0, 1, 25 End If
   If vpmKeyDown(keycode) Then Exit Sub 
End Sub 

Sub Table_KeyUp(ByVal keycode)
	If vpmKeyUp(keycode) Then Exit Sub

	If Keycode = StartGameKey Then Controller.Switch(16) = 0: tablelaunch.visible = 0	
    If keycode = PlungerKey Then
		PTime.Enabled = 0:PTime2.Enabled = 1:Plunger.Fire
        If(BallinPlunger = 1) then 'the ball is in the plunger lane
            PlaySound "Plunger2", 0, 40 / (15*Rnd), 0.05, 0.15
        else
            PlaySound "Plunger", 0, 40 / (15*Rnd), 0.05, 0.15
        end if
	End If
End Sub


   'Solenoids

SolCallback(1) = "solTrough"
SolCallback(2) = "solAutofire"
SolCallback(3) = "PMag.MagnetOn=" 
SolCallback(4) = "bSVUK.SolOut" 
SolCallback(5) = "RampGateSol"
SolCallback(6) = "TempleMotor"	
SolCallback(7) = "solArkDiverter"

SolCallback(15) = "SolLFlipper"
SolCallback(16) = "SolRFlipper"

SolCallback(19) = "Flasher_Temple"
SolCallback(20) = "SetLamp 120,"
SolCallBack(21) = "SlingshotFlash"
SolCallback(22) = "Sankara_Flash" 
SolCallback(23) = "SetLamp 123,"

SolCallback(25) = "RampFlash"
SolCallback(26) = "MapKick" '"bsMapVUK.SolOut"  'MAP EJECT
SolCallback(27) = "solArkMotor" 
SolCallback(28) = "FlashBackPanel" 'back panel 3
SolCallback(29) = "ArkFlash" 'ark front flash
SolCallback(30) = "SwordsmanMotor"
SolCallback(31) = "BumperFlash"
SolCallback(32) = "FlashCrusade"
SolCallback(36) = "ArkTopFlash"
SolCallback(37) = "SwordsmanFlash"
SolCallback(38) = "SchaedelFlash"


'*************************
' GI 
'*************************

Set GICallback = GetRef("GIUpdate")
Sub GIUpdate(no, step)
			DOF 101, DOFOn
			Dim xxx
			For each xxx in GILAMPEN:xxx.State = step:	Next
Backwall.color = rgb(48,36,36)
Apron.color = rgb(120,120,120)
LCard.color = rgb(102,102,102)
RCard.color = rgb(116,80,24)
Primitive243.blenddisablelighting = 0.2
        If step=0 then
			DOF 101, DOFOff
Backwall.color = rgb(20,16,16)
Apron.color = rgb(67,67,67)
LCard.color = rgb(57,57,57)
RCard.color = rgb(64,44,13)
Primitive243.blenddisablelighting = 0
		End If
End Sub	


' Physics Module by Hanibal

Sub Physik_Timer
     TBall1.x = templeball1.x  + 39 -(Lift/6)
     TBall1.y = templeball1.y  + (130*dCos(Lift))- Hiter

     TBALL2.x = templeball2.x  + 24 -(Lift/6)
     TBALL2.y = templeball2.y  + (75*dCos(Lift)) - Hiter 

     TBall1.velx=0
     TBall1.vely=0
     TBall1.velz=0
     TBALL2.velx=0
     TBALL2.vely=0
     TBALL2.velz=0
'End if

     TBall1.z = templeball1.z  + 45 +(138*dSin(Lift)) 'templeball1
     TBALL2.z = templeball2.z  + 45 +(79*dSin(Lift))  'templeball2

If frei = 0 Then
frei = 1
End If

End Sub

Sub MapKick(Enabled)
	If Enabled then
		sw45kick.kick 250,15
	Else
	End If
End Sub

'Flasher Updates


Sub Flasherupdate_timer

Hanflasher 80, l80, Flasher80d
Hanflasher 121, Flasher21a, Flasher21d1
Hanflasher 123, Flasher21b, Flasher21d2
Hanflasher 73, l73,FlasherLED73
Hanflasher 119, Flasher19, Flasher19x
Hanflasher 122, Flasher22, Flasher22x
Hanflasher 125, Flasher25a1, Flasher25d1
Hanflasher 126, Flasher25b1, Flasher25d2
Hanflasher 128, Flasher28, Flasher28d
Hanflasher 131, Flasher31, Flasher31x
Hanflasher 132, Flasher32, Flasher32x
Hanflasher 136, Flasher36a, Flasher36a1
Hanflasher 137, Flasher36a, Flasher36a2
Hanflasher 138, Flasher38, Flasher38x
Hanflasher 139, Flasher37, Flasher37x
Hanflasher 140, Flasher37a, Flasher37x1

HanLEDflasher 181, GI_24,FlasherGLLED81
HanLEDflasher 182, GI_24,FlasherGLLED82
HanLEDflasher 183, GI_24,FlasherGLLED83
HanLEDflasher 184, GI_24,FlasherGLLED84
HanLEDflasher 185, GI_24,FlasherGLLED85
HanLEDflasher 186, GI_24,FlasherGLLED86
HanLEDflasher 187, GI_24,FlasherGLLED87
HanLEDflasher 188, GI_24,FlasherGLLED88
HanLEDflasher 189, GI_24,FlasherGLLED89
HanLEDflasher 190, GI_24,FlasherGLLED90

'KombiflasherHanLED 75, L75,FlasherLED8

Dim yy
if table.showDT=false then
for each yy in backlights
yy.intensity=8
 next
else
for each yy in backlights
yy.intensity=30
 next 
end If

End Sub

'** Extra math to make my life easier **
Function dCos(degrees)
  Dim Pi:Pi = CSng(4*Atn(1))
	dcos = cos(degrees * Pi/180)
	if ABS(dCos) < 0.000001 Then dCos = 0
	if ABS(dCos) > 0.999999 Then dCos = 1 * sgn(dCos)
End Function

Function dSin(degrees)
  Dim Pi:Pi = CSng(4*Atn(1))
	dsin = sin(degrees * Pi/180)
	if ABS(dSin) < 0.000001 Then dSin = 0
	if ABS(dSin) > 0.999999 Then dSin = 1 * sgn(dSin)
End Function


 Sub Augen_Timer

' ******Hanibals Random Lights Script

Flasher25a.Intensity = (20+(10*Rnd))
Flasher25a1.Intensity = Flasher25a.Intensity *3
Flasher25b.Intensity = Flasher25a.Intensity 
Flasher25b1.Intensity = Flasher25a1.Intensity 
Flasher25c1.Intensity = Flasher25a.Intensity /4

Flasher29.Intensity = (50+(30*Rnd))
'Flasher38.Intensity = (10+(20*Rnd))
'Flasher38a.Intensity = (15+(2*Rnd))
'Flasher38b.Intensity = (15+(2*Rnd))
Flasher21a.Intensity = (105+(10*Rnd))
Flasher21b.Intensity = (105+(10*Rnd))
Flasher21c.Intensity = (55+(10*Rnd))
Flasher21d.Intensity = (55+(10*Rnd))
'Flasher32.Intensity = (10+(2*Rnd))
'Flasher19.Intensity = (30+(2*Rnd))
Flasher22.Intensity = (20+(7*Rnd))
Flasher22a.Intensity = Flasher22.Intensity
Flasher36a.Intensity = (30+(20*Rnd))
Flasher36b.Intensity = (30+(20*Rnd))
Flasher37.Intensity = (20+(5*Rnd))
'Flasher31.Intensity = (55+(10*Rnd))
 'Flasher28.Intensity = (45+(5*Rnd))
Flasher28b.Intensity = (30+(10*Rnd))
Flasher28c.Intensity = (50+(10*Rnd))
l15.Intensity = (40+(5*Rnd))
FlasherAkator.Intensity = (70+(40*Rnd))


Flasher32x.amount = Flasher32.Intensity
Flasher19x.amount = Flasher19.Intensity

 End Sub

RampGateWall.IsDropped = 1

Sub RampGateSol(Enabled)
	If Enabled then
		'RampGate.collidable = 0
		RampGateWall.IsDropped = 0
		FlasherAkator.State = 1
	Else
		'RampGate.collidable = 1
		RampGateWall.IsDropped = 1
		FlasherAkator.State = 0
	End If
End Sub

Sub FlashBackPanel(Enabled)
	If Enabled Then
Topflash.image = "FlasherON"
Flash28.visible = 1
'Flasher28.state = 1
		Flasher28n.State = 1        
        Flasher28b.state = 1        
	Else
Topflash.image = "FlasherOff"
Flash28.visible = 0
		Flasher28n.State = 0
'        Flasher28.state = 0
        Flasher28b.state = 0
'        Flasher28c.state = 0
'        Flasher28W.state = 0
'        Flasher28W1.state = 0
	End If
End Sub

Sub SwordsmanFlash(Enabled)
	If Enabled Then
        Flasher37.state = 1
        'f37a.state = 1
	Else
        Flasher37.state = 0
        'f37a.state = 0
	End If
End Sub


Sub SlingshotFlash(Enabled)
	If Enabled Then
'		SLINGFLASH = 1
Slingflashlinks.image = "FlasherON"
Slingflashrechts.image = "FlasherON"
        Flasher21a.state = 1
        Flasher21a1.state = 1
        Flasher21b.state = 1
        Flasher21b1.state = 1
	Else

'		SLINGFLASH = 0
Slingflashlinks.image = "FlasherOff"
Slingflashrechts.image = "FlasherOff"

        Flasher21a.state = 0
        Flasher21a1.state = 0
        Flasher21b.state = 0
        Flasher21b1.state = 0
	End If
End Sub


Sub ArkTopFlash(Enabled)
	If Enabled Then
        Flasher36a.state = 1
        Flasher36b.state = 1

	Else
        Flasher36a.state = 0
        Flasher36b.state = 0
	End If
End Sub


Sub Sankara_Flash(Enabled)
	If Enabled Then
        Flasher22.state = 1
		Flasher22a.state = 1
sankara.blenddisablelighting = 1.2
	Else
        Flasher22.state = 0
        Flasher22a.state = 0
sankara.blenddisablelighting = 0.3
	End If
End Sub


Sub Flasher_Temple(Enabled)
	If Enabled Then
        Flasher19.state = 1
	Else
        Flasher19.state = 0
	End If
End Sub


Sub FlashCrusade(Enabled)
	If Enabled Then
        Flasher32.state = 1
	Else
        Flasher32.state = 0
	End If
End Sub

Sub RampFlash(Enabled)
	If Enabled Then

'		KISTENFLASH = 1

Toplinks.image = "FlasherON"
Toprechts.image = "FlasherON"

'        Flasher25a.state = 1
        Flasher25a1.state = 1
'        Flasher25b.state = 1
        Flasher25b1.state = 1
'        Flasher25c.state = 1
        Flasher25c1.state = 1

	Else

'		KISTENFLASH = 0
Toplinks.image = "FlasherOff"
Toprechts.image = "FlasherOff"

'        Flasher25a.state = 0
        Flasher25a1.state = 0
'        Flasher25b.state = 0
        Flasher25b1.state = 0
'        Flasher25c.state = 0
        Flasher25c1.state = 0
	End If


End Sub


Sub BumperFlash(Enabled)
	If Enabled Then
        Flasher31.state = 1
        Flasher31a.state = 1
	Else
        Flasher31.state = 0
        Flasher31a.state = 0
	End If
End Sub


Sub SchaedelFlash(Enabled)
	If Enabled Then
        Flasher38.state = 1
        Flasher38a.state = 1
        Flasher38b.state = 1

	Else
        Flasher38.state = 0
        Flasher38a.state = 0
        Flasher38b.state = 0

	End If
End Sub



Sub ArkFlash(Enabled)
	If Enabled Then
        Flasher29.state = 1

	Else
		Flasher29.state = 0

	End If
End Sub


Sub TempleMotor(Enabled)
	If Enabled Then
		DT.Enabled = 1
'        PlaySound "E_Motorlift2", 0, 40 / (15*Rnd), -0.05, 0.15
		'Debug.print Timer & "DT Enabled"

	Else
		DT.Enabled = 0
 '       StopSound "E_Motorlift2"
		'Debug.print Timer & "DT Disabled"

	End If
End Sub

Sub SwordsmanMotor(Enabled)
	If Enabled Then
		SM.Enabled = 1
        PlaySound SoundFX("E_Motorlift3",DOFGear), 0, 10 / (25*Rnd), -0.15, 0.15
		'Debug.print Timer & "SM Enabled"
	Else
		SM.Enabled = 0
        StopSound "E_Motorlift3"
		'Debug.print Timer & "SM Disabled"
	End If
End Sub

Sub solTrough(Enabled)
	If Enabled Then
		bsTrough.ExitSol_On
		vpmTimer.PulseSw 22
	End If
 End Sub

Sub solAutofire(Enabled)
	If Enabled Then
	  Plunger.Pullback
      vpmTimer.AddTimer 200, PlungerIM.AutoFire : Plunger.Fire
	End If
End Sub

Sub solArkDiverter(Enabled)
	if enabled Then
		diverter.rotatetoend
        Playsound SoundFX("PlastikHit",DOFContactors), 1, 3 / (15*Rnd), +0.1
		'arkdiv.isdropped = 0
	else
		diverter.rotatetostart
		'arkdiv.isdropped = 1
		Playsound SoundFX("PlastikHit",DOFContactors), 1, 3 / (15*Rnd), +0.1
	end if
End Sub

Sub solArkMotor(Enabled)
	if enabled then
		arkmotor.enabled = 1
        playsound SoundFX("E_Motorlift",DOFGear), 0, 40 / (25*Rnd), 0.05, 0.15
		'debug.print "ArkMotor Enabled"
	else
		arkmotor.enabled = 0
		'debug.print "ArkMotor Disabled"
        StopSound "E_Motorlift"
	end if
End Sub


Sub UpdateFlipperLogo_Timer
    BallShadowUpdate
    LFLogo.RotY = LeftFlipper.CurrentAngle
    RFlogo.RotY = RightFlipper.CurrentAngle
    sw6p.RotX = -(sw6.currentangle) +90
    sw14p.RotX = -(sw14.currentangle) +90
    Primitive134.RotX = -(spinner1.currentangle)
    Primitive157.RotX = -(spinner2.currentangle)
End Sub 


Sub SolLFlipper(Enabled)
     If Enabled Then
         LeftFlipper.RotateToEnd: PlaySound SoundFX("Flipper-oben-Links",DOFFlippers)

     Else
         LeftFlipper.RotateToStart: PlaySound SoundFX("Flipper-unten-Links",DOFFlippers), 0, 1 / (25*Rnd), -0.05, 0.15

     End If
  End Sub
  
Sub SolRFlipper(Enabled)
     If Enabled Then
         RightFlipper.RotateToEnd : PlaySound SoundFX("Flipper-oben-Rechts",DOFFlippers)
     Else
         RightFlipper.RotateToStart : PlaySound SoundFX("Flipper-unten-Rechts",DOFFlippers), 0, 1 / (25*Rnd), 0.05, 0.15
     End If
End Sub

 'Drains and Kickers
Sub Drain_Hit 
	PlaySound "Drain"
	bsTrough.AddBall Me
	Drain.TimerInterval = 200
	Drain.TimerEnabled = 1
End Sub

Sub Drain_Timer
	GI_TroughCheck
	If GI_TroughCheck = 8 Then 
Drain.TimerEnabled = False
	End If	
End Sub

Sub BallRelease_UnHit()	
	NewBallId
End Sub

'''*****************************************************************************************
'''*freneticamnesic level nudge script, based on rascals nudge bobble with help from gtxjoe*
'''*     add timers and "Nudgebobble(keycode)" to left and right tilt keys to activate     *
'''*****************************************************************************************
Dim bgcharctr:bgcharctr = 2
Dim centerlocation:centerlocation = 90
Dim bgdegree:bgdegree = 7 'move +/- 7 degrees
Dim bgdurationctr:bgdurationctr = 0

Sub LevelT_Timer()
	Dim loopctr
	Level.RotAndTra7 = Level.RotAndTra7 + bgcharctr  'change rotation value by bgcharctr
	'debug.print "Degrees: " & Level.RotAndTra7 & " Max degree offset: " & bgdegree & " Cycle count: " & bgdurationctr ''debug print
	If Level.RotAndTra7 >= bgdegree + centerlocation then bgcharctr = -1:bgdurationctr = bgdurationctr + 1   'if level moves past max degrees, change direction and increate durationctr
	If Level.RotAndTra7 <= -bgdegree + centerlocation then bgcharctr = 1  'if level moves past min location, change direction
	If bgdurationctr = 4 then bgdegree = bgdegree - 2:bgdurationctr = 0 'if level has moved back and forth 5 times, decrease amount of movement by -2 and repeat by resetting durationctr
	If bgdegree <= 0 then LevelT.Enabled = False:bgdegree = 7 'if amount of movement is 0, turn off LevelT timer and reset movement back to max 7 degrees
End Sub


Sub Nudgebobble(keycode)
	If keycode = LeftTiltKey then bgcharctr = -1  'if nudge left, move in - direction
	If keycode = RightTiltKey then bgcharctr = 1  'if nudge left, move in + direction
	If keycode = CenterTiltKey then 		'if nudge center, generate random number 1 or 2.  If 1 change it to -2.  use this number for initial direction
		Dim randombobble:randombobble = Int(2 * Rnd + 1)
		If randombobble = 1 then randombobble = -2
		bgcharctr = randombobble
	End If
	LevelT.Enabled = True:bgdurationctr = 0:bgdegree = 7
End Sub

Sub bobblesome_Timer()  'This looks like a free running timer that 1 out of ten times will start movement 
	Dim chance
	chance = Int(10*Rnd+1)
	If chance = 5 then Nudgebobble(CenterTiltKey)
End Sub




'Sub LaneKicker_Hit:	
'	bsSVUK.AddBall Me:
'End Sub	
'
Sub sw11_Hit:Controller.Switch(11) = 1:bsVUK.AddBall Me:PlaySound "scoopenter", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:End Sub	
'Sub sw11_UnHit: Controller.Switch(11) = 0: End Sub


Sub TOD_Hit:vpmTimer.PulseSw 12:bsVUK.AddBall Me:PlaySound "scoopenter", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:End Sub 'ClearBallID

Sub sw45_Hit:	
     Controller.Switch(45) = 1

	'GI_AllOff 1000
'	ClearBallID
	'bsMapVUK.AddBall Me:

    PlaySound "kicker_enter_center", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1
End Sub	
Sub sw45_UnHit: Controller.Switch(45) = 0: End Sub



Sub TempleWall2_Hit  : vpmTimer.PulseSw 59:Me.TimerEnabled = 1:Hiter = 10 :templeball1.TransY = 15:templeball2.TransY = 15:sw59p.TransZ = 4: playsound "fx_chapa", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: Frei = 0: End Sub
Sub TempleWall2_Timer:Me.TimerEnabled = 0:Hiter = 0 :templeball1.TransY = 0:templeball2.TransY = 0:sw59p.TransZ = 0:End Sub

' Hanibals Pulser Script for cinectic impuls transfer
Sub Pulser_Hit :Pulsercinetic :End Sub 'mLockMagnet.Magneton = 1
'Sub Pulser_UnHit :mLockMagnet.Magneton = 0:End Sub

Sub Pulsercinetic

If Not isNull(PulserBall.velx) and Not isNull(ActiveBall.velx) Then 
PulserBall.velx = (ActiveBall.velx * 2.5)
PulserBall.vely = (ActiveBall.vely * 2.5)
End If

End Sub
'-------------------------------------------------------------



Sub ArkMag_Hit:PMag.AddBall ActiveBall:End Sub
Sub ArkMag_UnHit:PMag.RemoveBall ActiveBall:End Sub

Sub TestMag_Hit:mLockMagnet.Magneton = 1:End Sub
Sub TestMag_UnHit:mLockMagnet.Magneton = 0:End Sub


Sub sw54_Hit  : vpmTimer.PulseSw(54): Playsound "rollover", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:End Sub

Sub sw38_Hit  : vpmTimer.PulseSw(38): Playsound "rollover", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:End Sub

Sub sw58_Hit  : vpmTimer.PulseSw(58): Playsound "rollover", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:End Sub

Sub sw13_Hit  : vpmTimer.PulseSw(13): Playsound "rollover", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:End Sub


Sub sw24_Hit  : vpmTimer.PulseSw(24): Playsound "rollover", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:sw24p.TransZ = -18: End Sub ' left outlane
Sub sw24_UnHit: sw24p.TransZ = 0: End Sub
Sub sw25_Hit  : vpmTimer.PulseSw(25): Playsound "rollover", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:sw25p.TransZ = -18: End Sub ' left inlane
Sub sw25_UnHit: sw25p.TransZ = 0: End Sub

Sub sw26_Hit  : vpmTimer.PulseSw(26): Flasher21c.state = 1 : End Sub
Sub sw26_UnHit  : Flasher21c.state = 0 : End Sub
Sub sw27_Hit  : vpmTimer.PulseSw(27): Flasher21d.state = 1 : End Sub
Sub sw27_UnHit  : Flasher21d.state = 0 : End Sub

Sub sw28_Hit  : vpmTimer.PulseSw(28): Playsound "rollover", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:sw28p.TransZ = -18: End Sub ' right inlane
Sub sw28_UnHit: sw28p.TransZ = 0: End Sub 
Sub sw29_Hit  : vpmTimer.PulseSw(29): Playsound "rollover", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:sw29p.TransZ = -18: End Sub ' right outlane 
Sub sw29_UnHit: sw29p.TransZ = 0: End Sub

Sub sw61_Hit  : Controller.Switch(61) = 1: :End Sub 'vpmTimer.PulseSw(61) Flasher37a.state = 1 
Sub sw61_Unhit: Controller.Switch(61) = 0: End Sub 'Flasher37a.state = 0 :

Sub sw62_Hit  : Controller.Switch(62) = 1: End Sub	'vpmTimer.PulseSw(62):
Sub sw62_Unhit:Controller.Switch(62) = 0: End Sub 


Sub sw48_Hit  : vpmTimer.PulseSw(48): Flasher38.state = 1 :Flasher38a.state = 1 :Flasher38b.state = 1 : DTimer.Enabled = 1:End Sub
'Sub sw48_UnHit  : Flasher38.state = 0 :Flasher38a.state = 0 :Flasher38b.state = 0 : End Sub
Sub DTimer_Timer: Flasher38.state = 0 :Flasher38a.state = 0 :Flasher38b.state = 0 :DTimer.Enabled = 0:End Sub


' Sub sw60_Hit  : Controller.Switch(60) = 1: End Sub
' Sub sw60_UnHit: Controller.Switch(60) = 0: End Sub
Sub TriggerSW60_Hit: vpmTimer.PulseSw 60: FlasherAkator2.State =1  End Sub
Sub TriggerSW60_UnHit: FlasherAkator2.State =0  End Sub

Sub sw40_Hit  : Controller.Switch(40) = 1: 	PlaySound "metalhit_medium": End Sub 'ark hit opto
Sub sw40_UnHit: Controller.Switch(40) = 0: End Sub

Sub sw35_Hit  : vpmTimer.PulseSw 35:Me.TimerEnabled = 1:sw35p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw35_Timer:Me.TimerEnabled = 0:sw35p.TransX = 0:End Sub
Sub sw36_Hit  : vpmTimer.PulseSw 36:Me.TimerEnabled = 1:sw36p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw36_Timer:Me.TimerEnabled = 0:sw36p.TransX = 0:End Sub
Sub sw37_Hit  : vpmTimer.PulseSw 37:Me.TimerEnabled = 1:sw37p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw37_Timer:Me.TimerEnabled = 0:sw37p.TransX = 0:End Sub
Sub sw41_Hit  : vpmTimer.PulseSw 41:Me.TimerEnabled = 1:sw41p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw41_Timer:Me.TimerEnabled = 0:sw41p.TransX = 0:End Sub
Sub sw42_Hit  : vpmTimer.PulseSw 42:Me.TimerEnabled = 1:sw42p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw42_Timer:Me.TimerEnabled = 0:sw42p.TransX = 0:End Sub
Sub sw43_Hit  : vpmTimer.PulseSw 43:Me.TimerEnabled = 1:sw43p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw43_Timer:Me.TimerEnabled = 0:sw43p.TransX = 0:End Sub
Sub sw44_Hit  : vpmTimer.PulseSw 44:Me.TimerEnabled = 1:sw44p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw44_Timer:Me.TimerEnabled = 0:sw44p.TransX = 0:End Sub
Sub sw55_Hit  : vpmTimer.PulseSw 55:Me.TimerEnabled = 1:sw55p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw55_Timer:Me.TimerEnabled = 0:sw55p.TransX = 0:End Sub
Sub sw56_Hit  : vpmTimer.PulseSw 56:Me.TimerEnabled = 1:sw56p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw56_Timer:Me.TimerEnabled = 0:sw56p.TransX = 0:End Sub
Sub sw57_Hit  : vpmTimer.PulseSw 57:Me.TimerEnabled = 1:sw57p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw57_Timer:Me.TimerEnabled = 0:sw57p.TransX = 0:End Sub
Sub sw1_Hit  : vpmTimer.PulseSw 1:Me.TimerEnabled = 1:sw1p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw1_Timer:Me.TimerEnabled = 0:sw1p.TransX = 0:End Sub
Sub sw2_Hit  : vpmTimer.PulseSw 2:Me.TimerEnabled = 1:sw2p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw2_Timer:Me.TimerEnabled = 0:sw2p.TransX = 0:End Sub
Sub sw3_Hit  : vpmTimer.PulseSw 3:Me.TimerEnabled = 1:sw3p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw3_Timer:Me.TimerEnabled = 0:sw3p.TransX = 0:End Sub
Sub sw4_Hit  : vpmTimer.PulseSw 4:Me.TimerEnabled = 1:sw4p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw4_Timer:Me.TimerEnabled = 0:sw4p.TransX = 0:End Sub
Sub sw5_Hit  : vpmTimer.PulseSw 5:Me.TimerEnabled = 1:sw5p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw5_Timer:Me.TimerEnabled = 0:sw5p.TransX = 0:End Sub
Sub sw7_Hit  : vpmTimer.PulseSw 7:Me.TimerEnabled = 1:sw7p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw7_Timer:Me.TimerEnabled = 0:sw7p.TransX = 0:End Sub
Sub sw8_Hit  : vpmTimer.PulseSw 8:Me.TimerEnabled = 1:sw8p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw8_Timer:Me.TimerEnabled = 0:sw8p.TransX = 0:End Sub
Sub sw9_Hit  : vpmTimer.PulseSw 9:Me.TimerEnabled = 1:sw9p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw9_Timer:Me.TimerEnabled = 0:sw9p.TransX = 0:End Sub
Sub sw10_Hit  : vpmTimer.PulseSw 10:Me.TimerEnabled = 1:sw10p.TransX = -4: playsound SoundFX("target",DOFTargets), 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1: End Sub
Sub sw10_Timer:Me.TimerEnabled = 0:sw10p.TransX = 0:End Sub

Sub sw6_Spin:vpmTimer.PulseSw 6: playsound "spinner" , 0, 40 / (15*Rnd), 0.10, 0.15: End Sub 
Sub sw14_Spin:vpmTimer.PulseSw 14:playsound "spinner" , 0, 40 / (15*Rnd), -0.10, 0.15:End Sub




Sub sw48s_Spin:Me.TimerEnabled = 1:playsound "spinner" , 0, 40 / (15*Rnd), 0.7, 0.15:End Sub
'Sub sw48s_Spin:Me.TimerEnabled = 1:SkullFlash.Alpha = 255:vpmTimer.PulseSw 48:End Sub
Sub sw48s_Timer:Me.TimerEnabled = 0:End Sub
Sub Spinner1_Hit:Test.State = 1:End Sub
Sub Spinner1_Spin:Me.TimerEnabled = 1:playsound "spinner" , 0, 40 / (15*Rnd), -0.10, 0.15:End Sub
'Sub Spinner1_Spin:Me.TimerEnabled = 1:SkullFlash.Alpha = 255:vpmTimer.PulseSw 60:End Sub
Sub Spinner1_Timer:Me.TimerEnabled = 0:End Sub

Sub Spinner2_Hit: playsound "spinner" , 0, 40 / (15*Rnd), 0.10, 0.15: End Sub 
Sub Spinner2_Spin: playsound "spinner" , 0, 40 / (15*Rnd), 0.10, 0.15: End Sub 

'***Slings and rubbers
 
Dim LStep, RStep, LTStep, RTStep
Dim Leftsling3p:Leftsling3p = False
Dim Rightsling3p:Rightsling3p = False
Dim LeftTopsling3p:LeftTopsling3p = False
Dim RightTopsling3p:RightTopsling3p = False

Sub LeftSlingShot_Slingshot
LeftSling.IsDropped = 0
vpmTimer.PulseSw 26
PlaySound SoundFX("slingshot",DOFContactors), 0, 40 / (15*Rnd), -0.05, 0.15+(0.2*Rnd)
'LeftSlingshot.TimerEnabled = 1
Leftsling3p = True
Me.TimerEnabled = 1
End Sub

Sub LeftSlingShot_Timer
    Select Case LStep
        Case 0:LeftSLing.IsDropped = 0
        Case 1: 'pause
        Case 2:LeftSLing.IsDropped = 1:LeftSLing2.IsDropped = 0
        Case 3:LeftSLing2.IsDropped = 1:LeftSLing3.IsDropped = 0
        Case 4:LeftSLing3.IsDropped = 1:Me.TimerEnabled = 0: LStep=0
    End Select

    LStep = LStep + 1
End Sub

Sub RightSlingShot_Slingshot
RightSling.IsDropped = 0
vpmTimer.PulseSw 27
PlaySound SoundFX("slingshot",DOFContactors), 0, 40 / (15*Rnd), 0.05, 0.15+(0.2*Rnd)
'RightSlingshot.TimerEnabled = 1
Rightsling3p = True
Me.TimerEnabled = 1
End Sub

Sub RightSlingShot_Timer
    Select Case RStep
        Case 0:RightSLing.IsDropped = 0
        Case 1: 'pause
        Case 2:RightSLing.IsDropped = 1:RightSLing2.IsDropped = 0
        Case 3:RightSLing2.IsDropped = 1:RightSLing3.IsDropped = 0
        Case 4:RightSLing3.IsDropped = 1:Me.TimerEnabled = 0: Rstep = 0
    End Select

    RStep = RStep + 1
End Sub

Sub LS3_Timer()
	If Leftsling3p = True and Left3.TransZ > -23 then Left3.TransZ = Left3.TransZ - 4
	If Leftsling3p = False and Left3.TransZ < -0 then Left3.TransZ = Left3.TransZ + 4
	If Left3.TransZ <= -23 then Leftsling3p = False
End Sub

Sub RS3_Timer()
	If Rightsling3p = True and Right3.TransZ > -23 then Right3.TransZ = Right3.TransZ - 4
	If Rightsling3p = False and Right3.TransZ < -0 then Right3.TransZ = Right3.TransZ + 4
	If Right3.TransZ <= -23 then Rightsling3p = False
End Sub

 Sub sw46_Slingshot
	Controller.Switch(46) = 1
	LeftTopSling1.IsDropped = 1
 	PlaySound SoundFX("Leftslingshot",DOFContactors), 0, 40 / (15*Rnd), 0.07, 0.15
	sw46.TimerEnabled = 1
  End Sub

Sub sw46_Timer

    Select Case LTStep
        Case 0:LeftTopSling1.IsDropped = 0
        Case 1: 'pause
        Case 2:LeftTopSling1.IsDropped = 1:LeftTopSling2.IsDropped = 0
        Case 3:LeftTopSling2.IsDropped = 1:LeftTopSling3.IsDropped = 0
        Case 4:LeftTopSling3.IsDropped = 1:Me.TimerEnabled = 0: LTStep=0:Controller.Switch(46) = 0
    End Select

    LTStep = LTStep + 1
End Sub

 Sub sw47_Slingshot
	Controller.Switch(47) = 1
	RightTopSling1.IsDropped = 1
 	PlaySound SoundFX("Leftslingshot",DOFContactors), 0, 40 / (15*Rnd), 0.07, 0.15
	sw47.TimerEnabled = 1
  End Sub

Sub sw47_Timer

    Select Case RTStep
        Case 0:RightTopSling1.IsDropped = 0
        Case 1: 'pause
        Case 2:RightTopSling1.IsDropped = 1:RightTopSling2.IsDropped = 0
        Case 3:RightTopSling2.IsDropped = 1:RightTopSling3.IsDropped = 0
        Case 4:RightTopSling3.IsDropped = 1:Me.TimerEnabled = 0: RTStep=0:Controller.Switch(47) = 0
    End Select

    RTStep = RTStep + 1

End Sub

     ' Impulse Plunger
    Const IMPowerSetting = 50
    Const IMTime = 0.6
    Set plungerIM = New cvpmImpulseP
    With plungerIM
        .InitImpulseP swplunger, IMPowerSetting, IMTime
		.Switch 23
        .Random 1.5
        .InitExitSnd "plunger2", "plunger"
        .CreateEvents "plungerIM"
    End With

Sub sw23_unhit :GI_TroughCheck: End Sub
'
'Hanibals Bumper Script with Light
      Sub Bumper1b_Hit:vpmTimer.PulseSw 30: BumperL1.State = 1 :PlaySound SoundFX("bumper",DOFContactors), 0, (18 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:B1Drop = True:End Sub
     
      Sub Bumper2b_Hit:vpmTimer.PulseSw 31: BumperL2.State = 1 :PlaySound SoundFX("bumper",DOFContactors), 0, (18 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:B2Drop = True: End Sub
     
      Sub Bumper3b_Hit:vpmTimer.PulseSw 32: BumperL3.State = 1 :BumperL3a.State = 1 :PlaySound SoundFX("bumper",DOFContactors), 0, (18 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:B3Drop = True:End Sub

      Sub Bumper4b_Hit:vpmTimer.PulseSw 33: BumperL4.State = 1 :PlaySound SoundFX("bumper",DOFContactors), 0, (18 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:B4Drop = True:End Sub
     
Dim B1Drop:B1Drop = False

Sub B1T_Timer()
	If B1Drop = True and Br1.z > -65 then Br1.z = Br1.z - 7
	If B1Drop = False and Br1.z < -25 then Br1.z = Br1.z + 7
	If Br1.z <= -65 then B1Drop = False : BumperL1.State = 0
End Sub

Dim B2Drop:B2Drop = False

Sub B2T_Timer()
	If B2Drop = True and Br2.z > -65 then Br2.z = Br2.z - 7
	If B2Drop = False and Br2.z < -25 then Br2.z = Br2.z + 7
	If Br2.z <= -65 then B2Drop = False : BumperL2.State = 0
End Sub

Dim B3Drop:B3Drop = False

Sub B3T_Timer()
	If B3Drop = True and Br3.z > -65 then Br3.z = Br3.z - 7
	If B3Drop = False and Br3.z < -25 then Br3.z = Br3.z + 7
	If Br3.z <= -65 then B3Drop = False : BumperL3.State = 0 : BumperL3a.State = 0
End Sub

Dim B4Drop:B4Drop = False

Sub B4T_Timer()
	If B4Drop = True and Br4.z > -65 then Br4.z = Br4.z - 7
	If B4Drop = False and Br4.z < -25 then Br4.z = Br4.z + 7
	If Br4.z <= -65 then B4Drop = False : BumperL4.State = 0
End Sub


 '****************************************
 ' SetLamp 0 is Off
 ' SetLamp 1 is On
 ' LampState(x) current state
 '****************************************
 
Dim LampState(200)
Dim FadingLevel(200)
Dim FadingState(200)
Dim FlashState(200)
Dim FlashLevel(200)
Dim Flashhelfer(200)
Dim FlashSpeedUp, FlashSpeedDown
Dim x


AllLampsOff()
LampTimer.Interval = 40 'lamp fading speed
LampTimer.Enabled = 1

Sub LampTimer_Timer()
    Dim chgLamp, num, chg, ii
    chgLamp = Controller.ChangedLamps
    If Not IsEmpty(chgLamp) Then
        For ii = 0 To UBound(chgLamp)
            LampState(chgLamp(ii, 0) ) = chgLamp(ii, 1)
            FadingLevel(chgLamp(ii, 0) ) = chgLamp(ii, 1) + 4
			FlashState(chgLamp(ii, 0) ) = chgLamp(ii, 1)
        Next
    End If

    UpdateLamps
End Sub
Sub FlashInit
    FlashSpeedUp = 300   ' fast speed when turning on the flasher
    FlashSpeedDown = 20 ' slow speed when turning off the flasher, gives a smooth fading
End Sub

Sub AllFlashOff
End Sub

 Sub UpdateLamps()

	NFadeLm 7, l7	
	NFadeLm 8, l8	
	NFadeLm 9, l9	
	NFadeLm 10, l10
	NFadeLm 11, l11	
	NFadeLm 12, l12	
	NFadeLm 13, l13	
	NFadeLm 14, l14	
	NFadeLm 15, l15 	 
	NFadeLm 16, l16	
	NFadeLm 19, l19	
	NFadeLm 20, l20	
	NFadeLm 21, l21	
	NFadeLm 22, l22	
	NFadeLm 23, l23	
	NFadeLm 24, l24
	NFadeLm 25, l25	
	NFadeLm 26, l26	
	NFadeLm 27, l27	
	NFadeLm 28, l28	
	NFadeLm 29, l29	
	NFadeLm 30, l30	
	NFadeLm 31, l31	
	NFadeLm 32, l32	
	NFadeLm 33, l33	
	nFadeLm 34, l34	
	NFadeLm 35, l35	
	NFadeLm 36, l36	
	NFadeLm 37, l37	
	NFadeLm 38, l38	
	NFadeLm 39, l39	
	NFadeLm 41, l41	
	NFadeLm 42, l42	
	NFadeLm 43, l43	
	NFadeLm 45, l45	
	NFadeLm 46, l46	
	NFadeLm 47, l47	
	NFadeLm 48, l48	
	NFadeLm 49, l49	
	NFadeLm 50, l50
	NFadeLm 51, l51	
	NFadeLm 52, l52	
	NFadeLm 53, l53	
	NFadeLm 54, l54
	NFadeLm 55, l55	
	NFadeLm 56, l56	
	NFadeLm 64, l64	
	NFadeLm 65, l65	
	NFadeLm 66, l66	
	NFadeLm 67, l67	
	NFadeLm 68, l68	
	NFadeLm 69, l69	
	NFadeLm 70, l70	
	NFadeLm 71, l71	
	NFadeLm 72, l72

'    KombiflasherLED 73, l73, FlasherLED73
'	NFadeLm 73,l73b1
'	NFadeLm 73,l73
 FadeDisableLighting 73, L81P3, 30
	NFadeLm 77, l77	
	NFadeLm 79, l79	
'	nFadeLD 80, l80,l80b, "indypflightson", "indypf"  ', "indypflightsb", "indypflightsa", "indypflightsoff"
	NFadeLm 80, l80b  
	NFadeLm 80, l80
 FadeDisableLighting 80, Primitive130, 30 

'Flasher


'	NFadeLm 137, Flasher37
'	NFadeLm 138, Flasher38
'	NFadeLm 138, Flasher38a
'	NFadeLm 138, Flasher38b
FadeDisableLighting 138, Primitive245, 0.5
'FadeDisableLighting 122, sankara, 1.5
End Sub


Sub Initialisierung_timer

    Initialisierung.Enabled = 0
	Flashersteuerung.Enabled = 1


End Sub

	DIM Backflash 
	DIM Backflashp
	DIM SLINGFLASH 
	DIM SLINGFLASHP
	DIM KISTENFLASH
	DIM KISTENFLASHP



Sub Flashersteuerung_timer


' Flasher SlingshotFlash

		If SLINGFLASHP < 1500 AND SLINGFLASH = 1 Then

			SLINGFLASHP = 1500'SLINGFLASHP +FlashSpeedUp
			Flasher21d1.opacity = SLINGFLASHP
			Flasher21d2.opacity = SLINGFLASHP

		End If


		If SLINGFLASHP  > 0 AND SLINGFLASH = 0 Then
			SLINGFLASHP = SLINGFLASHP - 20
			Flasher21d1.opacity = SLINGFLASHP
			Flasher21d2.opacity = SLINGFLASHP

		End If


' Flasher Backflash

		If Backflashp < 800 AND Backflash = 1 Then
			Backflashp = 800 'Backflashp  + (FlashSpeedUp*3)
			Flasher28d.opacity = Backflashp
		End If


		If Backflashp> 0 AND Backflash = 0 Then
			Backflashp = Backflashp  - 20
			Flasher28d.opacity = Backflashp
		End If


' Flasher KISTENFLASH

		If KISTENFLASHP < 600 AND KISTENFLASH = 1 Then
			KISTENFLASHP = 600 'KISTENFLASHP +FlashSpeedUp
			Flasher25d1.opacity = KISTENFLASHP
			Flasher25d2.opacity = KISTENFLASHP
		End If

		If KISTENFLASHP > 0 AND KISTENFLASH = 0 Then
			KISTENFLASHP = KISTENFLASHP - 20
			Flasher25d1.opacity = KISTENFLASHP
			Flasher25d2.opacity = KISTENFLASHP
		End If
End Sub


Sub FadePrim(nr, pri, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 2:pri.image = d:FadingLevel(nr) = 0
        Case 3:pri.image = c:FadingLevel(nr) = 1
        Case 4:pri.image = b:FadingLevel(nr) = 2
        Case 5:pri.image = a:FadingLevel(nr) = 3
    End Select
End Sub


''Lights


Sub NFadeLm(nr, a)
    Select Case FadingLevel(nr)
        Case 4:a.state = 0
        Case 5:a.State = 1
    End Select
End Sub



Sub FadeL(nr, a, b)
    Select Case FadingLevel(nr)
        Case 2:b.state = 0:FadingLevel(nr) = 0
        Case 3:b.state = 1:FadingLevel(nr) = 2
        Case 4:a.state = 0:FadingLevel(nr) = 3
        Case 5:a.state = 1:FadingLevel(nr) = 1
    End Select
End Sub

Sub NFadeL(nr, Light, a,b)   'NFadeL(nr, Light, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 2:Light.image = b:FadingLevel(nr) = 0 : Light.state = 0 'Off
        Case 3:Light.image = b:FadingLevel(nr) = 2 : Light.state = 1'fading...
        Case 4:Light.image = b:FadingLevel(nr) = 3 : Light.state = 1
        Case 5:Light.image = b:FadingLevel(nr) = 1 : Light.state = 1
    End Select
End Sub

'Parallel Script
Sub NFadeLD(nr, Light,Light2, a,b)   'NFadeL(nr, Light, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 2:Light.image = b:FadingLevel(nr) = 0 : Light.state = 0 : Light2.state = 0 	'Off
        Case 3:Light.image = b:FadingLevel(nr) = 2 : Light.state = 1 : Light2.state = 1 	'fading...
        Case 4:Light.image = b:FadingLevel(nr) = 3 : Light.state = 1 : Light2.state = 1 
        Case 5:Light.image = b:FadingLevel(nr) = 1 : Light.state = 1 : Light2.state = 1 
    End Select
End Sub

' Flasher objects
' Uses own faster timer

Sub Flash(nr, object)
    Select Case FlashState(nr)
        Case 0 'off
            FlashLevel(nr) = FlashLevel(nr) - FlashSpeedDown
            If FlashLevel(nr) < 0 Then
                FlashLevel(nr) = 0
                FlashState(nr) = -1 'completely off
            End if
 '           Object.alpha = FlashLevel(nr)
        Case 1 ' on
            FlashLevel(nr) = FlashLevel(nr) + FlashSpeedUp
            If FlashLevel(nr) > 255 Then
                FlashLevel(nr) = 255
                FlashState(nr) = -2 'completely on
            End if
'            Object.alpha = FlashLevel(nr)
    End Select
End Sub

 Sub AllLampsOff():For x = 1 to 200:LampState(x) = 4:FadingLevel(x) = 4:Next:UpdateLamps:UpdateLamps:Updatelamps:End Sub
 

Sub SetLamp(nr, value)
    If value = 0 AND LampState(nr) = 0 Then Exit Sub
    If value = 1 AND LampState(nr) = 1 Then Exit Sub
'    LampState(nr) = abs(value) + 4
'FadingLevel(nr ) = abs(value) + 4: FadingState(nr ) = abs(value) + 4
End Sub

Sub SetFlash(nr, stat)
    FlashState(nr) = ABS(stat)
End Sub


Sub FlashAR(nr, ramp, a, b, c, r)                                                          'used for reflections when there is no off ramp
    Select Case FadingState(nr)
        Case 2:'ramp.intensity = 0:r.State = ABS(r.state -1):FadingState(nr) = 0                'Off
        Case 3:ramp.image = c:r.State = ABS(r.state -1):FadingState(nr) = 2                'fading...
        Case 4:ramp.image = b:r.State = ABS(r.state -1):FadingState(nr) = 3                'fading...
        Case 5:ramp.image = a:'ramp.intensity = 1:r.State = ABS(r.state -1):FadingState(nr) = 1 'ON
    End Select
End Sub


Sub FlashARm(nr, ramp, a, b, c, r)
    Select Case FadingState(nr)
        Case 2:'ramp.intensity = 0:r.State = ABS(r.state -1)
        Case 3:ramp.image = c:r.State = ABS(r.state -1)
        Case 4:ramp.image = b:r.State = ABS(r.state -1)
        Case 5:ramp.image = a:'ramp.intensity = 1:r.State = ABS(r.state -1)
    End Select
End Sub

Sub Flashm(nr, object) 'multiple flashers, it doesn't change the flashstate
    Select Case FlashState(nr)
        Case 0         'off
 '           Object.alpha = FlashLevel(nr)
        Case 1         ' on
 '           Object.alpha = FlashLevel(nr)
    End Select
End Sub

Sub FlasherTimer_Timer()


 End Sub

Sub FadeDisableLighting(nr, a, alvl)
	Select Case FadingLevel(nr)
		Case 4
			a.UserValue = a.UserValue - 0.3
			If a.UserValue < 0 Then 
				a.UserValue = 0
				FadingLevel(nr) = 0
			end If
			a.BlendDisableLighting = alvl * a.UserValue 'brightness
		Case 5
			a.UserValue = a.UserValue + 0.50
			If a.UserValue > 1 Then 
				a.UserValue = 1
				FadingLevel(nr) = 1
			end If
			a.BlendDisableLighting = alvl * a.UserValue 'brightness
	End Select
End Sub


'SOUNDS

Sub BallstopL_Hit: PlaySound "drop_left", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:End Sub
Sub arkdrop_Hit: PlaySound "drop_right", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1:End Sub


'***********************
'Hanibal Ramp Plunger
'***********************

 Dim BallinPlunger


Sub swPlunger_Hit:BallinPlunger = 1:End Sub                            'in this sub you may add a switch, for example Controller.Switch(14) = 1

Sub swPlunger_UnHit:BallinPlunger = 0:End Sub                          'in this sub you may add a switch, for example Controller.Switch(14) = 0

Sub Plungin_Hit:Plungerlight.state = 1 :End Sub   

Sub Plungin_UnHit: Plungerlight.state = 0    :End Sub 
 
 
   '*************************************
  '          Nudge System
  '*************************************
  
  Dim LeftNudgeEffect, RightNudgeEffect, NudgeEffect
  
  Sub LeftNudge(angle, strength, delay)
      vpmNudge.DoNudge angle, (strength * (delay-LeftNudgeEffect) / delay) + RightNudgeEffect / delay
      LeftNudgeEffect = delay
      RightNudgeEffect = 0
      RightNudgeTimer.Enabled = 0
      LeftNudgeTimer.Interval = delay
      LeftNudgeTimer.Enabled = 1
  End Sub
  
  Sub RightNudge(angle, strength, delay)
      vpmNudge.DoNudge angle, (strength * (delay-RightNudgeEffect) / delay) + LeftNudgeEffect / delay
      RightNudgeEffect = delay
      LeftNudgeEffect = 0
      LeftNudgeTimer.Enabled = 0
      RightNudgeTimer.Interval = delay
      RightNudgeTimer.Enabled = 1
  End Sub
  
  Sub CenterNudge(angle, strength, delay)
      vpmNudge.DoNudge angle, strength * (delay-NudgeEffect) / delay
      NudgeEffect = delay
      NudgeTimer.Interval = delay
      NudgeTimer.Enabled = 1
  End Sub
  
  Sub LeftNudgeTimer_Timer()
      LeftNudgeEffect = LeftNudgeEffect-1
      If LeftNudgeEffect = 0 then LeftNudgeTimer.Enabled = 0
  End Sub
  
  Sub RightNudgeTimer_Timer()
      RightNudgeEffect = RightNudgeEffect-1
      If RightNudgeEffect = 0 then RightNudgeTimer.Enabled = 0
  End Sub
  
  Sub NudgeTimer_Timer()
      NudgeEffect = NudgeEffect-1
      If NudgeEffect = 0 then NudgeTimer.Enabled = 0
  End Sub

 
 Dim tnopb, nosf
 '
 tnopb = 16 	' <<<<< SET to the "Total Number Of Possible Balls" in play at any one time
 nosf = 9	' <<<<< SET to the "Number Of Sound Files" used / B2B collision volume levels
 
 Dim currentball(16), ballStatus(16)
 Dim iball, cnt, coff, errMessage
 
 XYdata.interval = 1 			' Timer interval starts at 1 for the highest ball data sample rate
 coff = False				' Collision off set to false
 
 For cnt = 0 to ubound(ballStatus)	' Initialize/clear all ball stats, 1 = active, 0 = non-existant
 	ballStatus(cnt) = 0
 Next
' 
 '======================================================
 ' <<<<<<<<<<<<<< Ball Identification >>>>>>>>>>>>>>
 '======================================================
 ' Call this sub from every kicker(or plunger) that creates a ball.
 Sub NewBallID 						' Assign new ball object and give it ID for tracking
 	For cnt = 1 to ubound(ballStatus)		' Loop through all possible ball IDs
    	If ballStatus(cnt) = 0 Then			' If ball ID is available...
    	Set currentball(cnt) = ActiveBall			' Set ball object with the first available ID
    	currentball(cnt).uservalue = cnt			' Assign the ball's uservalue to it's new ID
    	ballStatus(cnt) = 1				' Mark this ball status active
    	ballStatus(0) = ballStatus(0)+1 		' Increment ballStatus(0), the number of active balls
 	If coff = False Then				' If collision off, overrides auto-turn on collision detection
 							' If more than one ball active, start collision detection process
 	If ballStatus(0) > 1 and XYdata.enabled = False Then XYdata.enabled = True
 	End If
 	Exit For					' New ball ID assigned, exit loop
    	End If
    	Next 
 '  	Debugger 					' For demo only, display stats
 End Sub 
 
 '=====================================================
 ' <<<<<<<<<<<<<<<<< XYdata_Timer >>>>>>>>>>>>>>>>>
 '=====================================================
 ' Ball data collection and B2B Collision detection.
 ReDim baX(tnopb,4), baY(tnopb,4), bVx(tnopb,4), bVy(tnopb,4), TotalVel(tnopb,4)
 Dim cForce, bDistance, xyTime, cFactor, id, id2, id3, B1, B2
 
 Sub XYdata_Timer()
 	' xyTime... Timers will not loop or start over 'til it's code is finished executing. To maximize
 	' performance, at the end of this timer, if the timer's interval is shorter than the individual
 	' computer can handle this timer's interval will increment by 1 millisecond. 
     xyTime = Timer+(XYdata.interval*.001)	' xyTime is the system timer plus the current interval time
 	' Ball Data... When a collision occurs a ball's velocity is often less than it's velocity before the
 	' collision, if not zero. So the ball data is sampled and saved for four timer cycles. 
    	If id2 >= 4 Then id2 = 0						' Loop four times and start over

  '      tablelaunch.visible = 0								'Turn off Ball sorting Info
    	id2 = id2+1								' Increment the ball sampler ID

    	For id = 1 to ubound(ballStatus)					' Loop once for each possible ball
 '  	If ballStatus(id) = 1 Then						' If ball is active...
 '       If BallStatus(b)=0 Then Exit Sub
 '           tablelaunch.Visible = True 								'Turn on Ball sorting Info
 '   		baX(id,id2) = round(currentball(id).x,2)				' Sample x-coord
 '   		baY(id,id2) = round(currentball(id).y,2)				' Sample y-coord
 '   		bVx(id,id2) = round(currentball(id).velx,2)				' Sample x-velocity
 '   		bVy(id,id2) = round(currentball(id).vely,2)				' Sample y-velocity
 '   		TotalVel(id,id2) = (bVx(id,id2)^2+bVy(id,id2)^2) 		' Calculate total velocity
 ' 		If TotalVel(id,id2) > TotalVel(0,0) Then TotalVel(0,0) = int(TotalVel(id,id2))
 '   	End If
 
    	Next
 	' Collision Detection Loop - check all possible ball combinations for a collision.
 	' bDistance automatically sets the distance between two colliding balls. Zero milimeters between
 	' balls would be perfect, but because of timing issues with ball velocity, fast-traveling balls
 	' prevent a low setting from always working, so bDistance becomes more of a sensitivity setting,
 	' which is automated with calculations using the balls' velocities.
 	' Ball x/y-coords plus the bDistance determines B2B proximity and triggers a collision. 
 	id3 = id2 : B2 = 2 : B1 = 1						' Set up the counters for looping
 	Do
 	If ballStatus(B1) = 1 and ballStatus(B2) = 1 Then			' If both balls are active...
 		bDistance = int((TotalVel(B1,id3)+TotalVel(B2,id3))^1.04)
 		If ((baX(B1,id3)-baX(B2,id3))^2+(baY(B1,id3)-baY(B2,id3))^2)<2800+bDistance Then collide B1,B2 : Exit Sub		
 		End If
 		B1 = B1+1							' Increment ball1
  
 		If B1 >= ballStatus(0) Then Exit Do				' Exit loop if all ball combinations checked	
 		If B1 >= B2 then B1 = 1:B2 = B2+1				' If ball1 >= reset ball1 and increment ball2
  
 	Loop
 	
  	If ballStatus(0) <= 1 Then XYdata.enabled = False 			' Turn off timer if one ball or less
 
 	If XYdata.interval >= 40 Then coff = True : XYdata.enabled = False	' Auto-shut off
 	If Timer > xyTime * 3 Then coff = True : XYdata.enabled = False		' Auto-shut off
    	If Timer > xyTime Then XYdata.interval = XYdata.interval+1		' Increment interval if needed
 End Sub
 
 '=========================================================
 ' <<<<<<<<<<< Collide(ball id1, ball id2) >>>>>>>>>>>
 '=========================================================
 'Calculate the collision force and play sound accordingly.
 Dim cTime, cb1,cb2, avgBallx, cAngle, bAngle1, bAngle2
 
 Sub Collide(cb1,cb2) 	
 ' The Collision Factor(cFactor) uses the maximum total ball velocity and automates the cForce calculation, maximizing the
 ' use of all sound files/volume levels. So all the available B2B sound levels are automatically used by adjusting to a
 ' player's style and the table's characteristics.
  	If TotalVel(0,0)/1.8 > cFactor Then cFactor = int(TotalVel(0,0)/1.8)
 ' The following six lines limit repeated collisions if the balls are close together for any period of time
   	avgBallx = (bvX(cb2,1)+bvX(cb2,2)+bvX(cb2,3)+bvX(cb2,4))/4
   	If avgBallx < bvX(cb2,id2)+.1 and avgBallx > bvX(cb2,id2)-.1 Then
  	If ABS(TotalVel(cb1,id2)-TotalVel(cb2,id2)) < .000005 Then Exit Sub
  	End If
   	If Timer < cTime Then Exit Sub
   	cTime = Timer+.1				' Limits collisions to .1 seconds apart
' GetAngle(x-value, y-value, the angle name) calculates any x/y-coords or x/y-velocities and returns named angle in radians
'  	GetAngle baX(cb1,id3)-baX(cb2,id3), baY(cb1,id3)-baY(cb2,id3),cAngle	' Collision angle via x/y-coordinates
 	id3 = id3 - 1 : If id3 = 0 Then id3 = 4		' Step back one xyData sampling for a good velocity reading
'  	GetAngle bVx(cb1,id3), bVy(cb1,id3), bAngle1	' ball 1 travel direction, via velocity
'  	GetAngle bVx(cb2,id3), bVy(cb2,id3), bAngle2	' ball 2 travel direction, via velocity
 ' The main cForce formula, calculating the strength of a collision
 	cForce = Cint((abs(TotalVel(cb1,id3)*Cos(cAngle-bAngle1))+abs(TotalVel(cb2,id3)*Cos(cAngle-bAngle2))))
     	If cForce < 4 Then Exit Sub			' Another collision limiter
    	cForce = Cint((cForce)/(cFactor/nosf))		' Divides up cForce for the proper sound selection.
   	If cForce > nosf-1 Then cForce = nosf-1		' First sound file 0(zero) minus one from number of sound files
    	PlaySound("collide" & cForce)			' Combines "collide" with the calculated sound level and play sound
 End Sub
 
 '=================================================
 ' <<<<<<<< GetAngle(X, Y, Anglename) >>>>>>>>
 '=================================================
 ' A repeated function which takes any set of coordinates or velocities and calculates an angle in radians.
 Dim Xin,Yin,rAngle,Radit,wAngle,Pi
 Pi = Round(4*Atn(1),6)					'3.1415926535897932384626433832795
 
 Sub GetAngle(Xin, Yin, wAngle)						
  	If Sgn(Xin) = 0 Then
  		If Sgn(Yin) = 1 Then rAngle = 3 * Pi/2 Else rAngle = Pi/2
  		If Sgn(Yin) = 0 Then rAngle = 0
  	Else
  		rAngle = atn(-Yin/Xin)			' Calculates angle in radians before quadrant data
  	End If
  	If sgn(Xin) = -1 Then Radit = Pi Else Radit = 0
  	If sgn(Xin) = 1 and sgn(Yin) = 1 Then Radit = 2 * Pi
  	wAngle = round((Radit + rAngle),4)		' Calculates angle in radians with quadrant data
 	'"wAngle = round((180/Pi) * (Radit + rAngle),4)" ' Will convert radian measurements to degrees - to be used in future
 End Sub

Dim Jaildown, RPDown, LPUp

Sub Table_exit()
	Controller.Pause = False
	Controller.Stop
End Sub

Dim MultiballFlag
Function GI_TroughCheck 
	Dim Ballcount: 	Ballcount = 0
	If Controller.Switch(18) = TRUE then Ballcount = Ballcount + 1':debug.print "18x"
    If Controller.Switch(19) = TRUE then Ballcount = Ballcount + 1':debug.print "19x"
    If Controller.Switch(20) = TRUE then Ballcount = Ballcount + 1':debug.print "20x"
    If Controller.Switch(21) = TRUE then Ballcount = Ballcount + 1':debug.print "21x"
	Ballcount = Ballcount + arkballcnt

	If Ballcount < 7 Then 'Keep track of multiball mode
		MultiballFlag = 1
	Else
		MultiballFlag = 0
	End If

	GI_TroughCheck = Ballcount

	debug.print "Troughcheck " & ballcount & " Multiball " & MultiballFlag

	If ballcount = 8 then 
		GameOverTimerCheck.Enabled = 1 'no ball in play
		'debug.print timer & "Game Over?"
	Else
		GameOverTimerCheck.Enabled = 0 'ball in play
		'debug.print timer & "Game Not Over"
	End If

End Function	

sub solcheck(value,enabled) 'gtxjoe romtest script
	dim x
	dprint timer & " Schuetz-An " & value &"="&enabled

	'Add required table solenoid actions here
	Select Case value
		Case 1: 
			If Enabled Then
				bsTrough.ExitSol_On
				vpmTimer.PulseSw 22
				'debug.print "BALLRELEASE"
			End If
		Case 2: SolAutoFire enabled
		Case 7: 'ARK DIVERTER
			'debug.print timer & " diverter " & enabled
			if enabled Then
				'diverter.rotatetoend
				arkdiv.isdropped = 0
			else
				'diverter.rotatetostart
				arkdiv.isdropped = 1
			end if
'		Case  25: If enabled then bsTrough.EntrySol_On
'		Case  26: If enabled then bsTrough.ExitSol_On 
		case 27: 'ARK MOTOR
			if enabled then
				controller.switch(50) = 0
				controller.switch(51) = 0
				arkmotor.interval = 2000
				arkmotor.enabled = 1
			else
				arkmotor.enabled = 0
			end if
	End Select
End Sub


Const ArkHeightMax = 208
Const ArkLidMax = 35
'Const ArkSpeed = .15
arkmotor.interval = 2
dim Arkdirection: ArkDirection = 1
Dim Arkheight, ArkPos, ArkLidAngle, ArkSpeed
Dim ArkTempPos: ArkTempPos = 0

Sub ArkMotor_Timer

	'Test
	ArkSpeed =(0.4*RND)
	'Change height
	ArkTempPos = ArkTempPos + ArkDirection*ArkSpeed
	ArkPos = ArkTempPos
	'debug.print arktemppos
	ArkLidAngle = ArkTempPos * ArkLidMax/ArkHeightMax

	'Set Switches
	If ArkTempPos >= ArkHeightMax Then  'UP
		Controller.Switch(50) = 1
		ArkPos = ArkHeightMax
	Else
		Controller.Switch(50) = 0
	End If
	If ArkTempPos <= 0 Then    			'DOWN        
		Controller.Switch(51) = 1
		ArkPos = 0
	Else
		Controller.Switch(51) = 0
	End If

	'Move Primitives and balls
	if Not isNull(arkballs(0)) then Arkballs(0).z = ArkPos + 25:
	if Not isNull(arkballs(1)) then Arkballs(1).z = ArkPos + 25:
	if Not isNull(arkballs(2)) then Arkballs(2).z = ArkPos + 25:
	if Not isNull(arkballs(3)) then Arkballs(3).z = ArkPos + 25:
	Primitive107.TransZ = ArkPos - 15 'Platform
	PrimArkLid.RotZ = ArkLidAngle

	'Release Balls if on top of ark
	if Not isNull(arkballs(0)) Then
		If Arkballs(0).z = ArkHeightMax + 25 then 
			ArkPlatformTrigger0.Enabled = 1
			ArkKicker0.kick 0,0
			arkballs(0) = NULL
			arkballcnt = 0
		End If
	End If
	if Not isNull(arkballs(1)) Then
		If Arkballs(1).z = ArkHeightMax + 25 then 
			ArkPlatformTrigger1.Enabled = 1
			ArkKicker1.kick 0,0
			arkballs(1) = NULL
		End If
	End If	
	if Not isNull(arkballs(2)) Then
		If Arkballs(2).z = ArkHeightMax + 25 then 
			ArkPlatformTrigger2.Enabled = 1
			ArkKicker2.kick 0,0
			arkballs(2) = NULL
		End If
	End If
	if Not isNull(arkballs(3)) Then
		If Arkballs(3).z = ArkHeightMax + 25 then 
			ArkPlatformTrigger3.Enabled = 1
			ArkKicker3.kick 0,0
			arkballs(3) = NULL
		End If
	End If

	'Check Motor Direction
	If ArkTempPos >= ArkHeightMax +3 Then	
		Arkdirection = -1
	ElseIf ArkTempPos <= 0 -3 Then 		
		Arkdirection = 1
	End If
	
	IF Arkdirection = 1 AND ArkTempPos >= 10 AND tablelaunch.visible = 0 Then
        Flasher36a.state = 1
        Flasher36b.state = 1
	End If

	IF Arkdirection = -1 Then
        Flasher36a.state = 0
        Flasher36b.state = 0
	End If


End Sub

Sub ArkPlatformTrigger0_UnHit:NewBallID: me.enabled=0: me.timerinterval = 500: me.timerenabled = 1:End Sub
Sub ArkPlatformTrigger0_Timer: GI_TroughCheck: me.timerenabled = 0: End Sub
Sub ArkPlatformTrigger1_UnHit:NewBallID: me.enabled=0:End Sub
Sub ArkPlatformTrigger2_UnHit:NewBallID: me.enabled=0:End Sub
Sub ArkPlatformTrigger3_UnHit:NewBallID: me.enabled=0:End Sub

' Ark Ball Count

Dim arkballs(4), arkballcnt
arkballs(0) = NULL:arkballs(1) = NULL:arkballs(2) = NULL:arkballs(3) = NULL

Sub sw39_Init: Controller.Switch(39) = 0 :End Sub 'enter ark
Sub sw39_Hit: 'Ark Opto
	Controller.Switch(39) = 1
	me.TimerInterval = 300  '500
	me.TimerEnabled = 1
	
'	'Track all four balls as they enter ark
	Set arkballs(arkballcnt) = ActiveBall
'	debug.print "sw39 hit" & arkballcnt & ":" & arkballs(arkballcnt).x
'	arkballcnt = (arkballcnt+1) mod 4
End Sub  
Sub sw39_UnHit
	Controller.Switch(39) = 0:
'	ClearballId
	Activeball.DestroyBall
	'Track all four balls as they enter ark
	Select Case arkballcnt:
		Case 0:
			Set arkballs(0) = arkkicker0.CreateBall
			'debug.print "Arkball0"
		Case 1:
			Set arkballs(1) = arkkicker1.CreateBall
			'debug.print "Arkball1"
		Case 2:
			Set arkballs(2) = arkkicker2.CreateBall
			'debug.print "Arkball2"
		Case 3:
			Set arkballs(3) = arkkicker3.CreateBall
			'debug.print "Arkball3"
            tablelaunch.visible = 0  'Turn Off Ball Info
	End Select

'	Set arkballs(arkballcnt) = ActiveBall
'	debug.print "sw39 hit" & arkballcnt & ":" & arkballs(arkballcnt).x
	arkballcnt = (arkballcnt+1) mod 5
End Sub
Sub sw39_Timer
	GI_TroughCheck 'update ball count after ball enters ark
	me.TimerEnabled = 0
End Sub

Sub sw49_Hit:Controller.Switch(49) = 1:End Sub 'enter launch ramp
Sub sw49_UnHit:Controller.Switch(49) = 0:End Sub


Const DTMaxRotate = 30
Dim TempleSpeed:TempleSpeed = 0.3
Dim TempleDir: TempleDir = 1
Dim TPos,PrimPos
Dim TempMotorUp, TempMotorDown, TempSoundTrigger1, TempSoundTrigger2

DT.Interval = 30
Sub DT_Timer
    TempleSpeed = 0.3+(0.2 * RND)
	'Change angle
	TPos = TPos + TempleDir*TempleSpeed
	PrimPos = TPos

	'Set Switches and Walls
	If TPos >= DTMaxRotate Then  'If up all the way
		Controller.Switch(52) = 1
		PrimPos = DTMaxRotate
		sw59.IsDropped = True
		TempleWall1.IsDropped = True
		TempleWall2.IsDropped = True
		templebase.isdropped = False

 	Else
		Controller.Switch(52) = 0
	End If
	If TPos <= 0 Then           'If down all the way
		Controller.Switch(53) = 1
		PrimPos = 0
		sw59.IsDropped = False
		TempleWall1.IsDropped = False
		TempleWall2.IsDropped = False
		templebase.isdropped = True

 	Else
		Controller.Switch(53) = 0
	End If

	' Sound Aktivation
 
   If TPos = 1 AND TempleDir = 1 Then
	TempSoundTrigger1 = 1
    TempMotorUp = 1
    End If


   If TPos = 1 AND TempleDir = -1 Then
    StopSound "E_Motorlift4"
    TempMotorDown = 0
    End If


    If TPos = DTMaxRotate-1 AND TempleDir = -1 Then
	TempSoundTrigger2 = 1
    TempMotorDown = 1
    End If


    If TPos = DTMaxRotate-1 AND TempleDir = 1 Then
    StopSound "E_Motorlift2"
    TempMotorUp = 0
    End If


	'Check Motor Direction
	If TPos >= DTMaxRotate + 1 Then	'If up all the way + padding
		TempleDir = -1
	ElseIf TPos <= 0 - 1 Then 		'If down all the way + padding
		TempleDir = 1
	End If

' Hanibals Sound Routine for Temple moving

If TempMotorUp = 1 AND TempSoundTrigger1 = 1 Then
        PlaySound SoundFX("E_Motorlift2",DOFContactors), 0, 40 / (25*Rnd), -0.05, 0.15
        TempSoundTrigger1 = 0

End If

If TempMotorDown = 1 AND TempSoundTrigger2 = 1  Then
        PlaySound SoundFX("E_Motorlift4",DOFContactors), 0, 40 / (25*Rnd), -0.05, 0.15
		TempSoundTrigger2 = 0
End If
	'Move Primitives
	sw59p.Rotx = PrimPos
	temple1.Rotx = PrimPos
	temple2.Rotx = PrimPos
	temple3.Rotx = PrimPos
	temple4.Rotx = PrimPos
	temple5.Rotx = PrimPos
	temple6.Rotx = PrimPos
	temple7.Rotx = PrimPos
	temple8.Rotx = PrimPos
	templeball1.Rotx = PrimPos
	templeball2.Rotx = PrimPos
    Lift = PrimPos
End Sub

' Hanibals Sound Routine for Temple moving

Sub TempMotorSound

If TempMotorUp = 1 Then
        PlaySound SoundFX("E_Motorlift2",DOFContactors), 0, 40 / (25*Rnd), -0.05, 0.15
		Else
		StopSound "E_Motorlift2"
End If

If TempMotorDown = 1 Then
        PlaySound SoundFX("E_Motorlift4",DOFContactors), 0, 40 / (25*Rnd), -0.05, 0.15
		Else
		StopSound "E_Motorlift4"
End If

End Sub


Const SMMaxRotate = 80
Const SMMinRotate = -10
Dim SwordsManSpeed:SwordsManSpeed = 10
Dim SwordsManDir: SwordsManDir = 1
Dim SMPos,SMPrimPos
SM.Interval = 30
SMPos = SMMinRotate
Sub SM_Timer

	'Different Speeds
	IF SwordsManDir = 1 Then
	SwordsManSpeed = 5
	Else
	SwordsManSpeed = 10
	End If
	'Change angle
	SMPos = SMPos + SwordsManDir*SwordsManSpeed
	SMPrimPos = SMPos

	'Set Switches
	If SMPos >= SMMaxRotate Then  
		Controller.Switch(64) = 1
		SMPrimPos = SMMaxRotate
		Playsound"PlastikHit", 1, 2 / (15*Rnd), -0.1
	Else
		Controller.Switch(64) = 0
	End If
	If SMPos <= SMMinRotate Then           
		Controller.Switch(63) = 1
		SMPrimPos = SMMinRotate
		Playsound"PlastikHit", 1, 2 / (15*Rnd), -0.1
	Else
		Controller.Switch(63) = 0
	End If

	'Check Motor Direction
	If SMPos >= SMMaxRotate + 1 Then	
		SwordsManDir = -1
	ElseIf SMPos <= SMMinRotate - 1 Then 		
		SwordsManDir = 1
	End If

	If SMPos < SMMaxRotate -2 Then	
        f37a.state = 0
		Swordmanlicht.Enabled = 0
	Else
		Swordmanlicht.Enabled = 1
	End If

	'Move Primitives
	swordsmanprim.ObjRotZ = SMPrimPos:'debug.print SMPrimPos
'	swordsmanprim.ObjRotZ = 80
	swordsmanprim1.ObjRotZ = swordsmanprim.ObjRotZ
End Sub

Sub Swordmanlicht_Timer

		If f37a.state = 1 Then
			f37a.state = 0
		Else
			f37a.state = 1
		End If

End Sub

'----- Debug Print 
Dim dString
Const debugOn = True
Sub dprint (dString)
	If debugOn = True Then
		debug.print dString
	End If
End Sub

'--------------------
'     8 BallStack
'--------------------
Private Const con8StackSw    = 8  ' Stack switches
Class cvpm8BallStack

	Private mSw(), mEntrySw, mBalls, mBallIn, mBallPos(), mSaucer, mBallsMoving
	Private mInitKicker, mExitKicker, mExitDir, mExitForce
	Private mExitDir2, mExitForce2
	Private mEntrySnd, mEntrySndBall, mExitSnd, mExitSndBall, mAddSnd
	Public KickZ, KickBalls, KickForceVar, KickAngleVar

	Private Sub Class_Initialize
		ReDim mSw(con8StackSw), mBallPos(conMaxBalls)
		mBallIn = 0 : mBalls = 0 : mExitKicker = 0 : mInitKicker = 0 : mBallsMoving = False
		KickBalls = 1 : mSaucer = False : mExitDir = 0 : mExitForce = 0
		mExitDir2 = 0 : mExitForce2 = 0 : KickZ = 0 : KickForceVar = 0 : KickAngleVar = 0
		mAddSnd = 0 : mEntrySnd = 0 : mEntrySndBall = 0 : mExitSnd = 0 : mExitSndBall = 0
		vpmTimer.AddResetObj Me
	End Sub

	Private Property Let NeedUpdate(aEnabled) : vpmTimer.EnableUpdate Me, False, aEnabled : End Property

	Private Function SetSw(aNo, aStatus)
		SetSw = False : If HasSw(aNo) Then Controller.Switch(mSw(aNo)) = aStatus : SetSw = True
	End Function

	Private Function HasSw(aNo)
		HasSw = False : If aNo <= con8StackSw Then If mSw(aNo) Then HasSw = True
	End Function

	Public Sub Reset
		Dim ii : If mBalls Then For ii = 1 to mBalls : SetSw mBallPos(ii), True : Next
	      If mEntrySw And mBallIn > 0 Then Controller.Switch(mEntrySw) = True
	End Sub

	Public Sub Update
		Dim BallQue, ii
		NeedUpdate = False : BallQue = 1
		For ii = 1 To mBalls
			If mBallpos(ii) > BallQue Then ' next slot available
				NeedUpdate = True
				If HasSw(mBallPos(ii)) Then ' has switch
					If Controller.Switch(mSw(mBallPos(ii))) Then
						SetSw mBallPos(ii), False
					Else
						mBallPos(ii) = mBallPos(ii) - 1
						SetSw mBallPos(ii), True
					End If
				Else ' no switch. Move ball to first switch or occupied slot
					Do
						mBallPos(ii) = mBallPos(ii) - 1
					Loop Until SetSw(mBallPos(ii), True) Or mBallPos(ii) = BallQue
				End If
			End If
			BallQue = mBallPos(ii) + 1
		Next
	End Sub

	Public Sub AddBall(aKicker)
		If isObject(aKicker) Then
			If mSaucer Then
				If aKicker Is mExitKicker Then
					mExitKicker.Enabled = False : mInitKicker = 0
				Else
					aKicker.Enabled = False : Set mInitKicker = aKicker
				End If
			Else
				aKicker.DestroyBall
			End If
		ElseIf mSaucer Then
			mExitKicker.Enabled = False : mInitKicker = 0
		End If
		If mEntrySw Then
			Controller.Switch(mEntrySw) = True : mBallIn = mBallIn + 1
		Else
			mBalls = mBalls + 1 : mBallPos(mBalls) = con8StackSw + 1 : NeedUpdate = True
		End If
		PlaySound mAddSnd
	End Sub

	' A bug in the script engine forces the "End If" at the end
	Public Sub SolIn(aEnabled)     : If aEnabled Then KickIn        : End If : End Sub
	Public Sub SolOut(aEnabled)    : If aEnabled Then KickOut False : End If : End Sub
	Public Sub SolOutAlt(aEnabled) : If aEnabled Then KickOut True  : End If : End Sub
	Public Sub EntrySol_On   : KickIn        : End Sub
	Public Sub ExitSol_On    : KickOut False : End Sub
	Public Sub ExitAltSol_On : KickOut True  : End Sub

	Private Sub KickIn
		If mBallIn Then PlaySound mEntrySndBall Else PlaySound mEntrySnd : Exit Sub
		mBalls = mBalls + 1 : mBallIn = mBallIn - 1 : mBallPos(mBalls) = con8StackSw + 1 : NeedUpdate = True
		If mEntrySw And mBallIn = 0 Then Controller.Switch(mEntrySw) = False
	End Sub

	Private Sub KickOut(aAltSol)
		Dim ii,jj, kForce, kDir, kBaseDir
		If mBalls Then PlaySound mExitSndBall Else PlaySound mExitSnd : Exit Sub
		If aAltSol Then kForce = mExitForce2 : kBaseDir = mExitDir2 Else kForce = mExitForce : kBaseDir = mExitDir
		kForce = kForce + (Rnd - 0.5)*KickForceVar
		If mSaucer Then
			SetSw 1, False : mBalls = 0 : kDir = kBaseDir + (Rnd - 0.5)*KickAngleVar
			If isObject(mInitKicker) Then
				vpmCreateBall mExitKicker : mInitKicker.Destroyball : mInitKicker.Enabled = True
			Else
				mExitKicker.Enabled = True
			End If
			mExitKicker.Kick kDir, kForce, KickZ
		Else
			For ii = 1 To kickballs
				If mBalls = 0 Or mBallPos(1) <> ii Then Exit For ' No more balls
				For jj = 2 To mBalls ' Move balls in array
					mBallPos(jj-1) = mBallPos(jj)
				Next
				mBallPos(mBalls) = 0 : mBalls = mBalls - 1 : NeedUpdate = True
				SetSw ii, False
				If isObject(mExitKicker) Then
					If kForce < 1 Then kForce = 1
					kDir = kBaseDir + (Rnd - 0.5)*KickAngleVar
					vpmTimer.AddTimer 200*(ii-1), "vpmCreateBall(" & mExitKicker.Name & ").Kick " &_
					  CInt(kDir) & "," & Replace(kForce,",",".") & "," & Replace(KickZ,",",".") & " '"
				End If
				kForce = kForce * 0.8
			Next
		End If
	End Sub

	Public Sub InitSaucer(aKicker, aSw, aDir, aPower)
		InitKick aKicker, aDir, aPower : mSaucer = True
		If aSw Then mSw(1) = aSw Else mSw(1) = aKicker.TimerInterval
	End Sub

	Public Sub InitNoTrough(aKicker, aSw, aDir, aPower)
		InitKick aKicker, aDir, aPower : Balls = 1
		If aSw Then mSw(1) = aSw Else mSw(1) = aKicker.TimerInterval
		If Not IsObject(vpmTrough) Then Set vpmTrough = Me
	End Sub

	Public Sub InitSw(aEntry, aSw1, aSw2, aSw3, aSw4, aSw5, aSw6, aSw7, aSw8)
		mEntrySw = aEntry : mSw(1) = aSw1 : mSw(2) = aSw2 : mSw(3) = aSw3 : mSw(4) = aSw4
		mSw(5) = aSw5 : mSw(6) = aSw6 : mSw(7) = aSw7: mSw(8) =aSw8
		If Not IsObject(vpmTrough) Then Set vpmTrough = Me
	End Sub

	Public Sub InitKick(aKicker, aDir, aForce)
		Set mExitKicker = aKicker : mExitDir = aDir : mExitForce = aForce
	End Sub

	Public Sub CreateEvents(aName, aKicker)
		Dim obj, tmp
		If Not vpmCheckEvent(aName, Me) Then Exit Sub
		vpmSetArray tmp, aKicker
		For Each obj In tmp
			If isObject(obj) Then
				vpmBuildEvent obj, "Hit", aName & ".AddBall Me"
			Else
				vpmBuildEvent mExitKicker, "Hit", aName & ".AddBall Me"
			End If
		Next
	End Sub

	Public Property Let IsTrough(aIsTrough)
		If aIsTrough Then
			Set vpmTrough = Me
		ElseIf IsObject(vpmTrough) Then
			If vpmTrough Is Me Then vpmTrough = 0
		End If
	End Property

	Public Property Get IsTrough : IsTrough = vpmTrough Is Me : End Property

	Public Sub InitAltKick(aDir, aForce)
		mExitDir2 = aDir : mExitForce2 = aForce
	End Sub

	Public Sub InitEntrySnd(aBall, aNoBall) : mEntrySndBall = aBall : mEntrySnd = aNoBall : End Sub
	Public Sub InitExitSnd(aBall, aNoBall)  : mExitSndBall = aBall  : mExitSnd = aNoBall  : End Sub
	Public Sub InitAddSnd(aSnd) : mAddSnd = aSnd : End Sub

	Public Property Let Balls(aBalls)
		Dim ii
		For ii = 1 To con8StackSw
			SetSw ii, False : mBallPos(ii) = con8StackSw + 1
		Next
		If mSaucer And aBalls > 0 And mBalls = 0 Then vpmCreateBall mExitKicker
		mBalls = aBalls : NeedUpdate = True
	End Property

	Public Default Property Get Balls : Balls = mBalls         : End Property
	Public Property Get BallsPending  : BallsPending = mBallIn : End Property

	' Obsolete stuff
	Public Sub SolEntry(aSnd1, aSnd2, aEnabled)
		If aEnabled Then mEntrySndBall = aSnd1 : mEntrySnd = aSnd2 : KickIn
	End Sub
	Public Sub SolExit(aSnd1, aSnd2, aEnabled)
		If aEnabled Then mExitSndBall = aSnd1 : mExitSnd = aSnd2 : KickOut False
	End Sub
	Public Sub InitProxy(aProxyPos, aSwNo) : End Sub
	Public TempBallColour, TempBallImage, BallColour
	Public Property Let BallImage(aImage) : vpmBallImage = aImage : End Property

End Class


'*********************************************************************
'                 Positional Sound Playback Functions
'*********************************************************************

' Play a sound, depending on the X,Y position of the table element (especially cool for surround speaker setups, otherwise stereo panning only)
' parameters (defaults): loopcount (1), volume (1), randompitch (0), pitch (0), useexisting (0), restart (1))
' Note that this will not work (currently) for walls/slingshots as these do not feature a simple, single X,Y position
Sub PlayXYSound(soundname, tableobj, loopcount, volume, randompitch, pitch, useexisting, restart)
	PlaySound soundname, loopcount, volume, AudioPan(tableobj), randompitch, pitch, useexisting, restart, AudioFade(tableobj)
End Sub

' Similar subroutines that are less complicated to use (e.g. simply use standard parameters for the PlaySound call)
Sub PlaySoundAt(soundname, tableobj)
    PlaySound soundname, 1, 1, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub

Sub PlaySoundAtBall(soundname)
    PlaySoundAt soundname, ActiveBall
End Sub


'*********************************************************************
'                     Supporting Ball & Sound Functions
'*********************************************************************

Function AudioFade(tableobj) ' Fades between front and back of the table (for surround systems or 2x2 speakers, etc), depending on the Y position on the table. "table1" is the name of the table
	Dim tmp
    tmp = tableobj.y * 2 / table.height-1
    If tmp > 0 Then
		AudioFade = Csng(tmp ^10)
    Else
        AudioFade = Csng(-((- tmp) ^10) )
    End If
End Function

Function AudioPan(tableobj) ' Calculates the pan for a tableobj based on the X position on the table. "table1" is the name of the table
    Dim tmp
    tmp = tableobj.x * 2 / table.width-1
    If tmp > 0 Then
        AudioPan = Csng(tmp ^10)
    Else
        AudioPan = Csng(-((- tmp) ^10) )
    End If
End Function

Function Vol(ball) ' Calculates the Volume of the sound based on the ball speed
    Vol = Csng(BallVel(ball) ^2 / 5000)
End Function

Function Pitch(ball) ' Calculates the pitch of the sound based on the ball speed
    Pitch = BallVel(ball) * 20
End Function

Function BallVel(ball) 'Calculates the ball speed
    BallVel = INT(SQR((ball.VelX ^2) + (ball.VelY ^2) ) )
End Function

'*****************************************
'      JP's VP10 Rolling Sounds
'*****************************************

Const tnob = 14 ' total number of balls
ReDim rolling(tnob)
InitRolling

Sub InitRolling
    Dim i
    For i = 0 to tnob
        rolling(i) = False
    Next
End Sub

Sub RollingTimer_Timer()
    Dim BOT, b
    BOT = GetBalls

	' stop the sound of deleted balls
    For b = UBound(BOT) + 1 to tnob
        rolling(b) = False
        StopSound("fx_ballrolling" & b)
    Next

	' exit the sub if no balls on the table
    If UBound(BOT) = -1 Then Exit Sub

	' play the rolling sound for each ball

    For b = 0 to UBound(BOT)
      If BallVel(BOT(b) ) > 1 Then
        rolling(b) = True
        if BOT(b).z < 30 Then ' Ball on playfield
          PlaySound("fx_ballrolling" & b), -1, Vol(BOT(b) ), AudioPan(BOT(b) ), 0, Pitch(BOT(b) ), 1, 0, AudioFade(BOT(b) )
        Else ' Ball on raised ramp
          PlaySound("fx_ballrolling" & b), -1, Vol(BOT(b) )*.5, AudioPan(BOT(b) ), 0, Pitch(BOT(b) )+50000, 1, 0, AudioFade(BOT(b) )
        End If
      Else
        If rolling(b) = True Then
          StopSound("fx_ballrolling" & b)
          rolling(b) = False
        End If
      End If
 ' play ball drop sounds
        If BOT(b).VelZ < -1 and BOT(b).z < 55 and BOT(b).z > 27 Then 'height adjust for ball drop sounds
            PlaySound "fx_ball_drop" & b, 0, ABS(BOT(b).velz)/17, AudioPan(BOT(b)), 0, Pitch(BOT(b)), 1, 0, AudioFade(BOT(b))
        End If
    Next
End Sub

'**********************
' Ball Collision Sound
'**********************

Sub OnBallBallCollision(ball1, ball2, velocity)
	PlaySound("fx_collide"), 0, Csng(velocity) ^2 / 2000, AudioPan(ball1), 0, Pitch(ball1), 0, 0, AudioFade(ball1)
End Sub

'General Sound Handler



Sub LeftFlipper_Collide(parm)
    PlaySound "fx_rubber_flipper", 0, parm / (15*Rnd), -0.05, 0.15
End Sub

Sub RightFlipper_Collide(parm)
    PlaySound "fx_rubber_flipper", 0, parm / (15*Rnd), 0.05, 0.15
End Sub

Sub Rubbers_Hit(idx)
	PlaySound "fx_rubber2", 0, (20 + Vol(ActiveBall)), (20+ AudioPan(ActiveBall)), Pitch(ActiveBall), 1, 1

End Sub




Sub Pins_Hit (idx)
	PlaySound "metalhit_medium", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1
    'Test1.State=1:
End Sub

Sub Primitive_Hit (idx)
	PlaySound "metalhit_medium", 0, (8 +Vol(ActiveBall)),  AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1
'    Test1.State=1:
End Sub


Sub Metals_Thin_Hit (idx)
	PlaySound "metalhit_thin", 0, (8 +Vol(ActiveBall)), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1
End Sub

Sub Metals_Medium_Hit (idx)
	PlaySound "metalhit_medium", 0, (8 +Vol(ActiveBall)), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1
End Sub

Sub Metals2_Hit (idx)
	PlaySound "metalhit2", 0, (8 +Vol(ActiveBall)), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1
End Sub

Sub Gates_Hit (idx)
	PlaySound "gate", 0, (8 +Vol(ActiveBall)), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1
End Sub


Sub Posts_Hit(idx)
		PlaySound "fx_postrubber", 0, (8 +Vol(ActiveBall)), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1
End Sub


Sub Plastik_Hit(idx)
		PlaySound "rubber_hit_2", 0, (8 +Vol(ActiveBall)), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 1
End Sub



'******  Hanibal's Special Flashers


Sub Hanflasher (nr, a, object)

DIM Helfer
    IF a.state = 0 Then 
	Helfer = 0
    Else
    Helfer = 1
    End If

    Select Case Helfer
        Case 0 'off
            FlashLevel(nr) = FlashLevel(nr) - (50)
            If FlashLevel(nr) < 0 Then
                FlashLevel(nr) = 0
                FlashState(nr) = -1 'completely off
            End if
            Object.opacity = FlashLevel(nr)
            Object.amount = FlashLevel(nr)/10
        Case 1 ' on
            FlashLevel(nr) = FlashLevel(nr) + (200)
            If FlashLevel(nr) > 1000 Then
                FlashLevel(nr) = 1000
                FlashState(nr) = -2 'completely on
            End if
            Object.opacity = FlashLevel(nr)
            Object.amount = FlashLevel(nr)/10
    End Select
End Sub


Sub HanLEDflasher(nr, a, object)
DIM Helfer
    IF a.state = 0 Then 
	Helfer = 0
    Else
    Helfer = 1
    End If

    Select Case Helfer
        Case 0 'off
            FlashLevel(nr) = FlashLevel(nr) - (20)
            If FlashLevel(nr) < 0 Then
                FlashLevel(nr) = 0
                FlashState(nr) = -1 'completely off
            End if
            Object.opacity = FlashLevel(nr)
            Object.amount = FlashLevel(nr)/10
        Case 1 ' on
            FlashLevel(nr) = FlashLevel(nr) + (200/4)
            If FlashLevel(nr) > 600 Then
                FlashLevel(nr) = 600
                FlashState(nr) = -2 'completely on
            End if
            Object.opacity = FlashLevel(nr)
            Object.amount = FlashLevel(nr)/10
    End Select
End Sub

'*********** BALL SHADOW *********************************
Dim BallShadow:BallShadow = Array (BallShadow1, BallShadow2, BallShadow3,Ballshadow4,Ballshadow5,Ballshadow6,Ballshadow7,Ballshadow8,Ballshadow9,Ballshadow10,Ballshadow11,Ballshadow12,Ballshadow13,Ballshadow14)

Sub BallShadowUpdate()
    Dim BOT, b
    BOT = GetBalls
    ' hide shadow of deleted balls
    If UBound(BOT)<(tnob-1) Then
        For b = (UBound(BOT) + 1) to (tnob-1)
            BallShadow(b).visible = 0
        Next
    End If
    ' exit the Sub if no balls on the table
    If UBound(BOT) = -1 Then Exit Sub
    ' render the shadow for each ball
    For b = 0 to UBound(BOT)
		BallShadow(b).X = BOT(b).X
		ballShadow(b).Y = BOT(b).Y + 10                       
        If BOT(b).Z > 20 and BOT(b).Z < 200 Then
            BallShadow(b).visible = 1
        Else
            BallShadow(b).visible = 0
        End If
if BOT(b).z > 30 Then 
ballShadow(b).height = BOT(b).Z - 19
ballShadow(b).opacity = 110
Else
ballShadow(b).height = BOT(b).Z - 23
ballShadow(b).opacity = 90
End If
    Next	
End Sub
