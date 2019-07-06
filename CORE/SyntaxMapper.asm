[section .data]
  variables times 1024 dw 0
[section .code]

returnCycle:
  pop edx 

  GIC:
    call getNextLayer 
    QuickGIC:
      cmp ecx, '[]'
      je _heap
      cmp edi, -1
      jle _external
    AfterExtern:
      cmp ecx, '+'
      je _add         
      cmp ecx, '-'
      je _sub
      cmp ecx, '*'
      je _mul
      cmp ecx, '/'
      je _div
      cmp ecx, '=='
      je _if
      cmp ecx, '/\'
      je _hypotenuse
      cmp ecx, 'sin'
      je _sin
      cmp ecx, 'cos'
      je _cos
      cmp ecx, 'tan'
      je _tan
      cmp ecx, 'asin'
      je _asin
      cmp ecx, 'acos'
      je _acos
      cmp ecx, 'atan'
      je _atan
      cmp ecx, '@'
      je _atan2
      cmp ecx, '2deg'
      je _toDeg
      cmp ecx, '2rad'
      je _toRad




    endCycle:
      cmp edi, -1
      jle _saveExternal
      cmp edi, 0
      jg _globalize


      cmp esi, 1  
      je GIC      

jmp endGIC
