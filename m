From: tonu@jes.ee (Tonu Samuel)
Date: Wed, 05 Oct 2005 19:48:27 +0000
Subject: [lm-sensors] SE95 driver
Message-Id: <200510052047.16399.tonu@jes.ee>
List-Id: <lm-sensors.vger.kernel.org>
References: <4647.192.168.0.190.1127544743.squirrel@www.jes.ee>
In-Reply-To: <4647.192.168.0.190.1127544743.squirrel@www.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Monday 26 September 2005 23:54, you wrote:

> > Seems like Philips SE95 i2c thermo sensor support is missing. Datasheet
> > http://www.semiconductors.philips.com/acrobat/datasheets/SE95_2.pdf

I got now hardware working and can read data out of chips on i2c. I fetched 
lm_sensors2 fom CVS and implemented SE95 detection code as it was always 
confused with some DS1621 whose driver didn't worked at all for this chip.

Is it OK to submit some patches for detection only? I think I also can detect 
pcf8574 and newer brother pca9554. They are very similar chips.

More....pcf8583 (clock, calendar and some RAM) drivers seems to exist in 
kernel in other tree than i2c. Right now it does not get detected (goes for 
EEPROM, confidence 2) and as much I have today tested it, looks like it is 
difficult to detect it properly. 0x50 and 0x51 are only addresses 8583 can 
reside on. It is difficult to tell what chip it is unless writing to it. If 
it breaks, then chip was rewritable EEPROM :P

tonu@pm:~> locate pcf8583
/usr/src/linux-2.6.11.4-21.9/drivers/acorn/char/pcf8583.c
/usr/src/linux-2.6.11.4-21.9/drivers/acorn/char/pcf8583.h
tonu@pm:~>   

I soldered pca9698 to prototyping board. Huh, 0,5mm legspan is something I do 
not like to solder. Please add this chip to my "TODO" in new drivers list. I 
get to it after SE95 is done. pca9506 also. 

Some output and example patch included. Nothing important. Just FYI. I am 
going to verify many things as there can be "extra" noise from LM75 where it 
was derived. Plus own bugs of course :)

   Tonu
----------------------------------------------------------------------------------
This is SE95. 

home:~/lm_sensors2 # ./prog/dump/i2cdump 0 0x4f
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x4f, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 12 00 4b 50 00 a1 95 00 00 00 00 00 00 00 00 00    ?.KP.??.........
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
home:~/lm_sensors2 #               
---------------------------------------------------------------------------------
This is pcf8583 - mostly useless random stuff. At least from detection 
viewpoint. 

