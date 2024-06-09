Option Explicit
Randomize

On Error Resume Next
ExecuteGlobal GetTextFile("controller.vbs")
If Err Then MsgBox "You need the controller.vbs in order to run this table, available in the vp10 package"
On Error Goto 0

Const cGameName="eatpm_l4",UseSolenoids=2,UseLamps=0,UseGI=0,SSolenoidOn="SolOn",SSolenoidOff="SolOff", SCoin="coin"

'********* FlexDMD *************************************
Dim UseFlexDMD:UseFlexDMD = 1		' 1 = on, 0 = off 
' ** for flex dmd cGameName needs to be eatpm_l4 rom **  
'  	(as nvram data is used and mapped for that rom)
'
' Flex DMD colours controlled by vpinmame colorise options (F1);
'	100% - Large score text
'	 66% - Segment display representation (bottom LineChars)
'    33% - Player number / info text
'	  0% - Background colour
' Check 'Colorize' in vpinmame options to enable custom colours.
'********************************************************

LoadVPM "01560000", "S11.VBS", 3.26
Dim DesktopMode: DesktopMode = Table1.ShowDT

If DesktopMode = True Then 'Show Desktop components
Ramp16.visible=1
Ramp15.visible=1
Primitive13.visible=1
Else
Ramp16.visible=0
Ramp15.visible=0
Primitive13.visible=0
End if


'*************************************************************
'Solenoid Call backs
'**********************************************************************************************************
 
 SolCallback(1) = "bsTrough.SolIn"
 SolCallback(2) = "bsTrough.SolOut"
 SolCallback(3) = "dtbank.SolDropUp"
 SolCallback(5) = "bsTP.SolOut"
 SolCallback(6) = "SolPopper"
 SolCallback(7) = "vpmSolSound SoundFX(""Knocker"",DOFKnocker),"
 SolCallback(8) = "bsLock.SolOut"
 SolCallback(11) = "SolGI"
 SolCallback(14) = "SolBoogie"
 SolCallback(22) = "SolFlipReset"
 'SolCallback(23) = "SolRun"

 
 'Flashers
 SolCallback(13) = "vpmflasher f13,"
 SolCallback(15) = "vpmflasher f15,"
 SolCallback(16) = "vpmflasher array(f16,f16a,f16b),"
 SolCallback(25) = "vpmflasher f25," '01C
 SolCallback(26) = "vpmflasher f26," '02C
 SolCallback(27) = "vpmflasher f27," '03C
 SolCallback(28) = "vpmflasher f28," '04C
 SolCallback(29) = "vpmflasher f29," '05C
 SolCallback(30) = "vpmflasher f30," '06C
 SolCallback(31) = "vpmflasher f31," '07C
 SolCallback(32) = "vpmflasher f32," '08C
 
SolCallback(sLRFlipper) = "SolRFlipper"
SolCallback(sLLFlipper) = "SolLFlipper"

Sub SolLFlipper(Enabled)
     If Enabled Then
         PlaySound SoundFX("fx_Flipperup",DOFContactors):LeftFlipper.RotateToEnd
     Else
         PlaySound SoundFX("fx_Flipperdown",DOFContactors):LeftFlipper.RotateToStart
     End If
  End Sub
  
Sub SolRFlipper(Enabled)
     If Enabled Then
         PlaySound SoundFX("fx_Flipperup",DOFContactors):RightFlipper.RotateToEnd
     Else
         PlaySound SoundFX("fx_Flipperdown",DOFContactors):RightFlipper.RotateToStart
     End If
End Sub

'**********************************************************************************************************

'Solenoid Controlled toys
'**********************************************************************************************************

 Sub SolBoogie(Enabled)
     If Enabled then
		playsound SoundFX("solenoid",DOFContactors)
		boogie1.transy = -20
		boogie2.transy = 20

     else
		playsound SoundFX("solenoid",DOFContactors)
		boogie1.transy = 0
		boogie2.transy = 0

     End If
 End Sub

 Sub SolGI(Enabled)
	If Enabled Then
		dim xx
		For each xx in GI:xx.State = 0: Next
        PlaySound "fx_relay"
Table1.colorgradeimage = "colorgrade_3"
	Else
		For each xx in GI:xx.State = 1: Next
        PlaySound "fx_relay"
Table1.colorgradeimage = "ColorGradeLUT256x16_extraConSat"
	End If
End Sub


Dim popperBall, popperZpos
 Sub SolPopper(Enabled)
     If Enabled Then
         If bsBP.Balls Then
             Set popperBall = sw32a.Createball
             popperBall.Z = 0
             popperZpos = 0
             sw32a.TimerInterval = 2
             sw32a.TimerEnabled = 1
         End If
     End If
 End Sub
 
 Sub sw32a_Timer
     popperBall.Z = popperZpos
     popperZpos = popperZpos + 10
     If popperZpos> 150 Then
         sw32a.TimerEnabled = 0
         sw32a.DestroyBall
         bsBP.ExitSol_On
     End If
 End Sub
 

 Sub SolFlipReset(Enabled)
     If Enabled Then
		Coffin_1.z = 90
		Coffin_2.z = 90
		Coffin_Elvira.z = 20
		Coffin_Drac.z = 20
        Controller.Switch(53) = 0
        Controller.Switch(54) = 0
		playsound SoundFX("DTReset",DOFContactors)
     End If
 End Sub
 

'**********************************************************************************************************

'Initiate Table
'**********************************************************************************************************
 
 Dim bsTrough, bsLock, bsTP, bsBP, dtBank, BallInVuk

Sub Table1_Init

	FlexDMD_Init

	vpmInit Me

	On Error Resume Next
		With Controller
		.GameName = cGameName
		If Err Then MsgBox "Can't start Game" & cGameName & vbNewLine & Err.Description : Exit Sub
		.SplashInfoLine = "Elvira and the Party Monsters"&chr(13)&"You Suck"
	         .HandleKeyboard = 0
         .ShowTitle = 0
         .ShowDMDOnly = 1
         .ShowFrame = 0
         .HandleMechanics = 0
         .Hidden = 1
         On Error Resume Next
         .Run GetPlayerHWnd
         If Err Then MsgBox Err.Description
		If UseFlexDMD Then ExternalEnabled = Controller.Games(cGameName).Settings.Value("showpindmd")
		If UseFlexDMD Then Controller.Games(cGameName).Settings.Value("showpindmd") = 0
         On Error Goto 0
     End With
 
    PinMAMETimer.Interval=PinMAMEInterval
    PinMAMETimer.Enabled=1

	If UseFlexDMD Then NvRam_Init
		
    vpmNudge.TiltSwitch=swTilt
    vpmNudge.Sensitivity=3
    vpmNudge.TiltObj=Array(Bumper1, Bumper2, Bumper3, LeftSlingshot, RightSlingshot)
 
    Set bsTrough=New cvpmBallStack
     bsTrough.InitSw 9, 11, 12, 13, 0, 0, 0, 0
     bsTrough.InitKick BallRelease, 80, 12
     bsTrough.InitExitSnd SoundFX("ballrelease",DOFContactors), SoundFX("Solenoid",DOFContactors)
     bsTrough.Balls=3
 
	Set bsLock = new cvpmBallStack
	 bsLock.InitSw 0,49,50,51,0,0,0,0
	 bsLock.InitKick BallLock,70,28
	 bsLock.InitExitSnd SoundFX("Popper",DOFContactors), SoundFX("Solenoid",DOFContactors)
	 bsLock.CreateEvents "bsLock", BallLock

    Set bsTP=New cvpmBallStack
     bsTP.InitSaucer sw48, 48, 24, 24
     bsTP.InitExitSnd SoundFX("Popper",DOFContactors), SoundFX("Solenoid",DOFContactors)
     bsTP.KickAngleVar=3
     bsTP.KickForceVar=4

    Set bsBP = New cvpmBallStack
     bsBP.InitSaucer sw32, 32, 0, 0
     bsBP.InitKick sw32a, 190, 16
     bsBP.InitExitSnd SoundFX("Popper",DOFContactors), SoundFX("Solenoid",DOFContactors)
 
    Set dtbank=new cvpmdroptarget
     dtbank.InitDrop Array(sw41, sw42, sw43), array(41, 42, 43)
     dtbank.InitSnd SoundFX("DTDrop",DOFContactors),SoundFX("DTReset",DOFContactors)

 End Sub
 
 '**********************************************************************************************************
