#SingleInstance Force
SetTitleMatchMode "RegEx"

; Create the GUI
MyGui := Gui()
MyGui.Title := "Doktool-2.0"
MyGui.OnEvent("Close", (*) => ExitApp())

; Add a button to GUI to refresh the script
BtnRefresh := MyGui.Add("Button", , "Refresh")
BtnRefresh.OnEvent("Click", Refresh)

; Read a setting file to use constant variables in script
settings := Map()
Loop read, "resources/settings2.0.txt" {
  Loop parse, A_LoopReadLine, A_Tab {
    str := StrSplit(A_LoopField, ":")
    settings[str[1]] := str[2]
  }
}

; Get all Dofus windows
DofusProcesses := WinGetList("ahk_exe i)dofus", , ,)

; Define a list of hotkeys to use ("Alt+A",...)
Hotkeys := ["!a", "!z", "!e", "!r", "!q", "!s", "!d", "!f"]

; List all Dofus windows
; And assign a hotkey to each window to switch to it
Characters := []
Loop DofusProcesses.Length {
  ID := DofusProcesses[A_Index]
  If (((RegExMatch(WinGetTitle("ahk_id " ID), "^[^\s]+", &CharacterName)))
    && (CharacterName[] != "Dofus")) {
    Characters.Push(CharacterName[])
    MyGui.Add("Text", "section", CharacterName[])
    MyGui.Add("Hotkey", "+disabled", Hotkeys[1])
    Hotkey(Hotkeys[1], SwitchCharacter.Bind(CharacterName[]), "s")  ; "s" to always enable hotkey
    Hotkeys.RemoveAt(1)
  }
}

; Display the GUI
MyGui.Show("AutoSize")

; Infinite loop to run script and functions indefinitely
Loop {
  if WinActive("ahk_exe i)dofus") {
    Suspend False  ; Enable hotkeys only if a dofus window is active  ; Enable hotkeys only if a dofus window is active
    FightMode
  }
  else {
    Suspend True
  }
}

; Click on same spot on each window
ClickAllWindows(xpos, ypos, *) {
  Loop Characters.Length {
    ControlClick("x" xpos " y" ypos, Characters[A_Index])
    Sleep(Random(150, 400))
  }
}

; Check if current window is in fight to enable FightSwitchCharacter
; (To avoid looking for the character who has to play all the time, if there is no fight)
FightMode(*) {
  try {
    If ImageSearch(&FoundX, &FoundY,
      settings["buttonGiveUpX1"], settings["buttonGiveUpY1"],
      settings["buttonGiveUpX2"], settings["buttonGiveUpY2"],
      "*30 resources\GiveUp.png") {
      FightSwitchCharacter
    }
  }
  catch {
    MsgBox "GiveUp: wrong or missing image."
    ExitApp
  }
  Sleep(250)
}

; Loop through characters to auto switch to character window which must play
FightSwitchCharacter(*) {
  Loop Characters.Length {
    try {
      If ImageSearch(&FoundX, &FoundY,
        settings["illustrationStartTurnX1"], settings["illustrationStartTurnY1"],
        settings["illustrationStartTurnX2"], settings["illustrationStartTurnY2"],
        "*30 resources\characters\" . Characters[A_Index] . ".png") {
        SwitchCharacter(Characters[A_Index])
      }
    }
    catch {
      MsgBox Characters[A_Index] . ": wrong or missing image."
      ExitApp
    }
  }
}

; Refresh the script
Refresh(*) {
  Run(A_ScriptFullPath)
  ExitApp
}

; Switch to window assigned to character
SwitchCharacter(Character, *) {
  WinActivate Character
}

; Thumb mouse button 1 to click over all windows
Xbutton1:: {
  MouseGetPos(&xpos, &ypos)
  ClickAllWindows(xpos, ypos)
}

; Up arrow to click on topMap(x,y)
Up:: {
  ClickAllWindows(settings["topMapX"], settings["topMapY"])
}

; Down arrow to click on bottomMap(x,y)
Down:: {
  ClickAllWindows(settings["bottomMapX"], settings["bottomMapY"])
}

; Left arrow to click on leftMap(x,y)
Left:: {
  ClickAllWindows(settings["leftMapX"], settings["leftMapY"])
}

; Right arrow to click on rightMap(x,y)
Right:: {
  ClickAllWindows(settings["rightMapX"], settings["rightMapY"])
}

; F2 to click on notification (join party, fight, ...)
F2:: {
  ClickAllWindows(settings["notifX"], settings["notifY"])
}