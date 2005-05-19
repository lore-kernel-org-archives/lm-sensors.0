From: cheaterjs@gmx.de (Jan Schiefer)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: False detection of sensors on MSI K7N2 Delta-L (NForce2)!
Message-Id: <415BE34E.6040109@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <415BD873.8010303@gmx.de>
In-Reply-To: <415BD873.8010303@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare schrieb:

>On Thu, 30 Sep 2004 11:57:07 +0200, Jan Schiefer wrote
>  
>
>>I've been trying to get lm_sensors working on my lovely MSI K7N2 
>>Delta-L NForce2 mainboard since I switched to kernel 2.6.x. When I 
>>choose ISA or SMBUS it makes no difference. I tried every version... 
>>It never worked...
>>
>>Now I discovered the problem: False chip detection by sensors-detect.
>>I finally got it working (manually) with kernel 2.6.9-rc2 and lm_sensors
>>CVS.
>>Just because I was lucky I tried the right module.
>>
>>sensors-detect (even in latest CVS) makes following module suggestions:
>>i2c-nforce2, i2c-isa, eeprom, w83627hf
>>Only the eeprom reader will be detected then.
>>
>>The correct modules are: i2c-isa, eeprom, w83781d
>>Only these modules make it work. So you don't need i2c-nforce2 (I don't
>>know why on a NForce2-Board...) and w83781d instead of w83627hf.
>>    
>>
>
>It's not exactly a false detection. Your motherboard has a W83627HF chip which
>happens to be supported by both the w83781d and the w83627hf drivers. The
>latter is prefered, so sensors-detect does the correct thing.
>
>Now, if the w83627hf driver doesn't see your chip, that's the real problem and
>we have to correct that.
>
>We would need:
>1* The full output of sensors-detect. Make sure to unload all chip drivers
>(eeprom, w83781d, w83627hf) before running the script.
>2* A dump of your chip contents. You should obtain it with "isadump 0x295 0x296".
>
>Also note that if you only load i2c-isa, eeprom and w83781d, the eeprom module
>will not actually be used, since it needs i2c-nforce2 (on your system).
>
>Thanks.
>
>  
>
1.
---
[root@mrsuicide mrsuicide]# sensors-detect

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
 
 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation, just 
scanning
 the bus will break your Thinkpad forever!
 If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We have
 had users reporting system breakage on other IBM systems as well.
 
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `rivatv' for device 02:00.0: GeForce FX 5600
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce2 
SMBus (MCP)
Probe succesfully concluded.
 
We will now try to load each adapter module in turn.
Load `rivatv' (say NO if built into your kernel)? (YES/no):
FATAL: Module rivatv not found.
Loading failed... skipping.
** Note: rivatv module is available at http://rivatv.sourceforge.net/
Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no):
FATAL: Module i2c_nforce2 not found.
Loading failed... skipping.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.
 
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.
 
 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double 
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
 
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
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
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
 
Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83627HF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x52)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x52)
 
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
 
Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)
 
Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)
 
 
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
modprobe i2c-isa
# I2C chip drivers
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----
 
WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
 
Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no

---

2.
---

[root@mrsuicide mrsuicide]# isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 68 6c ce c0 c3 23 32 2b ff ff ff 6c 62 6c 62 d8
30: c4 c3 b0 d9 b2 31 15 3b 31 00 a2 00 0c 10 00 00
40: 01 02 00 00 00 00 00 58 2d 02 01 84 50 95 00 a3
50: ff ff 00 ff ff ff 00 00 21 70 ff ff 11 01 ff 05
60: 68 6c ce c0 c3 23 32 2b ff ff ff 6c 62 6c 62 d8
70: c4 c3 b0 d9 b2 31 15 3b 31 00 a2 00 0c 10 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 68 6c ce c0 c3 23 32 2b ff ff ff 6c 62 6c 62 d8
b0: c4 c3 b0 d9 b2 31 15 3b 31 00 a2 00 0c 10 00 00
c0: 01 00 00 00 00 00 00 58 2d 02 01 84 50 95 00 a3
d0: ff ff 00 ff ff ff 00 00 21 70 ff ff 11 01 ff 05
e0: 68 6c ce c0 c3 23 32 2b ff ff ff 6c 62 6c 62 d8
f0: c4 c3 b0 d9 b2 31 15 3b 31 00 a2 00 0c 10 00 00

---

Have fun!