'Plunger code
'**********************************************************************************************************

Sub Table1_KeyDown(ByVal KeyCode)
	If KeyDownHandler(keycode) Then Exit Sub
	If keycode = PlungerKey Then Plunger.Pullback:playsound"plungerpull"
    If keycode=RightFlipperKey Then Controller.Switch(57)=1
    If keycode=LeftFlipperKey Then Controller.Switch(58)=1
End Sub

Sub Table1_KeyUp(ByVal KeyCode)
	If KeyUpHandler(keycode) Then Exit Sub
	If keycode = PlungerKey Then Plunger.Fire:PlaySound"plunger"
    If keycode=RightFlipperKey Then Controller.Switch(57)=0
    If keycode=LeftFlipperKey Then Controller.Switch(58)=0
End Sub

'**********************************************************************************************************

 ' Drain hole
Sub Drain_Hit:bsTrough.addball me : playsound "drain" : End Sub
Sub sw48_Hit:bsTP.AddBall Me : playsound "popper_ball": End Sub
Sub BallLock_Hit:bsLock.AddBall Me : playsound "popper_ball": End Sub
Sub sw32_Hit():bsBP.AddBall Me : playsound "popper_ball": End Sub
 'Bumpers
Sub Bumper1_Hit : vpmTimer.PulseSw 35 : BCap1.z = -15 : playsound SoundFX("fx_bumper1",DOFContactors): vpmtimer.AddTimer 200, "BCap1.z = 0'" :End Sub
Sub Bumper2_Hit : vpmTimer.PulseSw 36 : BCap2.z = -15 : playsound SoundFX("fx_bumper1",DOFContactors): vpmtimer.AddTimer 200, "BCap2.z = 0'" :End Sub
Sub Bumper3_Hit : vpmTimer.PulseSw 37 : BCap3.z = -15 : playsound SoundFX("fx_bumper1",DOFContactors): vpmtimer.AddTimer 200, "BCap3.z = 0'" :End Sub
 'Wire Triggers
 Sub sw17_Hit : Controller.Switch(17)=1 : playsound"rollover": End Sub
 Sub sw17_UnHit: Controller.Switch(17)=0 : End Sub
 Sub sw18_Hit : Controller.Switch(18)=1 : playsound"rollover": End Sub
 Sub sw18_UnHit : Controller.Switch(18)=0 : End Sub
 Sub sw19_Hit : Controller.Switch(19)=1 : playsound"rollover": End Sub
 Sub sw19_UnHit : Controller.Switch(19)=0 : End Sub
 Sub sw20_Hit : Controller.Switch(20)=1 : playsound"rollover": End Sub
 Sub sw20_UnHit : Controller.Switch(20)=0 : End Sub
 Sub sw21_Hit : Controller.Switch(21)=1 : playsound"rollover": End Sub
 Sub sw21_UnHit : Controller.Switch(21)=0 : End Sub
 Sub sw22_Hit : Controller.Switch(22)=1 : playsound"rollover": End Sub
 Sub sw22_UnHit : Controller.Switch(22)=0 : End Sub
 Sub sw23_Hit : Controller.Switch(23)=1 : playsound"rollover": End Sub
 Sub sw23_UnHit : Controller.Switch(23)=0 : End Sub
 Sub sw29_Hit : Controller.Switch(29)=1 : playsound"rollover": End Sub
 Sub sw29_UnHit : Controller.Switch(29)=0 : End Sub
 Sub sw45_Hit : Controller.Switch(45)=1 : playsound"rollover": End Sub
 Sub sw45_UnHit : Controller.Switch(45)=0 : End Sub
 Sub sw46_Hit : Controller.Switch(46)=1 : playsound"rollover": End Sub
 Sub sw46_UnHit : Controller.Switch(46)=0 : End Sub
 Sub sw47_Hit : Controller.Switch(47)=1 : playsound"rollover": End Sub
 Sub sw47_UnHit : Controller.Switch(47)=0 : End Sub

'Gate Trigger
 Sub sw30_Hit : vpmTimer.PulseSw 30 : End Sub
 Sub sw31_Hit : vpmTimer.PulseSw 31 : End Sub
 Sub sw44_Hit : vpmTimer.PulseSw 44 : End Sub
 Sub sw52_Hit : vpmTimer.PulseSw 52 : End Sub

 'Stand Up Targets
 Sub sw15_Hit : vpmTimer.PulseSw 15 : End Sub
 Sub sw16_Hit : vpmTimer.PulseSw 16 : End Sub

 Sub sw25_Hit : vpmTimer.PulseSw 25 : End Sub
 Sub sw26_Hit : vpmTimer.PulseSw 26 : End Sub
 Sub sw27_Hit : vpmTimer.PulseSw 27 : End Sub
 Sub sw28_Hit : vpmTimer.PulseSw 28 : End Sub

 'Droptargets
 Sub sw41_Dropped : dtbank.Hit 1 : End Sub
 Sub sw42_Dropped : dtbank.Hit 2 : End Sub
 Sub sw43_Dropped : dtbank.Hit 3 : End Sub
 
'Coffin Targets
 Sub sw53_Hit() : Controller.Switch(53) = 1
     vpmTimer.PulseSw 55 : 
	 Coffin_1.z = 20 : 
	 Coffin_Elvira.z = 90 :
	 playsound SoundFX("DTDrop",DOFContactors) 
 End Sub
 
 Sub sw54_Hit() : Controller.Switch(54) = 1
     vpmTimer.PulseSw 56 :
 	 Coffin_2.z = 20 : 
	 Coffin_Drac.z = 90 :
	 playsound SoundFX("DTDrop",DOFContactors) 
 End Sub

'Generic Ramp Sounds
 Sub LeftDrop_Hit:PlaySound "fx_ballrampdrop":End Sub
 'Sub Trigger2_Hit:PlaySound "Wire Ramp":End Sub
 Sub Trigger3_Hit:PlaySound "fx_ballrampdrop":End Sub
' Sub Trigger4_Hit:PlaySound "fx_ballrampdrop":End Sub
 'Sub Trigger5_Hit:PlaySound "Wire Ramp":End Sub
 Sub RightDrop_Hit:PlaySound "fx_ballrampdrop":End Sub

'***************************************************
'       JP's VP10 Fading Lamps & Flashers
'       Based on PD's Fading Light System
' SetLamp 0 is Off
' SetLamp 1 is On
' fading for non opacity objects is 4 steps
'***************************************************

