[section .data]
  sect dd 0
  savedx dd 0
  variables times 1024 dw 0
[section .code]

returnCycle:
  pop edx 
  mov [savedx], edx

  GIC:
    call getNextLayer 

    QuickGIC:
      cmp ecx, '[]'
      je _heap
      cmp edi, -1
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
      cmp edi, -1
      jle _saveExternal
      cmp edi, 0
      jg _globalize
      cmp esi, 0 
      jne GIC      

mov edx, dword [savedx]
push edx
ret
