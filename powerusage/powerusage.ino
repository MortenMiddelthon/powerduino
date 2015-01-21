// Set the analog input pin where the photo resistor is connected
#define PHOTO 0

uint32_t timestamp;
uint32_t interval = 60000;
uint16_t counter = 0;
uint8_t c = 0;

// The light_state variable determines when the photo resistor has detected a pulse
// This is to avoid counting one pulse more than once
uint8_t light_state = 0;

// Set the photo resistor light threshold. This may have to be adjusted to your 
// environment
uint16_t threshold = 180;

void setup() {
	Serial.begin(9600);
	// Set the timestamp to current running time
	timestamp = millis();
	light_state = 0;
}


void loop() {
	uint16_t light = analogRead(PHOTO);
	// If time interval has been reached, print out the current pulse count
	if(millis() > timestamp + interval) {
		timestamp = millis();
		Serial.println();
		Serial.print("#");
		Serial.print(c);
		Serial.print(" Blinks: ");
		Serial.println(counter);
		counter = 0;
		if(c >= 255) {
			c = 0;
		}
		else {
			c++;
		}
	}
	// Count the pulse if light as above threshold value
	if(light > threshold && light_state == 0) {
		light_state = 1;
		counter++;
		Serial.println(light);
	}
	else if(light < threshold) {
		light_state = 0;
	}
	delay(5);
}
