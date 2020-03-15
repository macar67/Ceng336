
LIST    P=18F8722

#INCLUDE <p18f8722.inc> 

CONFIG OSC = HSPLL, FCMEN = OFF, IESO = OFF, PWRT = OFF, BOREN = OFF, WDT = OFF, MCLRE = ON, LPT1OSC = OFF, LVP = OFF, XINST = OFF, DEBUG = OFF


 
 delay_variable1       udata 0X22
 delay_variable1
 
 delay_variable2       udata 0X24
 delay_variable2
 
 delay_variable3       udata 0X26
 delay_variable3
 
 flagA4	    udata 0x28
 flagA4  
 
 flagE3	    udata 0x30
 flagE3 
 
 flagE4B    udata 0x32
 flagE4B 
 
 flagE4C    udata 0x34
 flagE4C 


 
ORG     0x00
goto   main

  
init:
   
    clrf PORTA
    clrf PORTB
    clrf PORTC
    clrf PORTD
    clrf PORTE
    
    
    ;-----all ports are assigned as a ouput----------------
    
    movlw b'000000000'
    movwf  flagA4 
    
    movwf TRISB
    
    movwf TRISC
    
    movwf TRISD
    
    clrf  LATB
    clrf  LATC
    clrf  LATD
       ;-----------------------------end---------------
   ;RB[0,3],RC[0,3],RD[0,7] assigment 1 becasue of the turn on all leds 
   movlw b'00001111'
   
   movwf  LATB 
   movwf  LATC
   
   movlw  b'11111111'
   movwf  LATD
   
    ;allpins are opened now 16 pin is lighted
   
    Call  delay   ;1 second 
    ;after 1 second delay
    movlw h'00'
    movwf LATB
    movwf LATC
    movwf LATD
    Call start
      
  ;-----------------------------------------------------------------------------------------------

  
  start
    clrf TRISA
    clrf LATA
    clrf PORTA
    
    clrf TRISE
    clrf LATE
    clrf PORTE
    
    movlw b'00010000'
    movwf TRISA  ;ra4 input 
       
    movlw b'00011000'
    movwf TRISE  ;rE3 and re4 input 
    
    
    
    movlw 0
 
    movwf  flagA4
    movwf  flagE3

first  
 btfss PORTA,4
 goto first
 cek
  btfsc PORTA,4
 goto cek
 incf flagA4
 goto checkPortE3
 
 
loop
    btfss PORTA,4
    goto checkPortE3
    releaseModeA4
	btfsc PORTA,4
	goto releaseModeA4
	incf flagA4
    checkPortE3
	btfss PORTE,3
	goto loop
	releaseModeE3
	    btfsc PORTE,3
	    goto releaseModeE3
	    incf flagE3
	    goto portSelection
	    
	
portSelection
   clrf PORTA
   clrf LATA
   clrf TRISA
   movlw h'00'
   movwf TRISA
   movwf LATA
  
   btfsc flagA4,0
   goto addition
   goto subtraction
   
   
addition
    movlw 0
 
    movwf  flagE4B
    
    movwf flagE4C
    
  loopAdditionPortB
    btfss PORTE,3
    goto checkPortE4B
    releaseModeE3ForAdditionB
	btfsc PORTE,3
	goto releaseModeE3ForAdditionB
	goto loopAdditionPortC
    checkPortE4B
	btfss PORTE,4
	goto  loopAdditionPortB
	releaseModeE4ForAdditionB
	    btfsc PORTE,4
	    goto releaseModeE4ForAdditionB
		   	   
	    incf flagE4B
	    light0
	    movlw  b'00000000'
	     cpfseq flagE4B
	     goto light1
	     
	     movwf LATB
	    light1
	     movlw  b'00000001'
	     cpfseq flagE4B
	     goto light2
	      movlw b'00000001'
	     movwf LATB
	     light2
		movlw  b'00000010'
	     cpfseq flagE4B
	     goto light3
	     movlw b'00000011'
	     movwf LATB
	      light3
		movlw  b'00000011'
	     cpfseq flagE4B
	     goto light4
	     movlw b'00000111'
	     movwf LATB
	      light4
		movlw b'00000100'
	     cpfseq flagE4B
	     goto light5
	     movlw h'0f'
	     movwf LATB
	     light5
	     movlw b'00000101'
	    cpfseq flagE4B
	    goto loopAdditionPortB
	    ;goto turnOfAllPins
	    movlw b'00000000'
	    movwf LATB
	    movlw 0
	    movwf  flagE4B
    
	    goto loopAdditionPortB
	     
	    
	     	    
	    
	    
