# HLA (High Level Assembler)

El lenguaje de programación HLA (High Level Assembler) es un lenguaje ensamblador de alto nivel diseñado para facilitar la programación en lenguaje de máquina, al ofrecer una sintaxis más comprensible y accesible. Fue creado por Randall Hyde y se utiliza principalmente para la enseñanza de la programación de sistemas y el desarrollo de software de bajo nivel.

- Características principales de HLA:
    - <b>Sintaxis de Alto Nivel:</b> A diferencia de los lenguajes ensambladores tradicionales, que suelen tener una sintaxis muy rígida y poco amigable, HLA permite una escritura más similar a lenguajes de programación de alto nivel como C o Pascal.

    - <b>Facilidad de Aprendizaje:</b> HLA está diseñado especialmente para estudiantes y programadores novatos que deseen aprender sobre la programación de sistemas y el funcionamiento interno de la computadora sin tener que lidiar con la complejidad del lenguaje ensamblador típico.

    - <b>Integración de Funciones de Alto Nivel:</b> Incluye características como estructuras de control (if, while, etc.), manejo de funciones y procedimientos, lo que lo hace más parecido a un lenguaje de programación de alto nivel.

    - <b>Uso Educativo:</b> Se utiliza frecuentemente en cursos de arquitectura de computadoras y sistemas operativos, ya que permite a los estudiantes comprender mejor cómo funciona el hardware y el software a nivel de máquina.

    - <b>Compatibilidad:</b> HLA se puede usar para programar tanto en sistemas operativos Windows como en Linux, y puede generar código que se ejecute en diferentes arquitecturas de CPU.


https://randallhyde.com/AssemblyLanguage/HighLevelAsm/

# Estructura de un Programa en HLA

```hla
    program NombreDelPrograma;
    #include("stdlib.hhf")  // Incluir librerías

    // Declaraciones globales
    type
        // Definición de nuevos tipos de datos (struct, union, etc.)
    static
        // Definición de variables estáticas (globales)
    var
        // Definición de variables locales (usualmente en la pila)
    const
        // Definición de constantes

    begin NombreDelPrograma;
        // Código del programa
        // Instrucciones y lógica del programa
    end NombreDelPrograma;
```

## Seccion `type`

La sección `type` se utiliza para definir nuevos tipos de datos. Estos pueden ser estructuras (`struct`), uniones (`union`), punteros (`ptr`), arrays, o cualquier otro tipo de dato personalizado que desees crear. Esta sección es opcional y se utiliza principalmente cuando necesitas tipos de datos complejo

```
type
    Person: struct
        name: string;
        age: int32;
    endstruct;

    ptrPerson: ptr32 to Person;  // Puntero a la estructura Person

```

Explicación: Aquí definimos un tipo `Person` que es una estructura con un campo `name` de tipo `string` y un campo `age` de tipo `int32`. También definimos un puntero (`ptrPerson`) que apunta a este tipo de estructura.

## Seccion `static`

La sección `static` se utiliza para declarar variables globales o estáticas. Estas variables tienen una duración de vida que abarca toda la ejecución del programa, y se almacenan en la data segment (segmento de datos) de la memoria.

Las variables estáticas suelen utilizarse cuando se necesitan datos que estén disponibles en toda la aplicación y que no se destruyan después de que se termine un procedimiento o función.

```
static
    globalCount: int32 := 0;  // Variable global, inicializada en 0
    message: string := "Hello, World!";
```

<b>Explicación:</b> Aquí definimos una variable entera `globalCount` que se mantiene disponible en toda la ejecución del programa y una cadena de texto `message` que también está siempre disponible.

## Seccion `var`

La sección `var` se utiliza para declarar variables locales que suelen asignarse en la pila (stack). Estas variables existen solo dentro del bloque de código donde fueron declaradas y se eliminan automáticamente cuando ese bloque termina. Esta sección es comúnmente utilizada para variables temporales que no requieren persistir durante todo el programa.

```
begin MiPrograma;
    var
        tempValue: int32;
        tempMessage: string;

    // Usar las variables locales
    mov( 10, tempValue );  // Asignar valor a la variable local
    mov( "Mensaje temporal", tempMessage );
end MiPrograma;

```

<b>Explicación:</b> Aquí `tempValue` y `tempMessage` son variables locales que solo existen dentro del bloque `begin` y `end` del programa `MiPrograma`.

## Seccion `const`

La sección `const` se utiliza para declarar constantes, es decir, valores que no cambian durante la ejecución del programa. Las constantes son útiles para valores que necesitas reutilizar sin permitir que su valor sea modificado.

```
const
    PI: real4 := 3.141592;  // Definir la constante PI
    MAX_VALUE: int32 := 100;
```

<b>Explicación:</b> Aquí `PI` es una constante de tipo `real4` con un valor fijo de `3.141592` y `MAX_VALUE` es una constante entera con valor `100`. Estas no pueden cambiar en ninguna parte del programa.

## Seccion `readonly`

Esta sección se utiliza para declarar datos que no se pueden modificar durante la ejecución del programa, pero que no son exactamente constantes en el sentido de `const`. Se utiliza comúnmente para almacenar valores de solo lectura, como cadenas de caracteres o tablas de búsqueda.

```
readonly
    errorMessage: string := "Error: Operation failed!";
```

<b>Explicación:</b> Esta cadena `errorMessage` está en una sección de solo lectura, por lo que no puede ser modificada por el programa una vez definida.


## Seccion `storage`

La sección storage se usa para reservar un bloque de memoria sin inicializar. Es útil cuando solo necesitas declarar el espacio para almacenar datos, pero no necesitas darle un valor inicial de inmediato.

```
storage
    buffer: byte[1024];  // Reserva un buffer de 1024 bytes
```

