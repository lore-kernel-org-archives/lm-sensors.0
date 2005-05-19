From: jefft@spamcop.net (jefft@spamcop.net)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: lm_sensors and Tyan S2468 examples
Message-Id: <1038105339.3de03afb4c74d@webmail.spamcop.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello. Working with your documentation and information from Tyan, I have put 
together a pretty good setup for a Tyan S2468 dual-Athlon motherboard. I 
didn't see any complete examples on your website, so I'll send you this. Feel 
free to post this to your mailing list or to your support database if you 
think it would be helpful.

TYAN Thunder K7X S2468GN lm_sensors setup (note that this setup may apply at 
least partially to the S2462, S2469, and other similar motherboards).

Linux kernel 2.4.19
lm_sensors version 2.6.5

Lm_sensors was compiled and installed with defaults.

The S2468 has two Winbond monitoring chips, a W83627HF and a W83782D. As with 
other recent Tyan motherboards, it is necessary to move one of the two chips 
to another address. To do this, place the following lines in 
your /etc/modules.conf:
# I2C module options
alias char-major-89 i2c-dev
options w83781d init=1 force_subclients=0,0x2c,0x4a,0x4b

On startup, use the following to load the required I2C modules and load the 
lm_sensors configuration file.
#lm_sensors stuff
# I2C adapter drivers
modprobe i2c-amd756
# I2C chip drivers
modprobe w83781d
/usr/local/bin/sensors -s

The following configuration file was created based on experimentation and 
information from Tyan. It is highly customized to the S2468 motherboard. The 
voltages and fans match the Tyan documentation.

# Sensors configuration file used by 'libsensors'
#------------------------------------------------
#
#### Here begins the real configuration file

chip "w83627hf-*"

# Same as above for w83781d except that in5 and in6 are computed differently.
# Rather than an internal inverting op amp, the 82d/83s use standard positive
# inputs and the negative voltages are level shifted by a 3.6V reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.

    label in0 "VCore 1"
    label in1 "VCore 2"
    label in5 "V AGP"
    ignore in2
    ignore in3
    ignore in4
    ignore in6
    ignore in7
    ignore in8

    label fan1 "Chas 2"
    label fan2 "Chas 5"
    label fan3 "Chas 6"
    label temp1 "T VRM1"
    label temp2 "T AGP"
    label temp3 "T DDR"

# adjust this if your vid is wrong; see doc/vid
#   set vrm 9.0

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in0_min vid*0.95
    set in0_max vid*1.05
    set in1_min vid*0.95
    set in1_max vid*1.05
    set in5_min 3.3 * 0.95
    set in5_max 3.3 * 1.05

# set up sensor types (thermistor is default)
# 1 = PII/Celeron Diode; 2 = 3904 transistor;
# 3435 = thermistor with Beta = 3435
# If temperature changes very little, try 1 or 2.
#   set sensor1 1
#   set sensor2 2
#   set sensor3 3435
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


chip "w83782d-*"

# Same as above for w83781d except that in5 and in6 are computed differently.
# Rather than an internal inverting op amp, the 82d/83s use standard positive
# inputs and the negative voltages are level shifted by a 3.6V reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.

    label in1 "V DDR"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in8 "VBat"
    ignore in0
    ignore in6
    ignore in7
    label fan1 "CPU 1"
    label fan2 "CPU 2"
    label fan3 "Chas 1"
    label temp1 "T CPU1"
    label temp2 "T CPU2"
    label temp3 "T VRM2"

    compute in1 (2)*@ ,	@/(2)
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14

# adjust this if your vid is wrong; see doc/vid
#   set vrm 9.0

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in1_min 2.5 * 0.95
    set in1_max 2.5 * 1.05
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

# set up sensor types (thermistor is default)
# 1 = PII/Celeron Diode; 2 = 3904 transistor;
# 3435 = thermistor with Beta = 3435
# If temperature changes very little, try 1 or 2.
#   set sensor1 1
#   set sensor2 2
#   set sensor3 3435
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

This configuration file produces the following sample output. Note that I 
don't have my chassis fans hooked to the fan connectors on the motherboard.

root@gamma:/etc# sensors
w83782d-i2c-0-28
Adapter: SMBus AMD768 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
V DDR:     +2.48 V  (min =  +2.36 V, max =  +2.62 V)
+3.3V:     +3.39 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.97 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.16 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.39 V  (min = -13.21 V, max = -10.90 V)
VBat:      +3.32 V  (min =  +2.40 V, max =  +3.60 V)
CPU 1:    7941 RPM  (min = 3000 RPM, div = 2)
CPU 2:    7941 RPM  (min = 3000 RPM, div = 2)
Chas 1:      0 RPM  (min = 3000 RPM, div = 2)
T CPU1:      +51?C  (limit =  +60?C)                       sensor = 3904 
transistor
T CPU2:    +59.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 
transistor   ALARM
T VRM2:    +59.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 
transistor   ALARM
vid:      +1.850 V
alarms:
beep_enable:
          Sound alarm disabled

w83627hf-i2c-0-2c
Adapter: SMBus AMD768 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.74 V  (min =  +1.74 V, max =  +1.93 V)       ALARM
VCore 2:   +1.74 V  (min =  +1.74 V, max =  +1.93 V)       ALARM
V AGP:     +3.32 V  (min =  +3.13 V, max =  +3.45 V)
Chas 2:      0 RPM  (min = 3000 RPM, div = 2)
Chas 5:      0 RPM  (min = 3000 RPM, div = 2)
Chas 6:      0 RPM  (min = 3000 RPM, div = 2)
T VRM1:      +49?C  (limit =  +60?C)                       sensor = 3904 
transistor
T AGP:     +37.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 
transistor
T DDR:     +37.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 
transistor
vid:      +1.850 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

Hopefully this helps other people to get this motherboard going. It's a great 
motherboard with very good monitoring options.

Jeff
jefft@spamcop.net
