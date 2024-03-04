#include-once

; AutoIt Version : 3.3.16.1

Func SetBitmapMask($hBitmap, $hMask)
  Local $aDim1 = _GDIPlus_ImageGetDimension($hBitmap)
  Local $aDim2 = _GDIPlus_ImageGetDimension($hMask)
  If $aDim1[0] <> $aDim2[0] Or $aDim1[1] <> $aDim1[1] Then Return SetError(1, 0, Null)
  Local $tBitmap = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $aDim1[0], $aDim1[1], BitOR($GDIP_ILMWRITE, $GDIP_ILMREAD), $GDIP_PXF32ARGB)
  Local $tMask = _GDIPlus_BitmapLockBits($hMask, 0, 0, $aDim2[0], $aDim2[1], BitOR($GDIP_ILMWRITE, $GDIP_ILMREAD), $GDIP_PXF32ARGB)
  Local $sCode = '0x8CC883F83374238B4C24048B7C24088B74240CBBFFFFFF00AD25000000FF211F090783C704E2F1C20C0056534C89C6BBFFFFFF00AD25000000FF211A09024883C204E2F05B5EC3'
  Local $dCode = Binary($sCode)
  Local $iCode = BinaryLen($dCode)
  Local $pCode = _MemVirtualAlloc(0, $iCode, $MEM_COMMIT, $PAGE_EXECUTE_READWRITE)
  Local $tCode = DllStructCreate('byte Code[' & $iCode & ']', $pCode)
  $tCode.Code = $dCode
  Local $aCall = DllCallAddress('int', DllStructGetPtr($tCode), 'int', $aDim1[0] * $aDim1[1], 'ptr', $tBitmap.Scan0, 'ptr', $tMask.Scan0)
  _MemVirtualFree($pCode, $iCode, $MEM_DECOMMIT)
  _GDIPlus_BitmapUnlockBits($hBitmap, $tBitmap)
  _GDIPlus_BitmapUnlockBits($hMask, $tMask)
  Return $aDim1
EndFunc
