bits 16
org 0x7C00

_start:
    ; Configurar registros de segmento
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; 1. Activar Modo Gráfico VGA 320x200 con 256 colores (Modo 0x13)
    mov ax, 0x0013
    int 0x10

    ; 2. Cargar el Kernel (15 sectores) desde el disco a 0x1000
    mov ah, 0x02
    mov al, 15
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0x00
    mov bx, 0x1000
    int 0x13
    jc error_lectura

    ; 3. Saltar a la ejecución del Kernel
    jmp 0x0000:0x1000

error_lectura:
    cli
    hlt

times 510 - ($ - $$) db 0
dw 0xAA55