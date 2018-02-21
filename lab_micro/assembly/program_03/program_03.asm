.INCLUDE"m328Pdef.inc"

.DEF V_A=R16
.DEF V_B=R17
.DEF V_C=R18
.DEF V_D=R19
.DEF V_E=R20
.DEF R_1=R21
.DEF R_2=R22

.CSEG
.ORG 0x0000
	rjmp RESET
	
	RESET: 	ldi V_A,20
	 		ldi V_B,32
			ldi V_C,70
			ldi V_D,3
			MOV R_1,V_A
			ADD R_1,V_B
			MOV R_2,V_C
			SUB R_2,V_D
			MOV V_C,R_1
			SUB V_C,R_2
			MOV V_E,V_C
			SUBI V_E,10
			INC V_B
			MOV V_D,V_C
			ADD V_D,V_B
			SUB V_D,V_E
			DEC V_A

.DSEG
.ESEG

