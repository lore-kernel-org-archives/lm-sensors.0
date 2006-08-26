From: michaelnel@comcast.net (Michael Nelson)
Date: Sat, 26 Aug 2006 13:25:13 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060826132513.GA4743@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I tried with the SVN sensors-detect, and the results were different, but
apparently not correct.  It looked like this:

Script started on Sat Aug 26 06:03:29 2006
seahunt:/usr/local/src # ./sensors-detect 
# sensors-detect revision $Revision$ ($Date$)

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
Use driver `i2c-i801' for device 00:1f.3: Intel ICH8
Probe successfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): 
 Module loaded successfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively): 
Adapter cannot be probed, skipping.

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively): 
Adapter cannot be probed, skipping.

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively): 
Adapter cannot be probed, skipping.

Next adapter: SMBus I801 adapter at 0400
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x08
Client found at address 0x22
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Client found at address 0x30
Client found at address 0x32
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `EDID EEPROM'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

Some chips are also accessible through the ISA I/O ports. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!

Do you want to scan the ISA I/O ports? (YES/no): 
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Success!
    (confidence 6, driver `lm78')
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
Probing for `Winbond W83627DHG'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `AMD K8 thermal sensors'
  Trying general detect... Failed!
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
  Failed! (0xa0)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xa0)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xa0)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xa0)
Probing for `Winbond W83687THF Super IO Sensors'
  Failed! (0xa0)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xa0)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0xa0)
Probing for `Winbond W83L517D Super IO'
  Failed! (0xa0)
Probing for `Fintek F71805F/FG Super IO Sensors'
  Failed! (0xa021)
Probing for `Fintek F71872F/FG Super IO Sensors'
  Failed! (0xa021)
Probing for `Fintek F81218D Super IO'
  Failed! (0xa021)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (0xa021)
Probing for `Winbond W83627DHG Super IO Sensors'
  Success... found at address 0x0290

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

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400'
    Busdriver `i2c-i801', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `lm78' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `National Semiconductor LM78' (confidence: 6)

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the required modules.

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
modprobe i2c-isa
# Chip drivers
modprobe eeprom
modprobe w83627ehf
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


However.... running /etc/init.d/lm_sensors start says "FAILED" and if I try
to:

modprobe w83627ehf
FATAL: Error inserting w83627ehf
(/lib/modules/2.6.16.21-0.13-smp/kernel/drivers/hwmon/w83627ehf.ko): No such
device

So, I am back to using LM78 instead, which gives limited and probably bogus
information:

lm78-isa-0290
Adapter: ISA adapter
VCore 1:   +2.26 V  (min =  +2.85 V, max =  +3.15 V)
VCore 2:   +3.63 V  (min =  +2.85 V, max =  +3.15 V)
+3.3V:     +3.28 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.48 V  (min =  +4.76 V, max =  +5.24 V)
+12V:      +9.24 V  (min = +11.37 V, max = +12.59 V)
-12V:     -11.01 V  (min = -12.63 V, max = -11.40 V)
-5V:       -3.64 V  (min =  -5.25 V, max =  -4.74 V)
fan1:        0 RPM  (min = 7105 RPM, div = 2)
fan2:     1928 RPM  (min = 337500 RPM, div = 4)
fan3:        0 RPM  (min = 20454 RPM, div = 2)
temp:      +29.0??C  (high =   +26??C, hyst =   +80??C)   ALARM
vid:       +3.00 V

In contrast, the BIOS reports:

CPU Temp     	      51C
MB Temp	     	      30C
CPU Fan Speed	      2191 RPM
CPU Q-Fan control     disabled
Chassis fan 1	      N/A
Chassis fan 2	      969 RPM
Chassis fan 3	      N/A
Chassis Q-fan control disabled
Power fan speed	      2096
VCORE voltage	      1.224v
3.3V voltage	      3.264v
5V voltage	      5.068v
12V voltage	      11.932v


-- 

San Francisco, CA

