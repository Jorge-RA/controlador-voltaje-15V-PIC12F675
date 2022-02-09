#line 1 "D:/Jorge/Codigos en Mikro C/Controlador_Voltaje15V/Controlador_Voltaje15V.c"

void main() {

 unsigned int pasos = 0;
 float voltaje = 0;



 TRISIO = 255;
 delay_ms(50);
 TRISIO = 0;
 TRISIO.F0 = 1;
 GPIO = 0;
 delay_ms(50);
 ANSEL = 0b00100001;
 ADCON0 = 0b10000001;

 delay_ms(1);

 while(1){

 ADCON0.F1 = 1;
 delay_ms(1);
 while(ADCON0.F1);
 pasos = ((ADRESH & 0x03 )<<8) + ADRESL;
 voltaje = pasos *  0.0048 ;


 if(voltaje > 3.8)
 GPIO.F1 = 1;
 else
 GPIO.F1 = 0;







 }

}
