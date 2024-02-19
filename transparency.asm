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
