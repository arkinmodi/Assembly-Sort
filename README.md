# Assembly Sort
The Final Project for SFWRENG 2XA3 - Software Development Skills.

## Overview
A sorting algorithm implemented as a NSAM program.

This program takes one argument, a number between 2 - 9, which represents the number of integer elements to sort. The elements range from 1 to the inputted argument.

The program will print every stage in the sorting process to the screen. You will be require to press the `Enter` key to iterate through the stages.

## How It Works

The array of unsigned integers will be referred to as `peg`. Each item of the array represents the size of the `disk` at that position on the `disk`.

The program starts by checking if the argument is valid.

The `peg` is then initialized with a random array of numbers by the subprogram, `rconf`, which is located in `driver.c`. `rconf` takes the number of disks and the address of the array representing the `peg`.

The program will then sort this array in descending order through the use of recursion. The program will recursively call the sorting subprogram and each time it is reducing the size of the array by 1 (similar to bottom-up merge sort). The program then swaps each element until the next element is smaller than the current element (i.e. peg[i] > peg[i + 1]). Once all the recursive calls are complete, the array is now sorted.

## Example
    ./sorthem 4

          initial configuration

                   o|o
                 ooo|ooo
                oooo|oooo
                  oo|oo
         XXXXXXXXXXXXXXXXXXXXXXX


                   o|o
                 ooo|ooo
                oooo|oooo
                  oo|oo
         XXXXXXXXXXXXXXXXXXXXXXX


                   o|o
                 ooo|ooo
                  oo|oo
                oooo|oooo
         XXXXXXXXXXXXXXXXXXXXXXX


                   o|o
                  oo|oo
                 ooo|ooo
                oooo|oooo
         XXXXXXXXXXXXXXXXXXXXXXX


           final configuration

                   o|o
                  oo|oo
                 ooo|ooo
                oooo|oooo
         XXXXXXXXXXXXXXXXXXXXXXX

### Note
Only `sorthem.asm` and `makefile` were made my me. The other files were provided by the professor, [Dr. Frantisek Franek](http://www.cas.mcmaster.ca/~franek/).
