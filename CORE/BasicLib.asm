

addTGic:
  pop edx

  push eax
  push ebx
  push ecx
  push edi
  push esi

  push edx
ret

getNextLayer:
  pop edx   

  mov eax, [ebp-4]
  mov ebx, [ebp-8]
  mov ecx, [ebp-12]
  mov edi, [ebp-16]
  mov esi, [ebp-20]
  sub ebp, 20

  push edx
ret

%macro func 5
  mov eax, %1
  mov ecx, %2
  mov ebx, %3
  mov edi, %4
  mov esi, %5
  call addTGic
%endmacro

clearStack:
  pop edx
  eclop:
    pop esi
    pop edi
    pop ecx
    pop ebx
    pop eax
    cmp ecx, 0
    jne eclop
  push edx
ret

;mov eax, '1234'
;xchg al, ah
;rol eax, 4
;xchg al, ah