<b>Explicación:</b> Explicación: Aquí reservamos 1024 bytes de memoria en el buffer `buffer` para usarlos más adelante.

## Seccion `procedure`

En HLA, puedes definir procedimientos (funciones) usando el bloque `procedure`. Los procedimientos encapsulan un conjunto de instrucciones que pueden ser reutilizadas en diferentes partes del programa.

```
procedure Sumar( a: int32; b: int32 ); @nodisplay;
begin Sumar;
    mov( a, eax );
    add( b, eax );
end Sumar;
```

<b>Explicación:</b> Aquí definimos un procedimiento llamado `Sumar` que toma dos parámetros `a` y `b` de tipo `int32`. Suma `a` y `b`, almacenando el resultado en el registro `eax`.

## Seccion `begin` y `end`

La sección `begin ... end` contiene el código principal del programa. Todo lo que esté dentro 
de este bloque es ejecutado cuando el programa comienza.

```
begin MiPrograma;
    // Código del programa
    stdout.put( "Hola, Mundo!", nl );
end MiPrograma;
```

<b>Explicación:</b> El bloque `begin` y `end` marca el comienzo y el final del código ejecutable en el programa. En este caso, el programa imprimirá "Hola, Mundo!" en la consola.

## Diferencias Clave Entre `type`, `static`, `var`, y Otras Secciones

- `type`: Define <b>tipos de datos</b> personalizados (struct, union, arrays, etc.). No almacena datos en sí, solo define cómo deben estructurarse los datos.

- `static`: Define <b>variables globales o estáticas</b>. Estas variables son globales, lo que significa que existen durante toda la ejecución del programa.

- `var`: Define <b>variables locales</b>. Se almacenan en la <b>pila (stack)</b> y solo existen dentro del contexto de una función, procedimiento o bloque específico.

- `const`: Define <b>constantes</b>. No puedes modificar su valor después de su definición. Se utilizan para valores que no deben cambiar durante la ejecución del programa.

- `readonly`: Define datos que son de <b>solo lectura</b> y que no se pueden modificar una vez que son inicializados, pero no son estrictamente "constantes".

- `storage`: Reserva <b>memoria sin inicializar</b>. Es útil para crear buffers o reservar espacio para datos sin asignarles valores inicialmente.

# Registros

Los registros son pequeños espacios de almacenamiento dentro del procesador que se utilizan para realizar operaciones rápidas y manejar datos de manera eficiente. Los registros en HLA están categorizados según su tamaño y su propósito específico en la ejecución de instrucciones.

Los registros se pueden dividir según su capacidad en bits (8, 16, 32, y 64 bits) y cada uno tiene un rol importante en el manejo de datos, operaciones aritméticas y lógicas, y direccionamiento de memoria. Existen registros generales, registros de propósito específico (como punteros y contadores), y registros de estado (flags) que controlan el flujo de ejecución y reflejan el resultado de las operaciones.
- <b>Registros Generales:</b>

    Estos son registros de propósito general, que se utilizan comúnmente para operaciones aritméticas, lógicas, y de manejo de datos. Ejemplos incluyen  `AX`, `BX`, `CX`, y `DX`, con versiones extendidas para operaciones de mayor tamaño como `EAX (32 bits)` y `RAX (64 bits)`.
    También están los registros `R8-R15`, que solo están disponibles en arquitecturas de `64 bits`, proporcionando almacenamiento adicional.

- <b>Registros de Segmento y Punteros:</b>

    - `SP (Stack Pointer)`: Mantiene la dirección del tope de la pila, crucial para la administración de funciones y llamadas anidadas.
    - `BP (Base Pointer)`: Utilizado para acceder a variables locales dentro de una función.
    IP (Instruction Pointer): Apunta a la próxima instrucción que el procesador ejecutará.

- <b>Registros de Índice:</b>

    - `SI` (Source Index) y `DI` (Destination Index): Se emplean en operaciones con cadenas, donde `SI` apunta a la fuente de datos y `DI` al destino.

- <b>Registros de Segmento:</b>

    Estos registros, como `CS` (código), `DS` (datos), y `SS` (pila), determinan qué segmentos de memoria se están utilizando para el código, los datos y la pila, respectivamente.

- <b>Registros de Banderas (`Flags`):</b>

    Los registros `FLAGS` (y sus variantes extendidas `EFLAGS` y `RFLAGS`) contienen indicadores que reflejan el resultado de operaciones aritméticas y controlan el flujo del programa. Ejemplos de flags incluyen `ZF` (Zero Flag), `CF` (Carry Flag), `SF` (Sign Flag), y `OF` (Overflow Flag), que señalan condiciones como si un resultado es cero o si ha habido un acarreo en una operación.

## Registros Generales por Tamaño y Extensión

Esta tabla muestra los registros generales disponibles en la arquitectura de computadoras desde 8 bits hasta 64 bits. Presenta las diferentes extensiones de los registros (parte baja, parte alta, extendidos) según el tamaño (1 byte, 2 bytes, 4 bytes y 8 bytes) y cómo se agrupan en las distintas arquitecturas (16 bits, 32 bits, 64 bits).

| Registro General | 8 bits (1 byte)                       | 16 bits (2 bytes) | 32 bits (4 bytes) |  64 bits (8 bytes) |
|------------------|---------------------------------------|-------------------|-------------------|--------------------|
| `AX`             | `AL` (parte baja) / `AH` (parte alta) | `AX`              | `EAX`             | `RAX`              |
| `BX`             | `BL` / `BH`                           | `BX`              | `EBX`             | `RBX`              |
| `CX`             | `CL` / `CH`                           | `CX`              | `ECX`             | `RCX`              |
| `DX`             | `DL` / `DH`                           | `DX`              | `EDX`             | `RDX`              |
| `R8-R15`         | No aplicable                          | No aplicable      | `R8D-R15D`        | `R8-R15`           |


