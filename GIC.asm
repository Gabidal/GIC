  
%include 'GInclude'

[section .text]
global _start
_start:
mov ebp, esp

;_-_-_-_-_-_-_-_-_-_-_- 
  sec 'mat2'
  func 2.0, '/\', 5.0, 0, 1
  sec 'math'
  func 3, '+', 3, 0, 0
;_-_-_-_-_-_-_-_-_-_-_-
call returnCycle   
endGIC:


call clearStack

mov esp, ebp
mov eax, 1
mov ebx, 0
int 80h

[section .bss]
    mainHeap resb 1073741824