loopAdditionPortC
    btfss PORTE,3
    goto checkPortE4C
    releaseModeE3ForAdditionC
	btfsc PORTE,3
	goto releaseModeE3ForAdditionC
	goto loopAdditionPortD
    checkPortE4C
	btfss PORTE,4
	goto  loopAdditionPortC
	releaseModeE4ForAdditionC
	    btfsc PORTE,4
	    goto releaseModeE4ForAdditionC
	    incf flagE4C
	     
	    
	     light0.0
	     movlw  b'00000000'
	     cpfseq flagE4C
	     goto light1.1
	     movwf LATC
	    light1.1
	     movlw  b'00000001'
	     cpfseq flagE4C
	     goto light2.1
	      movlw b'00000001'
	     movwf LATC
	     light2.1
		movlw  b'00000010'
	     cpfseq flagE4C
	     goto light3.1
	     movlw b'00000011'
	     movwf LATC
	      light3.1
		movlw  b'00000011'
	     cpfseq flagE4C
	     goto light4.1
	     movlw b'00000111'
	     movwf LATC
	      light4.1
		movlw b'00000100'
	     cpfseq flagE4C
	     goto light5.1
	    movlw b'00001111'
	     movwf LATC
	     light5.1
	     movlw b'00000101'
	    cpfseq flagE4C
	     goto loopAdditionPortC
	   ;goto turnOfAllPins
	    movlw b'00000000'
	    movwf LATC
	     movlw 0
	    movwf  flagE4C
	    goto loopAdditionPortC
	     
	    
	    
	   
loopAdditionPortD
	    
    movlw 0
    addwf flagE4C,0

     addwf flagE4B,1
     case
       movlw b'00000000'
         
    cpfseq flagE4B
    goto case0
    movwf LATD
    goto turnOffBegin
   case0  
    movlw b'00000001'
         
    cpfseq flagE4B
    goto case1
    movwf LATD
    goto turnOffBegin
    
    
   case1
   movlw b'00000010'
   
    cpfseq flagE4B
    goto case2
     movlw b'00000011'
    movwf LATD
    goto turnOffBegin
   case2
    movlw b'00000011'
    cpfseq flagE4B
    goto case3
    movlw b'00000111'
    movwf LATD
    goto turnOffBegin
   case3
    movlw b'00000100'
    cpfseq flagE4B
    goto case4
    movlw b'00001111'
    movwf LATD
    goto turnOffBegin
   case4
    movlw b'00000101'
    cpfseq flagE4B
    goto case5
     movlw b'00011111'
     movwf LATD
    goto turnOffBegin
   case5
    movlw b'00000110'
    cpfseq flagE4B
    goto case6
    movlw b'00111111'
      movwf LATD
    goto turnOffBegin
   case6
    movlw b'00000111'
    cpfseq flagE4B
    goto case7
     movlw b'01111111'
      movwf LATD
    goto turnOffBegin
   case7    
    movlw b'00001000'
    cpfseq flagE4B
    goto case
      movlw b'11111111'
      movwf LATD
    goto turnOffBegin
	
      
