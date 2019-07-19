[section .data]
  save dd 0
  original dd 0
  hypo times 256 dq 0
  deg dw 57.2957795
[section .code]

_set:
  mov [edi], ebx
jmp endCycle

_add:
  push eax
  mov eax, dword [edi]
  add eax, ebx
  mov [edi], eax
  pop eax
jmp endCycle

_sub:
  push eax
  mov eax, dword [edi]
  sub eax, ebx
  mov [edi], eax
  pop eax
jmp endCycle

_mul:
  push eax
  mov eax, dword [edi]
  mul ebx
  mov [edi], eax
  pop eax
jmp endCycle

_div:
  push eax
  mov eax, dword [edi]
  div ebx
  mov [edi], eax
  pop eax
jmp endCycle

_if:
  cmp eax, ebx
  je _true
jmp _false

_notIf:
  cmp eax, ebx
  jne _true
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

_external:
  add eax, 1
  add esi, eax
  mov ebx, [esi]
jmp AfterExtern

_saveExternal:
  add esi, eax
  push edi
  mov edi, [edi]
  mov [esi+1], edi
  pop edi
  mov eax, 0
jmp endCycle

_jmp:
  push eax
  mov eax, ebx
  mov ebx, 20
  mul ebx
  add ebp, eax
  pop eax
jmp endCycle

;_-_-_-_-_-_-_-_-;

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
  
_nand:
  and eax, ebx
  not eax
jmp endCycle

_and:
  and eax, ebx
jmp endCycle

_xor:
  xor eax, ebx
jmp endCycle

_nor:
  or eax, ebx
  not eax
jmp endCycle

_nxor:
  xor eax, ebx
  not eax
jmp endCycle

_or:
  or eax, ebx
jmp endCycle
