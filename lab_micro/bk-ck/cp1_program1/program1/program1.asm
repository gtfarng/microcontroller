/*
 * program1.asm
 *
 *  Created: 3/1/2017 6:13:12 PM
 *   Author: s5635512085
 */ 


.INCLUDE	"m328Pdef.inc"
.DEF	VAR_A = R16
.DEF	VAR_B = R17
.DEF	VAR_C = R18
.DEF	VAR_D = R19
.DEF	VAR_E = R20
.DEF	TEMP = R21
.CSEG
.ORG 	0x0000
	rjmp	RESET
RESET:	ldi	VAR_A, 20
	ldi	VAR_B , 32
	ldi	VAR_C, 70
	ldi	VAR_D, 3
	mov	TEMP, VAR_A
	add	TEMP, VAR_B
	sub	VAR_C,VAR_D
	sub	TEMP, VAR_C
	mov	VAR_C, TEMP

; e = a*8 = 20*8 = 160 <256 ;สามารถใช้ lsl 8 bit ได้
	mov	VAR_E, VAR_A
	lsl	VAR_E
	lsl	VAR_E
	lsl	VAR_E	

	mov	VAR_D, VAR_C
	add	VAR_D, VAR_B
	sub	VAR_D,VAR_E
ENDP:	rjmp	ENDP

.DSEG
.ESEG



