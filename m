From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 21:31:31 +0000
Subject: [lm-sensors] [patchset 0/23] pc87360 upgrade to sensors-dev-attr,
Message-Id: <42EE7857.70908@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, folks,

this is an overview of a patchset (against 13-rc3-mm3).
the patches will be sent 1 at a time, as replys to this msg.

patches do the following, in lots of tiny steps
 (repeated separately for each of: voltage, fan, pwm, temp, thermistor)

1. upgrades device_attributes to sensor-device-attributes, following 
Yani's form

    1a. change declarations: DEVICE_ATTR -> SENSOR_DEVICE_ATTR
    1b. compute sensor_dev_attr from dev_attr (part of Yani-form)
    1c. change calls to device_create_file() to match.
    1d.  drop use of offset in macros, use sda->index instead (done in 
\d+x patches)

2. converts macro-repeated sysfs-callback-functions to single instances
    
3. refactors the SENSOR_DEVICE_ATTR macro so its array-initialization 
friendly.
    __SENSOR_DEVICE_ATTR is element initiialization expression,
    SENSOR_DEVICE_ATTR uses it in 'assignment/init-statement'

4. converts uses of SENSOR_DEVICE_ATTR into
    array initializations with repeated use of  __SENSOR_DEVICE_ATTR

5. convert repeated calls to device_create_file into loops on arrays 
done in 4

01-hwmon-sysfs
         include hwmon-sysfs
02-sda-vin
       change voltage in macros per Yani-form ( 1[abc] above)
02x-sda-vin-quell-warns
       1d. above ( offset still works, but attr is unused -> warning)

03-sda-fan, 03x-sda-fan-quell-warns
04-sda-pwm, 04x-sda-pwm-quell-warns
05-sda-temp, 05x-sda-temp-quell-warns
06-sda-therm, 06x-sda-therm-quell-warns
       repeating for each sensor type
       the x versions fix 'unused var' warnings by doing: 
s/offset/attr->index/

07-mv-temp-macros-2therm
       rename macros used in thermistors, otherwize they conflict with 
temp-macros later

08-vin-demacro
       take sensor-get/set out of big macros. make them functions
       macros now just declare repeated variables, and re-use functions.

09-fan-demacro
10-pwm-demacro
11-therm-demacro
12-temp-demacro
       same for other sensor types

15-sda-arry-initializer
       refactor SENSOR_DEVICE_ATTR for array-friendliness
       new __SENSOR_DEVICE_ATTR expands to initialization expression

16-vin-arrys-loop
       do array initialization for each voltage attribute.

17-fan-pwm-arrys-loop
18-temp-arrys-loop
19-therm-arrys-loop
       repeat for other sensors.
       these also have 'offset' skew built into initialization, rather 
than the functions.

20-fixup-offset-skews
    16-19 does array initialization of attrs.
    this corrects functions to match.

for whatever reason, most attrs have an enumeration 'skew' built in;
voltages start at unit 0, but temp, fan, pwm all start at unit 1.

that skew is now more explicit in the array initialization,
and patch 20 corrects for that in the getter-setter functions.

Please look carefully at the thermistor skews,
my soekris board doesnt have those sensors wired, and they 'borrow'
parts of the other sensors:
the 3 thermistors are numbered as temps 4-6, (hence offset - 4 ??)
and also use channels 11-14 of vin (hence offset +7 ??)

I suspect more cleanup/clarification is possible...


I felt slightly anal-retentive breaking it up as above,
but it makes for easier review, and its easier to recombine them
than it is to chop them up further.
Did I go too far? not enough? just right ?

all patches, w exception of the ones that have an x version also, 
compile cleanly.
The x patches fix warnings about unused attr vars, as the macro-changes 
are minimized,
and dont replace offset with attr->index until theyre de-macroed.


FYI, patches show a some object-size growth,
then steady shrinkage starting at 08-vin-demacro.
It ends with 45% savings :-D

$ ll lx-*/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 214328 Aug  1 11:40 lx-1/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 216600 Aug  1 11:42 lx-2/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 219296 Aug  1 11:42 lx-3/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 219848 Aug  1 11:43 lx-4/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 220044 Aug  1 11:43 lx-5/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 220156 Aug  1 11:44 lx-6/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 221776 Aug  1 11:45 lx-7/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 222528 Aug  1 11:46 lx-8/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 225356 Aug  1 11:46 lx-9/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 226108 Aug  1 11:47 lx-10/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 227192 Aug  1 11:48 lx-11/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 227240 Aug  1 11:48 lx-12/drivers/hwmon/pc87360.o

