From: tstone@t-online.de (Tim Krieglstein)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: Feedback Epox 8KHA+ w83781d
Message-Id: <20020226003211.GA9656@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi 

I just wanted to give you some feedback:

I've got an Epox 8KHA+ (Via KT266) with an winbond W83697HF.
After tampering around with your latest tarball i found
no support for that chipset. So i wrote a short c programm attached
to the mail. Then after thinking about integrating these findings
into the module, i stumbled over the fact that the chip is supported
in cvs. After fiddling around with the FAQ i finally got the module
working. I confused i2c-isa and i2c-viapro (wich seems to work also)
an it took me twice as long to get the module running than writing
the small c programm...
(The sensors-detect detects the chip correct but doesn't know that
it is already supported!)

I 'll probably trim the values according to the bios 
values. If you are interested on these values or if you want me to
test something just drop me a line.

Thank you

Cheers 
Tim
-- 
It's a damn poor mind that can only think of one way to spell a word. - Andrew Jackson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensor.c
Type: text/x-csrc
Size: 570 bytes
Desc: sensor.c
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020226/9be11835/sensor.bin
-------------- next part --------------
Reserving IO-Ports 0x290
Winbond 0x5ca3
0x20 reading: 110 
0x21 reading: 0 
0x22 reading: 207 
0x23 reading: 183 
0x24 reading: 202 
0x25 reading: 209 
0x26 reading: 159 
0x27 reading: 28 
0x28 reading: 179 
0x29 reading: 255 
0x2a reading: 255 
0x2b reading: 1 
0x2c reading: 1 
0x2d reading: 0 
0x2e reading: 0 
0x2f reading: 227 
0x30 reading: 186 
0x31 reading: 204 
0x32 reading: 168 
0x33 reading: 216 
0x34 reading: 178 
0x35 reading: 49 
-------------- next part --------------
w83697hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1: 1.76 (in0)
  in0_min: 0.01 (in0_min)
  in0_max: 0.01 (in0_max)
ERROR: Can't get feature `in1' data!ERROR: Can't get feature `in1_min' data!ERROR: Can't get feature `in1_max' data!+3.3V: 3.31 (in2)
  in2_min: 2.97 (in2_min)
  in2_max: 3.63 (in2_max)
+5V: 2.94 (in3)
  in3_min: 2.68 (in3_min)
  in3_max: 3.26 (in3_max)
+12V: 3.23 (in4)
  in4_min: 2.84 (in4_min)
  in4_max: 3.45 (in4_max)
-12V: 3.36 (in5)
  in5_min: 0.33 (in5_min)
  in5_max: 0.78 (in5_max)
-5V: 2.54 (in6)
  in6_min: 0.70 (in6_min)
  in6_max: 1.02 (in6_max)
V5SB: 3.26 (in7)
  in7_min: 2.68 (in7_min)
  in7_max: 3.26 (in7_max)
VBat: 3.08 (in8)
  in8_min: 2.70 (in8_min)
  in8_max: 3.29 (in8_max)
CPU Fan: 3750.00 (fan1)
  fan1_min: 3000.00 (fan1_min)
  fan1_div: 2.00 (fan1_div)
fan2: 0.00 (fan2)
  fan2_min: 3000.00 (fan2_min)
  fan2_div: 2.00 (fan2_div)
ERROR: Can't get feature `fan3' data!ERROR: Can't get feature `fan3_min' data!  fan3_div: 308.00 (fan3_div)
Geh?use Temperatur: 28.00 (temp1)
  temp1_hyst: 50.00 (temp1_hyst)
  temp1_over: 60.00 (temp1_over)
CPU Temp: 49.50 (temp2)
  temp2_hyst: 50.00 (temp2_hyst)
  temp2_over: 60.00 (temp2_over)
ERROR: Can't get feature `temp3' data!ERROR: Can't get feature `temp3_hyst' data!ERROR: Can't get feature `temp3_over' data!ERROR: Can't get feature `vid' data!alarms: 0.00 (alarms)
  beep_enable: 0.00 (beep_enable)
  beeps: 0.00 (beeps)
sensor1: 3435.00 (sensor1)
sensor2: 3435.00 (sensor2)
ERROR: Can't get feature `sensor3' data!
