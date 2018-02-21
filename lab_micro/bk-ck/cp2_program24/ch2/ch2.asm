.INCLUDE "m328Pdef.inc"
.DEF	TEMP_L = R16
.DEF	TEMP_H = R17
.DEF	VAR_I = R18
.CSEG
.ORG	0x0000
	rjmp	MAIN
MAIN:	ldi	ZL, low(NAME)
		ldi	ZH, high(NAME)
		ldi TEMP_H,0x00
		ldi	VAR_I, 0
FOR:	cpi	VAR_I, 20
		brlo	LOOP
		rjmp	ENDFOR
LOOP:	mov	TEMP_L,VAR_I		
		lsr TEMP_L											
		st	Z+,TEMP_L
		st	Z+,TEMP_H		
		inc	VAR_I
		rjmp	FOR
ENDFOR:	rjmp	ENDFOR

.DSEG
.ORG	0x100
NAME:	.BYTE	20*2
.ESEG
