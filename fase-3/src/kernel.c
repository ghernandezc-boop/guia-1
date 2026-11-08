// Dirección de memoria del Framebuffer VGA (Modo 0x13)
#define VGA_MEMORY ((unsigned char*)0xA0000)
#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 200

// Función principal del Kernel
void kernel_main(void) {
    unsigned char* vga = VGA_MEMORY;

    // 1. Fondo Azul Oscuro (Color 1)
    for (int i = 0; i < SCREEN_WIDTH * SCREEN_HEIGHT; i++) {
        vga[i] = 1;
    }

    // 2. Marco Exterior Blanco (Color 15)
    for (int x = 10; x < 310; x++) {
        vga[10 * SCREEN_WIDTH + x] = 15;
        vga[189 * SCREEN_WIDTH + x] = 15;
    }
    for (int y = 10; y < 190; y++) {
        vga[y * SCREEN_WIDTH + 10] = 15;
        vga[y * SCREEN_WIDTH + 309] = 15;
    }

    // 3. Logotipo Rojo Central (Color 4)
    for (int y = 60; y < 140; y++) {
        for (int x = 100; x < 220; x++) {
            vga[y * SCREEN_WIDTH + x] = 4;
        }
    }

    // 4. Cuadro Amarillo Interior (Color 14)
    for (int y = 80; y < 120; y++) {
        for (int x = 130; x < 190; x++) {
            vga[y * SCREEN_WIDTH + x] = 14;
        }
    }

    // Detener procesador
    while (1) {
        __asm__ volatile ("hlt");
    }
}