subtraction
	    
    movlw 0
 
    movwf  flagE4B
    
    movwf flagE4C
    
  loopSubtractionPortB
    btfss PORTE,3
    goto checkPortE4BForS
    releaseModeE3ForSubtractionB
	btfsc PORTE,3
	goto releaseModeE3ForSubtractionB
	goto loopSubtractionPortC
    checkPortE4BForS
	btfss PORTE,4
	goto  loopSubtractionPortB
	releaseModeE4ForSubtractionB
	    btfsc PORTE,4
	    goto releaseModeE4ForSubtractionB
	    incf flagE4B
	  	         	    
	     light1S
	     movlw  b'00000001'
	     cpfseq flagE4B
	     goto light2S
	      movlw b'00000001'
	     movwf LATB
	     light2S
		movlw  b'00000010'
	     cpfseq flagE4B
	     goto light3S
	     movlw b'00000011'
	     movwf LATB
	      light3S
		movlw  b'00000011'
	     cpfseq flagE4B
	     goto light4S
	     movlw b'00000111'
	     movwf LATB
	      light4S
		movlw b'00000100'
	     cpfseq flagE4B
	     goto light5S
	     movlw b'00001111'
	     movwf LATB
	     light5S
	     movlw b'00000101'
	    cpfseq flagE4B
	    
	    goto loopSubtractionPortB
	    ;goto turnOfAllPins
	    movlw b'00000000'
	    movwf LATB
	     movlw 0
	    movwf  flagE4B
	    goto loopSubtractionPortB
	     
	   
	    
  loopSubtractionPortC
    btfss PORTE,3
    goto checkPortE4CForS
    releaseModeE3ForSubtractionC
	btfsc PORTE,3
	goto releaseModeE3ForSubtractionC
	goto loopSubtractionPortD
    checkPortE4CForS
	btfss PORTE,4
	goto  loopSubtractionPortC
	releaseModeE4ForSubtractionC
	    btfsc PORTE,4
	    goto releaseModeE4ForSubtractionC
	    incf flagE4C
	    
	    light0.0S
	      movlw  b'00000000'
	     cpfseq flagE4C
	     goto light1.1S
	      movwf LATC
	     light1.1S
	     movlw  b'00000001'
	     cpfseq flagE4C
	     goto light2.1S
	      movlw b'00000001'
	     movwf LATC
	     light2.1S
		movlw  b'00000010'
	     cpfseq flagE4C
	     goto light3.1S
	     movlw b'00000011'
	     movwf LATC
	      light3.1S
		movlw  b'00000011'
	     cpfseq flagE4C
	     goto light4.1S
	     movlw b'00000111'
	     movwf LATC
	      light4.1S
		movlw b'00000100'
	     cpfseq flagE4C
	     goto light5.1S
	     movlw b'00001111'
	     movwf LATC
	     light5.1S
	     movlw b'00000101'
	    cpfseq flagE4C
	    goto loopSubtractionPortC
	    ;goto turnOfAllPins
	    movlw b'00000000'
	    movwf LATC
	     movlw 0
	    movwf  flagE4C
	    goto loopSubtractionPortC
	   
	   
loopSubtractionPortD
	    ;flagE4C ile flagE4B fark?n?n mutlak de?eri LATD ye atanmal?
      movlw 0
      addwf flagE4C,0
      cpfsgt flagE4B
      goto absoluteValue
      subwf flagE4B,1
      goto caseBase
      
  absoluteValue
     
       movlw 0
       addwf flagE4B,0
       subwf flagE4C,1
       movff flagE4C,flagE4B
     
     
     caseBase
       movlw b'00000000'
    cpfseq flagE4B
    goto case0.0
     movwf LATD
    goto turnOffBegin
   case0.0 
    movlw b'00000001'
    cpfseq flagE4B
    goto case1
     movwf LATD
    goto turnOffBegin
   case1.1
   movlw b'00000010'
    cpfseq flagE4B
    goto case2
    movlw b'00000011'
    movwf LATD
    goto turnOffBegin
   case2.2
    movlw b'00000011'
    cpfseq flagE4B
    goto case3
    movlw b'00000111'
    movwf LATD
    goto turnOffBegin
   case3.3
    movlw b'00000100'
    cpfseq flagE4B
    goto case4
    movlw b'00001111'
      movwf LATD
    goto turnOffBegin
   case4.4
    movlw b'00000101'
    cpfseq flagE4B
    goto case5
    movlw b'00011111'
     movwf LATD
    goto turnOffBegin
   case5.5
    movlw b'00000110'
    cpfseq flagE4B
    goto case6
     movlw b'00111111'
      movwf LATD
    goto turnOffBegin
   case6.6
    movlw b'00000111'
    cpfseq flagE4B
    goto case7
       movlw b'01111111'
      movwf LATD
    goto turnOffBegin
   case7.7    
    movlw b'00001000'
    cpfseq flagE4B
    goto  caseBase
    movlw b'11111111'
      movwf LATD
    goto turnOffBegin
	
    
  
	   
turnOffBegin
    call delay
    movlw b'00000000'
    movwf LATA
    movwf LATB
    movwf LATC
    movwf LATD
    movwf LATE
    
    
    goto start
    

  delay ; for delaying 1 second
    movlw h'35' 
    movwf delay_variable1
    movwf delay_variable2
    movwf delay_variable3
    loop1:
	decfsz delay_variable1
	goto loop2
	goto exitFromDelay
	loop2:
	    decfsz delay_variable2
	    goto loop3
	    goto loop1
	    loop3:
		decfsz delay_variable3
		goto loop3
		goto loop2
		
    exitFromDelay:
	clrf delay_variable1
	clrf delay_variable2
	clrf delay_variable3
	return
  ;----------endOFDelay-----------------------------------------------------------
  
  turnOfAllPins
    movlw b'00000000'
    movwf LATA
    movwf LATB
    movwf LATC
    movwf LATD
    movwf LATE
    goto loop

  main
    goto init

end
    
