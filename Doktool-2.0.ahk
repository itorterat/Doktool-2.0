#SingleInstance Force

; Create the GUI
MyGui := Gui()
MyGui.Title := "Doktool-2.0"
MyGui.OnEvent("Close", (*) => ExitApp())

; Add a button to GUI to refresh the script
BtnRefresh := MyGui.Add("Button", , "Refresh")
BtnRefresh.OnEvent("Click", Refresh)

; Get all Dofus windows
DofusProcesses := WinGetList("Dofus", , ,)

; Define a list of hotkeys to use ("Alt+A",...)
Hotkeys := ["!a", "!z", "!e", "!r", "!q", "!s", "!d", "!f"]

; List all Dofus windows
; And assign a hotkey to each window to switch to it
Characters := []
Loop DofusProcesses.Length {
  ID := DofusProcesses[A_Index]
  If ((RegExMatch(WinGetProcessName("ahk_id " ID), "i)dofus", &DofusProcess))
    && ((RegExMatch(WinGetTitle("ahk_id " ID), "^[^\s]+", &CharacterName)))
    && (CharacterName[] != "Dofus")) {
    Characters.Push(CharacterName[])
    MyGui.Add("Text", "section", CharacterName[])
    MyGui.Add("Hotkey", "+disabled", Hotkeys[1])
    Hotkey(Hotkeys[1], SwitchCharacter.Bind(CharacterName[]), "s")
    Hotkeys.RemoveAt(1)
  }
}

; Display the GUI
MyGui.Show("AutoSize")

; Refresh the script
Refresh(*)
{
  Run(A_ScriptFullPath)
  ExitApp
}

; Switch to window assigned to character
SwitchCharacter(Character, *) {
  WinActivate Character
}