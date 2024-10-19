
# ESTRUCTURA BASICA DE UN PROGRAMA ASM
```asm
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

```

# Registros principales (x86)
- Registros generales (32 bits):
    - `EAX`: Acumulador (usado comúnmente en operaciones aritméticas).
    - `EBX`: Base (usado como un registro de base en acceso a memoria).
    - `ECX`: Contador (usado en operaciones de bucle y desplazamiento).
    - `EDX`: Extendido (usado en multiplicaciones/divisiones).
    - `ESI`: Fuente de datos para operaciones de cadena.
    - `EDI`: Destino de datos para operaciones de cadena.
    - `EBP`: Base del puntero de pila (usado para acceder a variables locales).
    - `ESP`: Puntero de la pila (apunta a la cima de la pila).
- Registros de segmento:
    - `CS`: Segmento de código.
    - `DS`: Segmento de datos.
    - `SS`: Segmento de pila.
    - `ES`, `FS`, `GS`: Segmentos extra (usados para acceso a memoria específica).
- Registros de control de flujo:
    - `EIP`: Puntero de instrucción (apunta a la siguiente instrucción a ejecutar).
    - `EFLAGS`: Registro de banderas, contiene los estados de la CPU (banderas como ZF, CF, SF, OF, etc.).

# Banderas del registro EFLAGS
Las banderas son claves para el control de flujo y las operaciones lógicas/aritméticas. Aquí algunas de las más usadas:

- `CF` (Carry Flag): Acarreo de una operación de suma o préstamo en una resta.
- `ZF` (Zero Flag): Indica si el resultado de una operación es cero.
- `SF` (Sign Flag): Indica si el resultado de una operación es negativo.
- `OF` (Overflow Flag): Indica un desbordamiento en operaciones aritméticas con signo.
- `8PF` (Parity Flag): Indica si el número de bits a 1 en el resultado es par.




# Instrucciones ASM (x86)



## INSTRUCCIONES PARA LA TRANSFERENCIA DE DATOS

- `MOV`: Copia datos de un lugar a otro.
    ```
    MOV destino, origen
    ```
    <b>Ejemplo:</b> `MOV EAX, EBX` copia el valor de `EBX` en `EAX`.
    <br>

- `PUSH`: Inserta un valor en la pila.
    ```
    PUSH valor
    ```
    <b>Ejemplo:</b> `PUSH EAX` guarda el valor de `EAX` en la pila.
    <br>

- `POP`: Extrae un valor de la pila.
    ```
    POP destino
    ```
    <b>Ejemplo:</b> `POP EBX` saca el valor de la cima de la pila y lo pone en `EBX`.
    <br>

- `LEA`: Carga la dirección efectiva de un operando en un registro.
    ```
    LEA destino, [operando]
    ```
    <b>Ejemplo:</b> `LEA EAX, [EBX+4]` guarda la dirección de memoria `EBX+4` en `EAX`.
    <br>

- `XCHG`: Intercambia los valores entre dos registros o un registro y una posición de memoria.
    ```
    XCHG destino, origen
    ```

## INSTRUCCIONES ARITMÉTICAS

- `ADD`: Suma dos operandos y almacena el resultado en el operando de destino.
    ```
    ADD EAX, EBX
    ```
- `SUB`: Resta el segundo operando del primero.
    ```
    SUB EAX, EBX
    ```
- `INC`: Incrementa el valor de un operando en 1.
    ```
    INC EAX
    ```
- `DEC`: Decrementa el valor de un operando en 1.
    ```
    DEC EAX
    ```
- `MUL`: Multiplicación sin signo. Multiplica el valor en EAX por otro operando.
    ```
    MUL EBX
    ```
- `IMUL`: Multiplicación con signo.
    ```
    IMUL EBX
    ```
- `DIV`: Divide el valor de EAX entre un operando sin signo.
    ```
    DIV EBX
    ```
- `IDIV`: Divide con signo.
    ```
    IDIV EBX
    ```

## INSTRUCCIONES LÓGICAS

`instruccion` origen, destino

- `AND`: Realiza una operación lógica AND a nivel de bit.
    ```
    AND EAX, EBX
    ```
- `OR`: Realiza una operación lógica OR a nivel de bit.
    ```
    OR EAX, EBX
    ```
- `XOR`: Realiza una operación lógica XOR a nivel de bit (Exclusiva O).
    ```
    XOR EAX, EBX
    ```
- `NOT`: Realiza una inversión bit a bit del operando.
    ```
    NOT EAX
    ```
- `TEST`: Realiza una operación AND a nivel de bit, pero no almacena el resultado, solo establece los flags.
    ```
    TEST EAX, EBX
    ```
- `CMP`: Compara dos operandos restando uno del otro y establece los flags de acuerdo con el resultado.
    ```
    CMP EAX, EBX
    ```


## INSTRUCCIONES PARA EL CONTROL DE FLUJO

