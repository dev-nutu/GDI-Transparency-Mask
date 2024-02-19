#AutoIt3Wrapper_UseX64=n    ; Set this to [y] for x64

#include <GDIPlus.au3>
#include <Memory.au3>
#include <GUIConstantsEx.au3>
#include <TransparencyMask.au3>

$hMain = GUICreate('Transparency mask blending', 720, 400)
$cPic = GUICtrlCreatePic('', 0, 0, 720, 400)
GUISetState(@SW_SHOW, $hMain)

_GDIPlus_Startup()
$hDraw = _GDIPlus_BitmapCreateFromScan0(720, 400)
$hBackground = _GDIPlus_ImageLoadFromFile(@ScriptDir & '\assets\background.png')
$hTree = _GDIPlus_ImageLoadFromFile(@ScriptDir & '\assets\tree.png')
$hMask = _GDIPlus_ImageLoadFromFile(@ScriptDir & '\assets\mask.png')
$hGraphics = _GDIPlus_ImageGetGraphicsContext($hDraw)
$aDim = _GDIPlus_ImageGetDimension($hTree)

$DrawWithMask = False
AdlibRegister('Draw', 3000)
Draw()

Do
Until GUIGetMsg() =  $GUI_EVENT_CLOSE

_GDIPlus_BitmapDispose($hDraw)
_GDIPlus_ImageDispose($hBackground)
_GDIPlus_ImageDispose($hTree)
_GDIPlus_ImageDispose($hMask)
_GDIPlus_GraphicsDispose($hGraphics)
_GDIPlus_Shutdown()

Func Draw()
	_GDIPlus_GraphicsClear($hGraphics)
	_GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hBackground, 0, 0, 720, 400, 0, 0, 720, 400)
	If $DrawWithMask Then
		Local $hCloneTree = _GDIPlus_ImageClone($hTree)
		SetBitmapMask($hCloneTree, $hMask)
		_GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hCloneTree, 0, 0, $aDim[0], $aDim[1], 550, 200, $aDim[0], $aDim[1])
		_GDIPlus_ImageDispose($hCloneTree)
	Else
		_GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hTree, 0, 0, $aDim[0], $aDim[1], 550, 200, $aDim[0], $aDim[1])
	EndIf
	BitmapToCtrl($hDraw, $cPic)
	$DrawWithMask = Not $DrawWithMask
EndFunc

Func BitmapToCtrl($hBitmap, $cCtrl)
	Local Static $STM_SETIMAGE = 0x0172
	$hHBITMAP = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
	_WinAPI_DeleteObject(GUICtrlSendMsg($cCtrl, $STM_SETIMAGE, $IMAGE_BITMAP, $hHBITMAP))
	_WinAPI_DeleteObject($hHBITMAP)
EndFunc