home:~/lm_sensors2 # ./prog/dump/i2cdump 0 0x51
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x51, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 45 00 01 00 01 01 00 00 41 41 41 41 41 41 41    .E.?.??..AAAAAAA
10: 60 03 01 00 53 41 41 81 c3 40 45 06 41 4c 43 48    `??.SAA??@E?ALCH
20: 67 01 48 20 c1 41 99 c8 48 01 51 c1 c1 c9 61 60    g?H ?A??H?Q???a`
30: c0 45 01 d0 41 41 41 25 c5 70 e1 52 e3 55 41 01    ?E??AAA%?p?R?UA?
40: 05 61 43 40 49 c3 c1 40 51 41 49 45 43 51 e0 18    ?aC@I??@QAIECQ??
50: c9 c1 c3 01 45 41 41 41 31 24 51 40 81 51 41 41    ????EAAA1$Q@?QAA
60: 5d 43 41 49 41 43 01 15 d7 a8 2f 81 5f 38 a8 10    ]CAIAC????/?_8??
70: be 55 81 c1 b7 5e 5e 79 ea be a5 d8 ce e2 4c e8    ?U???^^y??????L?
80: 28 80 e8 3b 75 05 84 26 a9 e6 b3 c2 93 59 c2 5e    (??;u??&?????Y?^
90: c3 42 c8 26 be 58 cd 88 ae bc 3a e4 f6 13 96 a6    ?B?&?X????:?????
a0: d2 7a b9 f2 f8 96 b3 d2 0d af d8 97 2e 83 5e 0c    ?z??????????.?^?
b0: 97 20 1d 06 f9 77 39 3f ef c5 21 9b 18 71 eb dd    ? ???w9???!??q??
c0: 24 18 38 fb 43 b1 68 80 e9 e3 a4 06 92 00 35 e8    $?8?C?h??????.5?
d0: cc 5a 24 44 de 4f 34 e5 ff 5b d5 1c 3a db af 8b    ?Z$D?O4?.[??:???
e0: ca f5 93 aa ea ef 14 44 b8 1a e8 e6 ef 0b f6 fa    ???????D????????
f0: 03 0f 31 06 01 a3 07 bb 6e 8c ec 1a 89 8a f3 20    ??1?????n??????
home:~/lm_sensors2 #                

----------------------------------------------------------------------------------

home:~/lm_sensors2 # ./prog/detect/sensors-detect
# sensors-detect revision 1.395 (2005/10/01 15:34:38)

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:02.3: Intel 82371AB PIIX4 ACPI
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: ISA main adapter
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus PIIX4 adapter at 5000
Do you want to scan it? (YES/no/selectively):
Client at address 0x20 can not be probed - unload all client drivers first!
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Success!
    (confidence 6, driver `lm78')
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Success!
    (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Winbond W83L785R'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Philips NE1619'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `VIA VT1211 (I2C)'... Failed!
Probing for `ITE IT8712F'... Failed!
Probing for `ALi M5879'... Failed!
Probing for `SMSC LPC47M15x or LPC47M192'... Failed!
Client at address 0x38 can not be probed - unload all client drivers first!
Client found at address 0x48
Probing for `National Semiconductor LM75'... Failed!
Probing for `Philips SE95'... Failed!
Probing for `National Semiconductor LM77'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Maxim MAX6650/MAX6651'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x49
Probing for `National Semiconductor LM75'... Failed!
Probing for `Philips SE95'... Failed!
Probing for `National Semiconductor LM77'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x4f
Probing for `National Semiconductor LM75'... Failed!
Probing for `Philips SE95'... Success!
    (confidence 8, driver `se95')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Success!
    (confidence 6, driver `lm78')
    Alias of the chip on I2C bus `SMBus PIIX4 adapter at 5000', address 0x002d
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
    Alias of the chip on I2C bus `SMBus PIIX4 adapter at 5000', address 0x002d
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `lm78' (may not be inserted):
  Misdetects:
  * Bus `SMBus PIIX4 adapter at 5000'
    Busdriver `i2c-piix4', I2C address 0x2d
    ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `National Semiconductor LM78' (confidence: 6)

Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 5000'
    Busdriver `i2c-piix4', I2C address 0x2d (and 0x48 0x49)
    ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83781D' (confidence: 8)

Driver `se95' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 5000'
    Busdriver `i2c-piix4', I2C address 0x4f
    Chip `Philips SE95' (confidence: 8)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 5000'
    Busdriver `i2c-piix4', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus PIIX4 adapter at 5000'
    Busdriver `i2c-piix4', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 1)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
options w83781d ignore=0,0x2d
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-piix4
modprobe i2c-isa
# I2C chip drivers
modprobe w83781d
# Warning: the required module se95 is not currently installed on your system.
# For status of 2.6 kernel ports see 
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the 
following line.
modprobe se95
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
home:~/lm_sensors2 #
--------------------------------------------------------------
Index: kernel/chips/Module.mk
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/Module.mk,v
retrieving revision 1.69
diff -u -r1.69 Module.mk
--- kernel/chips/Module.mk      16 Apr 2005 13:23:24 -0000      1.69
+++ kernel/chips/Module.mk      5 Oct 2005 13:44:27 -0000
@@ -36,6 +36,7 @@
 KERNELCHIPSTARGETS += $(MODULE_DIR)/smartbatt.o
 KERNELCHIPSTARGETS += $(MODULE_DIR)/smbus-arp.o

+KERNELCHIPSTARGETS += $(MODULE_DIR)/se95.o

 # These targets ARE included in 'mkpatch'
 ifneq ($(shell if grep -q '^CONFIG_SENSORS_ADM1021=y' $(LINUX)/.config; then 
echo 1; fi),1)
Index: lib/chips.c
=================================RCS file: /home/cvs/lm_sensors2/lib/chips.c,v
retrieving revision 1.168
diff -u -r1.168 chips.c
--- lib/chips.c 1 Jun 2005 10:49:04 -0000       1.168
+++ lib/chips.c 5 Oct 2005 13:44:38 -0000
@@ -302,6 +302,19 @@
     { 0 }
   };

+static sensors_chip_feature se95_features[] +  {
+    { SENSORS_SE95_TEMP, "temp", NOMAP, NOMAP,
+                         R, SE95_SYSCTL_TEMP, VALUE(3), 1 },
+    { SENSORS_SE95_TEMP_HYST, "temp_hyst", SENSORS_SE95_TEMP,
+                              SENSORS_SE95_TEMP, RW,
+                              SE95_SYSCTL_TEMP, VALUE(2), 1 },
+    { SENSORS_SE95_TEMP_OVER, "temp_over", SENSORS_SE95_TEMP,
+                              SENSORS_SE95_TEMP, RW,
+                              SE95_SYSCTL_TEMP, VALUE(1), 1 },
+    { 0 }
+  };
+
 static sensors_chip_feature adm1021_features[]    {
     { SENSORS_ADM1021_TEMP, "temp", NOMAP, NOMAP,
@@ -5423,6 +5436,7 @@
  { SENSORS_LM78J_PREFIX, lm78j_features },
  { SENSORS_LM79_PREFIX, lm79_features },
  { SENSORS_LM75_PREFIX, lm75_features },
+ { SENSORS_SE95_PREFIX, se95_features },
  { SENSORS_GL518_PREFIX, gl518_features },
  { SENSORS_GL520_PREFIX, gl520_features },
  { SENSORS_LM80_PREFIX, lm80_features },
Index: lib/chips.h
=================================RCS file: /home/cvs/lm_sensors2/lib/chips.h,v
retrieving revision 1.108
diff -u -r1.108 chips.h
--- lib/chips.h 1 Jun 2005 10:49:04 -0000       1.108
+++ lib/chips.h 5 Oct 2005 13:44:41 -0000
@@ -166,6 +166,14 @@
 #define SENSORS_LM75_TEMP_HYST 52 /* RW */
 #define SENSORS_LM75_TEMP_OVER 53 /* RW */

+/* SE95 chips. */
+
+#define SENSORS_SE95_PREFIX "se95"
+
+#define SENSORS_SE95_TEMP 51 /* R */
+#define SENSORS_SE95_TEMP_HYST 52 /* RW */
+#define SENSORS_SE95_TEMP_OVER 53 /* RW */
+
 /* ADM1021 chips. */

 #define SENSORS_ADM1021_PREFIX "adm1021"
Index: mkpatch/FILES
=================================RCS file: /home/cvs/lm_sensors2/mkpatch/FILES,v
retrieving revision 1.33
diff -u -r1.33 FILES
--- mkpatch/FILES       16 Apr 2005 13:12:06 -0000      1.33
+++ mkpatch/FILES       5 Oct 2005 13:44:41 -0000
@@ -55,6 +55,8 @@
 kernel/chips/pc87360.c         drivers/sensors/pc87360.c
 kernel/chips/pcf8574.c         drivers/sensors/pcf8574.c
 kernel/chips/pcf8591.c         drivers/sensors/pcf8591.c
+kernel/chips/se95.h            drivers/sensors/se95.h
+kernel/chips/se95.c            drivers/sensors/se95.c
 kernel/chips/sis5595.c         drivers/sensors/sis5595.c
 kernel/chips/smsc47m1.c                drivers/sensors/smsc47m1.c
 kernel/chips/thmc50.c          drivers/sensors/thmc50.c
Index: mkpatch/mkpatch.pl
=================================RCS file: /home/cvs/lm_sensors2/mkpatch/mkpatch.pl,v
retrieving revision 1.84
diff -u -r1.84 mkpatch.pl
--- mkpatch/mkpatch.pl  29 May 2005 08:59:51 -0000      1.84
+++ mkpatch/mkpatch.pl  5 Oct 2005 13:44:43 -0000
@@ -1038,6 +1038,7 @@
 obj-$(CONFIG_SENSORS_PC87360)  += pc87360.o
 obj-$(CONFIG_SENSORS_PCF8574)  += pcf8574.o
 obj-$(CONFIG_SENSORS_PCF8591)  += pcf8591.o
+obj-$(CONFIG_SENSORS_SE95)     += se95.o
 obj-$(CONFIG_SENSORS_SIS5595)  += sis5595.o
 obj-$(CONFIG_SENSORS_SMSC47M1) += smsc47m1.o
 obj-$(CONFIG_SENSORS_THMC50)   += thmc50.o
Index: prog/detect/sensors-detect
=================================RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
retrieving revision 1.395
diff -u -r1.395 sensors-detect
--- prog/detect/sensors-detect  1 Oct 2005 15:34:38 -0000       1.395
+++ prog/detect/sensors-detect  5 Oct 2005 13:44:49 -0000
@@ -898,7 +898,7 @@
             smartbatt_chgr_detect adt7467_detect lm92_detect max1619_detect
             lm93_detect lm77_detect lm63_detect pca9556_detect
             w83791sd_detect vt1211_i2c_detect vt1211_alias_detect
-            smsc47m192_detect);
+            smsc47m192_detect se95_detect);

 # This is a list of all recognized chips.
 # Each entry must have the following fields:
@@ -967,6 +967,12 @@
        i2c_detect => sub { lm75_detect @_},
      } ,
      {
+       name => "Philips SE95",
+       driver => "se95",
+       i2c_addrs => [0x48..0x4f],
+       i2c_detect => sub { se95_detect @_},
+     } ,
+     {
        name => "National Semiconductor LM77",
        driver => "lm77",
        i2c_addrs => [0x48..0x4b],
@@ -2904,6 +2910,61 @@
   return 1;
 }

+
+# $_[0]: A reference to the file descriptor to access this chip.
+#        We assume an i2c_set_slave_addr was already done.
+# $_[1]: Address
+# Returns: undef if not detected, 6 or 8 if detected;
+#   6 means that the temperatures look strange;
+#   8 means that the temperatures make sense;
+# Registers used:
+#   0x00: Temperature
+#   0x01: Configuration
+#   0x02: Hysteresis
+#   0x03: Overtemperature Shutdown
+#   0x04: Magic byte 0xa1
+#   0x05: Magic byte 0x95
+#
+# The first detection step is based on the fact that the SE95 has only
+# four registers.
+# Note that register 0x00 may change, so we can't use the modulo trick on it.
+sub se95_detect
+{
+  my $i;
+  my ($file,$addr) = @_;
+
+  my $cur = i2c_smbus_read_word_data($file,0x00);
+  my $cur_varies = 0;
+  my $conf = i2c_smbus_read_byte_data($file,0x01);
+
+  my $hyst = i2c_smbus_read_word_data($file,0x02);
+
+  return if (i2c_smbus_read_byte_data($file,0x05) != 0xa1)
+    || (i2c_smbus_read_byte_data($file,0x06) !=0x95);
+
+  my $os = i2c_smbus_read_word_data($file,0x03);
+
+  # All registers hold the same value, obviously a misdetection
+  return if (! $cur_varies) and $conf = ($cur & 0xff) and $cur = $hyst
+    and $cur = $os;
+
+  $cur = swap_bytes($cur);
+  $hyst = swap_bytes($hyst);
+  $os = swap_bytes($os);
+  # Unused bits
+  return if ($conf & 0xe0);
+
+  $cur = $cur >> 8;
+  $hyst = $hyst >> 8;
+  $os = $os >> 8;
+  # Most probable value ranges
+
+  return 8 if $cur <= 100 and ($hyst >= 10 && $hyst <= 125)
+    and ($os >= 20 && $os <= 127) and $hyst < $os;
+  return 6;
+}
+
+
 # $_[0]: A reference to the file descriptor to access this chip.
 #        We assume an i2c_set_slave_addr was already done.
 # $_[1]: Address
Index: prog/sensors/chips.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensors/chips.c,v
retrieving revision 1.162
diff -u -r1.162 chips.c
--- prog/sensors/chips.c        23 Jun 2005 21:07:10 -0000      1.162
+++ prog/sensors/chips.c        5 Oct 2005 13:44:57 -0000
@@ -197,6 +197,26 @@
   free_the_label(&label);
 }

+void print_se95(const sensors_chip_name *name)
+{
+  char *label;
+  double cur,hyst,over;
+  int valid;
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_SE95_TEMP,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_SE95_TEMP,&cur) &&
+      !sensors_get_feature(*name,SENSORS_SE95_TEMP_HYST,&hyst) &&
+      !sensors_get_feature(*name,SENSORS_SE95_TEMP_OVER,&over))  {
+    if (valid) {
+      print_label(label,10);
+      print_temp_info( cur, over, hyst, HYST, 1, 1);
+      printf( "\n" );
+    }
+  } else
+    printf("ERROR: Can't get temperature data!\n");
+  free_the_label(&label);
+}
+
 void print_adm1021(const sensors_chip_name *name)
 {
   char *label;

----------------------------------