## Descripción de Registros Generales por Propósito y Tamaño

Esta tabla detalla los registros generales usados en las arquitecturas de procesadores x86 y x64, desde 8 bits hasta 64 bits. Cada registro incluye su propósito principal (acumulador, base, contador, datos) y un comentario que explica su uso común en operaciones aritméticas, de entrada/salida y direccionamiento de memoria.

| Registro     | Tamaño (bits) | Propósito                                            | Comentario                                            |
|--------------|---------------|------------------------------------------------------|-------------------------------------------------------|
| `AL` / `AH`  |      8        |  Parte baja (`AL`) y alta (`AH`) del acumulador `AX` | Operaciones aritméticas de 8 bits                     |
| `BL` / `BH`  |      8        |  Parte baja (`BL`) y alta (`BH`) del registro `BX`   | Generalmente usado en direccionamiento                |
| `CL` / `CH`  |      8        |  Parte baja (`CL`) y alta (`CH`) del registro `CX`   | Usado para contar en operaciones repetitivas (loops)  |
| `DL` / `DH`  |      8        |  Parte baja (`DL`) y alta (`DH`) del registro `DX`   | Usado en operaciones de E/S y datos                   |
| `AX`         |      16       |  Acumulador                                          | Operaciones aritméticas y de E/S                      |
| `BX`         |      16       |  Base                                                | Usado para direccionar memoria                        |
| `CX`         |      16       |  Contador                                            | Contador en bucles o operaciones repetitivas          |
| `DX`         |      16       |  Datos                                               | Usado en operaciones de E/S y multiplicación/división |
| `EAX`        |      32       |  Acumulador extendido                                | Operaciones aritméticas de 32 bits                    |
| `EBX`        |      32       |  Base extendida	                                  | Usado en direccionamiento de memoria en 32 bits       |
| `ECX`        |      32       |  Contador extendido                                  | Contador en bucles u operaciones lógicas en 32 bits   |
| `EDX`        |      32       |  Datos extendidos	                                  | Operaciones con datos de 32 bits                      |
| `RAX`        |      64       |  Acumulador de 64 bits                               | Operaciones aritméticas en sistemas de 64 bits        |
| `RBX`        |      64       |  Base de 64 bits	                                  | Usado para direccionamiento en 64 bits                |
| `RCX`        |      64       |  Contador de 64 bits	                              | Usado en bucles y operaciones lógicas                 |
| `RDX`        |      64       |  Datos de 64 bits	                                  | Usado para manejar datos en sistemas de 64 bits       |



## Registros Especiales y Segmentos con Indicadores de Estado

Esta tabla presenta los registros especiales utilizados para gestión de la pila, acceso a datos y ejecución de instrucciones (punteros de pila, base, fuente, destino e instrucción). También incluye los registros de segmentos de memoria y los indicadores de estado (flags), junto con registros adicionales disponibles en arquitecturas de 64 bits.


| Registro                | Tamaño (bits) | Propósito                                        | Comentario                                            |
|-------------------------|---------------|--------------------------------------------------|-------------------------------------------------------|
| `SP` / `ESP` / `RSP`          | 16 / 32 / 64  | Stack Pointer	                             | Apunta al tope de la pila                             |
| `BP` / `EBP` / `RBP`          | 16 / 32 / 64  | Base Pointer	                             | Usado para acceder a variables locales y parámetros   |
| `SI` / `ESI` / `RSI`          | 16 / 32 / 64  | Source Index	                             | Apunta a origen en operaciones con cadenas            |
| `DI` / `EDI` / `RDI`          | 16 / 32 / 64  | Destination Index	                         | Apunta a destino en operaciones con cadenas           |
| `IP` / `EIP` / `RIP`          | 16 / 32 / 64  | Instruction Pointer                   	 | Dirección de la próxima instrucción a ejecutar        |
| `CS`                          | 16            | Código	                                 | Segmento donde está el código                         |
| `DS`                          | 16            | Datos                                      | Segmento donde están los datos                        |
| `SS`                          | 16            | Pila	                                     | Segmento donde está la pila                           |
| `ES` / `FS` / `GS`            | 16            | Segmentos extra	                         | Segmentos adicionales para datos                      |
| `FLAGS` / `EFLAGS` / `RFLAGS` | 16 / 32 / 64  | Indicadores de estado	                     | Contiene varias banderas de control y resultado       |
| `ZF`                          | 1 (`FLAG`)    | Zero Flag	                                 | Indica si el resultado de una operación es cero       |
| `CF`                          | 1 (`FLAG`)    | Carry Flag	                             | Indica un acarreo (carry) en una operación aritmética |
| `SF`                          | 1 (`FLAG`)    | Sign Flag		                             | Indica si el resultado es negativo                    |
| `OF`                          | 1 (`FLAG`)    | Overflow Flag	                             | Indica un desbordamiento aritmético                   |
| `R8-R15`                      | 64            | Registros adicionales de propósito general | Disponibles solo en arquitecturas de 64 bits          |


# TIPOS DE DATOS

## Tipos de datos enteros con y sin signo

Estos tipos son utilizados para almacenar números enteros, con la diferencia de si permiten representar números negativos o no.



