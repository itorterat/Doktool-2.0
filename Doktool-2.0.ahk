#SingleInstance Force

MyGui := Gui()
MyGui.Title := "Doktool-2.0"
MyGui.OnEvent("Close", (*) => ExitApp())

MyGui.Show("AutoSize")