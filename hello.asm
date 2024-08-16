
mov ah, 0x0e				; display char
mov al, "H"					; char to be displayed
int 0x10						; int call, BIOS video service
mov al, "E"					;
int 0x10						;
mov al, "L"					;
int 0x10						;
mov al, "L"					;
int 0x10						;
mov al, "O"					;
int 0x10						;
mov al, "!"					;
int 0x10						;
jmp $							; jump to the current address (same as loop: jmp loop

;
; Padding and magic BIOS number

times 510 - ($-$$) db 0
dw 0xaa55