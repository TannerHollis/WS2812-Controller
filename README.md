

# WS2812 Controller

 - WS2812 LED: [WS2812](https://cdn-shop.adafruit.com/datasheets/WS2812.pdf)
 - ICE40UL640: [ICE40UL640](https://www.latticesemi.com/~/media/LatticeSemi/Documents/DataSheets/iCE/iCE40UltraLiteDataSheetDS1050.pdf)

 
## WS2812 LED Controller
[WS2812](https://cdn-shop.adafruit.com/datasheets/WS2812.pdf) LEDs are common RGB LEDs found everywhere today. They are fundamentally controlled by a simple PWM input that signals a single bit in each period. By varying the pwm signal from either 33% duty cycle to 67% duty cycle, one bit after another, data is latched by a timing constraint as seen in the documents. The basic WS2812 RGB LED is shown below.

![WS2812 Timing Data](/Images/WS2812_timing.png)

While in theory, this RGB LED seems practical enough to control. Many various CPU intensive schemes have been created to bit-bang their way to victory. Most methods involve the use of DMA and TIMers with large buffers in STM32 microcontrollers, while in Arduino the method used is usually direct port manipulation and bit-banging. Not to mention other tricks of the trade usually involve using Assembly, *Yuck!* Even with all of the advancements in microcontroller technology of today, it is over-encumbering for the small silicon we all love and play with. 

Ideally there should be little to no overhead in microcontrollers for the actual transmission of the data to the LEDs. Also, there should ideally be on-board storage that will store values of each pixel to offload memory constraints. Well, if you've been looking for something along these lines, then perhaps you should stop and take a look at this project.

## FPGA Based

After looking at the ["smallest FPGA" in the world](https://www.latticesemi.com/Products/FPGAandCPLD/iCE40Ultra), I was curious to check it out for myself. Indeed, it is very small at just 1.4mm x 1.4mm with only 16 pins. In fact, it gets worse at only 10 useable I/O's. But wait, 4 of the 10 I/O's are dedicated SPI port programming lines, leaving you with only 6 I/O's. Oh wait, don't forget that there is only *one* traditional push-pull output and the other 5 are open-drain outputs. The ICE40UL640 also has 640 LUTs (LookUp Tables), and although it's not a good measure to use for capacity in FPGAs, it is a good metric when compared to a basic FGPA like the [Intel Cyclone V-A2](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/cyclone-v/cv_51001.pdf) which has 25,000 LUTs. 

One really great thing about the ICE40UL640 is the RAM included. There are 14 blocks of 512x8bit ram in this FPGA which are 100% utilized for memory. Users can utilize this memory however they want, whether it be for user-data or purely LED data. Each LED requires 24bits of data, which means there is a total capacity of 2389 LEDs in one WS2812 Driver. In fact, this device could be used as additional RAM, which is easy to interface using SPI. Albeit, not the fastest memory controller due to the method of SPI clock detection.

**Below is the Device Architecture**
![Device Architecture](/Images/WS2812_Device_Overview-Device%20Overview.png)

## SPI 
The SPI module in this device runs off of the device's internal High Frequency Oscillator at 48 MHz. Common practices of SPI communication protocols in FPGAs use clock-domain crossing, which means the internal SPI module operates based on two clocks. Configurations like this tend to operate at higher speeds, but require more logic elements to synthesize. Since this device is so limited in total number of elements, this device uses a "buffer clock" design. Using a buffer of only two clock cycles means, that the effective SPI input clock frequency must be half of the device's operating frequency. For more stable operation, the maximum SPI clock frequency should be:

    f_clk_spi < 24MHz

However, to ensure more stable communications it is recommended to operate well below this frequency when possible.

### SPI Communication Protocol
This device uses 24 bit (3 byte) commands to operate the device, typically consisting of the following format:

    //n'bx = don't care of size n bits
    write =		{3'b100, addr[12:0], data[7:0]};
    read =		{3'b000, addr[12:0], 8'bx};
    clear_ram =	{3'b011, 21'bx};
    fill_ram =	{3'b101, 13'bx, data[7:0]};
    send_leds =	{3'b111, 8'bx, num_leds[12:0]};

There are only a few instructions required to operate this device:
|op|Binary|Hex|Parameter(s)|Description|
|--|--|--|--|--|
|write|100|0x80|addr, data|write data to address|
|read|000|0x00|addr|read data from address|
|clear_ram|011|0x60|N/A|clear ram with zeros|
|fill_ram|101|0xA0|data|fill ram with data|
|send_leds|111|0xE0|num_leds|send leds stopping at num_leds|

A shorthand way of declaring instructions in the c language psuedocode:

    uint8_t op = 0x80;	//write op
    uint16_t addr = 0x1C00;	//maximum address to write to (7168)
    uint8_t data = 0xAA;	//8'b10101010
    
    uint8_t instr[3];	//Sending MSB first
    instr[0] = (addr >> 8) | op; 
	instr[1] = addr;
	instr[2] = data;
	
	GPIO_SetPin(&CS_n, 0);
	SPI_Transmit(&instr, sizeof(instr)); //SPI Transmit set to MSB, CPOL = 0, CPHA = 0
	GPIO_SetPin(&CS_n, 1);
    
**Although this device in hardware is configured for CPOL = 0 and CPHA = 0, future versions might be able to support other SPI transmission configurations.**

## Bus Translator
The "bus translator" in this device is the main state machine responsible for controlling the memory operations as well as preparing the data for the LED Driver module. The bus translator sits idle waiting for a valid instruction to be present. Once it is alerted of a valid instruction, the bus translator will execute the instruction. Both the read and write instructions only take one clock cycle after alerted. 

When the device receives a "send_leds" instruction, since the RAM is only 8 bits wide, the bus translator must prepare data in 3 separate reads before latching the output for the WS2812 module. The WS2812 then will alert the bus translator when new data is required, thus latching the prepared data. This cycle continues until the last chunk of data has been prepared and the LED counter reaches the number of LEDs configured in the "send_leds" instruction. Throughout the duration of sending the LED data, the device will be unresponsive.

The "clear_ram" and "fill_ram" instruction are to provide the user with a quick way to fill the ram with a given value or to quickly clear the values stored in RAM. This process is very fast, because it will execute the entire write operation at the speed of the internal system frequency.

**Bus Translator Device Architecture**
![Bus Translator State Diagram](/Images/WS2812_Device_Overview-Bus%20Translator.png)

## WS2812 Driver
The LED driver in this device is very simple. It consists of two counters, one for each bit in the 24bit data and one for the bits for the LED. Simply put, when both counters are at zero, the WS2812 module will signal that it needs new RGB data, which latches the input to the module. Upon this output signal, the bus translator will increment the led counter. Since the WS2812  module is in control of the LED counter, the WS2812 will only operate while the "send_leds_n" signal is active low.

To complete the data transmission, the controller must send a reset signal. In the WS2812, the reset signal must be at least 65us.

**This device currently only supports the WS2812 RGB LED, future versions will support other various timing-based RGB LEDs**

## RAM
The one difficulty in this device, the ICE40UL640, is that it [doesn't support tri-states](https://www.latticesemi.com/en/Support/AnswerDatabase/4/7/7/4771). The more normal approach to using a true bus configuration would be to have a single wire connecting to each of the RAM modules "data_out" port. During a read sequence, the unselected RAM modules "data_out" port would be put in high-impedance as to not conflict with the input to the bus translator from the RAM modules. Instead of using a high-impedance state, this device utilizes a demultiplexer (i.e. "demux") that is 8 bitsx16 blocks wide. The input to the demux is a 127 bit wide bus. A selector input to the "demux" will actively change the output of the demux based on which bit of the selector is active.

## TODO

 - [ ] Develop standard C Library for use with microcontrollers
 - [ ] Depending on synthesis size, add programmable LED output settings and more functionality
 - [ ] Finish documenta...
