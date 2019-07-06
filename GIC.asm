  
%include 'GInclude'

[section .text]
global _start
_start:
mov ebp, esp
;_-_-_-_-_-_-_-_-_-_-_-
func 0.80901699437, '@', 0.58778525229, 1, 1
func 0.0, '2deg', 0.0, -1, 0
;_-_-_-_-_-_-_-_-_-_-_-
call returnCycle   
endGIC:


call clearStack

mov ebp, esp
mov eax, 1
mov ebx, 0
int 80h

[section .bss]
    mainHeap resb 1073741824