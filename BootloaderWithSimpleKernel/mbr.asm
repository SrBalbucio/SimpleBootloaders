; Diz para o NASM usar 16 BITS 
[bits 16]
[org 0x7c00]

; Carrega o kernel para
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl

; setup stack
mov bp, 0x9000
mov sp, bp

call load_kernel
call switch_32bit

jmp $

%include "disk.asm"
%include "gdt.asm"
%include "32bit.asm"

[bits 16]
load_kernel:
    mov bx, KERNEL_OFFSET
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

; Diz para o NASM usar 32 BITS
[bits 32]
BEGIN_32BIT:
    call KERNEL_OFFSET ; Da o controle para o kernel
    jmp $ ; Faz um loop caso o Kernel retorne

BOOT_DRIVE db 0

times 510 - ($-$$) db 0

; magic number
dw 0xaa55