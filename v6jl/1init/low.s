/ low core

br4 = 200
br5 = 240
br6 = 300
br7 = 340

. = 0^.
	br	1f
	4

/ trap vectors
	trap; br7+0.		/ bus error
	trap; br7+1.		/ illegal instruction
	trap; br7+2.		/ bpt-trace trap
	trap; br7+3.		/ iot trap
	trap; br7+4.		/ power fail
	trap; br7+5.		/ emulator trap
	trap; br7+6.		/ system entry

. = 40^.
.globl	start, dump
1:	jmp	start
	jmp	dump


. = 60^.
	klin; br4
	klou; br4

. = 100^.
	kwlp; br6
	kwlp; br6

. = 114^.
	trap; br7+7.		/ 11/70 parity

. = 214^.
	tcio; br6

. = 224^.
	tmio; br5

. = 240^.
	trap; br7+7.		/ programmed interrupt
	trap; br7+8.		/ floating point
	trap; br7+9.		/ segmentation violation

. = 254^.
	hpio; br5

//////////////////////////////////////////////////////
/		interface code to C
//////////////////////////////////////////////////////

.globl	call, trap

.globl	_klrint
klin:	jsr	r0,call; _klrint
.globl	_klxint
klou:	jsr	r0,call; _klxint

.globl	_clock
kwlp:	jsr	r0,call; _clock


.globl	_tcintr
tcio:	jsr	r0,call; _tcintr

.globl	_tmintr
tmio:	jsr	r0,call; _tmintr

.globl	_hpintr
hpio:	jsr	r0,call; _hpintr
