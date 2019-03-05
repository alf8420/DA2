; This code was implemented by Alfonso Contreras
; for CPE 301  Dr.Venkatesan, and it creates a waveform of 60% DutyCycle
; of with a period of 0.725ms with 0.435ms in one state and 0.290 ms in the
;other state.


.org 0 
LDI R16,04          ;representing PB2 
 
OUT DDRB, R16       ;enable PB2 as output 
 
LDI R17,0           ;used to set or reset PB2 
 
LDI R20,5           ;set clock prescaler to 1024 
STS TCCR1B,R20 
 
begin: 
LDI R20,0x00        ;resetting the counter to 0 
STS TCNT1H,R20  
STS TCNT1L,R20 
 
 RCALL delay2        ;calling timer to wait for 1 sec 
 
 EOR R17,R16 
 OUT PORTB, R17 


LDI R20,0x00        ;resetting the counter to 0 
STS TCNT1H,R20  
STS TCNT1L,R20

RCALL delay1        ;XOR to toggle led 
EOR R17,R16

OUT PORTB, R17 
RJMP begin          ;repeat main loop 
 
delay1:            ; I'm using as OFF state
LDS R29, TCNT1H    ;loading upper bit of counter to R29     
LDS R28, TCNT1L    ;loading lower bit of counter to R28 
 
     CPI R28,0x8C  ;comparing if lower 8 bits of timer is 0x08     
	 BRSH body     ;if lower bits of timer have reached desired amount, check the upper bits    
	 RJMP delay1    ;otherwise, keep checking lower bits 
 
body:     
CPI R29,0x1A       ;check to see if upper timer bits have reached the desired value     
BRLT delay1         ;if not, recheck the lower bits     

RET



delay2:                   ; I'm using as ON state                                   
       LDS R29, TCNT1H    ;loading upper bit of counter to R29     
       LDS R28, TCNT1L    ;loading lower bit of counter to R28 
 
       CPI R28,0xB2  ;comparing if lower 8 bits of timer is 0x08     
	   BRSH body2 ;if lower bits of timer have reached desired amount, check the upper bits    
	   RJMP delay2 ;otherwise, keep checking lower bits 
 
body2:     
CPI R29,0x11 ;check to see if upper timer bits have reached the desired value     
BRLT delay2 ;if not, recheck the lower bits   

RET ;once the timer reached the desired value, toggle the LED 




