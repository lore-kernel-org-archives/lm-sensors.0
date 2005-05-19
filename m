From: plukje@gmx.net (Eric)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 (probably) does something VERY,VERY BAD
Message-Id: <4062C734.5000104@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

'greetings

Based on the output of sensors-detect I insmodded adm1021:

Driver `adm1021' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0c00' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x4e
    Chip `National Semiconductor LM84' (confidence: 5)

The module was build from a 2.6.5-rc1 kernel tree (SMP). After 
insmodding the
module the machine shut down instantly, which could have only been caused
because the hardware detected _something_ critical enough that it shut 
down the
system immediatly. Initial tries to power up again were futile, only 
after unplugging
and giving it a few minutes the machine came back up again (*phew*).

I can't give you anything other helpfull information concerning what 
happened, simply
because there was none given. However I put the details of the machine 
below.
Whatever happened, it shouldn't have happened :-) (I'm just glad the 
machine came back
on again.)

let me know if you require any other information


Kind regards,


Eric


/proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 2400.153
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4734.97
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 2400.153
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4784.12


root@pathfinder eric # sensors-detect
 
This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.
 
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.
 
 We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no): no
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): no
 Well, you will know best. We will just hope you edited `/etc/modules.conf'
 for automatic loading of this module. If not,
 you won't be able to open any /dev/i2c-* file (unless youhave it built-in
 into your kernel)
 
 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double 
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
 
Next adapter: SMBus I801 adapter at 0c00 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x44
Client found at address 0x4e
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 5, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x52 can not be probed - unload all client drivers first!
Client found at address 0x69
 
 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
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
 this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x5217)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x5217)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x5217)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x52)
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
 
Driver `adm1021' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0c00' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x4e
    Chip `National Semiconductor LM84' (confidence: 5)
 
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
 
If you want to load the modules at startup, generate a config file
below and make sure lm_sensors get started (eg. rc-update add lm_sensors 
default).
 
To make the sensor modules behave correctly, add these lines to
/etc/modules.conf:
 
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----end cut here----
 
WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
To load everything that is needed, execute the commands above...
 
#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe adm1021
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----end cut here----
 
Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify 
other file name?
  (yes/NO/s): no





