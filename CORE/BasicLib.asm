

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

  mov edx, [ebp-4]
  mov eax, [ebp-8]
  mov ebx, [ebp-12]
  mov ecx, [ebp-16]
  mov edi, [ebp-20]
  mov esi, [ebp-24]
  sub ebp, 24

ret

%macro func 2
    jmp %1end
    [section .data]
    %1 times %2 dd 0
    [section .text]
    %1end:
    lea esi, [%1]
%endmacro

%macro set 4
  lea edi, [%1]
  mov ecx, %2
  mov ebx, %3
  mov eax, %4
  call addTGic
%endmacro

%macro var 2
  jmp %1end
  [section .data]
  %1 dd %2
  [section .text]
  %1end:
%endmacro

%macro sec 1
  mov edx, %1
  push edx
%endmacro

%macro run 2
    mov eax, %2
    mov [%1], eax
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