Dim LampState(200), FadingLevel(200)
Dim FlashSpeedUp(200), FlashSpeedDown(200), FlashMin(200), FlashMax(200), FlashLevel(200)

InitLamps()             ' turn off the lights and flashers and reset them to the default parameters
LampTimer.Interval = 5 'lamp fading speed
LampTimer.Enabled = 1

' Lamp & Flasher Timers

Sub LampTimer_Timer()
    Dim chgLamp, num, chg, ii
    chgLamp = Controller.ChangedLamps
    If Not IsEmpty(chgLamp) Then
        For ii = 0 To UBound(chgLamp)
            LampState(chgLamp(ii, 0) ) = chgLamp(ii, 1)       'keep the real state in an array
            FadingLevel(chgLamp(ii, 0) ) = chgLamp(ii, 1) + 4 'actual fading step
        Next
    End If
    UpdateLamps
End Sub
 
  Sub UpdateLamps
      NFadeL 1, l1
      NFadeL 2, l2
      NFadeL 3, l3
      NFadeL 4, l4
      NFadeL 5, l5
      NFadeL 6, l6
      NFadeL 7, l7
      NFadeL 8, l8
      NFadeL 9, l9
      NFadeL 10, l10
      NFadeLm 11, l11a  'Left Sling GI
      NFadeLm 11, l11b  'Left Sling GI
      NFadeLm 11, l11c  'Left Sling GI
      NFadeL 11, l11
      NFadeL 12, l12
      NFadeL 13, l13
      NFadeL 14, l14
      NFadeL 15, l15
      NFadeL 16, l16
'      Flash 17, fl17
      FadeDisableLighting 17, l17, 5 ' SKull LEDS 
'      Flash 18, fl18
      FadeDisableLighting 18, l18, 5 ' SKull LEDS      
      NFadeL 19, l19
      NFadeLm 20, l20a 'Right Sling GI
      NFadeLm 20, l20b 'Right Sling GI
      NFadeLm 20, l20c 'Right Sling GI
      NFadeL 20, l20
      NFadeLm 21, l21a
      NFadeL 21, l21
      NFadeLm 22, l22a
      NFadeL 22, l22
      NFadeLm 23, l23a
      NFadeL 23, l23
      NFadeLm 24, l24a
      NFadeL 24, l24
'      Flash 25, fl25
      FadeDisableLighting 25, l25, 10 'Ramp Entrance RED LED      
      NFadeL 26, l26
      NFadeL 27, l27
      NFadeL 28, l28
      NFadeL 29, l29
      NFadeL 30, l30
      NFadeL 31, l31
      NFadeL 32, l32
      NFadeL 33, l33
      NFadeL 34, l34
      NFadeL 35, l35
      NFadeL 36, l36
      NFadeL 37, l37
      NFadeL 38, l38
      NFadeL 39, l39
      NFadeL 40, l40
      NFadeL 41, l41
      NFadeL 42, l42
      NFadeL 43, l43
      NFadeL 44, l44
      NFadeL 45, l45
      NFadeL 46, l46
      NFadeL 47, l47
      NFadeL 48, l48
      NFadeL 49, l49
      NFadeL 50, l50
      NFadeL 51, l51
      NFadeL 52, l52
      NFadeL 53, l53
      NFadeLm 54, l54a 'Bumper  
      NFadeLm 54, l54
FadeDisableLighting 54, BCap1, 0.1
      NFadeLm 55, l55a 'Bumper  
      NFadeLm 55, l55
FadeDisableLighting 55, BCap2, 0.1
      NFadeLm 56, l56a 'Bumper  
      NFadeLm 56, l56
FadeDisableLighting 56, BCap3, 0.1
      Flash 57, f57 'BackWall
      Flash 58, f58 'BackWall
      Flash 59, f59 'BackWall
      Flash 60, l60 'BackGlass
      Flash 61, l61 'BackGlass
      Flash 62, l62 'BackGlass
      Flash 63, l63 'BackGlass
      Flash 64, l64 'BackGlass
  End Sub

' div lamp subs

Sub InitLamps()
    Dim x
    For x = 0 to 200
        LampState(x) = 0        ' current light state, independent of the fading level. 0 is off and 1 is on
        FadingLevel(x) = 4      ' used to track the fading state
        FlashSpeedUp(x) = 0.4   ' faster speed when turning on the flasher
        FlashSpeedDown(x) = 0.2 ' slower speed when turning off the flasher
        FlashMax(x) = 1         ' the maximum value when on, usually 1
        FlashMin(x) = 0         ' the minimum value when off, usually 0
        FlashLevel(x) = 0       ' the intensity of the flashers, usually from 0 to 1
    Next
End Sub

Sub AllLampsOff
    Dim x
    For x = 0 to 200
        SetLamp x, 0
    Next
End Sub

Sub SetLamp(nr, value)
    If value <> LampState(nr) Then
        LampState(nr) = abs(value)
        FadingLevel(nr) = abs(value) + 4
    End If
End Sub

' Lights: used for VP10 standard lights, the fading is handled by VP itself

Sub NFadeL(nr, object)
    Select Case FadingLevel(nr)
        Case 4:object.state = 0:FadingLevel(nr) = 0
        Case 5:object.state = 1:FadingLevel(nr) = 1
    End Select
End Sub

Sub NFadeLm(nr, object) ' used for multiple lights
    Select Case FadingLevel(nr)
        Case 4:object.state = 0
        Case 5:object.state = 1
    End Select
End Sub

'Lights, Ramps & Primitives used as 4 step fading lights
'a,b,c,d are the images used from on to off

