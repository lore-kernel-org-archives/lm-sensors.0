From: Jaap de Wolff <jaap@de-wolff.org>
Date: Fri, 17 Jun 2011 18:20:32 +0000
Subject: [lm-sensors] ASRock E350M1 configuration
Message-Id: <4DFB9AF0.500@de-wolff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

I did build a w83627ehf.ko driver for Ubuntu Natty system with the 
ubuntu 2.6.38-8-generic kernel.

After some experiments I came to the following configuration file  for 
my ASRock E350M1 MB:

The used config file and the sensor output are at the bottom of this post.

The values of in4 - in7 I am quite sure about:
The values match almost exact the values of what I see in the bios reading.
The same is true for the temp1 and temp2, and for the fan speed.

The raw value of in8 is just below the value of in7, but that it is 
reading the -12V is just a wild guess.
in2 and in3 are always exactly 3.3 V, so I suppose those are Vcc
in0 and in1 fluctuate between 0.95 and 1.35 V where in0 rises first when 
there is more processor activity.
I called them VCore 1 and 2, but not sure about those.

there is always a reading in the sensors that is labeled cpu0_vid, and 
always has the value 0.0V, but I have no idea what this is telling, or 
how I can remove it.

Anyone can confirm or give comment on those settings?

Jaap


$ cat /etc/sensors.d/sensors.conf
################################ start config part ###
chip "nct6775-*"

     label in0 "VCore1"
     label in1 "VCore2"
     label in2 "VCC1"
     label in3 "VCC2"
     label in4 "DRAM"
     label in5 "+1.8"
     label in6 "5V"
     label in7 "12V"
     label in8 "-12V"

# +12V -12V and +5V use dividers
     compute in6 @*3,  @/3
     compute in7 @*3.5,  @/3.5
     compute in8 @*-3.5,  @/-3.5

     set in0_min   0.9
     set in0_max   1.5
     set in1_min   0.9
     set in1_max   1.5
     set in2_min   3.3*0.95
     set in2_max   3.3*1.05
     set in3_min   3.3*0.95
     set in3_max   3.3*1.05
     set in4_min   1.3
     set in4_max   2.0
     set in5_min   1.8
     set in5_max   2.1
     set in6_min   5.0*0.95
     set in6_max   5.0*1.05
     set in7_min   12*0.95
     set in7_max   12*1.05
     set in8_min   -12*0.95
     set in8_max   -12*1.05

# Fans
    label fan1      "Chassis Fan1"
    label fan2      "CPU Fan"
    label fan3      "Chassis Fan2"
    ignore fan4

    set fan2_min    700

# Temperatures
    label temp1     "Sys Temp"
    label temp2     "CPU Temp"
    label temp3     "Temp?"

    set temp1_max       80
    set temp1_max_hyst  75


chip "k10temp-*"

   label temp1 "Cpu Core Temp"

######################################################## end config part 
############
$ sensors
######################### begin of sensor output #######################
nct6775-isa-0290
Adapter: ISA adapter
VCore1:       +0.96 V  (min =  +0.90 V, max =  +1.50 V)
VCore2:       +0.98 V  (min =  +0.90 V, max =  +1.50 V)
VCC1:         +3.30 V  (min =  +3.14 V, max =  +3.47 V)
VCC2:         +3.30 V  (min =  +3.14 V, max =  +3.47 V)
DRAM:         +1.38 V  (min =  +1.30 V, max =  +2.00 V)
+1.8:         +1.84 V  (min =  +1.80 V, max =  +2.04 V)
5V:           +4.94 V  (min =  +4.75 V, max =  +5.26 V)
12V:         +12.10 V  (min = +11.42 V, max = +12.60 V)
-12V:        -11.98 V  (min = -11.42 V, max = -12.60 V)
Chassis Fan1:   0 RPM  (min =    0 RPM, div = 128)
CPU Fan:     3245 RPM  (min =  703 RPM, div = 16)
Chassis Fan2:   0 RPM  (min =    0 RPM, div = 128)
Sys Temp:     +50.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = 
thermistor
CPU Temp:     +55.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = 
thermistor
Temp?:         -8.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = 
thermistor
cpu0_vid:    +0.000 V

k10temp-pci-00c3
Adapter: PCI adapter
Cpu Core Temp: +70.0°C  (high = +70.0°C, crit = +75.0°C)

######################### end of sensor output #######################

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
