# Assembly Sort
The Final Project for SFWRENG 2XA3 - Software Development Skills.

## Overview
A sorting algorithm implemented as a NSAM program.

This program takes one argument, a number between 2 - 9 (inclusive), which represents the number of integer elements to sort. The elements range from 1 to the inputted argument.

The program will print every stage in the sorting process to the screen. You will be require to press the `Enter` key to iterate through the stages.

## How To Run
(Recommended) Use the [prebuilt Docker image](https://github.com/arkinmodi/Assembly-Sort/pkgs/container/assembly-sort), by running the following:
```
docker run -it --rm ghcr.io/arkinmodi/assembly-sort:latest <a number between 2 and 9>
```

To build and run using Docker, run the following:
```
docker build -t assembly-sort .
docker run -it --rm assembly-sort <a number between 2 and 9>
```

To build and run locally, run the following:
```
make assembly-sort
./assembly-sort <a number between 2 and 9>
```

> Note: This is a 32-bit application and may require additional packages to get building/running.

## How It Works
The array of unsigned integers will be referred to as `peg`. Each item of the array represents the size of the `disk` at that position on the `disk`.

The program starts by checking if the argument is valid.

The `peg` is then initialized with a random array of numbers by the subprogram, `rconf`, which is located in `driver.c`. `rconf` takes the number of disks and the address of the array representing the `peg`.

The program will then sort this array in descending order through the use of recursion. The program will recursively call the sorting subprogram and each time it is reducing the size of the array by 1 (similar to bottom-up merge sort). The program then swaps each element until the next element is smaller than the current element (i.e. peg[i] > peg[i + 1]). Once all the recursive calls are complete, the array is now sorted.

## Example
    ./assembly-sort 4

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
Only `assembly-sort.asm` and `makefile` were made my me. The other files were provided by [Dr. Frantisek Franek](http://www.cas.mcmaster.ca/~franek/).
