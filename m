From: jbloom@acopia.com (Jeff Bloom)
Date: Wed, 25 May 2005 02:34:03 +0000
Subject: [lm-sensors] lmsensors 2.9.0 LM93 driver problems
Message-Id: <02023CF4A21F4B479744D6203451DD7731F23B@EMAIL3.acopianet.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry to bother you on this issue but I can't seem to get sensors-detect
to scan the lm93 on a new Intel platform.
I am running the following:
    - kernel version 2.4.26
    - Patched above kernel with 2.9.0 i2c-patch where i2c-dev is built
into the kernel.
    - Compiled lmsensor-2.9.0 package.
    - Volcano Intel box (SE7320VP2) with an LM93 chipset from National
Semiconductor.
 
I verified the chip does exist on the motherboard as well.
 
So I have used this same package on an HP box to bring up bmcsensors and
i2c-ipmi without issue.
 
The only devices found were the eeprom and i2c-i801.
 
Any idea what I need to try next?
I can upgrade to 2.9.1 lmsensors and the i2c patch but didn't see any
reason yet why I should.
 
I appreciate any help you can provide.  Thanks.
 
-Jeff Bloom
 
 
Below is the sensors-detect output:(notice it doesn't even scan for the
lm93 at all)
 
 
/usr/local/bin# ./sensors-detect
 
This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.
 
It is generally safe and recommended to accept the default answers to
all
questions, unless you know what you're doing.
 
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 6300ESB
Probe succesfully concluded.
 
We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no): yes
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.
 
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): no
 Well, you will know best. We will just hope you edited
`/etc/modules.conf'
 for automatic loading of this module. If not,
 you won't be able to open any /dev/i2c-* file (unless youhave it
built-in
 into your kernel)
 
 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
 
Next adapter: SMBus I801 adapter at 0400
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x32
Client found at address 0x36
Client found at address 0x42
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x56
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69
Client found at address 0x6e
 
Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.
 
Do you want to scan the ISA bus? (YES/no): yes
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
 
Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0xf211)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xf211)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xf211)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0xf2)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0xf2)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xf2)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0xf2)
Probing for `VT1211 Super IO Sensors'
  Failed! (0xf2)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xf2)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xf2)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xf2)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xf2)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0xf2)
Probing for `Winbond W83L517D Super IO'
  Failed! (0xf2)
 
Do you want to scan for secondary Super I/O sensors? (YES/no): yes
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
 
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 
 
Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x56
    Chip `SPD EEPROM' (confidence: 8)
 

 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
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
modprobe i2c-i801
# I2C chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----
 
WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really
should
try these commands right now to make sure everything is working
properly.
Monitoring programs won't work until it's done.
 
Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): 
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

 


DISCLAIMER:
--------------------------------------------------------
The information contained in this e-mail is confidential and is intended solely for the review of the named addressee, and in conjunction with specific Acopia Networks business.  Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited. If you are unable to treat this information accordingly, or are not the intended recipient, please notify us immediately by returning the e-mail to the originator.	Thank You