Sub FadeObj(nr, object, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 4:object.image = b:FadingLevel(nr) = 6                   'fading to off...
        Case 5:object.image = a:FadingLevel(nr) = 1                   'ON
        Case 6, 7, 8:FadingLevel(nr) = FadingLevel(nr) + 1             'wait
        Case 9:object.image = c:FadingLevel(nr) = FadingLevel(nr) + 1 'fading...
        Case 10, 11, 12:FadingLevel(nr) = FadingLevel(nr) + 1         'wait
        Case 13:object.image = d:FadingLevel(nr) = 0                  'Off
    End Select
End Sub

Sub FadeObjm(nr, object, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 4:object.image = b
        Case 5:object.image = a
        Case 9:object.image = c
        Case 13:object.image = d
    End Select
End Sub

Sub NFadeObj(nr, object, a, b)
    Select Case FadingLevel(nr)
        Case 4:object.image = b:FadingLevel(nr) = 0 'off
        Case 5:object.image = a:FadingLevel(nr) = 1 'on
    End Select
End Sub

Sub NFadeObjm(nr, object, a, b)
    Select Case FadingLevel(nr)
        Case 4:object.image = b
        Case 5:object.image = a
    End Select
End Sub

' Flasher objects

Sub Flash(nr, object)
    Select Case FadingLevel(nr)
        Case 4 'off
            FlashLevel(nr) = FlashLevel(nr) - FlashSpeedDown(nr)
            If FlashLevel(nr) < FlashMin(nr) Then
                FlashLevel(nr) = FlashMin(nr)
                FadingLevel(nr) = 0 'completely off
            End if
            Object.IntensityScale = FlashLevel(nr)
        Case 5 ' on
            FlashLevel(nr) = FlashLevel(nr) + FlashSpeedUp(nr)
            If FlashLevel(nr) > FlashMax(nr) Then
                FlashLevel(nr) = FlashMax(nr)
                FadingLevel(nr) = 1 'completely on
            End if
            Object.IntensityScale = FlashLevel(nr)
    End Select
End Sub

Sub Flashm(nr, object) 'multiple flashers, it just sets the flashlevel
    Object.IntensityScale = FlashLevel(nr)
End Sub

Sub FadeDisableLighting(nr, a, alvl)
	Select Case FadingLevel(nr)
		Case 4
			a.UserValue = a.UserValue - 0.1
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

'**********************************************************************************************************
'Digital Display
'**********************************************************************************************************
 Dim Digits(32)
 Digits(0)=Array(a00, a05, a0c, a0d, a08, a01, a06, a0f, a02, a03, a04, a07, a0b, a0a, a09, a0e)
 Digits(1)=Array(a10, a15, a1c, a1d, a18, a11, a16, a1f, a12, a13, a14, a17, a1b, a1a, a19, a1e)
 Digits(2)=Array(a20, a25, a2c, a2d, a28, a21, a26, a2f, a22, a23, a24, a27, a2b, a2a, a29, a2e)
 Digits(3)=Array(a30, a35, a3c, a3d, a38, a31, a36, a3f, a32, a33, a34, a37, a3b, a3a, a39, a3e)
 Digits(4)=Array(a40, a45, a4c, a4d, a48, a41, a46, a4f, a42, a43, a44, a47, a4b, a4a, a49, a4e)
 Digits(5)=Array(a50, a55, a5c, a5d, a58, a51, a56, a5f, a52, a53, a54, a57, a5b, a5a, a59, a5e)
 Digits(6)=Array(a60, a65, a6c, a6d, a68, a61, a66, a6f, a62, a63, a64, a67, a6b, a6a, a69, a6e)
 Digits(7)=Array(a70, a75, a7c, a7d, a78, a71, a76, a7f, a72, a73, a74, a77, a7b, a7a, a79, a7e)
 Digits(8)=Array(a80, a85, a8c, a8d, a88, a81, a86, a8f, a82, a83, a84, a87, a8b, a8a, a89, a8e)
 Digits(9)=Array(a90, a95, a9c, a9d, a98, a91, a96, a9f, a92, a93, a94, a97, a9b, a9a, a99, a9e)
 Digits(10)=Array(aa0, aa5, aac, aad, aa8, aa1, aa6, aaf, aa2, aa3, aa4, aa7, aab, aaa, aa9, aae)
 Digits(11)=Array(ab0, ab5, abc, abd, ab8, ab1, ab6, abf, ab2, ab3, ab4, ab7, abb, aba, ab9, abe)
 Digits(12)=Array(ac0, ac5, acc, acd, ac8, ac1, ac6, acf, ac2, ac3, ac4, ac7, acb, aca, ac9, ace)
 Digits(13)=Array(ad0, ad5, adc, add, ad8, ad1, ad6, adf, ad2, ad3, ad4, ad7, adb, ada, ad9, ade)
 Digits(14)=Array(ae0, ae5, aec, aed, ae8, ae1, ae6, aef, ae2, ae3, ae4, ae7, aeb, aea, ae9, aee)
 Digits(15)=Array(af0, af5, afc, afd, af8, af1, af6, aff, af2, af3, af4, af7, afb, afa, af9, afe)
 
 Digits(16)=Array(b00, b05, b0c, b0d, b08, b01, b06, b0f, b02, b03, b04, b07, b0b, b0a, b09, b0e)
 Digits(17)=Array(b10, b15, b1c, b1d, b18, b11, b16, b1f, b12, b13, b14, b17, b1b, b1a, b19, b1e)
 Digits(18)=Array(b20, b25, b2c, b2d, b28, b21, b26, b2f, b22, b23, b24, b27, b2b, b2a, b29, b2e)
 Digits(19)=Array(b30, b35, b3c, b3d, b38, b31, b36, b3f, b32, b33, b34, b37, b3b, b3a, b39, b3e)
 Digits(20)=Array(b40, b45, b4c, b4d, b48, b41, b46, b4f, b42, b43, b44, b47, b4b, b4a, b49, b4e)
 Digits(21)=Array(b50, b55, b5c, b5d, b58, b51, b56, b5f, b52, b53, b54, b57, b5b, b5a, b59, b5e)
 Digits(22)=Array(b60, b65, b6c, b6d, b68, b61, b66, b6f, b62, b63, b64, b67, b6b, b6a, b69, b6e)
 Digits(23)=Array(b70, b75, b7c, b7d, b78, b71, b76, b7f, b72, b73, b74, b77, b7b, b7a, b79, b7e)
 Digits(24)=Array(b80, b85, b8c, b8d, b88, b81, b86, b8f, b82, b83, b84, b87, b8b, b8a, b89, b8e)
 Digits(25)=Array(b90, b95, b9c, b9d, b98, b91, b96, b9f, b92, b93, b94, b97, b9b, b9a, b99, b9e)
 Digits(26)=Array(ba0, ba5, bac, bad, ba8, ba1, ba6, baf, ba2, ba3, ba4, ba7, bab, baa, ba9, bae)
 Digits(27)=Array(bb0, bb5, bbc, bbd, bb8, bb1, bb6, bbf, bb2, bb3, bb4, bb7, bbb, bba, bb9, bbe)
 Digits(28)=Array(bc0, bc5, bcc, bcd, bc8, bc1, bc6, bcf, bc2, bc3, bc4, bc7, bcb, bca, bc9, bce)
 Digits(29)=Array(bd0, bd5, bdc, bdd, bd8, bd1, bd6, bdf, bd2, bd3, bd4, bd7, bdb, bda, bd9, bde)
 Digits(30)=Array(be0, be5, bec, bed, be8, be1, be6, bef, be2, be3, be4, be7, beb, bea, be9, bee)
 Digits(31)=Array(bf0, bf5, bfc, bfd, bf8, bf1, bf6, bff, bf2, bf3, bf4, bf7, bfb, bfa, bf9, bfe)
 
 Sub DisplayTimer_Timer
    Dim ChgLED, ii, num, chg, stat, obj

	If UseFlexDMD then FlexDMD.LockRenderThread

    ChgLED=Controller.ChangedLEDs(&Hffffffff, &Hffffffff)
    If Not IsEmpty(ChgLED)Then
		If DesktopMode = True Or UseFlexDMD Then
			For ii=0 To UBound(chgLED)
				num=chgLED(ii, 0) : chg=chgLED(ii, 1) : stat=chgLED(ii, 2)
				If UseFlexDMD then UpdateFlexChar num, stat
				If DesktopMode = True And Not CBool(UseFlexDMD) Then
					if (num < 32) then
						For Each obj In Digits(num)
							If chg And 1 Then obj.State=stat And 1
							chg=chg\2 : stat=stat\2
						Next
					Else
					end if
				End If
			Next
		end if
    End If

	If UseFlexDMD then 

		With FlexDMDScene
		
			'update display with segment data
			.GetLabel("SegmentDisplay").Text = Join(LineChars,"")

			'update nvram values
			NvRam_Update
	
			'update display using nvram data
			If InGame = 1 Then
				Select Case ActivePlayer 
				Case 0
					.GetLabel("MainDisplay").Text = FormatNumber(Join(Player1Score, ""),0,-1,0,-1)
				Case 1
					.GetLabel("MainDisplay").Text = FormatNumber(Join(Player2Score, ""),0,-1,0,-1)
				Case 2
					.GetLabel("MainDisplay").Text = FormatNumber(Join(Player3Score, ""),0,-1,0,-1)
				Case 3
					.GetLabel("MainDisplay").Text = FormatNumber(Join(Player4Score, ""),0,-1,0,-1)
				End Select
				.GetLabel("MainLabel").Text = "            PLAYER " & CStr(CInt(ActivePlayer) + 1) '& " (OF " & CStr(CInt(Players) + 1) & ")"
				.GetLabel("MainDisplay").SetAlignedPosition 100, 10, 2
				cntTimer = 0
			Else
				cntTimer = cntTimer + 1
				Select Case True
				Case cntTimer < 50
					.GetLabel("MainLabel").Text =  ""
				Case cntTimer < 110
					.GetLabel("MainLabel").Text =  "       GAMES PLAYED " & FormatNumber(Join(TotalGames,""),0,-1,0,-1)
				Case cntTimer < 170
					.GetLabel("MainLabel").Text =  ""
				Case cntTimer < 240
					.GetLabel("MainLabel").Text =  "            AND THE"
				Case cntTimer < 250
					.GetLabel("MainLabel").Text =  ""
				Case cntTimer < 510
					.GetLabel("MainLabel").Text =  "         " & "HIGHEST SCORES"
				Case Else
					.GetLabel("MainLabel").Text =  ""
				End Select

				Select Case True
				Case cntTimer < 100
					.GetLabel("MainDisplay").Text = "   GAME OVER"
				Case cntTimer < 120
					.GetLabel("MainDisplay").Text = ""
				Case cntTimer < 170
					.GetLabel("MainDisplay").Text = "     ELVIRA"
				Case cntTimer < 190
					.GetLabel("MainDisplay").Text = ""
				Case cntTimer < 240
					.GetLabel("MainDisplay").Text = " PARTY MONSTERS"
				Case cntTimer < 260
					.GetLabel("MainDisplay").Text = ""
				Case cntTimer < 360
					FlexDMDScene.GetLabel("MainDisplay").Text = "1) " & Join(HiScore1Init, "") & " " & LPad(FormatNumber(Join(HiScore1, ""),0,-1,0,-1),10)
				Case cntTimer < 435
					FlexDMDScene.GetLabel("MainDisplay").Text = "2) " & Join(HiScore2Init, "") & " " & LPad(FormatNumber(Join(HiScore2, ""),0,-1,0,-1),10)
				Case cntTimer < 485
					FlexDMDScene.GetLabel("MainDisplay").Text = "3) " & Join(HiScore3Init, "") & " " & LPad(FormatNumber(Join(HiScore3, ""),0,-1,0,-1),10)
				Case cntTimer < 510
					FlexDMDScene.GetLabel("MainDisplay").Text = "4) " & Join(HiScore4Init, "") & " " & LPad(FormatNumber(Join(HiScore4, ""),0,-1,0,-1),10)
				Case cntTimer < 530
					FlexDMDScene.GetLabel("MainDisplay").Text = ""
				Case Else	
					cntTimer = 0
				End Select
		
				FlexDMDScene.GetLabel("MainDisplay").SetAlignedPosition 1, 10, 0
			End If
		End With

		FlexDMD.UnlockRenderThread
	End If

 End Sub

' ********************************************************************************************************************************
' ********************************************************************************************************************************
   'Start of VPX  Call Back Functions
' ********************************************************************************************************************************
' ********************************************************************************************************************************


'**********Sling Shot Animations
' Rstep and Lstep  are the variables that increment the animation
'****************
Dim RStep, Lstep

Sub RightSlingShot_Slingshot
	vpmTimer.PulseSw 34
    PlaySound SoundFX("right_slingshot",DOFContactors), 0,1, 0.05,0.05 '0,1, AudioPan(RightSlingShot), 0.05,0,0,1,AudioFade(RightSlingShot)
    RSling.Visible = 0
    RSling1.Visible = 1
    sling1.TransZ = -20
    RStep = 0
    RightSlingShot.TimerEnabled = 1
End Sub

Sub RightSlingShot_Timer
    Select Case RStep
        Case 3:RSLing1.Visible = 0:RSLing2.Visible = 1:sling1.TransZ = -10
        Case 4:RSLing2.Visible = 0:RSLing.Visible = 1:sling1.TransZ = 0:RightSlingShot.TimerEnabled = 0
    End Select
    RStep = RStep + 1
End Sub

Sub LeftSlingShot_Slingshot
	vpmTimer.PulseSw 33
    PlaySound SoundFX("left_slingshot",DOFContactors), 0,1, -0.05,0.05 '0,1, AudioPan(LeftSlingShot), 0.05,0,0,1,AudioFade(LeftSlingShot)
    LSling.Visible = 0
    LSling1.Visible = 1
    sling2.TransZ = -20
    LStep = 0
    LeftSlingShot.TimerEnabled = 1
End Sub

Sub LeftSlingShot_Timer
    Select Case LStep
        Case 3:LSLing1.Visible = 0:LSLing2.Visible = 1:sling2.TransZ = -10
        Case 4:LSLing2.Visible = 0:LSLing.Visible = 1:sling2.TransZ = 0:LeftSlingShot.TimerEnabled = 0
    End Select
    LStep = LStep + 1
End Sub


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
    tmp = tableobj.y * 2 / table1.height-1
    If tmp > 0 Then
		AudioFade = Csng(tmp ^10)
    Else
        AudioFade = Csng(-((- tmp) ^10) )
    End If
End Function

Function AudioPan(tableobj) ' Calculates the pan for a tableobj based on the X position on the table. "table1" is the name of the table
    Dim tmp
    tmp = tableobj.x * 2 / table1.width-1
    If tmp > 0 Then
        AudioPan = Csng(tmp ^10)
    Else
        AudioPan = Csng(-((- tmp) ^10) )
    End If
End Function

Function Vol(ball) ' Calculates the Volume of the sound based on the ball speed
    Vol = Csng(BallVel(ball) ^2 / 2000)
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

Const tnob = 5 ' total number of balls
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
          PlaySound("fx_ballrolling" & b), -1, Vol(BOT(b) )/4, AudioPan(BOT(b) ), 0, Pitch(BOT(b) ), 1, 0, AudioFade(BOT(b) )
        Else ' Ball on raised ramp
          PlaySound("fx_ballrolling" & b), -1, Vol(BOT(b) )/7, AudioPan(BOT(b) ), 0, Pitch(BOT(b) )+50000, 1, 0, AudioFade(BOT(b) )
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


'*****************************************
'	ninuzzu's	FLIPPER SHADOWS
'*****************************************

sub FlipperTimer_Timer()
	FlipperLSh.RotZ = LeftFlipper.currentangle
	FlipperRSh.RotZ = RightFlipper.currentangle
    Flipperbatleft.RotAndTra8 = LeftFlipper.CurrentAngle - 90
    Flipperbatright.RotAndTra8 = RightFlipper.CurrentAngle + 90
End Sub

'*****************************************
'	ninuzzu's	BALL SHADOW
'*****************************************
Dim BallShadow
BallShadow = Array (BallShadow1,BallShadow2,BallShadow3,BallShadow4,BallShadow5)

Sub BallShadowUpdate_timer()
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
        If BOT(b).Z > 20 and BOT(b).Z < 140 Then
            BallShadow(b).visible = 1
        Else
            BallShadow(b).visible = 0
        End If
if BOT(b).z > 30 Then 
ballShadow(b).height = BOT(b).Z - 20
ballShadow(b).opacity = 110
Else
ballShadow(b).height = BOT(b).Z - 24
ballShadow(b).opacity = 80
End If
    Next
End Sub



'************************************
' What you need to add to your table
'************************************

' a timer called RollingTimer. With a fast interval, like 10
' one collision sound, in this script is called fx_collide
' as many sound files as max number of balls, with names ending with 0, 1, 2, 3, etc
' for ex. as used in this script: fx_ballrolling0, fx_ballrolling1, fx_ballrolling2, fx_ballrolling3, etc


'******************************************
' Explanation of the rolling sound routine
'******************************************

' sounds are played based on the ball speed and position

' the routine checks first for deleted balls and stops the rolling sound.

' The For loop goes through all the balls on the table and checks for the ball speed and 
' if the ball is on the table (height lower than 30) then then it plays the sound
' otherwise the sound is stopped, like when the ball has stopped or is on a ramp or flying.

' The sound is played using the VOL, AUDIOPAN, AUDIOFADE and PITCH functions, so the volume and pitch of the sound
' will change according to the ball speed, and the AUDIOPAN & AUDIOFADE functions will change the stereo position
' according to the position of the ball on the table.


'**************************************
' Explanation of the collision routine
'**************************************

' The collision is built in VP.
' You only need to add a Sub OnBallBallCollision(ball1, ball2, velocity) and when two balls collide they 
' will call this routine. What you add in the sub is up to you. As an example is a simple Playsound with volume and paning
' depending of the speed of the collision.


Sub Pins_Hit (idx)
	PlaySound "pinhit_low", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 0, 0, AudioFade(ActiveBall)
End Sub

Sub Targets_Hit (idx)
	PlaySound "target", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 0, 0, AudioFade(ActiveBall)
End Sub

Sub Metals_Thin_Hit (idx)
	PlaySound "metalhit_thin", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
End Sub

Sub Metals_Medium_Hit (idx)
	PlaySound "metalhit_medium", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
End Sub

Sub Metals2_Hit (idx)
	PlaySound "metalhit2", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
End Sub

Sub Gates_Hit (idx)
	PlaySound "gate4", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
End Sub

Sub Spinner_Spin
	PlaySound "fx_spinner", 0, .25, AudioPan(Spinner), 0.25, 0, 0, 1, AudioFade(Spinner)
End Sub

Sub Rubbers_Hit(idx)
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 20 then 
		PlaySound "fx_rubber2", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
	End if
	If finalspeed >= 6 AND finalspeed <= 20 then
 		RandomSoundRubber()
 	End If
End Sub

Sub Posts_Hit(idx)
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 16 then 
		PlaySound "fx_rubber2", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
	End if
	If finalspeed >= 6 AND finalspeed <= 16 then
 		RandomSoundRubber()
 	End If
End Sub

Sub RandomSoundRubber()
	Select Case Int(Rnd*3)+1
		Case 1 : PlaySound "rubber_hit_1", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
		Case 2 : PlaySound "rubber_hit_2", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
		Case 3 : PlaySound "rubber_hit_3", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
	End Select
End Sub

Sub LeftFlipper_Collide(parm)
 	RandomSoundFlipper()
End Sub

Sub RightFlipper_Collide(parm)
 	RandomSoundFlipper()
End Sub

Sub RandomSoundFlipper()
	Select Case Int(Rnd*3)+1
		Case 1 : PlaySound "flip_hit_1", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
		Case 2 : PlaySound "flip_hit_2", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
		Case 3 : PlaySound "flip_hit_3", 0, Vol(ActiveBall), AudioPan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
	End Select
End Sub

Sub Table1_Exit()
	Controller.Pause = False
	Controller.Stop
	If UseFlexDMD then
		If Not FlexDMD is Nothing Then 
			FlexDMD.Show = False
			FlexDMD.Run = False
			FlexDMD = NULL
		End if
		Controller.Games(cGameName).Settings.Value("showpindmd") = ExternalEnabled
	End if
End Sub


'**********************************************************************************************************
' FlexDMD code - scutters
'**********************************************************************************************************
Dim FlexDMD
Dim FlexDMDScene
DIm FlexDMDDict
Dim ExternalEnabled
Dim LineChars

Sub FlexDMD_Init() 'default/startup values

	If LCase(cGameName) <> "eatpm_l4" And UseFlexDMD = 1 Then
		'nvram code used by flex only tested with eatpm_l4
		MsgBox "Wrong rom " & cGameName & ". Use eatpm_l4 if enabling FlexDMD"
		UseFlexDMD = 0 
	End If

	If UseFlexDMD = 0 then 
		Exit Sub
	End if

	'pause display timer while flex (re-enabled at end of NvRam_Init)
	DisplayTimer.Enabled = False

	'array to hold characters to display converted from segment codes
	LineChars = Array(" "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," ")
	
	On Error Resume Next
	Set FlexDMD = CreateObject("FlexDMD.FlexDMD")
	On Error GoTo 0

	If IsObject(FlexDMD) Then

		FlexDMD.RenderMode = 2
		FlexDMD.Width = 128
		FlexDMD.Height = 32
		FlexDMD.Clear = True
		FlexDMD.GameName = cGameName
		FlexDMD.Run = True

		FlexDMD.LockRenderThread

		Set FlexDMDScene = FlexDMD.NewGroup("Scene")

		Dim vpmColourised, vpm33Percent, vpm66Percent, vpmOffPercent

		With FlexDMDScene

			.AddActor FlexDMD.NewImage("BackG", "FlexDMD.Resources.dmds.black.png")

			vpmColourised = Controller.Games(cGameName).Settings.Value("dmd_colorize")
			If vpmColourised = 0 Then
				vpm33Percent = Controller.Games(cGameName).Settings.Value("dmd_perc33") / 100
				vpm66Percent = Controller.Games(cGameName).Settings.Value("dmd_perc66") / 100
				vpmOffPercent = Controller.Games(cGameName).Settings.Value("dmd_perc0") / 100
			End If
			
			.AddActor FlexDMD.NewFrame("BackColour")
			.GetFrame("BackColour").Visible = True
			If vpmColourised = 0 Then			
				'RGB R & B colours seem reversed when darwing frames in flex
				'.GetFrame("BackColour").FillColor = RGB(Controller.Games(cGameName).Settings.Value("dmd_red0"),Controller.Games(cGameName).Settings.Value("dmd_green0"),Controller.Games(cGameName).Settings.Value("dmd_blue0"))
				.GetFrame("BackColour").FillColor = RGB(Controller.Games(cGameName).Settings.Value("dmd_blue0"),Controller.Games(cGameName).Settings.Value("dmd_green0"),Controller.Games(cGameName).Settings.Value("dmd_red0"))
			Else
				'.GetFrame("BackColour").FillColor = RGB(Controller.Games(cGameName).Settings.Value("dmd_red") * vpmOffPercent,Controller.Games(cGameName).Settings.Value("dmd_green") * vpmOffPercent,Controller.Games(cGameName).Settings.Value("dmd_blue") * vpmOffPercent)
				.GetFrame("BackColour").FillColor = RGB(Controller.Games(cGameName).Settings.Value("dmd_blue") * vpmOffPercent,Controller.Games(cGameName).Settings.Value("dmd_green") * vpmOffPercent,Controller.Games(cGameName).Settings.Value("dmd_red") * vpmOffPercent)
			End If
			.GetFrame("BackColour").Height = 32
			.GetFrame("BackColour").Width= 128
			.GetFrame("BackColour").Fill= True
			.GetFrame("BackColour").Thickness= 0
			
			Dim FlexDMDFont
			
			'main 32 segment display
			If vpmColourised = 0 Then
				Set FlexDMDFont = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(Controller.Games(cGameName).Settings.Value("dmd_red66"),Controller.Games(cGameName).Settings.Value("dmd_green66"),Controller.Games(cGameName).Settings.Value("dmd_blue66")), vbRed, 0)
			Else
				Set FlexDMDFont = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(Controller.Games(cGameName).Settings.Value("dmd_red") * vpm66Percent,Controller.Games(cGameName).Settings.Value("dmd_green") * vpm66Percent,Controller.Games(cGameName).Settings.Value("dmd_blue") * vpm66Percent), vbRed, 0)
			End If
			.AddActor(FlexDMD.NewLabel("SegmentDisplay", FlexDMDFont, Space(32)))
			.GetLabel("SegmentDisplay").SetAlignedPosition 0, 26, 0

			'main score display for nvram data
			If vpmColourised = 0Then
				FlexDMDFont = FlexDMD.NewFont("FlexDMD.Resources.udmd-f7by13.fnt", RGB(Controller.Games(cGameName).Settings.Value("dmd_red"),Controller.Games(cGameName).Settings.Value("dmd_green"),Controller.Games(cGameName).Settings.Value("dmd_blue")), vbRed, 0)
			Else
				FlexDMDFont = FlexDMD.NewFont("FlexDMD.Resources.udmd-f7by13.fnt", RGB(Controller.Games(cGameName).Settings.Value("dmd_red"),Controller.Games(cGameName).Settings.Value("dmd_green") ,Controller.Games(cGameName).Settings.Value("dmd_blue")), vbRed, 0)
			End If
			.AddActor(FlexDMD.NewLabel("MainDisplay", FlexDMDFont, Space(14)))
			.GetLabel("MainDisplay").SetAlignedPosition 1, 10, 0

			'lable for main score nvram data
			If vpmColourised = 0 Then
				FlexDMDFont = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(Controller.Games(cGameName).Settings.Value("dmd_red33"),Controller.Games(cGameName).Settings.Value("dmd_green33"),Controller.Games(cGameName).Settings.Value("dmd_blue33")), vbRed, 0)		
			Else
				FlexDMDFont = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(Controller.Games(cGameName).Settings.Value("dmd_red") * vpm33Percent,Controller.Games(cGameName).Settings.Value("dmd_green") * vpm33Percent,Controller.Games(cGameName).Settings.Value("dmd_blue") * vpm33Percent), vbRed, 0)
			End If
			.AddActor(FlexDMD.NewLabel("MainLabel", FlexDMDFont, Space(32)))'Space(10)))
			.GetLabel("MainLabel").SetAlignedPosition 0, 2, 0

		End With
		

		FlexDMD.Stage.AddActor FlexDMDScene
		FlexDMD.UnlockRenderThread
		
		FlexDictionary_Init
	Else
		
		UseFlexDMD = 0	
	End If

