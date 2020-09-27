LIST p=16F887
    #include "p16f887.inc"
; __config 0xFCF1
 __CONFIG _CONFIG1, _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_ON & _LVP_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

;***** VARIABLE DEFINITIONS

PC equ 0x02
cont1 equ 0x20
cont2 equ 0x21
Contador equ 0x22
 
 N equ 0x00
 
ORG 0x00 ; Inicio de programa
   GOTO Inicio
Inicio
    BCF STATUS, RP0; accede al banco 0
    BCF STATUS, RP1
    CLRF PORTB; Limpiar PORTB
    CLRF PORTC;
    BSF STATUS, RP0; Accede al banco 1
    CLRF TRISB; configura todas las patitas
    CLRF TRISC;
    BCF STATUS, RP0; Regresa al banco 0
    BSF STATUS, RP0
    BSF STATUS, RP1
    CLRF ANSELH
    BCF STATUS,RP0; Velve al banco 0
    BCF STATUS,RP1
    MOVLW 0X00
    MOVWF Contador
    MOVLW b'00000011'
    MOVWF PORTC;
    Paso1
    
       movlw  b'00000000'
       movwf PORTB
       movlw 0x09; Carga el número 1
       movwf Contador
       
    Display; INCREMENTO DE 1 A 9
       movf Contador,0
       call Tabla
       movwf PORTB
       DECF Contador,1
       call Retardo
       movlw 0X00; Incrementa a 10
       subwf Contador,0
       btfss STATUS,2
       goto Display
       goto Paso1
; TABLA de números
       Tabla
       ADDWF PCL,f
	RETLW 3Fh ; //Hex value to display the number 0.
	RETLW 06h ; //Hex value to display the number 1.
	RETLW 5Bh ; //Hex value to display the number 2.
	RETLW 4Fh ; //Hex value to display the number 3.
	RETLW 66h ; //Hex value to display the number 4.
	RETLW 6Dh ; //Hex value to display the number 5.
	RETLW 7Dh ; //Hex value to display the number 6.
	RETLW 07h ; //Hex value to display the number 7.
	RETLW 7Fh ; //Hex value to display the number 8.
	RETLW 6Fh ; //Hex value to display the number 9.
	RETLW 77h;
	RETURN
    Retardo; Rutina de retardo
        MOVLW N
	MOVWF cont1
    Rep1
        MOVLW N
	MOVWF cont2
    Rep2
        DECFSZ cont2,1
	goto Rep2
	DECFSZ cont1,1
	goto Rep1
	return; Retorno a la llamada de rutina
	end; fin del programa
       
    
    



