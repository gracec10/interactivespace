int X = 4;
int Y = 0;
int onOff = 23;
int button = 32;

void setup() 
{
Serial.begin(115200);
pinMode(X, INPUT);
pinMode(Y, INPUT);
pinMode(onOff, INPUT);
pinMode(button, INPUT);
}

void loop()
{
  int XValue = analogRead(X);
  int YValue = analogRead(Y);
  int onOffValue = digitalRead(onOff);
  int buttonValue = digitalRead(button);

  Serial.print(XValue);
  Serial.print(",");
  Serial.print(YValue);
  Serial.print(",");
  Serial.print(buttonValue);
  Serial.print(",");
  Serial.print(onOffValue);
  Serial.println(",");

  delay(1000);
}