End Sub

Sub FlexDictionary_Init

	'add conversion of segment charcters codes to lookup table
	'lower case alpha not used

	Set FlexDMDDict = CreateObject("Scripting.Dictionary")

	FlexDMDDict.Add 0, " "
	FlexDMDDict.Add 63, "0"
	FlexDMDDict.Add 6, "1"
	FlexDMDDict.Add 2139, "2"
	FlexDMDDict.Add 2127, "3"
	FlexDMDDict.Add 2150, "4"
	FlexDMDDict.Add 2157, "5"
	FlexDMDDict.Add 2173, "6"
	FlexDMDDict.Add 7, "7"
	FlexDMDDict.Add 2175, "8"
	FlexDMDDict.Add 2159, "9"
	'with commas removed
	FlexDMDDict.Add 32959, "0"
	FlexDMDDict.Add 32902, "1"
	FlexDMDDict.Add 35035, "2"
	FlexDMDDict.Add 35023, "3"
	FlexDMDDict.Add 35046, "4"
	FlexDMDDict.Add 35053, "5"
	FlexDMDDict.Add 35069, "6"
	FlexDMDDict.Add 32903, "7"
	FlexDMDDict.Add 35071, "8"
	FlexDMDDict.Add 35055, "9"
	'with dots removed
	FlexDMDDict.Add 32831, "0"
	FlexDMDDict.Add 32774, "1"
	FlexDMDDict.Add 34907, "2"
	FlexDMDDict.Add 34895, "3"
	FlexDMDDict.Add 34918, "4"
	FlexDMDDict.Add 34925, "5"
	FlexDMDDict.Add 34941, "6"
	FlexDMDDict.Add 32775, "7"
	FlexDMDDict.Add 34943, "8"
	FlexDMDDict.Add 34927, "9"
	
	FlexDMDDict.Add 2167, "A"
	FlexDMDDict.Add 10767, "B"
	FlexDMDDict.Add 57, "C"
	FlexDMDDict.Add 8719, "D"
	FlexDMDDict.Add 121, "E"
	FlexDMDDict.Add 113, "F"
	FlexDMDDict.Add 2109, "G"
	FlexDMDDict.Add 2166, "H"
	FlexDMDDict.Add 8713, "I"
	FlexDMDDict.Add 30, "J"
	FlexDMDDict.Add 5232, "K"
	FlexDMDDict.Add 56, "L"
	FlexDMDDict.Add 1334, "M"
	FlexDMDDict.Add 4406, "N"
	' "O" = 0
	FlexDMDDict.Add 2163, "P"
	FlexDMDDict.Add 4159, "Q"
	FlexDMDDict.Add 6259, "R"
	 ' "S" = 5
	FlexDMDDict.Add 8705, "T"
	FlexDMDDict.Add 62, "U"
	FlexDMDDict.Add 17456, "V"
	FlexDMDDict.Add 20534, "W"
	FlexDMDDict.Add 21760, "X"
	FlexDMDDict.Add 9472, "Y"
	FlexDMDDict.Add 17417, "Z"
	'with dots removed
	FlexDMDDict.Add 34935, "A"
	FlexDMDDict.Add 43535, "B"
	FlexDMDDict.Add 32825, "C"
	FlexDMDDict.Add 41487, "D"
	FlexDMDDict.Add 32889, "E"
	FlexDMDDict.Add 32881, "F"
	FlexDMDDict.Add 34877, "G"
	FlexDMDDict.Add 34934, "H"
	FlexDMDDict.Add 41481, "I"
	FlexDMDDict.Add 32798, "J"
	FlexDMDDict.Add 38000, "K"
	FlexDMDDict.Add 32824, "L"
	FlexDMDDict.Add 34102, "M"
	FlexDMDDict.Add 37174, "N"
	' "O." = 0.
	FlexDMDDict.Add 34931, "P"
	FlexDMDDict.Add 36927, "Q"
	FlexDMDDict.Add 39027, "R"
	' "S." = 5.
	FlexDMDDict.Add 41473, "T"
	FlexDMDDict.Add 32830, "U"
	FlexDMDDict.Add 50224, "V"
	FlexDMDDict.Add 53302, "W"
	FlexDMDDict.Add 54528, "X"
	FlexDMDDict.Add 42240, "Y"
	FlexDMDDict.Add 50185, "Z"
	
	FlexDMDDict.Add 17408, "/"
	FlexDMDDict.Add 1024, "'"
	FlexDMDDict.Add 16640, ")"
	FlexDMDDict.Add 5120, "("
	FlexDMDDict.Add 2120, "="
	FlexDMDDict.Add 10275, "?"
	FlexDMDDict.Add 2160, "/"
	FlexDMDDict.Add 2118, "/"
	FlexDMDDict.Add 2112, "-"
	FlexDMDDict.Add 8704, "|"
	FlexDMDDict.Add 10861, "$"
	FlexDMDDict.Add 8, "_"
	FlexDMDDict.Add 2048, "-"
	FlexDMDDict.Add 6144, "<"
	FlexDMDDict.Add 65535, "#"
	FlexDMDDict.Add 32576, "*"
	
