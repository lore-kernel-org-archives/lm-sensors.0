From: seth@integratedsolutions.org (Seth Bardash)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Tyan S2895 Dumps and Info
Message-Id: <200504130106.j3D16N519857@integratedsolutions.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

TWIMC,

First, I want to say thanks for all your previous work. We use it on most of
the machines we ship to customers so they can monitor the system temps.

Second, I wanted to try and help so.... I installed i2c and lmsensors (2.9.1
rev for both) on a brand new Tyan S2895A2NRF with Dual Opteron 248's, 4 x
512M DDR-400 RECC OCZ DIMMs (they show up in 4 of the dumps - I'm guessing
these dumps show the SPD info) 40GB IDE disk and an IDE CDROM

The OS installed is CentOS 3.4 x86_64 SMP version RHEL 3 Update 4 clone.

Everything compiles but sensors-detect does not detect any temperature
sensors.

The manual states that the temperature monitoring chip is a LM95221
connected to the LPC Super I/O Chip. I could not find this on the MB.

Hope this helps. 

If there is anything else I can run to give you more information let me
know.

Best

Seth Bardash

Integrated Solutions and Systems
1510 North Gate Road
Colorado Springs, CO 80921

719-495-5866
719-495-5870 Fax
719-337-4779 Cell

http://www.integratedsolutions.org

Failure can not cope with perseverance! 
-------------- next part --------------
[root@s10 detect]# ./sensors-detect

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
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce4 SMBus (MCP)
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
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

Next adapter: SMBus nForce2 adapter at 5000
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x30
Client found at address 0x31
Client found at address 0x34
Client found at address 0x35
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x54
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')

Next adapter: SMBus nForce2 adapter at 5040
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
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
  Failed! (0x6f01)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x6f01)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x6f01)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0x6f)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0x6f)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0x6f)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0x6f)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x6f)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x6f)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x6f)
Probing for `SMSC LPC47B397-NC Super IO'
  Success... but not activated
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
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
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-nforce2', I2C address 0x54
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-nforce2', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 5040' (Non-I2C SMBus adapter)
    Busdriver `i2c-nforce2', I2C address 0x51
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
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-nforce2
# I2C chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no
[root@s10 detect]#
[root@s10 detect]#
-------------- next part --------------
mail to sensors@stimpy.netroedge.com.

Please include the following in your mail:
	- The output of (as root) 'prog/detect/sensors-detect'
	- The output of (as root) 'prog/detect/i2cdetect 1'
	      (assuming your smbus adapter is on bus 1 -
	      run 'i2cdetect' with no arguments to list the busses).
	- The output of (as root) 'prog/dump/i2cdump X 0xXX'
	      X = the bus number
	      XX = the address of each chip you see in the output
	      of i2cdetect. (run once for each chip)
	- Part numbers of chips on your motherboard you think are
	      the sensor chips (look at your motherboard)


-------------- next part --------------
[root@s10 dump]# ./i2cdump 0 0x08
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x8, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
[root@s10 dump]#

[root@s10 dump]# ./i2cdump 0 0x30
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x30, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@s10 dump]#

[root@s10 dump]# ./i2cdump 0 0x31
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x31, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@s10 dump]#

[root@s10 dump]# ./i2cdump 0 0x34
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x34, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@s10 dump]#

[root@s10 dump]# ./i2cdump 0 0x35
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x35, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@s10 dump]#

[root@s10 dump]# ./i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 48 00 04 50 70 02 82 08 08 01    ??????H.?Pp?????
10: 0e 04 04 01 02 26 c0 00 00 00 00 28 28 3c 1e 40    ?????&?....((<?@
20: 60 60 40 40 00 00 00 00 00 37 46 28 28 50 00 00    ``@@.....7F((P..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 90    ..............??
40: 7f 7f 7f 7f b0 00 00 00 00 4f 43 5a 34 30 30 31    ?????....OCZ4001
50: 30 32 34 45 4c 45 52 44 43 2d 4b 00 00 00 00 00    024ELERDC-K.....
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 05 03 17 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
[root@s10 dump]#

[root@s10 dump]# ./i2cdump 0 0x51
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x51, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 48 00 04 50 70 02 82 08 08 01    ??????H.?Pp?????
10: 0e 04 04 01 02 26 c0 00 00 00 00 28 28 3c 1e 40    ?????&?....((<?@
20: 60 60 40 40 00 00 00 00 00 37 46 28 28 50 00 00    ``@@.....7F((P..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 90    ..............??
40: 7f 7f 7f 7f b0 00 00 00 00 4f 43 5a 34 30 30 31    ?????....OCZ4001
50: 30 32 34 45 4c 45 52 44 43 2d 4b 00 00 00 00 00    024ELERDC-K.....
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 05 03 17 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
[root@s10 dump]#

[root@s10 dump]# ./i2cdump 0 0x54
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x54, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 48 00 04 50 70 02 82 08 08 01    ??????H.?Pp?????
10: 0e 04 04 01 02 26 c0 00 00 00 00 28 28 3c 1e 40    ?????&?....((<?@
20: 60 60 40 40 00 00 00 00 00 37 46 28 28 50 00 00    ``@@.....7F((P..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 90    ..............??
40: 7f 7f 7f 7f b0 00 00 00 00 4f 43 5a 34 30 30 31    ?????....OCZ4001
50: 30 32 34 45 4c 45 52 44 43 2d 4b 00 00 00 00 00    024ELERDC-K.....
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 05 03 17 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
[root@s10 dump]#

[root@s10 dump]# ./i2cdump 0 0x55
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x55, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 48 00 04 50 70 02 82 08 08 01    ??????H.?Pp?????
10: 0e 04 04 01 02 26 c0 00 00 00 00 28 28 3c 1e 40    ?????&?....((<?@
20: 60 60 40 40 00 00 00 00 00 37 46 28 28 50 00 00    ``@@.....7F((P..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 90    ..............??
40: 7f 7f 7f 7f b0 00 00 00 00 4f 43 5a 34 30 30 31    ?????....OCZ4001
50: 30 32 34 45 4c 45 52 44 43 2d 4b 00 00 00 00 00    024ELERDC-K.....
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 05 03 17 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
[root@s10 dump]#

-------------- next part --------------
[root@s10 dump]# ./i2cdump 1 0x08
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1, address 0x8, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
[root@s10 dump]#
[root@s10 dump]#
[root@s10 dump]# ./i2cdump 1 0x51
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1, address 0x51, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 24 85 54 81 e0 00 ff ff ff ff ff ff ff ff ff ff    $?T??...........
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@s10 dump]#
-------------- next part --------------
[root@s10 detect]# ./i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: 30 31 XX XX 34 35 XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: 50 51 XX XX 54 55 XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
[root@s10 detect]#



 [root@s10 detect]# ./i2cdetect 1
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
[root@s10 detect]#
-------------- next part --------------
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.308 / Virus Database: 266.9.6 - Release Date: 4/11/2005
