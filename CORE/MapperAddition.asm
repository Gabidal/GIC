_math:
  cmp ecx, '+'
  je _add         
  cmp ecx, '-'
  je _sub
  cmp ecx, '*'
  je _mul
  cmp ecx, '/'
  je _div
_condition:
  cmp ecx, '=='
  je _if
  cmp ecx, '!='
  je _notIf
  cmp ecx, 'jmp'
  je _jmp
_trigonometri:
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
  cmp ecx, 'atn2'
  je _atan2
  cmp ecx, '2deg'
  je _toDeg
  cmp ecx, '2rad'
  je _toRad
_bitwise:
  cmp ecx, 'nand'
  je _nand
  cmp ecx, 'and'
  je _and
  cmp ecx, 'xor'
  je _xor
  cmp ecx, 'or'
  je _or
  cmp ecx, 'nor'
  je _nor
  cmp ecx, 'nxor'
  je _nxor

jmp endCycle