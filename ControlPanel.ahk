#SingleInstance, Ignore
CoordMode, Mouse, Screen
SetTitleMatchMode, 3

if not A_IsAdmin
{
    ; Relaunch script with admin rights
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

; Read settings from the main script's settings file
IniRead, Instances, Settings.ini, UserSettings, Instances, 1
IniRead, runMain, Settings.ini, UserSettings, runMain, 1
IniRead, Mains, Settings.ini, UserSettings, Mains, 1
IniRead, folderPath, Settings.ini, UserSettings, folderPath, C:\Program Files\Netease
IniRead, useChinaVersion, Settings.ini, UserSettings, useChinaVersion, 0

; Set MuMu folder path based on version
if (useChinaVersion) {
    mumuFolder = %folderPath%\MuMu Player 12
} else {
    mumuFolder = %folderPath%\MuMuPlayerGlobal-12.0
    if !FileExist(mumuFolder)
        mumuFolder = %folderPath%\MuMu Player 12
}

; Set MuMuManager.exe location
mumuManagerPath := mumuFolder "\shell\MuMuManager.exe"

; Monokai theme colors
global monokaiBg := "272822"      ; Dark background
global monokaiText := "F8F8F2"    ; Light text
global monokaiAccent := "66D9EF"  ; Blue accent
global monokaiButton := "49483E"  ; Button background
global monokaiButtonHover := "75715E" ; Button hover
global monokaiGroup := "3E3D32"   ; Group box background

; Create GUI with Monokai theme
Gui, New
Gui, Color, %monokaiBg%, %monokaiGroup%
Gui, Font, s10 c%monokaiText%, Segoe UI

; MuMu Instance Control Section
Gui, Add, GroupBox, x10 y10 w300 h240 c%monokaiAccent% Background%monokaiGroup%, MuMu Instance Control
Gui, Add, Button, x20 y30 w280 h30 gKillAllMumu Background%monokaiButton% c%monokaiText%, Kill All MuMu Instances
Gui, Add, Text, x20 y70 c%monokaiAccent%, Toggle Individual MuMu Instances:
Gui, Add, Button, x20 y90 w40 h30 gToggleMumu1 Background%monokaiButton% c%monokaiText% vMumu1Btn, 1
Gui, Add, Button, x65 y90 w40 h30 gToggleMumu2 Background%monokaiButton% c%monokaiText% vMumu2Btn, 2
Gui, Add, Button, x110 y90 w40 h30 gToggleMumu3 Background%monokaiButton% c%monokaiText% vMumu3Btn, 3
Gui, Add, Button, x155 y90 w40 h30 gToggleMumu4 Background%monokaiButton% c%monokaiText% vMumu4Btn, 4
Gui, Add, Button, x200 y90 w40 h30 gToggleMumu5 Background%monokaiButton% c%monokaiText% vMumu5Btn, 5
Gui, Add, Button, x245 y90 w40 h30 gToggleMumu6 Background%monokaiButton% c%monokaiText% vMumu6Btn, 6

; Disk Cache Cleaning Section
Gui, Add, Text, x20 y130 c%monokaiAccent%, Clean Disk Cache:
Gui, Add, Button, x20 y150 w40 h30 gCleanDisk1 Background%monokaiButton% c%monokaiText%, 1
Gui, Add, Button, x65 y150 w40 h30 gCleanDisk2 Background%monokaiButton% c%monokaiText%, 2
Gui, Add, Button, x110 y150 w40 h30 gCleanDisk3 Background%monokaiButton% c%monokaiText%, 3
Gui, Add, Button, x155 y150 w40 h30 gCleanDisk4 Background%monokaiButton% c%monokaiText%, 4
Gui, Add, Button, x200 y150 w40 h30 gCleanDisk5 Background%monokaiButton% c%monokaiText%, 5
Gui, Add, Button, x245 y150 w40 h30 gCleanDisk6 Background%monokaiButton% c%monokaiText%, 6

; AHK Script Control Section
Gui, Add, GroupBox, x10 y260 w300 h180 c%monokaiAccent% Background%monokaiGroup%, AHK Script Control
Gui, Add, Button, x20 y280 w280 h30 gKillAllAHK Background%monokaiButton% c%monokaiText%, Kill All AHK Scripts
Gui, Add, Text, x20 y320 c%monokaiAccent%, Toggle Individual AHK Scripts:
Gui, Add, Button, x20 y340 w40 h30 gToggleAHK1 Background%monokaiButton% c%monokaiText% vAHK1Btn, 1
Gui, Add, Button, x65 y340 w40 h30 gToggleAHK2 Background%monokaiButton% c%monokaiText% vAHK2Btn, 2
Gui, Add, Button, x110 y340 w40 h30 gToggleAHK3 Background%monokaiButton% c%monokaiText% vAHK3Btn, 3
Gui, Add, Button, x155 y340 w40 h30 gToggleAHK4 Background%monokaiButton% c%monokaiText% vAHK4Btn, 4
Gui, Add, Button, x200 y340 w40 h30 gToggleAHK5 Background%monokaiButton% c%monokaiText% vAHK5Btn, 5
Gui, Add, Button, x245 y340 w40 h30 gToggleAHK6 Background%monokaiButton% c%monokaiText% vAHK6Btn, 6

; Main Instance Control Section
Gui, Add, GroupBox, x10 y450 w300 h60 c%monokaiAccent% Background%monokaiGroup%, Main Instance Control
Gui, Add, Button, x20 y470 w280 h30 gToggleMainInstance Background%monokaiButton% c%monokaiText% vMainInstanceBtn, Toggle Main Instance

; Status Section
Gui, Add, GroupBox, x10 y520 w300 h120 c%monokaiAccent% Background%monokaiGroup%, Status
Gui, Add, Text, x20 y540 w280 h60 vStatusText c%monokaiText%, Checking instances...
Gui, Add, Button, x20 y610 w280 h20 gRefreshStatus Background%monokaiButton% c%monokaiText%, Refresh Status

; Utility Section
Gui, Add, GroupBox, x320 y10 w200 h200 c%monokaiAccent% Background%monokaiGroup%, Utilities
Gui, Add, Button, x330 y30 w180 h30 gOpenProjectFolder Background%monokaiButton% c%monokaiText%, Open Project Folder
Gui, Add, Button, x330 y65 w180 h30 gOpenLogsFolder Background%monokaiButton% c%monokaiText%, Open Logs Folder
Gui, Add, Button, x330 y100 w180 h30 gToggleMonitor Background%monokaiButton% c%monokaiText% vToggleMonitor, Toggle Monitor.ahk
Gui, Add, Button, x330 y135 w180 h30 gTogglePTCGPB Background%monokaiButton% c%monokaiText% vTogglePTCGPB, Toggle PTCGPB.ahk
Gui, Add, Button, x330 y170 w180 h30 gCheckUpdate Background%monokaiButton% c%monokaiText%, Check For Updates

; Stats Section
Gui, Add, GroupBox, x320 y220 w200 h160 c%monokaiAccent% Background%monokaiGroup%, Statistics
Gui, Add, Text, x330 y240 w180 h90 vStatsText c%monokaiText%, Loading stats...
Gui, Add, Button, x330 y350 w180 h20 gRefreshStats Background%monokaiButton% c%monokaiText%, Refresh Stats

; Show GUI
Gui, Show, w530 h650, PTCGP-Extra Control Panel by Josh

; Initial status check
SetTimer, UpdateStatus, 5000
Gosub, UpdateStatus
Gosub, UpdateStats
return

; Functions for killing MuMu instances
KillAllMumu:
    Loop %Instances% {
        killInstance(A_Index)
    }
    if (runMain) {
        Loop %Mains% {
            mainInstanceName := "Main" . (A_Index > 1 ? A_Index : "")
            killInstance(mainInstanceName)
        }
    }
    Gosub, UpdateStatus
return

KillMumu1:
    killInstance(1)
    Gosub, UpdateStatus
return

KillMumu2:
    killInstance(2)
    Gosub, UpdateStatus
return

KillMumu3:
    killInstance(3)
    Gosub, UpdateStatus
return

KillMumu4:
    killInstance(4)
    Gosub, UpdateStatus
return

KillMumu5:
    killInstance(5)
    Gosub, UpdateStatus
return

KillMumu6:
    killInstance(6)
    Gosub, UpdateStatus
return

; Functions for cleaning disk cache
CleanDisk1:
    cleanInstanceDisk(1)
return

CleanDisk2:
    cleanInstanceDisk(2)
return

CleanDisk3:
    cleanInstanceDisk(3)
return

CleanDisk4:
    cleanInstanceDisk(4)
return

CleanDisk5:
    cleanInstanceDisk(5)
return

CleanDisk6:
    cleanInstanceDisk(6)
return

; Functions for toggling MuMu instances
ToggleMumu1:
    toggleInstance(1, "Mumu1Btn")
return

ToggleMumu2:
    toggleInstance(2, "Mumu2Btn")
return

ToggleMumu3:
    toggleInstance(3, "Mumu3Btn")
return

ToggleMumu4:
    toggleInstance(4, "Mumu4Btn")
return

ToggleMumu5:
    toggleInstance(5, "Mumu5Btn")
return

ToggleMumu6:
    toggleInstance(6, "Mumu6Btn")
return

; Functions for toggling AHK scripts
ToggleAHK1:
    toggleAHK("1.ahk", "AHK1Btn")
return

ToggleAHK2:
    toggleAHK("2.ahk", "AHK2Btn")
return

ToggleAHK3:
    toggleAHK("3.ahk", "AHK3Btn")
return

ToggleAHK4:
    toggleAHK("4.ahk", "AHK4Btn")
return

ToggleAHK5:
    toggleAHK("5.ahk", "AHK5Btn")
return

ToggleAHK6:
    toggleAHK("6.ahk", "AHK6Btn")
return

ToggleMainInstance:
    if (runMain) {
        Loop %Mains% {
            mainInstanceName := "Main" . (A_Index > 1 ? A_Index : "")
            toggleInstance(mainInstanceName, "MainInstanceBtn")
        }
    }
return

TogglePTCGPB:
    if (checkAHK("PTCGPB.ahk")) {
        killAHK("PTCGPB.ahk")
        GuiControl,, TogglePTCGPB, Toggle PTCGPB.ahk
    } else {
        ; Launch the script
        Run, %A_ScriptDir%\PTCGPB.ahk
        GuiControl,, TogglePTCGPB, Toggle PTCGPB.ahk *
    }
    Gosub, UpdateStatus
return

; Functions for killing AHK scripts
KillAllAHK:
    Loop %Instances% {
        killAHK(A_Index . ".ahk")
    }
    if (runMain) {
        Loop %Mains% {
            mainInstanceName := "Main" . (A_Index > 1 ? A_Index : "")
            killAHK(mainInstanceName . ".ahk")
        }
    }
    killAHK("Monitor.ahk")
    killAHK("PTCGPB.ahk")
    Gosub, UpdateStatus
return

KillAHK1:
    killAHK("1.ahk")
    Gosub, UpdateStatus
return

KillAHK2:
    killAHK("2.ahk")
    Gosub, UpdateStatus
return

KillAHK3:
    killAHK("3.ahk")
    Gosub, UpdateStatus
return

KillAHK4:
    killAHK("4.ahk")
    Gosub, UpdateStatus
return

KillAHK5:
    killAHK("5.ahk")
    Gosub, UpdateStatus
return

KillAHK6:
    killAHK("6.ahk")
    Gosub, UpdateStatus
return

KillMainInstance:
    if (runMain) {
        Loop %Mains% {
            mainInstanceName := "Main" . (A_Index > 1 ? A_Index : "")
            killInstance(mainInstanceName)
            killAHK(mainInstanceName . ".ahk")
        }
    }
    Gosub, UpdateStatus
return

RefreshStatus:
    Gosub, UpdateStatus
    Gosub, UpdateStats
return

UpdateStatus:
    status := "Running Instances:`n"
    
    ; Check main instances
    if (runMain) {
        Loop %Mains% {
            mainInstanceName := "Main" . (A_Index > 1 ? A_Index : "")
            if (checkInstance(mainInstanceName)) {
                status .= mainInstanceName . ", "
                GuiControl,, MainInstanceBtn, %mainInstanceName% *
            } else {
                GuiControl,, MainInstanceBtn, %mainInstanceName%
            }
            if (checkAHK(mainInstanceName . ".ahk")) {
                status .= mainInstanceName . ".ahk, "
                GuiControl,, AHK%A_Index%Btn, %mainInstanceName% *
            } else {
                GuiControl,, AHK%A_Index%Btn, %mainInstanceName%
            }
        }
    }
    
    ; Check regular instances
    Loop %Instances% {
        if (checkInstance(A_Index)) {
            status .= A_Index . ", "
            GuiControl,, Mumu%A_Index%Btn, %A_Index% *
        } else {
            GuiControl,, Mumu%A_Index%Btn, %A_Index%
        }
        if (checkAHK(A_Index . ".ahk")) {
            status .= A_Index . ".ahk, "
            GuiControl,, AHK%A_Index%Btn, %A_Index% *
        } else {
            GuiControl,, AHK%A_Index%Btn, %A_Index%
        }
    }
    
    ; Check Monitor.ahk
    if (checkAHK("Monitor.ahk")) {
        status .= "Monitor.ahk, "
        GuiControl,, ToggleMonitor, Toggle Monitor.ahk *
    } else {
        GuiControl,, ToggleMonitor, Toggle Monitor.ahk
    }
    
    ; Check PTCGPB.ahk
    if (checkAHK("PTCGPB.ahk")) {
        status .= "PTCGPB.ahk, "
        GuiControl,, TogglePTCGPB, Toggle PTCGPB.ahk *
    } else {
        GuiControl,, TogglePTCGPB, Toggle PTCGPB.ahk
    }
    
    GuiControl,, StatusText, %status%
return

; Utility functions
OpenProjectFolder:
    Run, explorer.exe %A_ScriptDir%
return

OpenLogsFolder:
    Run, explorer.exe %A_ScriptDir%\Logs
return

ToggleMonitor:
    ; Check if Monitor.ahk is running
    monitorRunning := false
    DetectHiddenWindows, On
    WinGet, IDList, List, ahk_class AutoHotkey
    Loop %IDList% {
        ID:=IDList%A_Index%
        WinGetTitle, ATitle, ahk_id %ID%
        if InStr(ATitle, "\Monitor.ahk") {
            monitorRunning := true
            break
        }
    }
    
    if (monitorRunning) {
        ; Kill Monitor.ahk
        killAHK("Monitor.ahk")
        GuiControl,, ToggleMonitor, Toggle Monitor.ahk
        MsgBox, 64, Monitor Status, Monitor has been turned OFF.
    } else {
        ; Launch Monitor.ahk
        Run, %A_ScriptDir%\Monitor.ahk
        GuiControl,, ToggleMonitor, Toggle Monitor.ahk *
        MsgBox, 64, Monitor Status, Monitor has been turned ON.
    }
    
    Gosub, UpdateStatus
return

; Helper functions from your existing codebase
killAHK(scriptName := "") {
    killed := 0
    if(scriptName != "") {
        DetectHiddenWindows, On
        WinGet, IDList, List, ahk_class AutoHotkey
        Loop %IDList% {
            ID:=IDList%A_Index%
            WinGetTitle, ATitle, ahk_id %ID%
            if InStr(ATitle, "\" . scriptName) {
                WinGet, pid, PID, ahk_id %ID%
                WinKill, ahk_id %ID%
                killed := killed + 1
                
                ; Verify process is actually dead
                Process, Exist, %pid%
                if (ErrorLevel) {
                    RunWait, taskkill /f /pid %pid% /t,, Hide
                }
            }
        }
    }
    return killed
}

checkAHK(scriptName := "") {
    cnt := 0
    if(scriptName != "") {
        DetectHiddenWindows, On
        WinGet, IDList, List, ahk_class AutoHotkey
        Loop %IDList% {
            ID:=IDList%A_Index%
            WinGetTitle, ATitle, ahk_id %ID%
            if InStr(ATitle, "\" . scriptName) {
                cnt := cnt + 1
            }
        }
    }
    return cnt
}

killInstance(instanceNum := "") {
    global mumuManagerPath, mumuFolder
    killed := 0
    maxRetries := 3
    retryDelay := 2000 ; 2 seconds
    
    ; First try to get the MuMu instance number
    mumuNum := getMumuInstanceNumFromPlayerName(instanceNum)
    
    ; If we found a valid MuMu instance number, try to shut it down properly using MuMuManager
    if (mumuNum != "") {
        ; Run the MuMuManager command to properly shut down the instance
        RunWait, %mumuManagerPath% api -v %mumuNum% shutdown_player,, Hide
        
        ; Wait a moment for the processes to terminate
        Sleep, 5000
        
        ; Check if the instance is still running
        pID := checkInstance(instanceNum)
        if (!pID) {
            ; Instance was successfully shut down
            killed := 1
            LogToFile("Properly shut down instance " . instanceNum . " using MuMuManager", "ControlPanel.txt")
            return killed
        }
    }
    
    ; If MuMuManager method failed or no instance number was found, fall back to the original method
    pID := checkInstance(instanceNum)
    if pID {
        Process, Close, %pID%
        killed := killed + 1
        
        ; Verify process is actually dead
        Process, Exist, %pID%
        if (ErrorLevel) {
            ; Forceful termination if needed
            Loop %maxRetries% {
                RunWait, taskkill /f /pid %pID% /t,, Hide
                Sleep %retryDelay%
                Process, Exist, %pID%
                if (!ErrorLevel) {
                    killed := 1
                    break
                }
            }
        }
        
        ; Try to kill any remaining MuMu processes for this instance
        ; RunWait, taskkill /f /im MuMuVMMHeadless.exe /fi "WINDOWTITLE eq %instanceNum%" /t,, Hide
        ; RunWait, taskkill /f /im MuMuVMMSVC.exe /fi "WINDOWTITLE eq %instanceNum%" /t,, Hide
        
        LogToFile("Killed instance " . instanceNum . " using fallback method", "ControlPanel.txt")
    }
    
    return killed
}

checkInstance(instanceNum := "") {
    ret := WinExist(instanceNum)
    if(ret) {
        WinGet, temp_pid, PID, ahk_id %ret%
        return temp_pid
    }
    return ""
}

; Function to clean disk cache for a specific instance
cleanInstanceDisk(instanceNum) {
    global mumuFolder
    
    ; Get the mumu instance number for this script
    mumuNum := getMumuInstanceNumFromPlayerName(instanceNum)
    if (mumuNum != "") {
        ; Loop through all directories in the vms folder
        Loop, Files, %mumuFolder%\vms\*, D  ; D flag to include directories only
        {
            folder := A_LoopFileFullPath
            configFolder := folder "\configs"  ; The config folder inside each directory

            ; Check if config folder exists
            IfExist, %configFolder%
            {
                ; Define path to extra_config.json
                extraConfigFile := configFolder "\extra_config.json"

                ; Check if extra_config.json exists and read playerName
                IfExist, %extraConfigFile%
                {
                    FileRead, extraConfigContent, %extraConfigFile%
                    ; Parse the JSON for playerName
                    RegExMatch(extraConfigContent, """playerName"":\s*""(.*?)""", playerName)
                    if(playerName1 == instanceNum) {
                        ; Found the correct folder, now delete ota.vdi
                        otaPath := folder . "\ota.vdi"
                        if FileExist(otaPath) {
                            FileDelete, %otaPath%
                            if FileExist(otaPath) {
                                MsgBox, 16, Disk Cache, Failed to delete cache disk for instance %instanceNum%
                                LogToFile("Failed to delete cache disk for instance " . instanceNum, "ControlPanel.txt")
                            } else {
                                MsgBox, 64, Disk Cache, Deleted cache disk for instance %instanceNum%
                                LogToFile("Deleted cache disk for instance " . instanceNum, "ControlPanel.txt")
                            }
                        }
                        break
                    }
                }
            }
        }
    }
}

; Function to get MuMu instance number from player name
getMumuInstanceNumFromPlayerName(scriptName := "") {
    global mumuFolder

    if(scriptName == "") {
        return ""
    }

    ; Loop through all directories in the base folder
    Loop, Files, %mumuFolder%\vms\*, D  ; D flag to include directories only
    {
        folder := A_LoopFileFullPath
        configFolder := folder "\configs"  ; The config folder inside each directory

        ; Check if config folder exists
        IfExist, %configFolder%
        {
            ; Define paths to vm_config.json and extra_config.json
            extraConfigFile := configFolder "\extra_config.json"

            ; Check if extra_config.json exists and read playerName
            IfExist, %extraConfigFile%
            {
                FileRead, extraConfigContent, %extraConfigFile%
                ; Parse the JSON for playerName
                RegExMatch(extraConfigContent, """playerName"":\s*""(.*?)""", playerName)
                if(playerName1 == scriptName) {
                    RegExMatch(A_LoopFileFullPath, "[^-]+$", mumuNum)
                    return mumuNum
                }
            }
        }
    }
}

; Function to log to file
LogToFile(message, logFile) {
    logFile := A_ScriptDir . "\Logs\" . logFile
    FormatTime, readableTime, %A_Now%, MMMM dd, yyyy HH:mm:ss
    FileAppend, % "[" readableTime "] " message "`n", %logFile%
}

; Helper function to toggle an instance
toggleInstance(instanceNum, buttonVar) {
    if (checkInstance(instanceNum)) {
        killInstance(instanceNum)
        GuiControl,, %buttonVar%, %instanceNum%
    } else {
        ; Launch the instance
        Run, %mumuManagerPath% api -v %instanceNum% launch_player,, Hide
        GuiControl,, %buttonVar%, %instanceNum% *
    }
    Gosub, UpdateStatus
}

; Helper function to toggle an AHK script
toggleAHK(scriptName, buttonVar) {
    if (checkAHK(scriptName)) {
        killAHK(scriptName)
        GuiControl,, %buttonVar%, % SubStr(scriptName, 1, InStr(scriptName, ".") - 1)
    } else {
        ; Launch the script
        Run, %A_ScriptDir%\%scriptName%
        GuiControl,, %buttonVar%, % SubStr(scriptName, 1, InStr(scriptName, ".") - 1) " *"
    }
    Gosub, UpdateStatus
}

GuiClose:
ExitApp 

CheckUpdate:
    Run, https://github.com/joshptcgp/PTCGPB-Extra
return 

; Function to calculate and display stats
UpdateStats:
    ; Read reroll time from settings
    IniRead, rerollTime, Settings.ini, UserSettings, rerollTime
    if (rerollTime = "ERROR" || rerollTime = "") {
        GuiControl,, StatsText, No stats available yet
        return
    }

    ; Calculate elapsed time
    totalSeconds := Round((A_TickCount - rerollTime) / 1000)
    minutes := Floor(totalSeconds / 60)
    hours := Floor(minutes / 60)
    minutes := Mod(minutes, 60)

    ; Get total packs opened
    totalPacks := SumVariablesInJsonFile()

    ; Calculate packs per hour
    packsPerHour := Round((totalPacks / totalSeconds) * 3600, 2)

    ; Get configuration info
    IniRead, deleteMethod, Settings.ini, UserSettings, deleteMethod
    IniRead, nukeAccount, Settings.ini, UserSettings, nukeAccount
    IniRead, packMethod, Settings.ini, UserSettings, packMethod

    ; Build configuration message
    configMsg := "Type: " . deleteMethod
    if (packMethod)
        configMsg .= " (1P Method)"
    if (nukeAccount && !InStr(deleteMethod, "Inject"))
        configMsg .= " (Menu Delete)"

    ; Update stats display
    statsText := "Time: " . hours . "h " . minutes . "m`n"
    statsText .= "Instances: " . Instances . "`n"
    statsText .= "Packs: " . totalPacks . "`n"
    statsText .= "Rate: " . packsPerHour . " packs/hour`n"
    statsText .= configMsg

    GuiControl,, StatsText, %statsText%
return

RefreshStats:
    Gosub, UpdateStats
    Gosub, UpdateStatus
return

; Function to sum variables in JSON file (ported from PTCGPB.ahk)
SumVariablesInJsonFile() {
    jsonFileName := A_ScriptDir . "\json\Packs.json"
    if (jsonFileName = "") {
        return 0
    }

    ; Read the file content
    FileRead, jsonContent, %jsonFileName%
    if (jsonContent = "") {
        return 0
    }

    ; Parse the JSON and calculate the sum
    sum := 0
    ; Clean and parse JSON content
    jsonContent := StrReplace(jsonContent, "[", "") ; Remove starting bracket
    jsonContent := StrReplace(jsonContent, "]", "") ; Remove ending bracket
    Loop, Parse, jsonContent, {, }
    {
        ; Match each variable value
        if (RegExMatch(A_LoopField, """variable"":\s*(-?\d+)", match)) {
            sum += match1
        }
    }

    return sum
} 