End Sub

Sub UpdateFlexChar(id, value)
	'map segment code to character 
	Dim chr
	if FlexDMDDict.Exists (value) then
		chr = FlexDMDDict.Item (value)
		if id < 32 then
			LineChars(id) = chr
		end if
	end if 
		
End Sub

' nvram data variables
Dim Player1Score, Player2Score, Player3Score, Player4Score
Dim HiScore1, HiScore2, HiScore3, HiScore4, HiScore1Init, HiScore2Init, HiScore3Init, HiScore4Init
Dim ActivePlayer, InGame, TotalGames, Players, Credits, cntTimer

Sub NvRam_Init

	' most locations from https://github.com/tomlogic/pinmame-nvram-maps/blob/master/eatpm_l4.nv.json 
	' see also https://www.vpforums.org/index.php?showtopic=33611&p=346441

	Dim NVRAM
	NVRAM = Controller.NVRAM
	If Not IsEmpty(NVRAM) Then

		Player1Score = Array (ConvertBCD(NVRAM(512)),ConvertBCD(NVRAM(513)),ConvertBCD(NVRAM(514)),ConvertBCD(NVRAM(515)))
		Player2Score = Array (ConvertBCD(NVRAM(516)),ConvertBCD(NVRAM(517)),ConvertBCD(NVRAM(518)),ConvertBCD(NVRAM(519)))
		Player3Score = Array (ConvertBCD(NVRAM(520)),ConvertBCD(NVRAM(521)),ConvertBCD(NVRAM(522)),ConvertBCD(NVRAM(523)))
		Player4Score = Array (ConvertBCD(NVRAM(524)),ConvertBCD(NVRAM(525)),ConvertBCD(NVRAM(526)),ConvertBCD(NVRAM(527)))

		HiScore1 = Array (ConvertBCD(NVRAM(1787)),ConvertBCD(NVRAM(1788)),ConvertBCD(NVRAM(1789)),ConvertBCD(NVRAM(1790)))
		HiScore2 = Array (ConvertBCD(NVRAM(1791)),ConvertBCD(NVRAM(1792)),ConvertBCD(NVRAM(1793)),ConvertBCD(NVRAM(1794)))
		HiScore3 = Array (ConvertBCD(NVRAM(1795)),ConvertBCD(NVRAM(1796)),ConvertBCD(NVRAM(1797)),ConvertBCD(NVRAM(1798)))
		HiScore4 = Array (ConvertBCD(NVRAM(1799)),ConvertBCD(NVRAM(1800)),ConvertBCD(NVRAM(1801)),ConvertBCD(NVRAM(1802)))

		HiScore1Init = Array (Chr(NVRAM(1803)), Chr(NVRAM(1804)), Chr(NVRAM(1805)))
		HiScore2Init = Array (Chr(NVRAM(1806)), Chr(NVRAM(1807)), Chr(NVRAM(1808)))
		HiScore3Init = Array (Chr(NVRAM(1809)), Chr(NVRAM(1810)), Chr(NVRAM(1811)))
		HiScore4Init = Array (Chr(NVRAM(1812)), Chr(NVRAM(1813)), Chr(NVRAM(1814)))

		ActivePlayer = NVRAM(179) : InGame = NVRAM(832)

		TotalGames = Array(ConvertBCD(NVRAM(1620)),ConvertBCD(NVRAM(1621)),ConvertBCD(NVRAM(1622)))

		Players = NVRAM(178) : Credits = NVRAM(1786)

		'make sure timer is enabled and interval set (for attract display speed using cntTimer)
		DisplayTimer.Enabled = True
		DisplayTimer.Interval = 40
		cntTimer = 0

	End If
		
