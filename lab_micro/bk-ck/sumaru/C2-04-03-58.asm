.INCLUDE "m328Pdef.inc"

.DEF	TMP = R16
.DEF	READ_V = R17
.DEF	VAR_A = R18
.DEF	DISTANCE = R19

.MACRO	COMPARE_AND_BRANCH_IF_KEYPRESSED
			LDI		TMP,0xff
			CP		R0,TMP
			BRNE	KEYPRESSED
.ENDMACRO

.CSEG
.ORG	0x00
			RJMP	RESET

RESET:
			LDI		TMP,0xFF
			OUT		DDRB,TMP

			LDI		TMP,0xFF
			OUT		PORTB,TMP

			LDI		TMP,0x78
			OUT		DDRC,TMP

READ_KEYPAD:
			;ROW A SCAN
			LDI		TMP,0b01110111
			LDI		DISTANCE,0
			CALL	SCAN_KEYPAD
			COMPARE_AND_BRANCH_IF_KEYPRESSED
			
			;ROW B SCAN
			LDI		TMP,0b01101111
			LDI		DISTANCE,5
			CALL	SCAN_KEYPAD
			COMPARE_AND_BRANCH_IF_KEYPRESSED

			;ROW C SCAN
			LDI		TMP,0b01011111
			LDI		DISTANCE,10
			CALL	SCAN_KEYPAD
			COMPARE_AND_BRANCH_IF_KEYPRESSED

			;ROW D SCAN
			LDI		TMP,0b00111111
			LDI		DISTANCE,15
			CALL	SCAN_KEYPAD
			COMPARE_AND_BRANCH_IF_KEYPRESSED

			RJMP	READ_KEYPAD

KEYPRESSED:

			CALL	DISP_7SEG
			RJMP	READ_KEYPAD

DISP_7SEG:

			PUSH 	ZL
			PUSH	ZH
			PUSH	R0
			LDI		ZL,low(TB_7SEGMENT*2)
			LDI		ZH,high(TB_7SEGMENT*2)

			LDI		TMP,0x0F
			AND		VAR_A,TMP
			ADD		ZL,VAR_A
			LDI		TMP,0x00
			ADC		ZH,TMP
			LPM
			COM		r0
			LDI		TMP,0xff
			OUT		DDRB,TMP
			OUT		PORTB,r0
			POP		r0
			POP		ZH
			POP		ZL
			RET

SCAN_KEYPAD:
			LDI		ZL,low(KEYPAD_TABLE*2)
			LDI		ZH,high(KEYPAD_TABLE*2)

			OUT		PORTC,TMP
			IN		READ_V,PINC
			LDI		TMP,0b00000111
			AND		READ_V,TMP
			ADD		READ_V,DISTANCE
			SUBI	READ_V,3
			LDI		TMP,0x00
			ADD		ZL,READ_V
			ADC		ZH,TMP
			LPM
			MOV		VAR_A,r0
			RET

KEYPAD_TABLE:
			.DB 0x01, 0xFF, 0x02, 0x03, 0xFF, 0x04, 0xFF, 0x05, 0x06, 0xFF
			.DB 0x07, 0xFF, 0x08, 0x09, 0xFF, 0x0A, 0xFF, 0x00, 0x0B, 0xFF


TB_7SEGMENT:
			.DB 0b00111111, 0b00000110
			.DB 0b01011011, 0b01001111
			.DB 0b01100110, 0b01101101
			.DB 0b01111101, 0b00000111
			.DB 0b01111111, 0b01101111
			.DB 0b01110111, 0b01111100
			.DB 0b00111001, 0b01011110
			.DB 0b01111001, 0b01110001