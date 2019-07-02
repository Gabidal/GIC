[section .data]
  save dd 0
  original dd 0
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
  