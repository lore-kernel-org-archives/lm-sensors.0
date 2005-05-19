From: whitney@math.berkeley.edu (Wayne Whitney)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: Followup to Ticket #812 (Tyan S2460)
Message-Id: <Pine.LNX.4.33.0202091752030.4041-100000@mf1.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I got the latest CVS version of i2c and lm_sensors and tried out the new
force_subclients option, as you suggested in Ticket #812 (among others).  
My results are below, note that this is without rebooting, so I had
previously run with the older w83781d.o.  But I did initialize the sensors
in the BIOS before this boot.

As to "init=0", I find that it is required if I have not compiled my
kernel with ACPI support, but it is not required if I have compiled my
kernel with ACPI support.  Also note that I have put "compute" statements
in sensors.conf to double the fan speeds to match the BIOS readout.

I guess once we figure out which data is reliable we'll want to separate
the w83627hf and w83782d sections of sensors.conf, so as to be able to se
the options differently and ignore various inputs.

I'm really unclear on the CPU temperatures, I'll have to try a (literally)  
cold boot and watch the temperatures rise to figure out what is going on.  
Too bad I don't know how to enable bus disconnect on the 760MP chipset.

Let me know if you need any further info.

Cheers,
Wayne

[root@redstart root]# modprobe -v lm_sensors
/sbin/insmod /lib/modules/2.4.17-ide20020109/misc/i2c-core.o
Using /lib/modules/2.4.17-ide20020109/misc/i2c-core.o
Symbol version prefix 'smp_'
# post-install i2c-core:
modprobe -k i2c-amd756
/sbin/insmod /lib/modules/2.4.17-ide20020109/misc/i2c-proc.o
Using /lib/modules/2.4.17-ide20020109/misc/i2c-proc.o
/sbin/insmod /lib/modules/2.4.17-ide20020109/misc/w83781d.o force_subclients=0,0x2c,0x4a,0x4b
Using /lib/modules/2.4.17-ide20020109/misc/w83781d.o
# post-install lm_sensors:
sensors -s
[root@redstart root]# sensors
w83627hf-i2c-0-2c
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.74 V  (min =  +1.66 V, max =  +1.82 V)       ALARM  
VCore 2:   +1.72 V  (min =  +1.66 V, max =  +1.82 V)       ALARM  
+3.3V:     +3.32 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +4.99 V  (min =  +4.72 V, max =  +5.24 V)              
+12V:      +9.42 V  (min = +10.79 V, max = +13.19 V)              
-12V:     -11.88 V  (min = -13.21 V, max = -10.90 V)              
-5V:       +0.17 V  (min =  -5.26 V, max =  -4.76 V)              
V5SB:      +5.48 V  (min =  +4.72 V, max =  +5.24 V)       ALARM  
VBat:      +3.29 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:     5232 RPM  (min = 3000 RPM, div = 4)              ALARM  
fan2:     5672 RPM  (min = 3000 RPM, div = 4)              ALARM  
fan3:        0 RPM  (min = 3000 RPM, div = 4)                     
temp1:       +41?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor   ALARM   
temp2:     +51.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor           
temp3:     +35.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor           
vid:       +1.85 V
alarms:   
beep_enable:
          Sound alarm disabled

w83782d-i2c-0-2d
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.76 V  (min =  +1.66 V, max =  +1.82 V)              
VCore 2:   +2.17 V  (min =  +1.66 V, max =  +1.82 V)              
+3.3V:     +1.53 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +4.84 V  (min =  +4.72 V, max =  +5.24 V)              
+12V:      +4.67 V  (min = +10.79 V, max = +13.19 V)              
-12V:      -2.16 V  (min = -13.21 V, max = -10.90 V)              
-5V:       +2.71 V  (min =  -5.26 V, max =  -4.76 V)              
V5SB:      +4.22 V  (min =  +4.72 V, max =  +5.24 V)              
VBat:      +3.29 V  (min =  +2.40 V, max =  +3.60 V)       ALARM  
fan1:        0 RPM  (min = 3000 RPM, div = 4)                     
fan2:        0 RPM  (min = 3000 RPM, div = 4)                     
fan3:        0 RPM  (min = 3000 RPM, div = 4)                     
temp1:       +61?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor           
temp2:     +54.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor           
temp3:     +59.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor           
vid:       +1.85 V
alarms:   
beep_enable:
          Sound alarm disabled

[root@redstart root]# cat /etc/sensors.conf
chip "w83782d-*" "w83783s-*" "w83627hf-*"

# Same as above for w83781d except that in5 and in6 are computed differently.
# Rather than an internal inverting op amp, the 82d/83s use standard positive
# inputs and the negative voltages are level shifted by a 3.6V reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.

    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "V5SB"
    label in8 "VBat"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute fan1  2*@,  @/2
    compute fan2  2*@,  @/2
    compute fan3  2*@,  @/2

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in0_min 1.75 * 0.95
    set in0_max 1.75 * 1.05
    set in1_min 1.75 * 0.95
    set in1_max 1.75 * 1.05
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20
    set fan1_div 4
    set fan2_div 4
    set fan3_div 4

# set up sensor types (thermistor is default)
# 1 = PII/Celeron Diode; 2 = 3904 transistor;
# 3435 = thermistor with Beta = 3435
# If temperature changes very little, try 1 or 2.
    set sensor1 2
    set sensor2 2
    set sensor3 2

# examples for temperature limits
#    set temp1_over 40	
#    set temp1_hyst 37	
#    set temp2_over 52	
#    set temp2_hyst 47	
#    set temp3_over 52	
#    set temp3_hyst 47	
