From: jroland@linux-migration.net (Jon Roland)
Date: Tue, 23 Aug 2005 05:28:01 +0000
Subject: [lm-sensors] Fw: Processes causing CPU to overheat
Message-Id: <430A5153.2040604@linux-migration.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-------- Original Message --------
Subject: Processes causing CPU to overheat
Date: Mon, 22 Aug 2005 22:11:41 +0000
From: Jon Roland <jroland@linux-migration.net>
Reply-To: jroland@linux-migration.net
Organization: Linux Migration Network
To: sensors@stimpy.netroedge.com
CC: Rob Ristroph <rgr@sdf.lonestar.org>, Les Nemeth <linuxles@yahoo.com>

One of my systems, with an Athlon 64 running Fedora Core 4, has developed an
interesting problem. With a temperature monitor I installed, the CPU runs at about
35 C normally, no matter what I am doing. But then, for no apparent reason, the
temperature rises rapidly to about 52 C and the system freezes, or sometimes
crashes. GKrellM shows a sudden rise in "nice usage" on the CPU and in both
processes and disk usage at the same time. Once the rise begins, I have only
seconds before the system freezes.

Attached are two frames from a log of top -b -c , the first from just before the
transition, the second from just after. Note the sudden appearance of ten perl
processes that consume about 10% of the CPU each.

I killed the first of those perl processes before the freezeup could occur, and
all the perl processes also died, the nice usage dropped to zero, and the CPU
temperature dropped back to the normal level of 35 C. I have since rebooted the
system, but the problem, which previously occurred after about a half-hour of a
session, has not returned, so far, after 10 hours.

We have been trying to figure out how 100 CPU usage could cause the CPU to
overheat. The only thing we can think of is that the processes might have somehow
turned off power to the CPU fan, or increased power to the CPU. Have you ever
encountered that kind of thing?

Where it gets interesting, and why I am contacting you, is that before I killed
that process, I could run sensors. Since then, when I run it, I get "No sensors
found!". I ran sensors-detect, and it seems to have run okay. Log attached. This
suggests to me that the process I killed has something to do with sensors.

Any comments or suggestions?

Please visit my website, http://www.constitution.org

-- Jon

http://www2.lm-sensors.nu/~lm78/support.html

----------------------------------------------------------------
Linux Migration Network   7793 Burnet Road #37, Austin, TX 78757
512/374-9585 www.linux-migration.net jroland@linux-migration.net
----------------------------------------------------------------

-------------- next part --------------
A non-text attachment was scrubbed...
Name: top_050822-00x.log
Type: text/x-log
Size: 20728 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050823/997d9906/top_050822-00x-0001.bin
-------------- next part --------------
[root@yara ~]# sensors
No sensors found!
[root@yara ~]# man sensors
Formatting page, please wait...
[root@yara ~]# sensors-detect

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
 Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce3 250Gb SMBus (MCP)
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): y
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus nForce2 adapter at 4c40
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x08
Client found at address 0x4e
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Success!
    (confidence 3, driver `ds1621')
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Failed!
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `Maxim MAX1619'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `Maxim MAX6659'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!

Next adapter: SMBus nForce2 adapter at 4c00
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x08
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x6a

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): y
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
  Trying address 0x0290... Success!
    (confidence 8, driver `it87')
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): y
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8712)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8712)
Probing for `ITE 8712F Super IO Sensors'
  Success... found at address 0x0290
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): y
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

Driver `ds1621' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 4c40'
    Busdriver `i2c-nforce2', I2C address 0x4e
    Chip `Dallas Semiconductor DS1621' (confidence: 3)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 4c00'
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 4c00'
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 4c00'
    Busdriver `i2c-nforce2', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE 8712F Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? y

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
modprobe i2c-isa
# I2C chip drivers
modprobe ds1621
modprobe eeprom
modprobe it87
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): y
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
