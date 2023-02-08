#SingleInstance Force

MyGui := Gui()
MyGui.Title := "Doktool-2.0"
MyGui.OnEvent("Close", (*) => ExitApp())

; Add a button to GUI to refresh the script
BtnRefresh := MyGui.Add("Button", , "Refresh")
BtnRefresh.OnEvent("Click", Refresh)

; Get all Dofus windows
DofusProcesses := WinGetList("Dofus", , ,)

; List all Dofus windows
Characters := []
Loop DofusProcesses.Length {
  ID := DofusProcesses[A_Index]
  If ((RegExMatch(WinGetProcessName("ahk_id " ID), "i)dofus", &DofusProcess))
    && ((RegExMatch(WinGetTitle("ahk_id " ID), "^[^\s]+", &CharacterName)))
    && (CharacterName[] != "Dofus")) {
    Characters.Push(CharacterName[])
    MyGui.Add("Text", "section", CharacterName[])
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