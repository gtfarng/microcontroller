.include "m328Pdef.inc"

.equ all_pin_out =0xff
.equ all_pin_in = 0x00
.def var_a = r16
.def tmp = r17

.CSEG
.ORG 0x0000
		ldi var_a,all_pin_out
		out ddrb,var_a

		ldi var_a,all_pin_in
		out ddrc,var_a

		ldi tmp,0x00

MAIN: 	in var_a,pinc
		andi var_a,0x0f

		ldi zl,low(TB_7SEGMENT*2)
		ldi zh,high(TB_7SEGMENT*2)

		add zl,var_a
		adc zh,tmp
		lpm

		com r0
		out portb,r0
		rjmp MAIN

TB_7SEGMENT: 	.DB 0b00111111, 0b00000110
				.DB 0b01011011, 0b01001111
				.DB 0b01100110, 0b01101101
				.DB 0b01111101, 0b00000111
				.DB 0b01111111, 0b01101111
				.DB 0b01110111, 0b01111100
				.DB 0b00111001, 0b01011110
				.DB 0b01111001, 0b01110001

.DSEG

.ESEG
