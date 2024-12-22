#include "HX711.h"
#include <SD.h>
#include "RTClib.h"

// RTC parameters
RTC_DS3231 rtc;
char daysOfTheWeek[7][12] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
float temp;

//time interval variables
  unsigned long previousMillis = 0; // For storing previous timestep
  int counter = 1;
  int INTERVAL = 1000;        // speed the sketch runs (ms)

//SD card parameters
  File myFile;
  #define FILE_NAME "SCALE1.csv"
  byte CS_pin = 4;

// HX711 circuit wiring
  const int mass1_pin = 13;
  const int mass1_sck = 12;
  const int mass2_pin = 11;
  const int mass2_sck = 10;
  const int mass3_pin = 9;
  const int mass3_sck = 6;
  const int mass4_pin = 0;
  const int mass4_sck = 1;
  float raw1;
  float raw2;
  float raw3;
  float raw4;
  float mass1;
  float mass2;
  float mass3;
  float mass4;
  HX711 scale1;
  HX711 scale2;
  HX711 scale3;
  HX711 scale4;

void setup() {
  Serial.begin(115200);
  scale1.begin(mass1_pin, mass1_sck);
  scale2.begin(mass2_pin, mass2_sck);
  scale3.begin(mass3_pin, mass3_sck);
  scale4.begin(mass4_pin, mass4_sck);

//SD test
  Serial.print("\nInitializing SD card...");
  if (!SD.begin(CS_pin)) {
    Serial.println(F("SD card initialization failed!"));
  }else{
    Serial.println(F("card initialized"));
  }

  myFile = SD.open(FILE_NAME, FILE_WRITE);
  myFile.print("Date, Time, Temp_clock, RecNum, scale_raw_1,scale_raw_2,scale_raw_3,scale_raw_4, scale_1, scale_2, scale_3, scale_4"); myFile.println(""); myFile.close();

  if (! rtc.begin()) {
    Serial.println("Couldn't find RTC");
    Serial.flush();
    while (1) delay(10);

  // When time needs to be re-set on a previously configured device, the
  // following line sets the RTC to the date & time this sketch was compiled
  rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
  // This line sets the RTC with an explicit date & time, for example to set
  // January 21, 2014 at 3am you would call:
  // rtc.adjust(DateTime(2014, 1, 21, 3, 0, 0));
  }

  if (rtc.lostPower()) {
    Serial.println("RTC lost power, let's set the time!");
    // When time needs to be set on a new device, or after a power loss, the
    // following line sets the RTC to the date & time this sketch was compiled
    //rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
    // This line sets the RTC with an explicit date & time, for example to set
    // January 21, 2014 at 3am you would call:
    // rtc.adjust(DateTime(2014, 1, 21, 3, 0, 0));
  }

}

void loop() {
  String fullstring = "";
   unsigned long currentMillis = millis(); 

  if ((currentMillis - previousMillis) >= INTERVAL) {
    
      // ..If yes, save current time.  Then update the LED pin and LED state.
    previousMillis = currentMillis;  //reset previous time for interval

    //read data from RTC
    DateTime now = rtc.now();
    temp = rtc.getTemperature();

    //Read data from scales
    raw1 = scale1.read_average(10);
    raw2 = scale2.read_average(10);
    raw3 = scale3.read_average(10);
    raw4 = scale4.read_average(10);
      
    //convert raw data from scales to grams
    mass1 = raw1*0.004720 - 344.1;
    mass2 = raw2*0.002567 - 671.3;
    mass3 = raw3*0.002616 + 99.86;
    mass4 = raw4*0.002991 - 1310;

    //output information to the serial monitor
    Serial.print("count: ");Serial.print(counter);Serial.print(" mass1: ");Serial.print(mass1);Serial.print(" ");Serial.print(" mass2:  ");Serial.print(mass2);Serial.print(" mass3:  ");Serial.print(mass3);Serial.print(" mass4:  ");Serial.print(mass4);Serial.print(" Temp ");Serial.println(temp);

    Serial.print("time: ");Serial.print(now.hour(), DEC);Serial.print(':');Serial.print(now.minute(), DEC);Serial.print(':');Serial.print(now.second(), DEC);Serial.println();

    fullstring += now.year();fullstring += "/";fullstring += now.month();;fullstring += "/";fullstring += now.day();;fullstring += ",";

    fullstring += now.hour(); ;fullstring += ":";;fullstring += now.minute();;fullstring += ":";fullstring += now.second();fullstring += ",";fullstring += temp;fullstring += ",";

    //write data to the memory card
    myFile = SD.open(FILE_NAME, FILE_WRITE);
    myFile.print(fullstring);myFile.print(float(counter));myFile.print(",");myFile.print(raw1);myFile.print(",");myFile.print(raw2);myFile.print(",");myFile.print(raw3);myFile.print(",");myFile.print(raw4);myFile.print(",");myFile.print(mass1);myFile.print(",");myFile.print(mass2);myFile.print(",");myFile.print(mass3);myFile.print(",");myFile.print(mass4);myFile.println("");myFile.close();

    counter = counter + 1;
  }
  
}
