import processing.serial.*;

Serial serial;

import processing.opengl.*;

//Soundライブラリーの読み込み
import processing.sound.*;
//サウンドプレイヤー
SoundFile soundfile;
//音量解析
Amplitude rms;


int input0 =0;//傾きセンサー
int input1 =0;
int input2 =0;
float input3 =0;
float input4=0;

float x ;
float y ;
float diameternew;
float r ;
float g ;
float b ;


float Xaxis;
float Yaxis;
float del;
float r1;
float b1;

int d;

int ms1;

void setup()
{
  //シリアルポートの設定
  serial = new Serial(this , Serial.list()[2] , 9600);
  serial.bufferUntil('\n');
  
  //通信開始のきっかけ
  serial.write("a");
  size(displayWidth, displayHeight);
  //blendMode(ADD);  
  noStroke();
  background(0);
  
  soundfile = new SoundFile(this, "037_se_kirakira17.wav");
  //soundfile.loop();
  rms = new Amplitude(this);
  rms.input(soundfile);
}

void draw()
{
    //println(input0);
    //println(input1);
    noStroke();
    fill(0,0,0,7);
    rect(0,0,displayWidth, displayHeight);
    fill(255);
    
    float diameter = random(5,10);
    
    blendMode(ADD);  
    x = map(input4,0,180,0,displayWidth);
    y = map(input1,50,300,0,displayHeight);
    
    Xaxis = x;
    Yaxis = y;
    
    d = floor(input3);
    println(d);
    
    r1 = map(input2,0,850,0,100);
    b1 = map(input2,0,850,100,0);
    
    for(int i = 0; i<d; i++){
    r = map(i, 0, d,r1, 255);
    g = map(i, 0, d,0, 255);
    b = map(i, 0, d,b1, 255);
    fill(r,g,b,20);
    noStroke();
    diameter =d-i;
    println(diameter);
    ellipse (x, y , diameter, diameter);
    }
    blendMode(BLEND);  
    
    if(d>20){
      soundfile.play();
      ms1 = millis()/1000;
    }
    
    //filter(BLUR, 1);
    
    //text("katamukix=" + input0 , 10 , 20);
    //text("katamukiy=" + input1 , 10 , 40);
}

void serialEvent(Serial serial)
{
    String sensorData_string = serial.readStringUntil('\n');
    sensorData_string = trim(sensorData_string);//改行コードを取り除く
    String sensors[] = split(sensorData_string , ',');
    
    if (sensors.length > 2)
    {
      if(sensors[0].equals("Data"))
      {
        input0 = int(sensors[1]);
        input1 = int(sensors[2]);//傾きセンサー
        input2 = int(sensors[3]);
        input3 = int(sensors[4]);
        input4 = int(sensors[5]);
        
      }
    }
    serial.write("a");
}
 void stop(){ 
  //soundfile.close();
  //soundfile.stop();
  //super.stop();
}
