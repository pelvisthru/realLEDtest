;
; segmentTest.asm
;
; Created: 1/11/2024 9:09:10 PM
; Author : bwen6
;


; Enable LEDs bjt and common anode
sbi VPORTC_DIR, 0
cbi VPORTC_OUT, 0

/*
ldi r16, 0xFF
sts PORTA_DIR, r16
ldi r16, 0x3F	;all on
ldi r16, 0x80 ;all off
sts PORTA_OUT, r16

;ldi r18, 0x5
;sts CLKCTRL_MCLKCTRLB, r18

;back and forth

ldi r21, 50
outer:
	ldi r19, 7
	ldi r20, 6
	rcall reconfigure
inner_down:
	rcall delay
	rcall delay
	lsr r16
	sts PORTA_OUT, r16
	dec r19
	brne inner_down
	inner_up:
		lsl r16
		ori r16, 1<<0
		sts PORTA_OUT, r16
		rcall delay
		rcall delay
		dec r20
		brne inner_up
	dec r21
	brne outer
	*/




;shift all left and then right


ldi r16, 0xFF
sts PORTA_DIR, r16
;ldi r16, 0x3F	;all on
ldi r16, 0x80 ;all off
sts PORTA_OUT, r16

ldi r21, 1
outer:
	ldi r19, 6
inner_down:
	lsr r16
	ori r16, 1<<6
	sts PORTA_OUT, r16
	rcall delay
	rcall delay
	dec r19
	brne inner_down
	ldi r19, 7
	inner_down_2:
		lsr r16
		sts PORTA_OUT, r16
		rcall delay
		rcall delay
		dec r19
		brne inner_down_2
		
	ldi r19, 6
	inner_up:
		lsl r16
		ori r16, 1<<0
		sts PORTA_OUT, r16
		rcall delay
		rcall delay
		dec r19
		brne inner_up
		ldi r19, 7
		inner_up_2:
			lsl r16
			andi r16, 0x3F
			sts PORTA_OUT, r16
			rcall delay
			rcall delay
			dec r19
			brne inner_up_2
			
dec r21
brne outer

end:
	rjmp end



;test for going up only

/*
ldi r16, 0xFF
sts PORTA_DIR, r16
ldi r16, 0x3F	;all on
;ldi r16, 0x80 ;all off
sts PORTA_OUT, r16

ldi r19, 6
inner_up_2:
	rcall delay
	rcall delay
	lsl r16
	andi r16, 0x3F
	sts PORTA_OUT, r16
	dec r19
	brne inner_up_2
*/


; binary count
/*
ldi r16, 0xFF
sts PORTA_DIR, r16
;ldi r16, 0x3F	;all on
ldi r16, 0x80 ;all off
sts PORTA_OUT, r16

inner:
	inc r16
	andi r16, 0x3F
	rcall delay
	rcall delay
	sts PORTA_OUT, r16
	cpi r16, 0
	brne inner

*/


;SOS morse code

/*
ldi r16, 0xFF
sts PORTA_DIR, r16
;ldi r16, 0x3F	;all on
ldi r16, 0x80 ;all off
sts PORTA_OUT, r16
main:
	rcall dash
	rcall dash
	rcall dash

	rcall delay
	rcall delay
	rcall delay

	rcall dot
	rcall dot
	rcall dot

	rcall delay
	rcall delay
	rcall delay

	rcall dash
	rcall dash
	rcall dash

	rcall delay
	rcall delay
	rcall delay

	rjmp main

end:
	rjmp end

dash:
	ldi r20, 3
	dashouter:
		ldi r19,3	
		dashinner:
			ldi r16, 0x3F	;all on
			sts PORTA_OUT, r16
			rcall delay
			rcall delay
			dec r19
			brne dashinner
		dec r20
		brne dashouter
	ldi r16, 0x80	;all off
	sts PORTA_OUT, r16
	rcall delay
	ret

dot:
	ldi r20, 3
	dotouter:
		ldi r19,1	
		dotinner:
			ldi r16, 0x3F	;all on
			sts PORTA_OUT, r16
			rcall delay
			rcall delay
			dec r19
			brne dotinner
		dec r20
		brne dotouter
	ldi r16, 0x80	;all off
	sts PORTA_OUT, r16
	rcall delay
	ret

	*/


/*
delay:
	ldi r18, 0
delayouter:
	ldi r17, 0
delayinner:
	dec r17
	brne delayinner
	dec r18
	brne delayouter
	ret*/

delay:
	push r18
	in r18, CPU_SREG
	push r18
	push r17

	ldi r18, 0
delayouter:
	ldi r17, 0
delayinner:
	dec r17
	brne delayinner
	dec r18
	brne delayouter

	pop r17
	pop r18
	out CPU_SREG, r18
	pop r18
	ret