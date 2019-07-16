  
%include 'GInclude'

[section .text]
global _start
_start:
mov ebp, esp

;_-_-_-_-_-_-_-_-_-_-_- 
  func 0, '+', 0, 1, 1                 ;int i = 0
  func 1, '+', 0, -1, 1                ;int i + 1
  func 100, '!=', 0, -1, 1             ;if i < 100
    func 1010, 'nand', 0, -1, 1        ;i = NAND(i)
    func 0, '==', 0, -1, 1              ;if else i == 0
      func 1010, 'and', 0, -1, 0       ;then i = AND(i)
    func 0, '==', 0, -1, 1             ;else if i == 0
      func 1010, 'xor', 0, -1, 0       ;then i = XOR(i) 
    func 10101, 'or', 0, -1, 0         ;else i = OR(i)
    func 0, '==', 0, -1, 1             ;else if i == 0
      func 1010, 'nxor', 0, -1, 0      ;then i = NXOR(i) 
    func 10101, 'nor', 0, -1, 0        ;else i = NOR(i)

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