| Tipo de dato   | Tamaño (bits) | Rango sin signo              | Rango con signo                                 | Descripción                                                        | 
|----------------|---------------|------------------------------|-------------------------------------------------|--------------------------------------------------------------------|
| `byte`         | 8 bits        | `0` a `255`                  | -                                               | Sin signo por defecto, usado para datos pequeños o bytes binarios. |
| `int8`         | 8 bits        | -                            | `-128` a `127`                                  | Entero con signo de 8 bits.                                        |
| `uint8`        | 8 bits        | `0` a `255`                  | -                                               | Entero sin signo de 8 bits.                                        |
| `word`         | 16 bits       | `0` a `65535`                | -                                               | Sin signo por defecto, usado para datos de 16 bits.                |
| `int16`        | 16 bits       | -                            | `-32768` a `32767`                              | Entero con signo de 16 bits.                                       |
| `uint16`       | 16 bits       | `0` a `65535`                | -                                               | Entero sin signo de 16 bits.                                       |
| `dword`        | 32 bits       | `0` a `4294967295`           | -                                               | Sin signo por defecto, usado para datos de 32 bits.                |
| `int32`        | 32 bits       | -                            | `-2147483648` a `2147483647`                    | Entero con signo de 32 bits.                                       |
| `uint32`       | 32 bit        | `0` a `4294967295`           | -                                               | Entero sin signo de 32 bits.                                       |
| `qword`        | 64 bits       | `0` a `18446744073709551615` | -                                               | Sin signo por defecto, usado para datos de 64 bits.                |
| `int64`        | 64 bits       | -                            | `-9223372036854775808` a `9223372036854775807`  | Entero con signo de 64 bits.                                       |
| `uint64`       | 64 bits       | `0` a `18446744073709551615` | -                                               | Entero sin signo de 64 bits.                                       |




### ENTEROS CON SIGNO EXPLÍCITOS

Estos tipos de datos representan tanto números negativos como positivos, usando el sistema de complemento a 2. El rango va desde −2<sup>𝑛−1</sup> hasta −2<sup>n−1</sup>-1, donde n es el número de bits.

-   <b>int8:</b> 1 byte (8bits)
    - <b>Valor máximo: </b> `127` (es decir, 2<sup>7</sup> -1)
    - <b>Valor mínimo: </b> `-128` (es decir, -2<sup>7</sup>)</b>
    - Ejemplo

    ```
    int8Var: int8 := 127;
    ```

-   <b>int16:</b> 2 bytes (16 bits)
    - <b>Valor máximo: </b> `32767` (es decir, 2<sup>15</sup> -1)
    - <b>Valor mínimo: </b> `-32768` (es decir, -2<sup>15</sup>)</b>
    - Ejemplo

    ```
    int32Var: int32 := 2147483647;
    ```

-   <b>int32:</b> 4 bytes (32 bits)
    - <b>Valor máximo: </b> `2147483647` (es decir, 2<sup>31</sup> -1)
    - <b>Valor mínimo: </b> `-2147483648` (es decir, -2<sup>31</sup>)</b>
    - Ejemplo

    ```
    int32Var: int32 := 2147483647;
    ```

-   <b>int64:</b> 8 bytes (64 bits)
    - <b>Valor máximo: </b> `9223372036854775807` (es decir, 2<sup>63</sup> -1)
    - <b>Valor mínimo: </b> `-9223372036854775808` (es decir, -2<sup>63</sup>)</b>
    - Ejemplo

    ```
    int64Var: int64 := 9223372036854775807;
    ```

## TIPOS DE DATOS FLOTANTES
Estos tipos se utilizan para almacenar números reales que incluyen una parte decimal, y utilizan una representación en notación científica dentro del procesador. Son útiles cuando se necesitan cálculos con fracciones o valores más precisos que no pueden representarse con enteros.


| Tipo de dato | Tamaño (bits) | Rango aproximado de valores | Precisión     | Descripción                                                                                  |
|--------------|---------------|-----------------------------|---------------|----------------------------------------------------------------------------------------------|
| `real4`      | 32 bits       | ±10 <sup>38</sup>           | 6-7 dígitos   | Precisión simple, flotante de 32 bits. Equivalente a float en otros lenguajes.               |
| `real8`      | 64 bits       | ±10 <sup>308</sup>          | 15-16 dígitos | Precisión doble, flotante de 64 bits. Equivalente a double.                                  |
| `real10`     | 80 bits       | ±10 <sup>34932</sup>        | 18-19 dígitos | Precisión extendida, flotante de 80 bits. Específico en algunas arquitecturas de procesador. |

- `real4` <b>(32 bits)</b>: También conocido como <b>precisión simple</b>. Este tipo usa 32 bits para almacenar números en formato de punto flotante. Es equivalente al tipo `float` en otros lenguajes de programación.
    - Valor máximo aproximado: `3.40282347E+38`
    ```
    real4Var: real4 := 3.40282347E+38;
    ```
- `real8` <b>(64 bits)</b>: También conocido como precisión doble. Este tipo utiliza 64 bits y es equivalente al tipo `double` en otros lenguajes.
    - Valor máximo aproximado: `1.7976931348623157E+308`
    ```
    real8Var: real8 := 3.40282347E+38;
    ```
- `real10` <b>(80 bits)</b>: También conocido como precisión extendida. Este tipo usa 80 bits y es más específico de ciertas arquitecturas de procesador como las x86, donde existe soporte para cálculos de precisión extendida en hardware.
    - Valor máximo aproximado: `1.18973149535723176508575932662800702E+4932`
    ```
    real80Var: real80 := 1.18973149535723176508575932662800702E+4932;
    ```

## TIPOS DE DATOS DE PUNTERO
Un puntero es una variable que contiene la dirección de memoria de otra variable. Los punteros en HLA dependen del tamaño de la arquitectura (32 o 64 bits).
| Tipo de dato | Tamaño (bits)   | Descripción                                                                                          |
|--------------|-----------------|------------------------------------------------------------------------------------------------------|
| `ptr32`      | 32 bits         | Puntero de 32 bits. Se usa en arquitecturas de 32 bits, como en sistemas operativos de 32 bits. |
| `ptr64`      | 64 bits         | Puntero de 64 bits. Se usa en arquitecturas de 64 bits, como en sistemas modernos de 64 bits. |

