From: armenb@cs.umass.edu (Armen Babikyan)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Sensors on IBM eServer 335/345?
Message-Id: <AA2546DC-6AB2-11D9-949A-003065F94C4C@cs.umass.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <2A5055C0-6929-11D9-98D6-003065F94C4C@cs.umass.edu>
In-Reply-To: <2A5055C0-6929-11D9-98D6-003065F94C4C@cs.umass.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

>> However, sensors-detect still isn't finding any sensor chips on this
>> system.  Is there a giant table somewhere that lists motherboard/chip
>> combinations so I can find the appropriate drivers for this system?  
>> Or
>> any general guidelines to what IBM or Serverworks prefer to use with
>> their systems/electronics?  Could the sensor chips be proprietary?
>
> We don't have such a table. We support chips, not board or systems. You
> may search the mailing-list archives or the support tickets:
> http://secure.netroedge.com/~lm78/search.html
> But I don't remember seing this family of servers discussed.
>
> You may ask IBM directly, they are supposed to know what hardware is 
> used
> in their server boards. The hardware could be proprietary. Or they 
> might
> not be hardware monitoring stuff on these boards at all. What makes you
> believe there is?

The long and the short:  IBM hardware support tells me there is 
hardware monitoring in this machine, but that it is indeed proprietary, 
and they are not willing to release any specifications with regards to 
hardware monitoring chips.  The proprietary hardware is meant to go 
with their proprietary monitoring software.  Sorry about that - up 
until this email I was optimistic that though they'd have proprietary 
software, the hardware would be *somewhat* standard. D'oh. :)

>> I know this machine
>> has two Xeon processors, and Xeons have embedded temperature sensors,
>> but have not had much luck trying to access them after inserting the
>> xeontemp lmsensors module - just wondering if my old kernel could have
>> anything to do with it.
>
> I don't think so.
>
> If the Xeon have thermal sensors, sensors-detect should have seen them,
> and the xeontemp driver as well. But I think I remember that not all
> Xeon CPUs have the thermal sensors.

Since the motherboard in this machine has hardware sensors (and a fancy 
optional software package to go with it), My guess is that the Xeon 
chips also have temperature sensors.  Is the access method of the Xeon 
temperature sensors such that IBM could have found a way to prevent 
third-party software (i.e. open source i2c/lmsensors) from retrieving 
this data?  Or could there be a fairly easy way to access this data?  
How does lmsensors get this data from the Xeon chip?

> You can send us the full output of sensors-detect (after unloading all
> i2c chip drivers) and we'll tell you if something can be done.

Here's my output of sensors-detect (that comes with lmsensors 2.9.0), 
if at all useful for answering the above question:

===cut here==emmy3:~# /usr/local/sbin/sensors-detect

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
  Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB5 South Bridge
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no): YES
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

  To continue, we need module `i2c-dev' to be loaded.
  If it is built-in into your kernel, you can safely skip this.
  i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
  Module loaded succesfully.

  We are now going to do the adapter probings. Some adapters may hang 
halfway
  through; we can't really help that. Also, some chips will be double 
detected;
  we choose the one with the highest confidence value in that case.
  If you found that the adapter hung after probing a certain address, 
you can
  specify that address to remain unprobed. That often
  includes address 0x69 (clock chip).

Next adapter: SMBus PIIX4 adapter at 0440
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x37
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
     (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
     (confidence 8, driver `eeprom')
Client found at address 0x57
Probing for `SPD EEPROM'... Success!
     (confidence 1, driver `eeprom')
Probing for `Sony Vaio EEPROM'... Failed!

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): YES
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

Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
   Failed! (0xee19)
Probing for `ITE 8705F Super IO Sensors'
   Failed! (0xee19)
Probing for `ITE 8712F Super IO Sensors'
   Failed! (0xee19)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
   Failed! (0xee)
Probing for `Nat. Semi. PC8739x Super IO'
   Failed! (0xee)
Probing for `Nat. Semi. PC8741x Super IO'
   Success... (no hardware monitoring capabilities)
Probing for `SMSC 47B27x Super IO Fan Sensors'
   Failed! (0xee)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
   Failed! (0xee)
Probing for `SMSC 47M14x Super IO Fan Sensors'
   Failed! (0xee)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
   Failed! (0xee)
Probing for `SMSC 47S42x Super IO Fan Sensors'
   Failed! (0xee)
Probing for `SMSC 47S45x Super IO Fan Sensors'
   Failed! (0xee)
Probing for `SMSC 47M172 Super IO'
   Failed! (0xee)
