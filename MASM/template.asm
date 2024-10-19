section .data                          ; Sección de datos, aquí van variables globales y constantes
    mensaje db 'Hola Mundo!', 0        ; Definición de un mensaje como una cadena de bytes
    longitud_mensaje equ $ - mensaje   ; Calcular longitud de la cadena

section .bss                           ; Sección de variables sin inicializar
    ; Aquí van variables que se inicializan en tiempo de ejecución
    buffer resb 64                     ; Reservar 64 bytes para un buffer

section .text                          ; Sección de código
    global _start                      ; Declarar el punto de entrada global

_start:                                ; Inicio del programa
    ; Llamar al sistema para escribir un mensaje en pantalla (sys_write)
    mov eax, 4                         ; Número de la llamada al sistema: sys_write
    mov ebx, 1                         ; Descriptor de archivo: 1 (stdout)
    mov ecx, mensaje                   ; Dirección del mensaje
    mov edx, longitud_mensaje          ; Longitud del mensaje
    int 0x80                           ; Interrupción de software para ejecutar la llamada al sistema

    ; Llamar al sistema para salir del programa (sys_exit)
    mov eax, 1                         ; Número de la llamada al sistema: sys_exit
    xor ebx, ebx                       ; Código de salida: 0
    int 0x80                           ; Interrupción de software para ejecutar la llamada al sistema