- <b>Punteros de 32 bits (`ptr32`)</b>
    ```
    program Ptr32Example;
    #include("stdlib.hhf")

    static
        intVariable: int32 := 12345;
        intPointer: ptr32;  // Puntero de 32 bits a un entero

    begin Ptr32Example;

        // Asignamos la dirección de intVariable a intPointer
        mov( &intVariable, intPointer );

        // Accedemos al valor al que apunta intPointer
        mov( [intPointer], eax );

        // Mostramos el valor almacenado en la dirección apuntada
        stdout.put( "Valor desde puntero (32 bits): ", eax, nl );

    end Ptr32Example;
    ```
    Explicación:
    - Declaramos una variable `intVariable` de tipo `int32` con un valor de `12345`.
    - `intPointer` es un puntero de 32 bits que almacenará la dirección de `intVariable`.
    - Usamos `mov( &intVariable, intPointer );` para almacenar la dirección de `intVariable` en `intPointer`.
    - Luego, accedemos al valor de la variable usando el puntero con `mov( [intPointer], eax );` y lo mostramos.


- <b>Punteros de 64 bits (`ptr64`)</b>

    ```
    program Ptr64Example;
    #include("stdlib.hhf")

    static
        intVariable: int64 := 987654321;
        intPointer: ptr64;  // Puntero de 64 bits a un entero

    begin Ptr64Example;

        // Asignamos la dirección de intVariable a intPointer
        mov( &intVariable, intPointer );

        // Accedemos al valor al que apunta intPointer
        mov( [intPointer], rax );

        // Mostramos el valor almacenado en la dirección apuntada
        stdout.put( "Valor desde puntero (64 bits): ", rax, nl );

    end Ptr64Example;
    ```
    Explicación:
    - `ptr64` se usa para almacenar la dirección de una variable en un sistema de 64 bits.
    - El procedimiento es similar al caso de punteros de 32 bits, pero aquí trabajamos con variables de 64 bits y registros como `rax`.


## TIPOS DE DATOS COMPUESTOS Y OTROS TIPOS COMUNES
Además de los tipos numéricos y flotantes, HLA ofrece algunos tipos de datos comunes para estructuras más complejas y manipulación de cadenas.

| Tipo de dato | Tamaño (bits)   | Descripción                                                                                          |
|--------------|-----------------|------------------------------------------------------------------------------------------------------|
| `char`       | 8 bits          | Almacena un solo carácter ASCII (un byte).                                                           |
| `string`     | Variable        | Almacena una cadena de caracteres. Los strings en HLA se manejan como punteros a bloques de memoria. |
| `boolean`    | 1 byte (8 bits) | Almacena un valor booleano (true o false). Normalmente solo usa 1 bit, pero ocupa 1 byte.            |
| `array`      | Variable        | Tipo compuesto que permite almacenar múltiples valores del mismo tipo en secuencia.                  |
| `struct`     | Variable        | Tipo compuesto que permite agrupar diferentes tipos de datos bajo una misma estructura.              |
| `union`      | Variable        | Similar a una estructura, pero todos los miembros comparten la misma ubicación de memoria.           |

- <b>char</b> 1 byte
    - Valor máximo: 255 (es un valor sin signo, por lo que puede almacenar un carácter con código ASCII desde 0 hasta 255)
    ```
    charVar: char := 255;
    ```
- <b>boolean</b> 1 byte
    - Valores permitidos: `0` (falso) o `1` (Verdadero)
    - Ejemplo de declaración:
    ```
    boolVar: boolean := 1;
    ```
- <b>String (Cadenas de caracteres)</b>
   ```
    program StringExample;
    #include("stdlib.hhf")

    static
        greeting: string := "Hello, World!";

    begin StringExample;

        // Mostramos la cadena de caracteres
        stdout.put( greeting, nl );

    end StringExample;
    ```

    Explicación:
    - Definimos una cadena greeting de tipo string con el valor "Hello, World!".
    - Usamos `stdout.put( greeting, nl );` para mostrar la cadena.

- <b>Array</b>
Un array es una secuencia de datos del mismo tipo. A continuación, se muestra cómo definir y acceder a un array en HLA.
    ```
    program ArrayExample;
    #include("stdlib.hhf")

    static
        numbers: int32[5] := [1, 2, 3, 4, 5];  // Array de 5 enteros

    begin ArrayExample;

        // Accedemos al tercer elemento (indexado desde 0)
        mov( numbers[2], eax );  // numbers[2] es el tercer elemento (3)
        
        // Mostramos el valor del tercer elemento
        stdout.put( "Tercer elemento del array: ", eax, nl );

    end ArrayExample;
    ```
    Explicación:
    - `numbers` es un array de 5 enteros de 32 bits.
    - Usamos `numbers[2]` para acceder al tercer elemento (debido a que el índice empieza en 0).
    - Luego mostramos ese valor con `stdout.put`.

- <b>Struct</b>
    Una estructura `(struct)` permite agrupar diferentes tipos de datos bajo un solo nombre. Aquí tienes un ejemplo simple de una estructura.
    ```
    program StructExample;
    #include("stdlib.hhf")

    type
        Person: struct
            name: string;
            age: int32;
        endstruct;

    static
        john: Person := ["John Doe", 30];  // Inicializamos con un nombre y edad

    begin StructExample;

        // Mostramos los valores de la estructura
        stdout.put( "Nombre: ", john.name, nl );
        stdout.put( "Edad: ", john.age, nl );

    end StructExample;
    ```

    Explicación
    - Definimos una estructura `Person` que tiene un campo `name` de tipo `string` y un campo `age` de tipo `int32`.
    - Creamos una variable `john` de tipo `Person` con valores `"John Doe"` para `name` y `30` para `age`.
    - Luego, mostramos estos valores accediendo a los campos con `john.name` y `john.age`.