End Sub

Sub NvRam_Update
	Dim NVRAM
	NVRAM = Controller.ChangedNVRAM
	If Not IsEmpty(NVRAM) Then
		Dim I, J
		For I = 0 To UBound(NVRAM)			'255 in score = no entry
			J = NVRAM(I,0)
			Select Case J
			Case 512, 513, 514, 515
				Player1Score(J - 512) = ConvertBCD(NVRAM(I,1))
			Case 516, 517, 518, 519
				Player2Score(J - 516) = ConvertBCD(NVRAM(I,1))		
			Case 520, 521, 522, 523
				Player3Score(J - 520) = ConvertBCD(NVRAM(I,1))
			Case 524, 525, 526, 527
				Player4Score(J - 524) = ConvertBCD(NVRAM(I,1))
			Case 1787, 1788, 1789, 1790
				HiScore1(J - 1787) = ConvertBCD(NVRAM(I,1))
			Case 1791, 1792, 1793, 1794
				HiScore2(J - 1791) = ConvertBCD(NVRAM(I,1))		
			Case 1795, 1796, 1797, 1798
				HiScore3(J - 1795) = ConvertBCD(NVRAM(I,1))
			Case 1799, 1800, 1801, 1802
				HiScore4(J - 1799) = ConvertBCD(NVRAM(I,1))
			Case 1803, 1804, 1805
				HiScore1Init(J - 1803) = Chr(NVRAM(I,1))
			Case 1806, 1807, 1808
				HiScore2Init(J - 1806) = Chr(NVRAM(I,1))
			Case 1809, 1810, 1811
				HiScore3Init(J - 1809) = Chr(NVRAM(I,1))
			Case 1812, 1813, 1814
				HiScore4Init(J - 1812) = Chr(NVRAM(I,1))
			Case 179
				ActivePlayer = NVRAM(I,1)				' +1 for display
			Case 832
				InGame = NVRAM(I,1)
			Case 1620,1621,1622
				TotalGames(J - 1620) = ConvertBCD(NVRAM(I,1))
			Case 178
				Players = NVRAM(I,1)					' +1 for display
			Case 1786
				Credits = NVRAM(I,1)
			End Select
		Next
	End If

End Sub

Function ConvertBCD(v) 
	'converts an 8bit number in BCD format to string (for example 12 in hexadecimal format to "12")
	ConvertBCD = "" & ((v AND &hF0) / 16) & (v AND &hF)
	If ConvertBCD = "255" Then ConvertBCD = "00"
End Function

Function LPad(StringToPad, Length)
	'simple left padding with spaces
	Dim x : x = 0
	If Length > Len(StringToPad) Then x = Length - len(StringToPad)
	LPad = Space(x) & StringToPad
End Function
