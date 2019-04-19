; Arkin Modi, 400142497, modia1
; SFWRENG 2XA3 Final Project
; Last Modified: Dec 3 2018

%include "asm_io.inc"

SECTION .data
error1: db "incorrect number of command line arguments, only 1 input between 2 and 9",10,0
error2: db "incorrect command line argument, should be between 2 and 9",10,0
initconfig: db "          initial configuration",10,0
finconfig: db "           final configuration",10,0
base: db "         XXXXXXXXXXXXXXXXXXXXXXX",10,0

SECTION .bss
peg: resd 9
numDISK: resd 1

SECTION .text
	global asm_main

showp:
	enter 0,0	; setup routine
	pusha		; save all registers

	mov edx, [ebp+8]	; edx = address of peg, i.e. peg[0]
	mov ecx, dword [ebp+12]	; ecx = # of disks 
	
	mov eax, 4
	mov ebx, 1

    add_loop:			; this is because mul was giving me seg fault
	cmp ebx, ecx
	je done
	add eax, 4
	inc ebx
	jmp add_loop

    done:
	add edx, eax

    LOOP:
	call print_nl
	sub edx, 4
	mov ebx, 20		; 9spaces + 11X's - peg[i]  = spaces
	sub ebx, dword [edx]	; ebx = number of spaces needed

    SPACES:
	cmp dword [edx], 0	; checks if next entry is 0
	je showp_end

    SPACES_1:
	cmp ebx, 0
	je CIRCLES_1
	mov al, ' '	
	call print_char
	dec ebx
	jmp SPACES_1

    CIRCLES_1:
	cmp ebx, dword [edx]
	je DIVIDE
	mov al, 'o'
	call print_char
	inc ebx
	jmp CIRCLES_1

    DIVIDE:
	mov al, '|'
	call print_char
	mov ebx, 0

    CIRCLES_2:
	cmp ebx, dword [edx]
        je LOOP
        mov al, 'o'
        call print_char
        inc ebx
        jmp CIRCLES_2

    showp_end:
	mov eax, base
	call print_string
	call read_char
	popa
	leave
	ret

swap:
	enter 0,0	; setup routine
	pusha		; save all registers

	mov ecx, [ebp+8]
	mov ebx, dword [ecx]
	mov eax, dword [ecx+4]
	mov dword [ecx], eax
	mov dword [ecx+4], ebx	

	popa
	leave
	ret

sorthem:
	enter 0,0	; setup routine
	pusha		; save all registers

	mov edx, [ebp+8]	; edx = address of peg, i.e. peg[0]
	mov ecx, dword [ebp+12]	; ecx = # of disks

	; base case
	cmp ecx, 1
	je sorthem_end

	; recursive call	
	add edx, 4
	dec ecx
	push ecx
	push edx
	call sorthem
	pop eax
	pop eax
	sub edx, 4

	mov ebx, 0	; counter

	; sorts the current first entry
    LOOP_SORT:
	cmp ebx, ecx
	je sorthem_end
	inc ebx

	mov eax, dword [edx]
	cmp eax, dword [edx+4]
	jb SWAP
	
    L2:
	add edx, 4
	jmp LOOP_SORT

    SWAP:
	push edx
	call swap
	pop eax
	jmp DISPLAY

    DISPLAY:
	push dword [numDISK]
	push peg
	call showp
	pop eax
	pop eax
	jmp L2

    sorthem_end:
	popa
	leave
	ret	

asm_main:
	enter 0,0	; setup routine
	pusha		; save all registers


	; check number of command line arguments
	mov eax, dword [ebp+8]
	cmp eax, dword 2
	jne ERROR1

	; check if 2 <= input >= 9
	mov ebx, dword [ebp+12]		; address of argv[]
	mov eax, dword [ebx+4]		; argv[1]
	mov bl, byte [eax]

    test1:				; checks if <2
	cmp bl, '2'
	jb ERROR2

    test2:				; checks if >9
	cmp bl, '9'
	ja ERROR2

	sub bl, '0'			; converts to unsigned int
	mov ecx, 0
	mov cl, bl			; ecx = # of disks
	mov [numDISK], ecx

	mov bl, byte [eax+1]		; checks if input is 1 digit
   	cmp bl, byte 0
   	jne ERROR2	

	; create a random configuration for array
	mov ebx, peg
	push ecx	; push # of disk
	push ebx	; push array
	call rconf

	; print "initial configuration"
	mov eax, initconfig
	call print_nl
	call print_string
	call showp
	call showp	; the example did this

	call sorthem

	; print "final configuration"
	mov eax, finconfig
	call print_nl
	call print_string
	call showp

	jmp asm_main_end

    ERROR1:
	mov eax, error1
	call print_string
	jmp error_end

    ERROR2:
	mov eax, error2
	call print_string
	jmp error_end	

    asm_main_end:
	pop eax
	pop eax
    error_end:
	popa			; restore all registers
	leave			; end routine
	ret			; return