- <b>Union</b>
    Una unión (union) es similar a una estructura, pero todos los campos comparten la misma posición en memoria, lo que permite que solo uno de ellos sea válido a la vez.

    ```
    program UnionExample;
    #include("stdlib.hhf")

    type
        Number: union
            intValue: int32;
            floatValue: real4;
        endunion;

    static
        num: Number;

    begin UnionExample;

        // Asignamos un valor entero a la unión
        mov( 42, num.intValue );
        
        // Mostramos el valor entero
        stdout.put( "Valor entero: ", num.intValue, nl );

        // Asignamos un valor flotante a la unión
        fldz();               // Colocamos 0.0 en la pila de FPU
        fstp( num.floatValue );  // Almacenamos el valor flotante en la unión

        // Mostramos el valor flotante
        stdout.put( "Valor flotante: ", num.floatValue, nl );

    end UnionExample;

    ```
    Explicacion

    - Definimos una unión `Number` que puede almacenar un `int32` o un `real4`, pero solo uno a la vez.
    - Primero, asignamos un valor entero (`42`) a `num.intValue`.
    - Luego, asignamos un valor flotante (en este caso `0.0`) a `num.floatValue` usando instrucciones de la <b>unidad de punto flotante (FPU)</b>.
    - Debido a que es una unión, ambos campos ocupan el mismo espacio de memoria, así que cuando asignas un valor flotante, el valor entero ya no es válido.

# Esctructuras de Control

## Expresiones booleanas
## IF...THEN...ESLEIF...ELSE...ENDIF
## WHILE...ENDWHILE
## FOR...ENDFOR
## REPEAT...UNTIL
## BREAK / BREAKIF
## FOREVER...ENDFOR

## Control de Excepciones

