const int lightSensorPin = A0;  // Analog pin connected to the light sensor
const int ampMeterPin  = A1;
const int relayPin1 = 2;
const int relayPin2 = 3;


void setup() {
  pinMode(relayPin1, OUTPUT);
  pinMode(relayPin2, OUTPUT);

  Serial.begin(9600);  // Initialize serial communication
}

void loop() {
  toggle();
  read_light();
  read_amp();

  delay(1000);  // Delay for 1 second (adjust as needed)
}

void toggle() {
  if (Serial.available() > 0) {
    char receivedChar = Serial.read();
    
    if (receivedChar == '0') {
      digitalWrite(relayPin1, LOW);  // Turn off the relay
      Serial.println("Relay 1 OFF");
    } else if (receivedChar == '1') {
      digitalWrite(relayPin1, HIGH);  // Turn on the relay
      Serial.println("Relay 1 ON");
      }else if (receivedChar == '2') {
      digitalWrite(relayPin2, LOW);  // Turn off the relay
      Serial.println("Relay 2 ON");
      }else if (receivedChar == '3') {
      digitalWrite(relayPin2, HIGH);  // Turn on the relay
      Serial.println("Relay 2 OFF");
      }
    }
  }


void read_light() {
  int lightSensorValue = analogRead(lightSensorPin);  // Read the analog value from the sensor
  Serial.print("Light Sensor Value: ");
  Serial.println(lightSensorValue);
}



void read_amp() {
unsigned int x=0;
float AcsValue=0.0,Samples=0.0,AvgAcs=0.0,AcsValueF=0.0;

  for (int x = 0; x < 150; x++){ //Get 150 samples
  AcsValue = analogRead(ampMeterPin);     //Read current sensor values   
  Samples = Samples + AcsValue;  //Add samples together
  delay (3); // let ADC settle before next sample 3ms
}
AvgAcs=Samples/150.0;//Taking Average of Samples
//((AvgAcs * (5.0 / 1024.0)) is converitng the read voltage in 0-5 volts
//2.5 is offset(I assumed that arduino is working on 5v so the viout at no current comes
//out to be 2.5 which is out offset. If your arduino is working on different voltage than 
//you must change the offset according to the input voltage)
//0.066v(66mV) is rise in output voltage when 1A current flows at input
AcsValueF = (2.5 - (AvgAcs * (5.0 / 1024.0)) )/0.066;
Serial.print("Consumption Amp Value: ");
Serial.println(AcsValueF);//Print the read current on Serial monitor

}