/*
 * ch3.asm
 *
 *  Created: 3/1/2017 6:57:40 PM
 *   Author: s5635512085
 */ 

 .INCLUDE "m328Pdef.inc"
.DEF	var_a = R16
.DEF	tmp = R17
.CSEG
.ORG	0x0000
	ldi	var_a,0xFF
	out 	DDRB,var_a
	ldi	var_a,0x00
	out 	DDRC,var_a
	ldi	tmp,0x00

MAIN:	in	var_a,PINC
	andi	var_a,0x0F
	ldi	ZL,low(TB7SEG*2)
	ldi	ZH,high(TB7SEG*2)
	add 	ZL,var_a
	adc	ZH,tmp
	lpm
	com 	R0
	out 	PORTB,R0
	rjmp	MAIN

TB7SEG:		.db 0b00111111, 0b00000110, 0b01011011, 0b01001111
		.db 0b01100110, 0b01101101, 0b01111101, 0b00000111
		.db 0b01111111, 0b01101111, 0b01110111, 0b01111100
		.db 0b00111001, 0b01011110, 0b01111001, 0b01110001