Probing for `SMSC LPC47B397-NC Super IO'
   Failed! (0xee)
Probing for `VT1211 Super IO Sensors'
   Failed! (0xee)
Probing for `Winbond W83627HF Super IO Sensors'
   Failed! (0xee)
Probing for `Winbond W83627THF Super IO Sensors'
   Failed! (0xee)
Probing for `Winbond W83637HF Super IO Sensors'
   Failed! (0xee)
Probing for `Winbond W83697HF Super IO Sensors'
   Failed! (0xee)
Probing for `Winbond W83697SF/UF Super IO PWM'
   Failed! (0xee)
Probing for `Winbond W83L517D Super IO'
   Failed! (0xee)

Do you want to scan for secondary Super I/O sensors? (YES/no): YES
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
   * Bus `SMBus PIIX4 adapter at 0440' (Non-I2C SMBus adapter)
     Busdriver `i2c-piix4', I2C address 0x50
     Chip `SPD EEPROM' (confidence: 8)
   * Bus `SMBus PIIX4 adapter at 0440' (Non-I2C SMBus adapter)
     Busdriver `i2c-piix4', I2C address 0x52
     Chip `SPD EEPROM' (confidence: 8)
   * Bus `SMBus PIIX4 adapter at 0440' (Non-I2C SMBus adapter)
     Busdriver `i2c-piix4', I2C address 0x57
     Chip `SPD EEPROM' (confidence: 1)


  I will now generate the commands needed to load the I2C modules.
  Sometimes, a chip is available both through the ISA bus and an I2C bus.
  ISA bus access is faster, but you need to load an additional driver 
module
  for it. If you have the choice, do you want to use the ISA bus or the
  I2C/SMBus (ISA/smbus)? ISA

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-piix4
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

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): YES
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
emmy3:~# /usr/local/bin/sensors
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and done
'modprobe i2c_sensor'!
For older kernels, make sure you have done 'modprobe i2c-proc'!
emmy3:~# modprobe i2c-proc
emmy3:~# /usr/local/bin/sensors
No sensors found!
emmy3:~#
===cut here==
Also, here are the relevant messages from the syslog:

===cut here==dmi_scan.o version 2.9.0 (20041228)
dmi_scan.o: SM BIOS found
i2c-core.o: i2c core module version 2.9.0 (20041228)
i2c-piix4.o version 2.9.0 (20041228)
Found ServerWorks CSB5 South Bridge device
i2c-piix4.o: Unusual config register value
i2c-piix4.o: Try using fix_hstcfg=1 if you experience problems
i2c-dev.o: i2c /dev entries driver module version 2.9.0 (20041228)
i2c-dev.o: Registered 'SMBus PIIX4 adapter at 0440' as minor 0
i2c-proc.o version 2.9.0 (20041228)
===cut here==
Regarding the unusual config register value, I removed the module and 
reinserted it with the suggested argument (fix_hstcfg=1).  Syslog 
revealed:

===cut here==Found ServerWorks CSB5 South Bridge device
i2c-piix4.o: Working around buggy BIOS (I2C)
i2c-dev.o: Registered 'SMBus PIIX4 adapter at 0440' as minor 0
===cut here==
However, when I ran sensors-detect again, my machine hung.

I displayed the syslog, so you can be sure I used the correct versions 
of all the modules (2.9.0).

[ Incidently, I have noticed that old i2c and lmsensors drivers allow 
old themselves to load on new i2c drivers.  I've rebooted since that 
case, of course, but is there ever a case where a user would want 
mismatched versions of i2c/lmsensors drivers?  It just seems to me that 
bad things could happen if that were the case...I know I've done that 
accidently and its caused erroneous driver behavior with bttv and i2c 
on a separate machine.  Should there be a check to make sure 
i2c/lmsensors drivers aren't being accidently mismatched? ]

I did notice that the above sensors-detect output finds a chip "Nat. 
Semi. PC8741x Super IO", but does not find hardware monitoring 
capabilities on it.  Maybe this is IBM's proprietary monitoring chip.

Here's an output of one of the CPUs in /proc/cpuinfo if at all useful:

===cut here==emmy3:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 5
cpu MHz         : 3189.539
cache size      : 512 KB
physical id     : 0
siblings        : 2
runqueue        : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 6370.09
...
emmy3:~#
===cut here==
And, if it makes a difference, I am running on kernel 2.4.21-27 (RedHat 
Enterprise Linux 3).

Thanks for your help,

   - Armen
