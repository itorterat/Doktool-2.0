#SingleInstance Force

MyGui := Gui()
MyGui.Title := "Doktool-2.0"
MyGui.OnEvent("Close", (*) => ExitApp())

; Add a button to GUI to refresh the script
BtnRefresh := MyGui.Add("Button", , "Refresh")
BtnRefresh.OnEvent("Click", Refresh)

MyGui.Show("AutoSize")

; Refresh the script
Refresh(*)
{
  Run(A_ScriptFullPath)
  ExitApp
}