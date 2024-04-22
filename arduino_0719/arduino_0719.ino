#include <ADXL345.h> 
ADXL345 adxl;

int Xaxis;
int Yaxis;
float del;
float f;
float d;

int x, y, z;
int a;
float xtoy;

int sensor0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  adxl.powerOn();
  Yaxis = 0;
  while( Serial.available() <= 0)
  {
    Serial.println("no data");
    delay(1000);  
  }

  pinMode(13,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial.available() > 0)
  {
    //if(Serial.read() =='a')
     //{

        adxl.readXYZ(&x, &y, &z);

        f = sqrt(sq(Xaxis-x)+sq(Yaxis-y));
        del = map(f,0,230,500,10);
        xtoy = atan2(x, y) / 3.14 * 180.0 ;
        
        Xaxis = x;
        Yaxis = y;
        //傾きセンサー

        sensor0 = analogRead(0);
        
        //送信用文字列
        Serial.print("Data");
        Serial.print(",");
        Serial.print(y);
        Serial.print(",");
        Serial.print(x);
        Serial.print(",");
        Serial.print(sensor0);
        Serial.print(",");
        Serial.print(f);
        Serial.print(",");
        Serial.println(xtoy);

        d = floor(f);

        if(d>20){
      digitalWrite(13,HIGH);
    }
    else{
     digitalWrite(13,LOW);
    }
    
        
    // }  
  }
  delay(10);  

}