- `JMP`: Salta a una dirección o etiqueta.
    ```
    JMP etiqueta
    ```
- `JE` / `JZ`: Salta si son iguales o si el resultado es cero (flag ZF = 1).
- `JNE` / `JNZ`: Salta si no son iguales o si el resultado no es cero (flag ZF = 0).
- `JG` / `JNLE`: Salta si el primer operando es mayor (salto condicional).
- `JL` / `JNGE`: Salta si el primer operando es menor.
- `CALL`: Llama a una subrutina.
- `RET`: Retorna de una subrutina.
- `LOOP`: Decrementa ECX y salta a una etiqueta si ECX no es cero.

## INSTRUCCIONES DE DESPLAZAMIENTO Y ROTACIÓN

- `SHL` / `SAL`: Desplaza a la izquierda (con signo en el caso de SAL).
- `SHR`: Desplaza a la derecha sin signo.
- `SAR`: Desplaza a la derecha con signo.
- `ROL`: Rota los bits a la izquierda, el bit que sale por la izquierda entra por la derecha.
- `ROR`: Rota los bits a la derecha.

## INSTRUCCIONES DE CADENA (STRING)
- `MOVS`: Mueve una cadena de bytes/palabras.
- `CMPS`: Compara dos cadenas de bytes/palabras.
- `LODS`: Carga un valor de la cadena en el acumulador
- `STOS`: Almacena el contenido del acumulador en la cadena de destino.

## INSTRUCCIONES DE ENTRADA SALIDA (I/O)
- `IN`: Lee desde un puerto de E/S.
- `OUT`: Escribe en un puerto de E/S.

## INSTRUCCIONES DEL PROCESADOR
- `STI`: Habilita interrupciones.
- `CLI`: Deshabilita interrupciones.
- `HTL`: Detiene la ejecución del procesador hasta que ocurra una interrupción.
- `NOP`: No realiza ninguna operación, solo avanza a la siguiente instrucción.

## INSTRUCCIONES SIMD (MULTIMEDIA)
- `ADDS`: Suma de números de punto flotante en paralelo.
- `MULPS`: Multiplicación de números de punto flotante en paralelo.

# OTROS


| Instrucción  | Explicación |
|--------------|-------------|
| `jc` etiqueta  | Salta si el indicador de acarreo (carry) está activado. Salta a la etiqueta si el indicador de acarreo está activado (1); continúa con la siguiente instrucción si el acarreo está desactivado (0). |
| `jnc` etiqueta | Salta si no hay acarreo. Salta a la etiqueta si el indicador de acarreo está desactivado (0); continúa si el acarreo está activado (1). |
| `jo` etiqueta  | Salta si hay desbordamiento. Salta a la etiqueta si el indicador de desbordamiento está activado (1); continúa si el desbordamiento está desactivado (0). |
| `jno` etiqueta | Salta si no hay desbordamiento. Salta a la etiqueta si el indicador de desbordamiento está desactivado (0); continúa si el desbordamiento está activado (1). |
| `js` etiqueta  | Salta si el signo es negativo. Salta a la etiqueta si el indicador de signo está activado (1); continúa si el signo está desactivado (0). |
| `jns` etiqueta | Salta si no hay signo negativo. Salta a la etiqueta si el indicador de signo está desactivado (0); continúa si el signo está activado (1). |
| `jz` etiqueta  | Salta si es cero. Salta a la etiqueta si el indicador de cero está activado (1); continúa si el indicador de cero está desactivado (0). |
| `jnz` etiqueta | Salta si no es cero. Salta a la etiqueta si el indicador de cero está desactivado (0); continúa si el indicador de cero está activado (1). |






# CONFIGURAR ENTORNO

## WINDOWS

### Configurar las rutas del compilador:
Debes agregar el directorio donde se encuentra ml64.exe a tu variable de entorno PATH. Generalmente se encuentra en una ruta similar a esta:
```
C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\<versión>\bin\Hostx64\x64\
```
Abre el panel de control.
Navega a Sistema > Configuración avanzada del sistema > Variables de entorno.
Busca la variable `PATH` y edítala.
Agrega la ruta hacia `ml64.exe`

### Configurar el entorno para el ensamblador y compilador
También puedes ejecutar el script que configura todo automáticamente:

```
"C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
```

### Compilar un archivo de código ensamblador

```
ml64.exe /c /Fo archivo.obj archivo.asm
```

`/c`: Ensambla el archivo pero no lo enlaza.
`/Fo archivo.obj`: Especifica el nombre del archivo de salida (objeto ensamblado).
`archivo.asm`: El archivo de código fuente ensamblador que deseas ensamblar.

### Enlazar el archivo objeto

Después de ensamblar tu código, puedes enlazar el archivo objeto con link.exe (también parte de las herramientas de Visual Studio) para generar el ejecutable:

```
link archivo.obj /OUT:programa.exe
``` 