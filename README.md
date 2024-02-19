# GDI+ Transparency Mask

This function can be used to add a transparency mask to an image. The code to blend the original image and the transparency mask it's written in FASM (for speed improvement) but it can be used in AutoIt (both x86/x64) with GDI+ functions.

![GDI+ Transparency Mask](/assets/transparency-mask.png)[^1]

> [!IMPORTANT]
> Include GDIPlus.au3 and Memory.au3 before including TransparencyMask.au3 in your project.

> [!IMPORTANT]
> Call _GDIPlus_Startup() before using this function and _GDIPlus_Shutdown() when you don't need to call this function anymore or any other GDI+ functions.

> [!TIP]
> If you have questions or if you need support for this function please visit AutoIt forum and post your questions [in this thread](https://www.autoitscript.com/forum/topic/211109-gdi-transparency-mask).

[^1]: Credits for the images used in my example goes to [itch.io](https://itch.io/).
