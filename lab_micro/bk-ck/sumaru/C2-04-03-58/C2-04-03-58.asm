.include "m328Pdef.inc"
.def TMP=R16
.def Read_V=R17
.def Var_A=R18
.def Distance=R19

.MACRO Compare
		ldi TMP,0xff
		cp R0,TMP
		brne KEYPRESSED
.ENDMACRO

.CSEG
.ORG 0x00
		rjmp RESET

RESET: 
		ldi TMP,0xFF
		out DDRB,TMP

		ldi	TMP,0xFF
		out PORTB,TMP

		ldi TMP,0x78
		out DDRC,TMP
READ_KEYPAD:
		ldi TMP,0b01110111
		ldi Distance,0
		call SCAN_KEYPAD
		Compare

		ldi TMP,0b01101111
		ldi Distance,5
		call SCAN_KEYPAD
		Compare

		ldi TMP,0b01011111
		ldi Distance,10
		call SCAN_KEYPAD
		Compare

		ldi TMP,0b00111111
		ldi Distance,15
		call SCAN_KEYPAD
		Compare
		
		rjmp READ_KEYPAD

KEYPRESSED:
		call DISP_7SEG
		rjmp READ_KEYPAD

DISP_7SEG:
		push 	ZL
		push	ZH
		push	R0
		ldi		ZL,low(TB_7SEGMENT*2)
		ldi		ZH,high(TB_7SEGMENT*2)

		ldi		TMP,0x0F
		and		Var_A,TMP
		add		ZL,Var_A
		ldi		TMP,0x00
		adc		ZH,TMP
		lpm
		com		R0
		ldi		TMP,0xFF
		out		DDRB,TMP
		out		PORTB,R0
		pop		R0
		pop		ZH
		pop		ZL
		ret

SCAN_KEYPAD:
		ldi		ZL,low(TB_7SEGMENT*2)
		ldi		ZH,high(TB_7SEGMENT*2)

		out		PORTC,TMP
		in		Read_V,PINC
		ldi		TMP,0b00000111
		and		Read_V,TMP
		add		READ_V,Distance
		subi	READ_V,3
		ldi		TMP,0x00
		add		ZL,Read_V
		adc		ZH,TMP
		lpm
		mov		Var_A,R0
		ret

KEYPAD_TABLE:
		.DB 0x01, 0xFF, 0x02, 0x03, 0xFF, 0x04, 0xFF, 0x05, 0x06, 0xFF
		.DB 0x07, 0xFF, 0x08, 0x09, 0xFF, 0x0A, 0xFF, 0x00, 0x0B, 0xFF
		

TB_7SEGMENT: 	.DB 0b00111111, 0b00000110
				.DB 0b01011011, 0b01001111
				.DB 0b01100110, 0b01101101
				.DB 0b01111101, 0b00000111
				.DB 0b01111111, 0b01101111
				.DB 0b01110111, 0b01111100
				.DB 0b00111001, 0b01011110
				.DB 0b01111001, 0b01110001
