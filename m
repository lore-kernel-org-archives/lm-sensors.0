From: bchang@atipa.com (Brady Chang)
Date: Wed, 26 Apr 2006 17:34:41 +0000
Subject: [lm-sensors] tyan 2891 on RHEL 4 2.6.9-32ELsmp kernel
Message-Id: <0D6FBA307D01EA42BAC8715725643AA01EDA2B@EXCHG2003.microtech-ks.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all, Just need a validation whether RHEL 4 2.6.9-32ELsmp does not support nForce4 SMBus. I believe 2.6.9 is pre 2.9.1.
 
lspci -v output
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
        Subsystem: Tyan Computer: Unknown device 2891
        Flags: 66Mhz, fast devsel, IRQ 177
        I/O ports at 1000 [size2]
        I/O ports at 5000 [sized]
        I/O ports at 5040 [sized]
        Capabilities: [44] Power Management version 2
 
using userspace tools 2 .9.1 
 
modprobe i2c-nforce2
modprobe i2c-isa
modprobe lm85
modprobe w83627hf
cp /etc/sensors.conf.tyan /etc/sensors.conf
cp: overwrite `/etc/sensors.conf'? y
sensors -s
sensors
w83627hf-isa-0c00
Adapter: ISA adapter
CPU2 Volt: +1.41 V  (min =  +0.00 V, max =  +0.00 V)              
CPU1 Volt: +1.41 V  (min =  +0.00 V, max =  +0.00 V)              
+3.3V:     +3.44 V  (min =  +3.14 V, max =  +3.47 V)              
Sys Fan 7:   0 RPM  (min =    0 RPM, div = 8)                     
Sys Fan 8:   0 RPM  (min =    0 RPM, div = 2)                     
alarms:   
beep_enable:
          Sound alarm disabled
 
from tyan's website:
#######
#    Sensors configuration file used by 'libsensors' for Tyan S2891
#
#  To support NFORCE4 SMBus controller, version 2.9.1 is at least
#
#  To your /etc/modules.conf file, add the lines:
#     alias char-major-89 i2c-dev
#
#  To your /etc/rc.xxx files, add the lines:
#     modprobe i2c-nforce2
#     modprobe i2c-isa
#     modprobe lm85
#     modprobe w83627hf
#     sensors -s
#
#  Then copy this file to /etc/sensors.conf
#
#  Notes: 
#
# Edited by: Raphael Deng <raphaeld at tyan.com> 04.05.05
#######

chip "lm85-i2c-*-2c"
	ignore pwm1
	ignore pwm2
	ignore pwm3
	ignore fan4
	ignore in0
	ignore in1
	ignore in2
	ignore in3
	ignore temp2
	ignore vid

	label fan1 "Sys Fan 1"
	label fan2 "Sys Fan 2"
	label fan3 "Sys Fan 9"

	label in4 "+12V"
	label temp1 "CPU2 Temp"
	label temp3 "Sys Temp 2"

chip "lm85-i2c-*-2e"
	ignore pwm1
	ignore pwm2
	ignore pwm3
	ignore in2
	ignore in4
	ignore temp2
	ignore vid
	label fan1 "Sys Fan 6"
	label fan2 "Sys Fan 5"
	label fan3 "Sys Fan 4"
	label fan4 "Sys Fan 3"
	label in0 "VDD 1.8V"
	label in1 "CK8 1.5V"
	label in3 "+5V"
	label temp1 "CPU1 Temp"
	label temp3 "Sys Temp 1"

chip "w83627hf-*"
	ignore pwm1
  	ignore pwm2
	ignore pwm3
	ignore in3
	ignore in4
	ignore in5
	ignore in6
	ignore in7
	ignore in8
	ignore fan3
	ignore temp1
	ignore temp2
	ignore temp3
	ignore vid

	label in0 "CPU2 Volt"
	label in1 "CPU1 Volt"
	label in2 "+3.3V"
	label fan1 "Sys Fan 7"
	label fan2 "Sys Fan 8"
 
# sensors-detect 
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
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce4 SMBus (MCP)
Probe succesfully concluded.
We will now try to load each adapter module in turn.
Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no): YES
Module loaded succesfully.
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
Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x5241)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x5241)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x5241)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0x52)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0x52)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0x52)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0x52)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x52)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x52)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0x52)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83627HF Super IO Sensors'
  Success... found at address 0x0c00
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
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (0x5241)
Do you want to scan for secondary Super I/O sensors? (YES/no): YES
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
Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0c00 (Busdriver `i2c-isa')
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
Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): YES
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060426/3d125b73/attachment.html
