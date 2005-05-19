From: janl@langfeldt.net (Nicolai Langfeldt)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lmsensors on Abit IC7-G
Message-Id: <3FBFA00C.2060805@langfeldt.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB92482.2070306@langfeldt.net>
In-Reply-To: <3FB92482.2070306@langfeldt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>- This is a pure PCI system, no ISA bus so no ISA probe, Intel ICH5 
>>chipset is correct.
> 
> 
> You're wrong. You might not have ISA slots, still you *do* have an ISA
> bus. Almost everybody does. And that's probably where your monitoring
> chipset is hiding.
> 
> 
>>Probing for `Winbond W83627HF'
>>   Trying address 0x0290... Success!
>>     (confidence 8, driver `w83781d')
> 
> 
> Here it is.

Oh well O:-)

> That said, the w83781d should have worked also, but W83627HF detection
> is known to be broken in 2.8.1. I have fixed it since (2003-10-25) so if
> you check lm_sensors2 CVS out, you should be able to use the w83781d
> driver. But anyway, try Super I/O, it should give even better results.

The CVS version worked better:

# sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

  BIOS vendor (ACPI): IntelR
  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

  We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
  Do you now want to be prompted for non-detectable adapters? (yes/NO): no
  To continue, we need module `i2c-dev' to be loaded.
  If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

  We are now going to do the adapter probings. Some adapters may hang 
halfway
  through; we can't really help that. Also, some chips will be double 
detected;
  we choose the one with the highest confidence value in that case.
  If you found that the adapter hung after probing a certain address, 
you can
  specify that address to remain unprobed. That often
  includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0500 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): yes

  Some chips are also accessible through the ISA bus. ISA probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan the ISA bus? (YES/no): yes
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
  this.  Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for `SMSC 47M10x Super IO Fan Sensors'
   Failed! (0x00)
Probing for `SMSC 47M14x Super IO Fan Sensors'
   Failed! (0x00)
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
Probing for `Winbond W83697UF Super IO PWM'
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
  I2C/SMBus (ISA/smbus)? smbus

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

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): yes
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
# rmmod w83627hf i2c-isa i2c-proc i2c-dev i2c-i801 i2c-core
# /etc/init.d/lm_sensors start
Starting up sensors: starting module __i2c-isa__
starting module __w83627hf__
                                                            [  OK  ]
# /usr/local/bin/sensors
w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.50 V  (min =  +0.00 V, max =  +0.00 V)
VCore 2:   +2.59 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +3.24 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.97 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.97 V  (min = +10.79 V, max = +13.19 V)
-12V:      -8.33 V  (min = -13.21 V, max = -10.90 V)
-5V:       -2.94 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.53 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.29 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     2008 RPM  (min =  166 RPM, div = 32)
fan2:     5273 RPM  (min =  166 RPM, div = 32)
fan3:        0 RPM  (min =  332 RPM, div = 16)              ALARM
temp1:       +31?C  (high =    +0?C, hyst =    +0?C)   sensor = thermistor
temp2:     +44.0?C  (high =   +85?C, hyst =   +80?C)   sensor = 
PII/Celeron diode
temp3:     +33.0?C  (high =   +85?C, hyst =   +80?C)   sensor = thermistor
vid:      +0.000 V
alarms:
beep_enable:
           Sound alarm disabled

This looks like real results.  The -12V is a bit worrying.  I'll compare 
with BIOS and tweak or whatever.

Thanks a lot,
   Nicolai