| Excepción                     | Descripción                                                                                                                |
|-------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| ex.StringOverflow             | Intento de almacenar una cadena que es demasiado grande en una variable de cadena.                                         |
| ex.StringIndexError           | Intento de acceder a un carácter que no está presente en una cadena.                                                       |
| ex.StringOverlap              | Intento de copiar una cadena sobre sí misma.                                                                               |
| ex.StringMetaData             | Valor de cadena corrupto.                                                                                                  |
| ex.StringAlignment            | Intento de almacenar una cadena en una dirección no alineada.                                                              |
| ex.StringUnderflow            | Intento de extraer caracteres "negativos" de una cadena.                                                                   |
| ex.IllegalStringOperation     | Operación no permitida en datos de cadena.                                                                                 |
| ex.ValueOutOfRange            | El valor es demasiado grande para la operación actual.                                                                     |
| ex.IllegalChar                | La operación encontró un código de carácter cuyo código ASCII no está en el rango 0..127.                                  |
| ex.TooManyCmdLnParms          | La línea de comandos contiene demasiados parámetros del programa.                                                          |
| ex.BadObjPtr                  | Puntero a un objeto de clase es ilegal.                                                                                    |
| ex.InvalidAlignment           | El argumento no estaba alineado en una dirección de memoria adecuada.                                                      |
| ex.InvalidArgument            | La llamada a la función (generalmente una llamada a la API del sistema operativo) contiene un valor de argumento inválido. | 
| ex.BufferOverflow             | El objeto de búfer o blob excedió el tamaño declarado.                                                                     |
| ex.BufferUnderflow            | Intento de recuperar datos inexistentes de un blob o búfer.                                                                |
| ex.IllegalSize                | El tamaño de los datos del argumento es incorrecto.                                                                        |
| ex.ConversionError            | La operación de conversión de cadena a numérico contiene caracteres ilegales (no numéricos).                               |
| ex.BadFileHandle              | El programa intentó acceder a un archivo usando un valor de manejador de archivo inválido.                                 |
| ex.FileNotFound               | El programa intentó acceder a un archivo inexistente.                                                                      |
| ex.FileOpenFailure            | El sistema operativo no pudo abrir el archivo (archivo no encontrado).                                                     |
| ex.FileCloseError             | El sistema operativo no pudo cerrar el archivo.                                                                            |
| ex.FileWriteError             | Error al escribir datos en un archivo.                                                                                     |
| ex.FileReadError              | Error al leer datos de un archivo.                                                                                         |
| ex.FileSeekError              | Intento de buscar una posición inexistente en un archivo.                                                                  |
| ex.DiskFullError              | Intento de escribir datos en un disco lleno.                                                                               |
| ex.AccessDenied               | El usuario no tiene suficientes privilegios para acceder a los datos del archivo.                                          |
| ex.EndOfFile                  | El programa intentó leer más allá del final del archivo                                                                    |
| ex.CannotCreateDir            | El intento de crear un directorio falló.                                                                                   |
| ex.CannotRemoveDir            | El intento de eliminar un directorio falló.                                                                                |
| ex.CannotRemoveFile           | El intento de eliminar un archivo falló.                                                                                   |
| ex.CDFailed                   | El intento de cambiar a un nuevo directorio falló.                                                                         |
| ex.CannotRenameFile           | El intento de renombrar un archivo falló.                                                                                  |
| ex.MemoryAllocationFailure    | Memoria del sistema insuficiente para la solicitud de asignación.                                                          |
| ex.MemoryFreeFailure          | No se pudo liberar el bloque de memoria especificado (sistema de gestión de memoria corrupto).                             |
| ex.MemoryAllocationCorruption | Sistema de gestión de memoria corrupto.                                                                                    |
| ex.AttemptToFreeNULLc         | El llamador intentó liberar un puntero NULL.                                                                               |
| ex.AttemptToDerefNULL         | El programa intentó acceder a datos indirectamente usando un puntero NULL.                                                 |
| ex.BlockAlreadyFree           | El llamador intentó liberar un bloque que ya había sido liberado.                                                          |
| ex.CannotFreeMemory           | Fallo en la operación de liberación de memoria.                                                                            |
| ex.PointerNotInHeap           | El llamador intentó liberar un bloque de memoria que no fue asignado en el heap.                                           |
| ex.WidthTooBig                | El ancho del formato para la conversión de número a cadena era demasiado grande.                                           |
| ex.FractionTooBig             | El tamaño del formato para la parte fraccionaria en la conversión de punto flotante a cadena era demasiado grande.         |
| ex.ArrayShapeViolation        | Intento de operación en dos arreglos cuyas dimensiones no coinciden.                                                       |
| ex.ArrayBounds                | Intento de acceder a un elemento de un arreglo, pero el índice estaba fuera de los límites.                                |
| ex.InvalidDate                | Operación de fecha con una fecha ilegal.                                                                                   |
| ex.InvalidDateFormat          | La conversión de cadena a fecha contiene caracteres ilegales.                                                              |
| ex.TimeOverflow               | Desbordamiento durante la aritmética del tiempo.                                                                           |
| ex.InvalidTime                | Operación de tiempo con una hora ilegal.                                                                                   |
| ex.InvalidTimeFormat          | La conversión de cadena a hora contiene caracteres ilegales.                                                               |
| ex.SocketError                | Fallo en la comunicación de red.                                                                                           |
| ex.ThreadError                | Error genérico de hilo (multitarea).                                                                                       |
| ex.AssertionFailed            | La instrucción assert encontró una aserción fallida.                                                                       |
| ex.ExecutedAbstract           | Intento de ejecutar un método de clase abstracta.                                                                          |
| ex.AccessViolation            | Intento de acceder a una ubicación de memoria ilegal.                                                                      |
| ex.InPageError                | Error de acceso a la memoria del sistema operativo.                                                                        |
| ex.NoMemory                   | Fallo de memoria del sistema operativo.                                                                                    |
| ex.InvalidHandle              | Manejador incorrecto pasado a una llamada de la API del sistema operativo.                                                 |
| ex.ControlC                   | Se presionó CTRL-C en la consola del sistema (funcionalidad específica del sistema operativo).                             |
| ex.Breakpoint                 | El programa ejecutó una instrucción de punto de interrupción (INT 3).                                                      |
| ex.SingleStep                 | El programa está operando con el indicador de traza activado.                                                              |
| ex.PrivInstr                  | El programa intentó ejecutar una instrucción reservada para el kernel.                                                     |
| ex.IllegalInstr               | El programa intentó ejecutar una instrucción de máquina ilegal.                                                            |
| ex.BoundInstr                 | Ejecución de la instrucción Bound con un valor "fuera de límites".                                                         |
| ex.IntoInstr                  | Ejecución de la instrucción Into con el indicador de desbordamiento activado.                                              |
| ex.DivideError                | El programa intentó dividir por cero u otro error de división.                                                             |
| ex.fDenormal                  | Excepción de punto flotante                                                                                                |
| ex.fDivByZero                 | Excepción de punto flotante                                                                                                |
| ex.fInexactResult             | Excepción de punto flotante                                                                                                |
| ex.fInvalidOperation          | Excepción de punto flotante                                                                                                |
| ex.fOverflow                  | Excepción de punto flotante                                                                                                |
| ex.fStackCheck                | Excepción de punto flotante                                                                                                |
| ex.fUnderflow                 | Excepción de punto flotante                                                                                                |
| ex.InvalidHandle              | El sistema operativo reportó un manejador inválido para alguna operación.                                                  |



# Librerías
Resumen de Librerías 
| Librería      | Descripción                                                             | Funciones / Comandos Comunes                            | 
|---------------|-------------------------------------------------------------------------|---------------------------------------------------------|
| `stdlib.hhf`  | Biblioteca estándar, incluye funciones de E/S, cadenas y más.           | `stdout.put`, `stdin.get`, `malloc`, `strlen`, `strcpy` |
| `hla.hhf`     | Biblioteca base de HLA, proporciona macros esenciales.	              | `@terminate`, `@nop`, `@clear`                          |
| `math.hhf`    | Funciones matemáticas avanzadas (trigonometría, potencias, logaritmos). |	`sqrt`, `sin`, `cos`, `pow`, `log`                      |
| `conv.hhf`    | Conversión entre tipos de datos (enteros, reales, cadenas).	          | `str2int`, `int2str`, `real2str`, `str2real`            |
| `strings.hhf` | Manipulación avanzada de cadenas de caracteres.	                      | `substr`, `strcat`, `toupper`, `tolower`                |
| `fileio.hhf`  | Operaciones de entrada/salida de archivos.	                          | `file.open`, `file.read`, `file.write`, `file.close`    |
| `windows.hhf` | Interacción con la API de Windows.	                                  | `CreateFile`, `MessageBox`, `ReadFile`, `WriteFile`     |

## Librería `stdlib.hhf`

La librería stdlib.hhf es una de las bibliotecas estándar más utilizadas en HLA (High Level Assembler). Proporciona una amplia gama de funciones y macros útiles para realizar tareas comunes, como entrada/salida, manejo de cadenas, operaciones matemáticas, entre otras.

