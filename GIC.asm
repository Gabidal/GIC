%include 'GInclude'

[section .text]
global _start
_start:
mov ebp, esp

;_-_-_-_-_-_-_-_-_-_-_- 
    var saltProsent, 23
    var sugarProsent, 32

    run salt, 5
    run sugar, 10

    func salt, 1
      sec 'math'
      set saltProsent,'=', 0, -1

    func sugar, 1
      sec 'math'
      set sugarProsent,'=', 0, -1

;_-_-_-_-_-_-_-_-_-_-_-
call returnCycle
endGIC:

mov eax, dword [saltProsent]
mov ebx, dword [sugarProsent]


call clearStack

mov ebp, esp
mov eax, 1
mov ebx, 0
int 80h