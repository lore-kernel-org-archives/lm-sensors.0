From: gar@reapl.net (Luke)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: asb100 question
Message-Id: <200404111158.58208.gar@reapl.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

	I have been trying to get sensors to work ASUS A7N8X-E Deluxe with the 
love-sources-2.6.5-r3 and lm-sensors-2.8.6, I am using gentoo.

So anyways, I use the modules i2c-nforce2, asb100 and eeprom - and when I 
emerge gkrellm, the sensors work! But when I run sensors I get:

galadriel root # sensors
eeprom-i2c-1-52
Adapter: SMBus nForce2 adapter at 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-1-50
Adapter: SMBus nForce2 adapter at 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

asb100-i2c-2-48
Adapter: SMBus nForce2 adapter at 5500
ERROR: Can't get alarm data!
ERROR: Can't get IN data! (0x0001)
ERROR: Can't get IN data! (0x0002)
ERROR: Can't get IN data! (0x0003)
ERROR: Can't get IN data! (0x0004)
ERROR: Can't get IN data! (0x0005)
ERROR: Can't get IN data! (0x0006)
ERROR: Can't get IN data! (0x0007)
ERROR: Can't get FAN data! (0x0031)
ERROR: Can't get FAN data! (0x0032)
ERROR: Can't get FAN data! (0x0033)
ERROR: Can't get TEMP data! (0x0051)
ERROR: Can't get TEMP data! (0x0054)
ERROR: Can't get TEMP data! (0x0057)
ERROR: Can't get TEMP data! (0x005a)
ERROR: Can't get VID data!
alarms:

asb100-i2c-2-49
Adapter: SMBus nForce2 adapter at 5500
ERROR: Can't get alarm data!
ERROR: Can't get IN data! (0x0001)
ERROR: Can't get IN data! (0x0002)
ERROR: Can't get IN data! (0x0003)
ERROR: Can't get IN data! (0x0004)
ERROR: Can't get IN data! (0x0005)
ERROR: Can't get IN data! (0x0006)
ERROR: Can't get IN data! (0x0007)
ERROR: Can't get FAN data! (0x0031)
ERROR: Can't get FAN data! (0x0032)
ERROR: Can't get FAN data! (0x0033)
ERROR: Can't get TEMP data! (0x0051)
ERROR: Can't get TEMP data! (0x0054)
ERROR: Can't get TEMP data! (0x0057)
ERROR: Can't get TEMP data! (0x005a)
ERROR: Can't get VID data!
alarms:

asb100-i2c-2-2d
Adapter: SMBus nForce2 adapter at 5500
ERROR: Can't get IN data! (0x0001)
ERROR: Can't get IN data! (0x0002)
ERROR: Can't get IN data! (0x0003)
ERROR: Can't get IN data! (0x0004)
ERROR: Can't get IN data! (0x0005)
ERROR: Can't get IN data! (0x0006)
ERROR: Can't get IN data! (0x0007)
ERROR: Can't get FAN data! (0x0031)
ERROR: Can't get FAN data! (0x0032)
ERROR: Can't get FAN data! (0x0033)
ERROR: Can't get TEMP data! (0x0051)
ERROR: Can't get TEMP data! (0x0054)
ERROR: Can't get TEMP data! (0x0057)
ERROR: Can't get TEMP data! (0x005a)
ERROR: Can't get VID data!
alarms:

and sensors -s:
asb100-i2c-2-48: Can't access procfs/sysfs file for writing;
Run as root?
asb100-i2c-2-49: Can't access procfs/sysfs file for writing;
Run as root?
asb100-i2c-2-2d: Can't access procfs/sysfs file for writing;
Run as root?

BTW: I am root - and sysfs is mounted - I don't use devfs anymore :)

I think it has something to do with my sensors.conf, which is just the default 
from the tar.gz from the site, which is made for Asus P4S333 (not my athlon 
board), here's the relavant bit:

chip "asb100-*"
    set vrm 9.0

    label in0 "VCore 1"
    set in0_min vid * 0.95
    set in0_max vid * 1.05

    label in1 "VCore 2"
    ignore in1
    set in1_min vid * 0.95
    set in1_max vid * 1.05

    label in2 "+3.3V"
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05

    label in3 "+5V"
    compute in3 1.68 * @ ,  @ / 1.68
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05

    label in4 "+12V"
    compute in4 3.8 * @ , @ / 3.8
    set in4_min 12  * 0.90
    set in4_max 12  * 1.10

    label in5 "-12V (reserved)"
    #ignore in5
    compute in5 -@ * 3.97 ,  -@ / 3.97
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10

    label in6 "-5V (reserved)"
    #ignore in6
    compute in6 -@ * 1.666 , -@ / 1.666
    set in6_max -5  * 0.95
    set in6_min -5  * 1.05

    label temp1 "M/B Temp"
    set temp1_over 45
    set temp1_hyst 40

    label temp2 "CPU Temp (Intel)"
    #ignore temp2
    set temp2_over 60
    set temp2_hyst 50

    # PWRTMP connector on P4S333, for external sensor
    label temp3 "Power Temp"
    #ignore temp3
    set temp3_over 45
    set temp3_hyst 40


    # Used for Athlon diode, ignore for P4S333
    label temp4 "CPU Temp (AMD)"
    set temp4_over 60
    set temp4_hyst 50
    #ignore temp4

    label fan1 "CPU Fan"
    set fan1_div 4
    set fan1_min 2000

    label fan2 "Chassis Fan"
    set fan2_div 2
    set fan2_min 4000

    label fan3 "Power Fan"
    set fan3_div 2
    set fan3_min 4000

So aside from getting "sensors" to work, I have another question, I belive 
temp1=CPU temp, temp2=MB temp (from looking at the BIOS), there are 2 other 
temps detected apparently, temp35, and temp4% (Celcius) - is one a temp 
for my nvidia graphics card, or the HDD?  I'd just like to label them 
properly :)

Thanks :)

Luke
