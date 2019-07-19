[section .data]
  savedx dd 0
[section .code]

returnCycle:
  pop edx 
  mov [savedx], edx

  GIC:
    call getNextLayer

    QuickGIC:
      cmp eax, -1
      jle _external

    AfterExtern:
      cmp edx, 'math'
      je _math
      cmp edx, 'if'
      je _condition
      cmp edx, 'mat2'
      je _trigonometri
      cmp edx, 'bit'
      je _bitwise

    endCycle:
      cmp eax, -1
      jle _saveExternal
      cmp ecx, 0
      jne GIC

mov edx, dword [savedx]
push edx
ret
