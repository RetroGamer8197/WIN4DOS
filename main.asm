[ORG 0x0000]

jmp start

start:
    mov ax, 0x0013
    int 0x10

    mov ax, 0x0A000
    mov es, ax
    mov al, 0x20
fillLoop:
    mov di, 0x0000
    call fillScreen
    inc cl
waitKey: 
    mov ah, 0x00
    int 0x16
    cmp ah, 0x1C
    jne waitKey
    mov ax, 0x0003
    int 0x10
    ret

fillScreen:
    mov [es:di], al
    inc di
    cmp di, 320*200
    jne fillScreen
    ret

times 512 - ($-$$) db 0