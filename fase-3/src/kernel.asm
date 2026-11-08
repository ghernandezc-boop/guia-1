bits 16
org 0x1000

kernel_main:
    ; Configurar ES apuntando al Framebuffer VGA (0xA000)
    mov ax, 0xA000
    mov es, ax
    xor di, di

    ; 1. Fondo Azul Oscuro (Color 1 - 320x200 = 64000 pixels)
    mov al, 1
    mov cx, 64000
    rep stosb

    ; 2. Marco Exterior Blanco (Color 15)
    ; Horizontales
    mov cx, 300
.marco_h:
    mov bx, cx
    add bx, 9
    mov byte [es:10*320 + bx], 15
    mov byte [es:189*320 + bx], 15
    loop .marco_h

    ; Verticales
    mov cx, 180
.marco_v:
    mov bx, cx
    add bx, 9
    imul bx, 320
    mov byte [es:bx + 10], 15
    mov byte [es:bx + 309], 15
    loop .marco_v

    ; 3. Logotipo Central Rojo (Color 4: X=100 a 220, Y=60 a 140)
    mov dx, 60
.logo_y:
    mov cx, 100
.logo_x:
    mov ax, dx
    imul ax, 320
    add ax, cx
    mov di, ax
    mov byte [es:di], 4
    inc cx
    cmp cx, 220
    jl .logo_x
    inc dx
    cmp dx, 140
    jl .logo_y

    ; 4. Cuadro Interior Amarillo (Color 14: X=130 a 190, Y=80 a 120)
    mov dx, 80
.inner_y:
    mov cx, 130
.inner_x:
    mov ax, dx
    imul ax, 320
    add ax, cx
    mov di, ax
    mov byte [es:di], 14
    inc cx
    cmp cx, 190
    jl .inner_x
    inc dx
    cmp dx, 120
    jl .inner_y

detener:
    cli
    hlt
    jmp detener