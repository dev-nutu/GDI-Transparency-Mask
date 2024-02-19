# GDI+ Transparency Mask

This function can be used to add a transparency mask to an image. The code to blend the original image and the transparency mask it's written in FASM (for speed improvement) but it can be used in AutoIt (both x86/x64) with GDI+ functions.

![GDI+ Transparency Mask](/assets/transparency-mask.png)[^1]

Function will take as parameters two bitmap handles (original image and mask) and returns an array that will contains the width and height of the image. When the function returns the original bitmap will be blended with the transparency mask.

Assembly code called inside the function:
```
mov ax, cs
cmp ax, 33h
je x64

use32
mov ecx, [esp+4]
mov edi, [esp+8]
mov esi, [esp+12]
mov ebx, 0xffffff
next32:
  lodsd
  and eax, 0xff000000
  and [edi], ebx
  or [edi], eax
  add edi, 4
  loop next32
ret 12


use64
x64:
push rsi
push rbx
mov rsi, r8
mov ebx, 0xffffff
next64:
  lodsd
  and eax, 0xff000000
  and [rdx], ebx
  or [rdx], eax
  add rdx, 4
  loop next64
pop rbx
pop rsi
ret
```

> [!IMPORTANT]
> Include GDIPlus.au3 and Memory.au3 before including TransparencyMask.au3 in your project.

> [!IMPORTANT]
> Call _GDIPlus_Startup() before using this function and _GDIPlus_Shutdown() when you don't need to call this function anymore or any other GDI+ functions.

> [!WARNING]
> Both images (original image and mask) must have the same width and height otherwise the function will return @error = 1.

> [!TIP]
> If you have questions or if you need support for this function please visit AutoIt forum and post your questions [in this thread](https://www.autoitscript.com/forum/topic/211109-gdi-transparency-mask).

[^1]: Credits for the images used in my example goes to [itch.io](https://itch.io/).
