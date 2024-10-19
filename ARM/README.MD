# ENSAMBLADOR ARM

- [Indroducción básica a ARM](#id1)
- [Registros en ARM](#id2)
- [Instrucciones comunes](#id3)
- [Modos de direccionamiento](#id4)
- [Manejo de pila (stack)](#id5)
- [Llamadas a funciones y manejo de parámetros](#id6)
- [Ejemplos básicos](#id7)

<div id='id1'></div>

# Indroducción básica a ARM
ARM es una arquitectura RISC (Reduced Instruction Set Computer), lo que significa que las instrucciones son generalmente simples y se ejecutan en un solo ciclo de reloj. ARM tiene varias versiones, pero todas comparten un conjunto básico de instrucciones.

- <b>Conjunto de instrucciones</b>: ARM usa instrucciones fijas de 32 bits para operaciones estándar, aunque también tiene un conjunto llamado Thumb, que usa instrucciones comprimidas de 16 bits.
- <b>Endianness</b>: ARM puede ser big-endian o little-endian.


<div id='id2'></div>

# Registros en ARM
ARM tiene un conjunto de 16 registros generales: `R0` a `R15`. Cada registro tiene un uso especial en ciertos contextos:

`R0` - `R3`: Argumentos y resultados de funciones.
`R4` - `R11`: Registros de propósito general (también conocidos como callees-saved o volátiles).
`R12`: Registro conocido como IP (Intra-Procedure Scratch Register).
`R13`: SP (Stack Pointer) apunta a la cima de la pila.
`R14`: LR (Link Register) guarda la dirección de retorno tras una subrutina.
`R15`: PC (Program Counter) almacena la dirección de la siguiente instrucción a ejecutar.




<div id='id3'>

# Instrucciones comunes
Estas son algunas de las instrucciones más comunes en ensamblador ARM:

- Cargar y almacenar:

    - `LDR Rd, [Rn]`: Carga el valor en la dirección de memoria de Rn en el registro Rd.
    - `STR Rd, [Rn]`: Almacena el valor del registro Rd en la dirección de memoria de Rn.

- Aritméticas:

    - `ADD Rd, Rn, Rm`: Suma `Rn` y `Rm`, y almacena el resultado en `Rd`.
    - `SUB Rd, Rn, Rm`: Resta `Rm` de `Rn`, y almacena el resultado en `Rd`.

- Lógicas:

    - `AND Rd, Rn, Rm`: Realiza la operación AND bit a bit entre `Rn` y `Rm`, y almacena el resultado en `Rd`.
    - `ORR Rd, Rn, Rm`: Realiza la operación OR entre `Rn` y `Rm`, y almacena el resultado en `Rd`.

- Control de flujo:

    - `B label`: Salta a la dirección indicada por `label`.
    - `BL label`: Salta a `label` y guarda la dirección de retorno en `LR`.

- Comparaciones:

    - `CMP Rn, Rm`: Compara `Rn` con `Rm` (realiza `Rn - Rm` sin almacenar el resultado, solo afecta las banderas).




<div id='id4'>

# Modos de direccionamiento
El ensamblador ARM admite varios modos de direccionamiento que permiten acceder a la memoria de diferentes formas:

- <b>Direccionamiento inmediato:</b>

    - `MOV R0, #10`: Carga el valor inmediato `10` en `R0`.

- <b>Direccionamiento directo:</b>

    - `LDR R0, [R1]`: Carga en `R0` el valor contenido en la dirección de memoria almacenada en `R1`.

- <b>Direccionamiento indirecto con desplazamiento:</b>

    - `LDR R0, [R1, #4]`: Carga en `R0` el valor en la dirección `R1 + 4`.



<div id='id5'>

# Manejo de pila (stack)
El stack (pila) en ARM se utiliza para almacenar datos temporalmente, como registros de propósito general o las direcciones de retorno durante llamadas a funciones. ARM utiliza un registro especial para apuntar a la cima de la pila: <b>SP</b> (Stack Pointer, `R13`).

En ARM, el stack crece hacia abajo (direcciones de memoria decrecientes).

- <b>Guardar valores en la pila (Push)</b>:

    - Para empujar valores al stack, se utiliza el comando `STR` o la instrucción `STMFD` (Store Multiple Full Descending).
    ```
    PUSH {R0, R1, R4}  ; Empuja los valores de R0, R1 y R4 al stack.
    ```

    También puede hacerse explícitamente:
    ```
    STMFD SP!, {R0, R1, R4}  ; Almacena R0, R1 y R4 en la pila y decrece SP.
    ```
- <b>Recuperar valores de la pila (Pop)</b>:

    - Para recuperar valores de la pila, se utiliza `LDR` o la instrucción `LDMFD` (Load Multiple Full Descending).
    ```
    POP {R0, R1, R4}  ; Extrae los valores del stack a R0, R1 y R4.
    ```

    También se puede hacer explícitamente:
    ```
    LDMFD SP!, {R0, R1, R4}  ; Carga desde la pila a R0, R1 y R4 y aumenta SP.
    ```
El uso del stack es fundamental en las llamadas a funciones y la preservación del estado entre llamadas.



<div id='id6'>

# Llamadas a funciones y manejo de parámetros

ARM sigue la convención AAPCS (ARM Architecture Procedure Call Standard), que define cómo se pasan parámetros a las funciones, cómo se manejan los retornos, y cómo se preservan los registros.

- <b>Paso de parámetros:</b>

    - Los primeros cuatro parámetros se pasan en los registros `R0` - `R3`.
    - Si hay más de cuatro parámetros, se pasan a través del stack.

- <b>Retorno de funciones:</b>
    - El valor de retorno se coloca en R0.

- <b>Preservación de registros:</b>
    - Los registros `R4` - `R11` deben ser preservados por la función llamada (callee-saved).
    - Los registros `R0` - `R3`, `R12` son temporales y pueden ser modificados por la función (caller-saved).

- <b>Ejemplo de llamada a una función:</b>

```asm
; Llamar a la función 'myFunction' con dos parámetros
MOV R0, #5       ; Primer parámetro
MOV R1, #10      ; Segundo parámetro
BL myFunction    ; Llama a la función, el resultado estará en R0

; Definición de la función
myFunction:
  ADD R0, R0, R1 ; Suma los dos parámetros (R0 = R0 + R1)
  BX LR          ; Retorna a la dirección almacenada en LR

```

<div id='id7'>

# Ejemplos básicos

Estos ejemplos muestran cómo trabajar con instrucciones básicas en ARM.

- <b>Sumar dos números:</b>
    ```
    MOV R0, #3       ; Cargar 3 en R0
    MOV R1, #5       ; Cargar 5 en R1
    ADD R2, R0, R1   ; Sumar R0 y R1, almacenar el resultado en R2 (R2 = 8)
    ```
- <b>Comparación y salto condicional:</b>
    ```asm
    MOV R0, #10      ; Cargar 10 en R0
    MOV R1, #15      ; Cargar 15 en R1
    CMP R0, R1       ; Comparar R0 con R1 (R0 - R1)
    BGT greater      ; Si R0 > R1, saltar a la etiqueta 'greater'
    ```
    greater: MOV R2, #1 ; Si es mayor, R2 toma el valor 1
    
    ```asm
    ;Bucle simple (contar de 0 a 9)
    MOV R0, #0       ; Inicializar contador en R0
    loop:
    CMP R0, #10      ; Comparar R0 con 10
    BGE end_loop     ; Si R0 >= 10, salir del bucle
    ADD R0, R0, #1   ; Incrementar el contador
    B loop           ; Repetir el bucle

    end_loop:
    ```


- <b>Manipulación de la pila:</b>
    ```
    MOV R0, #5       ; Cargar 5 en R0
    MOV R1, #10      ; Cargar 10 en R1
    PUSH {R0, R1}    ; Guardar R0 y R1 en la pila
    POP {R2, R3}     ; Recuperar los valores de la pila a R2 y R3
    ```
