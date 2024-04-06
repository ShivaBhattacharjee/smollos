org 0x7C00
bits 16
%define ENDL 0x0D , 0x0A

start:
    jmp main

; prints some random stuff on screen
; ds:si points to the string to be printed
puts:
    push ax
    push si

.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp .loop

.done:
    pop ax
    pop si
    ret

main:
    ; data segments
    mov ax, 0
    mov ds, ax
    mov es, ax
    ; stack segments
    mov ss, ax
    mov sp, 0x7C00  ; stack grows downward from where we are loading the memory

    mov si, msg
    call puts

    hlt

.halt:
    jmp .halt

msg: db "hello world this is my first boot in an os made using asm x86", ENDL, 0
times 510-($-$$) db 0
dw 0AA55h
