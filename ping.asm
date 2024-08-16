%define WIDTH  	320
%define HEIGHT 	200
%define ROW		 	100		; Y coord
%define COL			160		; X coord
%define BALL_POSX		50
%define BALL_POSY		70
%define BALL_WIDTH	05
%define BALL_HEIGHT	05

	mov ah, 00h					; Set VGA mode 320x 200 256 colors
	mov al, 13h
	int 0x10

	; Draw a pixel in the middle of the screen
	;

	mov ax, 0xA000				; Set offset base to access video memory
	mov es, ax					; This address cannot be loaded directly by ax, so...
	mov dl, 0x0B				; Color
	mov di, WIDTH * ROW		; Define the Y coord based using WIDTH as base
	add di, COL					; Define X coord as an offset, 
	mov BYTE [es:di], dl		; Put the pixel

	; Draw a rectangle
	call draw_ball

	; Padding and magic BIOS number
	;

draw_ball:
	init_y:
		mov di, WIDTH * BALL_POSY + BALL_POSX
		mov dl, 0x0B				; Color
		mov si, 0
	draw_ball_y:
		mov BYTE [es:di], dl
		add di, WIDTH
		cmp si, BALL_HEIGHT
		inc si
		jb draw_ball_y
	init_x:
		mov di, WIDTH * BALL_POSY + BALL_POSX
		mov si, 0
	draw_ball_x:
		mov BYTE [es:di], dl
		inc di
		cmp si, BALL_WIDTH
		inc si
		jb draw_ball_x 
	init_xy:
		mov dl, 0x0C
		mov di, WIDTH * BALL_POSY + BALL_POSX + (WIDTH * BALL_HEIGHT)
		mov si, 0
	draw_ball_xy:
		mov BYTE [es:di], dl
		inc di
		cmp si, BALL_WIDTH
		inc si
		jb draw_ball_xy
	init_yy:
		mov dl, 0x0E
		mov di, WIDTH * BALL_POSY + BALL_POSX + (BALL_WIDTH)
		mov si, 0
	draw_ball_yy:
		mov BYTE [es:di], dl
		add di, WIDTH
		cmp si, BALL_HEIGHT
		inc si
		jb draw_ball_yy
ret

	jmp $							; jump to the current address (same as loop: jmp loop

	times 510 - ($-$$) db 0
	dw 0xaa55
