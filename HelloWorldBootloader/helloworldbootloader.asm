; Diz para o NASM usar 16 BITS e onde TUDO começa
[bits 16]
[org 0x7c00]

init: 
  mov si, msg
  mov ah, 0x0e

done:
  hlt

print_char:
  lodsb
  cmp al, 0
  je done
  int 0x10
  jmp print_char ; repete para o proximo char

msg: db "Ola Mundo Cruel!", 0

times 510-($-$$) db 0
dw 0xaa55