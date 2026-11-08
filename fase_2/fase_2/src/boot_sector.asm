bits 16
org 0x7C00

inicio:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Resetear el controlador de disquete (int 0x13, ah=0x00)
    mov ah, 0x00
    mov dl, 0x00
    int 0x13

    ; Cargar la segunda etapa desde el disco (int 0x13, ah=0x02)
    mov ah, 0x02        ; Funcion: Leer sectores
    mov al, 2           ; Leer 2 sectores
    mov ch, 0           ; Cilindro 0
    mov cl, 2           ; Empezar desde el Sector 2
    mov dh, 0           ; Cabeza 0
    mov dl, 0x00        ; Dispositivo (Floppy A:)
    mov bx, 0x7E00      ; Cargar en la direccion de memoria 0x7E00
    int 0x13
    jc error_lectura

    ; Transferir el control a la Segunda Etapa
    jmp 0x0000:0x7E00

error_lectura:
    mov si, msg_error
imprimir:
    lodsb
    or al, al
    jz detener
    mov ah, 0x0E
    int 0x10
    jmp imprimir

detener:
    cli
    hlt

msg_error db "Error de lectura en el disco!", 0

times 510 - ($ - $$) db 0
dw 0xAA55qemu-system-i386 -drive file=build/boot_f2.bin,format=raw,if=floppy