- `stdout.put`: Es una de las funciones más utilizadas para mostrar valores en la salida estándar (normalmente la consola). Soporta múltiples tipos de datos como enteros, flotantes, cadenas, y más.
    ```
    stdout.put( "Mensaje", variable, nl );
    ```



- `stdout.putc`:
- stdout.putiX
    - stdout.puti8, stdout.puti16, stdout.puti32, stdout.puti64
- stdout.putuX
    - stdout.putu8, stdout.putu16, stdout.putu32, stdout.putu64
- stdout.putfX
    - stdout.putf32 y stdout.putf64
- stdout.putiXSize






- `stdin.get`: Se utiliza para leer la entrada del usuario desde la consola. Puedes leer valores como enteros, flotantes o cadenas.
    ```
    stdin.get( variable );
    ```

- stdin.getc
- stdin.getiX
- stdin.readLn
- stdin.flushInpunt


- `exit`: Finaliza el programa con un código de retorno opcional. Se utiliza típicamente para terminar el programa de manera controlada
    ```
    exit();
    ```

- `malloc`: Reserva un bloque de memoria dinámica. Similar a la función `malloc()` en C. Se debe liberar la memoria posteriormente con `free()`.
    ```
    malloc( numBytes );
    ```
- `free`: Libera un bloque de memoria previamente asignado con `malloc()`.
    ```
    free( pointer );
    ```

- `strlen`: Devuelve la longitud de una cadena.
    ```
    length := strlen( myString );
    ```
- `strcpy`: Copia el contenido de una cadena de caracteres a otra.
    ```
    strcpy( destString, sourceString );
    ```
- `strcmp`: Compara dos cadenas de caracteres y devuelve un valor basado en la comparación (igual, menor o mayor).
    ```
    result := strcmp( string1, string2 );
    ```
- Macros útiles
    - `nl`: Inserta una nueva línea.
    - `tab`: Inserta un tabulador en la salida.
    - `space`: Inserta un espacio en blanco.

## Librería `hla.hhf`

Esta es la librería principal y contiene muchos macros y funciones básicas que son esenciales para escribir programas en HLA.

- `@terminate`: Similar a exit(), termina la ejecución del programa con un código de retorno.
    ```
    @terminate( 0 );  // Retorna 0 para indicar éxito
    ```

- `@nop`: No realiza ninguna operación, se usa para agregar "no-ops" (instrucciones vacías) en el código.
    ```
    @nop();
    ```

- `@clear`: Limpia un registro.
    ```
    @clear( eax );  // Limpia el registro eax
    ```

- `@push` y `@pop`: Macros para manejar la pila.
    ```
    @push( eax );
    @pop( ebx );
    ```

## Librería `math.hhf`

Esta librería es útil para realizar operaciones matemáticas más avanzadas como trigonometría y otras funciones de cálculo.

- `sqrt`: Calcula la raíz cuadrada de un número.
    ```
    f := sqrt( 9.0 );
    ```

- `sin`, `cos`, `tan`: Funciones trigonométricas que calculan el seno, coseno y tangente, respectivamente.
    ```
    f := sin( angle );
    f := cos( angle );
    f := tan( angle );
    ```

- `pow`: Calcula un número elevado a una potencia.
    ```
    result := pow( base, exponent );
    ```

- `log`, `log10`: Calculan el logaritmo natural (log) y el logaritmo en base 10 (log10) de un número.
    ```
    f := log( number );
    f := log10( number );
    ```

## Librería `conv.hhf`

Esta biblioteca incluye funciones para convertir entre diferentes tipos de datos, como números y cadenas.

- `str2int`: Convierte una cadena de caracteres a un entero.
    ```
    i := str2int( "123" );
    ```
- `int2str`: Convierte un entero a una cadena de caracteres.
    ```
    int2str( i, resultString );
    ```
- `real2str`: Convierte un número flotante a una cadena de caracteres.
    ```
    real2str( f, resultString );
    ```
- `str2real`: Convierte una cadena de caracteres a un número flotante.
    ```
    f := str2real( "3.14" );
    ```

## Librería `strings.hhf`

Esta biblioteca incluye funciones para convertir entre diferentes tipos de datos, como números y cadenas.

- `substr`: Extrae una subcadena a partir de una cadena dada.
    ```
    substr( sourceString, startIndex, length, destString );
    ```
- `strcat`: Concatenación de dos cadenas.
    ```
    strcat( string1, string2 );
    ```
- `toupper`, `tolower`: Convierte una cadena a mayúsculas o minúsculas.
    ```
    toupper( myString );
    tolower( myString );
    ```


## Librería `fileio.hhf`

Si necesitas manejar archivos en HLA, la librería fileio.hhf es la adecuada. Permite abrir, leer, escribir y cerrar archivos de forma sencilla.

- `file.open`: Abre un archivo en un modo específico (lectura, escritura, etc.).
    ```
    file.open( fileHandle, "archivo.txt", file.rdonly );
    ```
- `file.read`: Lee datos de un archivo abierto.
    ```
    file.read( fileHandle, buffer, numBytes );
    ```
- `file.write`: Escribe datos en un archivo.
    ```
    file.write( fileHandle, buffer, numBytes );
    ```
- `file.close`: Cierra un archivo abierto.
    ```
    file.close( fileHandle );
    ```

## Librería `windows.hhf`

Si estás trabajando con sistemas Windows y deseas interactuar con el sistema operativo, la librería windows.hhf te permitirá llamar funciones de la API de Windows directamente desde HLA.

- `CreateFile`, `ReadFile`, `WriteFile`: Llamadas a funciones del sistema para abrir, leer y escribir archivos de manera avanzada.
- `MessageBox`: Muestra una ventana de diálogo con un mensaje.
    ```
    windows.MessageBox( 0, "Mensaje", "Título", 0 );
    ```

