/*
File:   test.c
Author: Taylor Robbins
Date:   12\14\2024
Description: 
	** Testing out using zig as a shared or dynamic library called "mathtest"
*/

// #include <stdio.h>
#include <stdint.h>
#include "mathtest.h"

int main(int argc, char** argv)
{
	int32_t result = add(42, 1337);
	printf("result = %d\n", result);
	return 0;
}

