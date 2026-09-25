# (1) FIRST DATA BASE LAB
---------------------------------------

## To make the output of a table pretier, it's needed 2 commands:
---------------------------------------
    ```
    sqlite> .mode column --wihtout capitals
    sqlite> .headers on
    ```
## To print out the columns of a table, it's needed 1 command:
---------------------------------------
    ``` 
    sqlite> .schema NAME_OF_TABLE
    ```
## First select sentace in sql ( example done in this database ):
---------------------------------------
    ```
    sqlite> SELECT titulo, anio --selects columns inside the table
       ...> FROM cancion #selects --the table wanted
       ...> WHERE anio > 2000  --fileters tuples by year that gretaer than 2000
       ...> ORDER BY anio desc; --orders tuples in descent. If you want in ascendant order, you can type asc
    ```

 There is a document that explains how SELECT works.

> OUTPUT OF THE CONTENT:
    ```
    titulo            anio
    ----------------  ----
    Tití Me Preguntó  2022
    Blinding Lights   2019
    Malamente         2018
    Love Story        2008
    ```

## Using patters:
---------------------------------------
    ```
    sqlite> select
       ...>     titulo,
       ...>     pais,
       ...>     genero
       ...> from cancion
       ...> where titulo LIKE '%love%' AND genero LIKE 'P__';
    ```
>output: 
## Useful keywords used in SQL:
---------------------------------------

 1) With ```SELECT``` you can choose which columns to display the tuples of a table. 
 2) If there is a lot of tuples in a database, it's possible to limit the amount displayed with ```LIMIT num```.
 3) With the keyword ```OFFSET num```, it's possible to offset the elements shown with the number specified.
 4) It's possible to remove duplicate tuples with the keyword ```DISTINCT``` right after ```SELECT```. (ex. ```SELECT DISTINCT```)
 5) To filter elements in a tuple, you can use WHERE condition. Ex: WHERE pais = 'Estados Unidos'
 6) There is boolean logic operators such as ```and```, ```or```, and ```not``` to filter stuff 
 7) It's possible to use arimthmetic operators on selected columns (if those columns are allowed to do arithmetic operations)
>   Ex: select duracion/60.0 reproducciones/10000000.0
>   **NOTE THAT IF YOU WANT THE RESULT TO BE A FOAT, YOU MUST PUT A DECIMAL POINT**
 8) Renaming a columns is as simple as: ```SELECT old_column_name AS new_column_name ```
 9) It's possible to rename it temporaly with: ```SELECT old_column_name ALIAS new_column_name```
 10) With ```ruond(x,y)```, you can set y numbers of decimals.

| bool operators | arithmetic opertors | Math Functions | Text Functions                          |
| -------------- | ------------------- | -------------- | --------------------------------------- |
| >              | +                   | round(x)       | '''||'''                                |
| <              | -                   | round(x,y)     | lenght(x)                               |
| =              | *                   | ceil(x)        | lower(x)                                |
| !=             | /                   | floor(x)       | upper(x)                                |
| >=             | %                   | abs(x)         | initcap(x) (capitalizes the first word) |
| <=             |                     | sqrt(x)        | substring(X,N)                          |
| <>             |                     |                | replace(X,Y,Z)                          |

|| 	Operador de concatenación
length(X) 	Longitud de la cadena de texto X
lower(X) 	Pasa a minúsculas todos las letras
upper(X) 	Pasa a mayúsculas todos las letras
initcap(X) 	Pasa todas las letras a minúscula y las primeras a mayúscula (no en SQLite)
substring(X, N) 	Devuelve la subcadena de X a partir del caracter N (substr en SQLite)
replace(X,Y,Z) 	Reemplaza la subcadena Y dentro de X por Z
