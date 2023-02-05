; Diz para o NASM que estamos usando 16BITS e diz onde começar
[bits 16]
[org 0x7c00]

boot:
    mov si, message
    mov ah, 0x0e

.loop:
    lodsb
    cmp al, 0
    je halt
    int 0x10
    jmp .loop   ; cria um loop

halt:
    hlt

message:
    db "Iniciado!", 0

times 510-($-$$) db 0
dw 0xAA55