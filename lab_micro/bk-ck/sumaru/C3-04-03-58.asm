.INCLUDE "m328Pdef.inc"

.DEF read=R16
.DEF num=R17
.DEF var_i=R18
.DEF TMP=R19

.CSEG
.ORG 0x00
		ldi TMP,0xFF
		out DDRB,TMP  ;portb bit 0-7 = output
		ldi TMP,0x00
		out DDRC,TMP  ;portc bit 0-7 = input
		ldi var_i,0
Reset:	ldi ZL,low(TB_7SEGMENT*2)
		ldi	ZH,high(TB_7SEGMENT*2)
		in read,pinc
		andi read,0b01110000
For:	cpi var_i,4		;var_i<4
		brlo Shift
		rjmp Endfor
Shift:	lsr read
		inc var_i
		rjmp For

Endfor:	ldi var_i,0
		add ZL,read
		adc ZH,var_i
		lpm
		out portb,R0
		rjmp Reset

TB_7SEGMENT:
			.DB 0b00000000, 0b00000001
			.DB 0b00000011, 0b00000111
			.DB 0b00001111, 0b00011111
			.DB 0b00111111, 0b01111111
