#include <Array.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

$commands = FileReadToArray ( "commandList.txt" )
_ArrayConcatenate ($commands, FileReadToArray ( "additonalCommandList.txt" ))
$commands = _ArrayUnique($commands)
_ArraySort($commands)

$case = FileReadToArray ( "caseList.txt" )
_ArrayConcatenate ($case, FileReadToArray ( "additonalCommandList.txt" ))
$exclude = FileReadToArray ( "literalList.txt" )
_ArrayConcatenate ($exclude, FileReadToArray ( "keywordList.txt" ))
Local $hFileOut = FileOpen("commandOut.txt", $FO_OVERWRITE )
Local $hFileOutErr = FileOpen("err.txt", $FO_OVERWRITE )
Local $hFileLines = FileOpen("lines.txt", $FO_OVERWRITE )
Dim $outCommands[0]

For $cmd In $commands
   Local $excludeIndex = _ArraySearch($exclude, $cmd, 0, 0, 0, 0, 1, 2)
   if $excludeIndex <> -1 Then ContinueLoop

   Local $iIndex = _ArraySearch($case, $cmd, 0, 0, 0, 0, 1, 2)
   if $iIndex == -1 Then
	  FileWriteLine($hFileOutErr, $cmd)
   Else
	  FileWriteLine($hFileOut, $case[$iIndex])
	  _ArrayAdd($outCommands, $case[$iIndex])
   EndIf
Next

$curLine = "        '"

For $cmd In $outCommands
   if StringLen($curLine&$cmd&" ") > 107  Then
	  $curLine &= "' +"&@LF
	  FileWriteLine($hFileLines, $curLine)
	  $curLine = "        '"&$cmd&" "
   Else
	  $curLine &= $cmd&" "
   EndIf
Next

