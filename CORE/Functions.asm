[section .data]
  save dd 0
  original dd 0
  hypo times 256 dq 0
  deg dw 57.2957795
[section .code]

_add:
  add eax, ebx
jmp endCycle

_sub:
  sub eax, ebx
jmp endCycle

_mul:
  mul ebx
jmp endCycle

_div:
  div ebx
jmp endCycle

_if:
  cmp eax, ebx
  je _true
jmp _false

_true:
  call getNextLayer
jmp QuickGIC

_false:
  cmp esi, 0
  jg _for
  call getNextLayer
  call getNextLayer
jmp QuickGIC

_for:
  mov [save], esi
  _flop:
    call getNextLayer
    mov esi, dword [save]
    add esi, -1             ;add is faster than sub XD
    mov [save], esi
    cmp esi, 0
    jnle _flop
  call getNextLayer
jmp QuickGIC


_globalize:
  mov variables[edi-1], eax
  mov edi, 0
jmp endCycle

_external:
  mov ebx, variables[edi+1]
jmp AfterExtern

_saveExternal:
  mov variables[edi+1], eax
  mov edi, 0
jmp endCycle

_heap:
  cmp edi, 0
  jl _getHeap
  jg _setHeap
  je _createHeap

_getHeap:
  mov [save], esi
  mov [original], edi
  mov esi, ebx
  mov edi, 4096
  mul edi
  mov edi, eax
  lea edi, mainHeap[edi]
  mov eax, dword [edi+esi]
  mov edi, dword [original]
  mov esi, dword [save]
jmp endCycle

_setHeap:
  mov [save], esi
  mov [original], edi
  mov esi, ebx
  mov edi, 4096
  mul edi
  mov edi, eax
  lea edi, mainHeap[edi]
  push edi
  mov edi, dword [original]
  mov eax, dword variables[edi-1]
  pop edi
  mov [edi+esi], eax
  mov edi, [original]
  mov esi, [save]
jmp endCycle

_createHeap:
  jmp endCycle

_hypotenuse:
  push eax
  push ebx
  fld dword [esp+4]
  fmul st0, st0
  fld dword [esp]
  fmul st0, st0
  faddp
  fsqrt
  fstp dword [esp+4]
  pop ebx
  pop eax
jmp endCycle

_sin:
  push ebx
  fld dword [esp]
  fsin
  fstp dword [esp]
  pop eax
jmp endCycle

_cos:
  push ebx
  fld dword [esp]
  fcos
  fstp dword [esp]
  pop eax
jmp endCycle

_tan:
  push ebx
  fld dword [esp]
  ftan
  fstp dword [esp]
  pop eax
jmp endCycle

_asin:
  push ebx
  fld  dword [esp]
  fmul st0, st0
  fld  st0
  fld1
  fsubrp st1, st0
  fdivp st1, st0
  fsqrt
  fld1
  fpatan
  fstp dword [esp]
  pop eax
jmp endCycle

_acos:
  push ebx
  fld  dword [esp]
  fmul st0, st0
  fld  st0
  fld1
  fsubrp st1, st0
  fxch st1
  fdivp st1, st0
  fsqrt
  fld1
  fpatan
  fstp dword [esp]
  pop eax
jmp endCycle

_atan:
  push ebx
  fld dword [esp]
  fld1
  fpatan
  fstp dword [esp]
  pop eax
jmp endCycle

_atan2:
  push eax        ;x
  push ebx        ;y
  fld dword [esp]
  fld dword [esp+4]
  fpatan
  fstp dword [esp+4]
  pop ebx
  pop eax
jmp endCycle

_toDeg:
  mov eax, ebx
  push eax
  fld dword [deg]
  fld dword [esp]
  fmulp
  fstp dword [esp]
  pop ebx
  pop eax
jmp endCycle

_toRad:
  mov eax, ebx
  push eax
  fld dword [deg]
  fld dword [esp]
  fdivp
  fstp dword [esp]
  pop ebx
  pop eax
jmp endCycle
  
