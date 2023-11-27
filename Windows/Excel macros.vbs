' https://support.microsoft.com/fr-fr/office/cr%C3%A9er-et-enregistrer-toutes-vos-macros-dans-un-classeur-unique-66c97ab3-11c2-44db-b021-ae005a9bc790
' %AppData%\Microsoft\Excel\XLSTART\PERSONAL.XLSB

Sub Starting_Layout()
'
' Starting_Layout Macro
' Filter and Freeze top row, Autofit columns
'
  Cells.Select
  Selection.AutoFilter
  Cells.EntireColumn.AutoFit
  Range("A2").Select
  ActiveWindow.FreezePanes = True
End Sub
