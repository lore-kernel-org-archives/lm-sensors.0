From: wberrier@myrealbox.com (Wade Berrier)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: K7VTA3 v 6.0
Message-Id: <1110614002.11476.12.camel@crusader>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I found the lm_sensors project while trying to find out how to control
the fan speed of my computers.

I've tried just about everything I can find on the net but when I run
pwmconfig, I get the following:

There are no pwm-capable sensor modules installed

Here are the modules I'm using from sensors-detect:

i2c-isa
# I2C chip drivers
it87


It almost seems that I should load the i2c-viapro, but it doesn't work.

Here are some of the entries in the /sys filesystem with the i2c-isa and
it87 modules loaded:

cd /sys
find . -name "*fan*"

./devices/platform/i2c-1/1-0290/fan3_div
./devices/platform/i2c-1/1-0290/fan2_div
./devices/platform/i2c-1/1-0290/fan1_div
./devices/platform/i2c-1/1-0290/fan3_min
./devices/platform/i2c-1/1-0290/fan2_min
./devices/platform/i2c-1/1-0290/fan1_min
./devices/platform/i2c-1/1-0290/fan3_input
./devices/platform/i2c-1/1-0290/fan2_input
./devices/platform/i2c-1/1-0290/fan1_input

It appears that pwmconfig is looking for fan1_pwm, but it does not find
it.

I don't know if it's a hardware limitation, or a driver limitation.

My motherboard is an ECS K7VTA3 rev6, with the via8235 chipset (although
lm_sensors seems to like to use the isa interface instead...).

Any suggestions of how I can get my fans to slow down based on
temperature?

If I get a spare harddrive I may try installing Windows XP and running
SpeedFan to see if my motherboard is actually capable.

Here is the output of sensors:

crusader:/sys/devices/platform/i2c-1/1-0290# sensors
it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.65 V  (min =  +1.42 V, max =  +1.57 V)   ALARM
VCore 2:   +2.53 V  (min =  +2.40 V, max =  +2.61 V)   
+3.3V:     +6.59 V  (min =  +3.14 V, max =  +3.46 V)   ALARM
+5V:       +5.13 V  (min =  +4.76 V, max =  +5.24 V)   
+12V:     +12.35 V  (min = +11.39 V, max = +12.61 V)   
-12V:     -11.90 V  (min = -12.63 V, max = -11.41 V)   
-5V:       -3.94 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
Stdby:     +3.33 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
VBat:      +3.23 V
fan1:     2445 RPM  (min =    0 RPM, div = 8)          
fan2:     2812 RPM  (min =  664 RPM, div = 8)          
fan3:        0 RPM  (min =  664 RPM, div = 8)          
M/B Temp:    +27?C  (low  =   +15?C, high =   +40?C)   sensor thermistor   
CPU Temp:    +42?C  (low  =   +15?C, high =   +45?C)   sensor thermistor   
Temp3:       +45?C  (low  =   +15?C, high =   +45?C)   sensor thermistor   

Thank you for the contributions you've made through your software.

Wade
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050312/16fdc47c/attachment.bin
