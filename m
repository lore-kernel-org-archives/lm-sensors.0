From: w.newell@verizon.net (Wes Newell)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Temps on S755MAX IT8705F
Message-Id: <40F5A42D.9070301@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've got a Jetway S755MAX (SIS755 chipset) with an AMD 64 3000+. The 
board uses an IT8705F and I've got the it87 driver loaded. LM_Sensors 
version 2.8.4 (MDK10.0). Everything works fine except I can't get the 
CPU temp working. Of the 3 temp sensors on the chip the only thing I've 
figured out is that temp2 is the MB temp. I've located the thermistor 
for this and everything is fine with it. I have no clue what temp1 is 
for. It stays at 70C most of the time. the only way I can get it to 
change is to run a a few  sessions of glxgears. It will then go up to 
72C max. Now temp3 is wild. It flucuates from 13C to about 54C and 
anyplace in between. I've gone as far to to disconnect my cpu fan to try 
and see a rise on these sensors, but I see none. Temp1 stayed at 70C, 
and temp3 acted the same and actually went from 54C to 13C once during 
this test. For the record, the bios cpu temps are stable around 41C, and 
using Smartguardian in win works fine. I've contacted Jetway, but I 
don't think they understand english very well, as I can't get a an 
answer as to which sensor is for the CPU. Anyway, with the sensors set 
to anything but thermistor, I get an invalid with sensirs output. Here's 
what I'm getting now using no temp computes.

[wes@wes2 wes]$ sensors
it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.50 V  (min =  +1.29 V, max =  +1.90 V)  VCore 2:   +1.52 
V  (min =  +1.29 V, max =  +1.90 V)  +3.3V:     +3.24 V  (min =  +3.13 
V, max =  +3.45 V)  +5V:       +4.99 V  (min =  +4.72 V, max =  +5.24 
V)  +12V:     +11.68 V  (min = +11.36 V, max = +12.60 V)  -12V:     
-11.65 V  (min = -11.10 V, max = -12.84 V)  -5V:       -4.84 V  (min =  
-4.62 V, max =  -5.32 V)  Stdby:     +4.99 V  (min =  +4.72 V, max =  
+5.24 V)  VBat:      +3.15 V
fan1:     3341 RPM  (min = 3000 RPM, div = 2)         Temp1:       
+70?C  (low  =   +20?C, high =   +70?C)   sensor = thermistor  
Temp/MB:     +30?C  (low  =   +25?C, high =   +45?C)   sensor = 
thermistor  Temp/CPU:    +36?C  (low  =   +15?C, high =   +60?C)   
sensor = thermistor

Here's the it87 section of sensors.conf.

chip "it87-*" "it8705-*" "it8712-*"

   label in0 "VCore 1"
   label in1 "VCore 2"
   label in2 "+3.3V"
   label in3 "+5V"
   label in4 "+12V"
   label in5 "-12V"
   label in6 "-5V"
   label in7 "Stdby"
   label in8 "VBat"

   set in0_min 1.3
   set in0_max 1.9
   set in1_min 1.3
   set in1_max 1.9
   set in2_min 3.3 * 0.95
   set in2_max 3.3 * 1.05
   set in3_min 5.0 * 0.95
   set in3_max 5.0 * 1.05
   set in4_min 12 * 0.95
   set in4_max 12 * 1.05
   set in5_max -12 * 1.07
   set in5_min -12 * 0.93
   set in6_max -5 * 1.07
   set in6_min -5 * 0.93
   set in7_min 5 * 0.95
   set in7_max 5 * 1.05
   ignore  vid

   compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
   compute in4 ((30/10) +1)*@  , @/((30/10) +1)
  compute in5 -(37/10)*@, -@/(37/10)
  compute in6 -(44/10)*@, -@/(44/10)
   compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# Temperature
   set sensor1 2
   set sensor2 2
   set sensor3 2

   label temp1       "Temp1"
   set   temp1_over  70
   set   temp1_low   20
   label temp2       "Temp/MB"
   set   temp2_over  45
   set   temp2_low   25
   label temp3       "Temp/CPU"
          set   temp3_over  60
   set   temp3_low   15

  # Fans
   ignore fan2
   set fan2_min 2500
   ignore fan3
   set fan3_min 3000


Any advice, even forget it would be helpful. I've messed with this for 
months. If you need more info let me know.

Thanks, Wes
