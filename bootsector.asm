[ORG 0x7C00]
mov ax, 0x0000
cld
mov ds, ax

jmp start

start:
    mov ax, 0x0003
    int 0x10
    mov si, bootFailMsg
    mov ax, 0xB800
    mov es, ax
    call printText
    call moveCursor
    jmp hang

hang:
    jmp hang

moveCursor:
    mov dx, 0x3D4
    mov al, 0x0F
    out dx, al

    inc dl
    mov al, bl
    out dx, al

    dec dl
    mov al, 0x0E
    out dx, al

    inc dl
    mov al, bh
    out dx, al
    ret

printText:
    mov al, [ds:si]
    mov [es:di], al
    inc si
    inc di
    inc di
    cmp al, 0x00
    jne printText
    mov bx, si
    shl bx, 1
    ret

bootFailMsg db "Invalid System Disk!", 0

times 510 - ($-$$) db 0
dw 0xAA55