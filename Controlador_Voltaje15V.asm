
_main:

;Controlador_Voltaje15V.c,2 :: 		void main() {
;Controlador_Voltaje15V.c,4 :: 		unsigned int pasos = 0;
;Controlador_Voltaje15V.c,5 :: 		float voltaje = 0;
;Controlador_Voltaje15V.c,9 :: 		TRISIO = 255;
	MOVLW      255
	MOVWF      TRISIO+0
;Controlador_Voltaje15V.c,10 :: 		delay_ms(50);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	NOP
;Controlador_Voltaje15V.c,11 :: 		TRISIO = 0;
	CLRF       TRISIO+0
;Controlador_Voltaje15V.c,12 :: 		TRISIO.F0 = 1;
	BSF        TRISIO+0, 0
;Controlador_Voltaje15V.c,13 :: 		GPIO = 0;
	CLRF       GPIO+0
;Controlador_Voltaje15V.c,14 :: 		delay_ms(50);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	NOP
;Controlador_Voltaje15V.c,15 :: 		ANSEL = 0b00100001; //Fosc/32 -- ANS0 pin Analogo
	MOVLW      33
	MOVWF      ANSEL+0
;Controlador_Voltaje15V.c,16 :: 		ADCON0 = 0b10000001; //Justificado a la izq. -- channel 00 -- Status 0   -- Convertidor A/D habilitado
	MOVLW      129
	MOVWF      ADCON0+0
;Controlador_Voltaje15V.c,18 :: 		delay_ms(1);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      75
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
;Controlador_Voltaje15V.c,20 :: 		while(1){
L_main3:
;Controlador_Voltaje15V.c,22 :: 		ADCON0.F1 = 1; //Comienza la conversion
	BSF        ADCON0+0, 1
;Controlador_Voltaje15V.c,23 :: 		delay_ms(1);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      75
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
;Controlador_Voltaje15V.c,24 :: 		while(ADCON0.F1); //espera que la conversion termine para bajar el flag
L_main6:
	BTFSS      ADCON0+0, 1
	GOTO       L_main7
	GOTO       L_main6
L_main7:
;Controlador_Voltaje15V.c,25 :: 		pasos = ((ADRESH & 0x03 )<<8) + ADRESL;
	MOVLW      3
	ANDWF      ADRESH+0, 0
	MOVWF      R3+0
	MOVF       R3+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
;Controlador_Voltaje15V.c,26 :: 		voltaje = pasos * resolucion;
	CALL       _word2double+0
	MOVLW      82
	MOVWF      R4+0
	MOVLW      73
	MOVWF      R4+1
	MOVLW      29
	MOVWF      R4+2
	MOVLW      119
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
;Controlador_Voltaje15V.c,29 :: 		if(voltaje > 3.8) //3.9V serían 12V aproximadamente a la entrada del circuito
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      51
	MOVWF      R0+0
	MOVLW      51
	MOVWF      R0+1
	MOVLW      115
	MOVWF      R0+2
	MOVLW      128
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main8
;Controlador_Voltaje15V.c,30 :: 		GPIO.F1 = 1;
	BSF        GPIO+0, 1
	GOTO       L_main9
L_main8:
;Controlador_Voltaje15V.c,32 :: 		GPIO.F1 = 0;
	BCF        GPIO+0, 1
L_main9:
;Controlador_Voltaje15V.c,40 :: 		}
	GOTO       L_main3
;Controlador_Voltaje15V.c,42 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
