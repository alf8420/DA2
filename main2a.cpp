/*
 * BLINKING.cpp
 *
 * Created: 3/2/2019 3:11:06 PM
 * Author : ALFONSO cONTRERAS
 */ 
#define F_CPU 16000000UL
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>





int main(void)
{
    // Pin B activated as OUTPUT FOR WAVESQUARE
	DDRB |= (1<<2);
	PORTD |= (1<<2);   //ACTIVATED AS PULL-UP
	EICRA = 0X2;
	
	EIMSK = (1<<AD2C);
	sei();
    
    while (1) 
    {
		PORTB ^= (1<<2);
		_delay_ms(1250);
		
    }
}

ISR (AD2C_vect)//ISR FOR EXTERNAL INTERRUPT 0
{
	PORTB ^=(1<<5);
	_delay_ms(1250);
}