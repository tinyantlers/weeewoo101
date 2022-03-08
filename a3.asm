

; Program Description:This assignment will show the use of loops and
; conditional code created from jump instructions to work
; with arrays.

; *****************************************************************
;  Static Data Declarations (initialized)
section .data

SERVICE_EXIT equ 60
SERVICE_WRITE equ 1
EXIT_SUCCESS equ 0
STANDARD_OUT equ 1
NEWLINE equ 10

programDone db "Program Done.", NEWLINE 
stringLength dq 14

;LEN equ 50

list1 dd 2078, 3854, 6593, 947, 5252, 1190, 716, 3587, 8014, 9563
	dd 9821, 3195, 1051, 6454, 5752, 980, 9015, 2478, 5624, 7251
	dd 2936, 1073, 1731, 5376, 4452, 792, 2375, 2542, 5666, 2228
	dd 454, 2379, 6066, 3340, 2631, 9138, 3530, 7528, 7152, 1551
	dd 9537, 9590, 2168, 9647, 5362, 2728, 5939, 4620, 1828, 5736

list2 dd 5087, 6614, 6035, 6573, 6287, 5624, 4240, 3198, 5162, 6972
	dd 6219, 1331, 1039, 23, 4540, 2950, 2758, 3243, 1229, 8402
	dd 8522, 4559, 1704, 4160, 6746, 5289, 2430, 9660, 702, 9609
	dd 8673, 5012, 2340, 1477, 2878, 2331, 3652, 2623, 4679, 6041
	dd 4160, 2310, 5232, 4158, 5419, 2158, 380, 5383, 4140, 1874
	
len dd 50
min dd 0
max dd 0
avg dd 0 
sum dq 0
odd db 0
even db 0 



; *****************************************************************
;  Static Data Declarations (uninitialized)
;  Uninitialized Static Data Declarations.
;	Place data declarations for uninitialized data here...
;	(i.e., large arrays that are not initialized)
section	.bss

list3 resd 50


;*****************************************************************
section .text
global _start
_start:

	mov ecx, dword[len]		; lp counter
	mov eax, dword[list1]


	mov rsi, 0				; index
	mov r8d, 2 				; divisor

; find sum loop 
; add same elements at i of lists and store into list3
	sumLoop:
		mov rax, 0
		mov eax, dword[list1+rsi*4]		; traverse by adding index and mult by offset
		add eax, dword[list2+rsi*4] 
		; dec until rcx is reduced to 0, lp breaks 
		div r8d 		; 2 is r8, divs eax automatically
		mov rdx, 0
		mov dword[list3+rsi*4], eax

;set min and max values
		cmp rsi, 0
		jne dontSet
		mov dword[min], eax
		mov dword[max], eax
		dontSet:

;get min 
		cmp eax, dword[min]
		jge notMin
		mov dword[min], eax
		notMin:

;get max 
		cmp eax, dword[max]
		jle notMax
		mov dword[max], eax
		notMax:

;get even / odd
		mov r11d, eax
		div r8d
		cmp edx, 0
		jne getOdd
		inc byte[even]
		jmp isEven
		getOdd:
		inc byte[odd]
		isEven:
		mov rax, 0
		mov rdx, 0
		mov eax, r11d

;get sum
		movsxd rax, dword[list3+rsi*4]
		add qword[sum], rax 
		inc rsi


		dec rcx
		cmp rcx, 0
		jne sumLoop

;	getAvg:
		mov rax, 0
		mov rdx, 0
		mov eax, dword[sum]			; eax = sum
		div dword[len]				; sum/length to get average
		mov dword[avg], eax			; Set avg




endProgram:
; 	Outputs "Program Done." to the console
	mov rax, SERVICE_WRITE
	mov rdi, STANDARD_OUT
	mov rsi, programDone
	mov rdx, qword[stringLength]
	syscall

	; 	Ends program with success return value
	mov rax, SERVICE_EXIT
	mov rdi, EXIT_SUCCESS
	syscall