-rw-rw-r--  1 jimc jimc 175648 Aug  1 11:49 lx-13/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 169664 Aug  1 11:50 lx-14/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 164096 Aug  1 11:50 lx-15/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 149692 Aug  1 11:51 lx-16/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 134628 Aug  1 11:51 lx-17/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 134628 Aug  1 11:52 lx-18/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 126288 Aug  1 11:52 lx-19/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 124880 Aug  1 11:53 lx-20/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 122492 Aug  1 11:53 lx-21/drivers/hwmon/pc87360.o
-rw-rw-r--  1 jimc jimc 120600 Aug  1 11:54 lx-22/drivers/hwmon/pc87360.o


Heres results, for 13-rc3-mm3

root@soekris:~# rmmod pc87360; modprobe  pc87360; sensors
pc87360: Device 0x09 not activated
pc87360 9191-6620: VLM conversion set to 1s period, 160us delay
pc87366-isa-6620
Adapter: ISA adapter
avi0:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)
VCORE:     +2.02 V  (min =  +0.00 V, max =  +3.01 V)
VCC:       +5.01 V  (min =  +0.00 V, max =  +6.03 V)
VPWR:     +12.34 V  (min =  +5.93 V, max = +28.02 V)
+12V:     +11.91 V  (min =  +0.00 V, max = +14.46 V)
-12V:     -12.28 V  (min = -60.61 V, max =  -2.76 V)
GND:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)
Vsb:       +3.33 V  (min =  +3.00 V, max =  +3.59 V)
Vdd:       +2.91 V  (min =  +3.00 V, max =  +3.59 V)       ALARM
Vbat:      +3.01 V  (min =  +2.40 V, max =  +3.01 V)
AVdd:      +3.31 V  (min =  +3.00 V, max =  +3.59 V)
Temp:       +109 C  (low  =    +0 C, high =   +70 C)   ALARM
Critical:    +85 C ALARM

b4 patch 20-fix-skew

root@soekris:~# rmmod pc87360; modprobe  pc87360; sensors
pc87360: Device 0x09 not activated
pc87360 9191-6620: VLM conversion set to 1s period, 160us delay
pc87366-isa-6620
Adapter: ISA adapter
avi0:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)
VCORE:     +2.01 V  (min =  +0.00 V, max =  +3.01 V)
VCC:       +5.03 V  (min =  +0.00 V, max =  +6.03 V)
VPWR:     +12.58 V  (min =  +5.93 V, max = +28.02 V)
+12V:     +11.91 V  (min =  +0.00 V, max = +14.46 V)
-12V:     -12.28 V  (min = -60.61 V, max =  -2.76 V)
GND:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)
Vsb:       +3.33 V  (min =  +3.00 V, max =  +3.59 V)
Vdd:       +2.88 V  (min =  +3.00 V, max =  +3.59 V)       ALARM
Vbat:      +3.01 V  (min =  +2.40 V, max =  +3.01 V)
AVdd:      +3.31 V  (min =  +3.00 V, max =  +3.59 V)
Temp:       +127 C  (low  =   -55 C, high =  +127 C)   OPEN
Critical:   +127 C ALARM


After I saw the OPEN, I removed the -1 from the index adjustment done in 
all the
*_temp_* callback functions - the offset is more clearly represented in 
the initialization
of the temp attr arrays.  Doing so restored the original results.

These dont differ, but voltages have no enumeration skew.
The temp number is different though :-)

root@soekris:~#
root@soekris:~# rmmod pc87360; modprobe  pc87360; sensors
pc87360: Device 0x09 not activated
pc87360 9191-6620: VLM conversion set to 1s period, 160us delay
pc87366-isa-6620
Adapter: ISA adapter
avi0:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)
VCORE:     +2.02 V  (min =  +0.00 V, max =  +3.01 V)
VCC:       +5.03 V  (min =  +0.00 V, max =  +6.03 V)
VPWR:     +12.58 V  (min =  +5.93 V, max = +28.02 V)
+12V:     +11.91 V  (min =  +0.00 V, max = +14.46 V)
-12V:     -12.28 V  (min = -60.61 V, max =  -2.76 V)
GND:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)
Vsb:       +3.33 V  (min =  +3.00 V, max =  +3.59 V)
Vdd:       +2.91 V  (min =  +3.00 V, max =  +3.59 V)       ALARM
Vbat:      +3.01 V  (min =  +2.40 V, max =  +3.01 V)
AVdd:      +3.31 V  (min =  +3.00 V, max =  +3.59 V)
Temp:       +109 C  (low  =    +0 C, high =   +70 C)   ALARM
Critical:    +85 C ALARM





FWIW, my numbers seem to agree with those on this page:
http://phk.freebsd.dk/soekris/env4801/

Im using sensors.conf from here:

http://dev.gentoo.org/~brix/papers/net4801/net4801.html


Ill be sending this patchset to soekris-tech@soekris.com,
I hope somebody there will run a sanity test for me there,
but its mostly *bsd users

have the appropriate amt of fun.
jimc
