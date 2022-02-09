#define resolucion 0.0048
void main() {
//Variables:
 unsigned int pasos = 0;
 float voltaje = 0;
/****************************/

//Registros:
 TRISIO = 255;
 delay_ms(50);
 TRISIO = 0;
 TRISIO.F0 = 1;
 GPIO = 0;
 delay_ms(50);
 ANSEL = 0b00100001; //Fosc/32 -- ANS0 pin Analogo
 ADCON0 = 0b10000001; //Justificado a la izq. -- channel 00 -- Status 0   -- Convertidor A/D habilitado
 /****************************/
 delay_ms(1);

 while(1){

  ADCON0.F1 = 1; //Comienza la conversion
  delay_ms(1);
  while(ADCON0.F1); //espera que la conversion termine para bajar el flag
   pasos = ((ADRESH & 0x03 )<<8) + ADRESL;
   voltaje = pasos * resolucion;

  
  if(voltaje > 3.8) //3.9V serían 12V aproximadamente a la entrada del circuito
   GPIO.F1 = 1;
  else
   GPIO.F1 = 0;
  
   

  
  
 
 
 }

}