From: kamen@ggbit.info (kamen)
Date: Mon, 01 May 2006 10:26:36 +0000
Subject: [lm-sensors] sensors work but broke the network and sound
Message-Id: <20060501102636.2558218C904@mail.host.bg>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060430120557.12F6E18C67F@mail.host.bg>
In-Reply-To: <20060430120557.12F6E18C67F@mail.host.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again

*Linux distro - VectorLinux, based on Slackware
*Kernel version - 2.6.13
*lm_sensors version - 2.9.2
*motherboard - nvidia nforce2


So I disabled sensors modules and made a cold reboot, but still no network and sound. In the outputs at boot/shutdown I saw that it can't find any sound card.

What I change in /etc/rc.modules and /etc/modules.conf is commented in the files I post here; 

Althought, I ran again sensors-detect, here is the full output: 

==================================================
[root at kamen-vectorlinux/home/kamen]# sensors-detect
# sensors-detect revision 1.393 (2005/08/30 18:51:18)

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
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `rivatv' for device 02:00.0: GeForce FX 5600
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce2 SMBus (MCP)
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `rivatv' (say NO if built into your kernel)? (YES/no): no
Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no): yes
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): yes
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus nForce2 adapter at 5100
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x08
Client found at address 0x4e
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Failed!
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `Maxim MAX1619'... Failed!
Probing for `National Semiconductor LM82/LM83'... Failed!
Probing for `Maxim MAX6659'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!

Next adapter: SMBus nForce2 adapter at 5000
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x08
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')

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
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
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

Do you want to scan for Super I/O sensors? (YES/no): yes
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
Probing for `Winbond W83687THF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x52)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x52)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (0x5217)

Do you want to scan for secondary Super I/O sensors? (YES/no): yes
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
  * Bus `SMBus nForce2 adapter at 5000'
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 5000'
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

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
 I2C/SMBus (ISA/smbus)? isa

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
modprobe eeprom
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
 
==========================================================

Here's my /etc/rc.d/rc.modules:

==========================
==========================

### Update module dependencies ###
RELEASE=`uname -r`
VERSION=`kernelversion`
# If /usr is mounted and we have 'find', we can try to take a shortcut:
if [ -x /usr/bin/find -a -e /lib/modules/$RELEASE/modules.dep \
     -a /lib/modules/$RELEASE/modules.dep -nt /etc/modules.conf ]; then
  NEWMODS="`/usr/bin/find /lib/modules/$RELEASE -type f -newer /lib/modules/$RELEASE/modules.dep`"
  # Only rebuild dependencies if new module(s) are found:
  if [ ! "" = "$NEWMODS" ]; then
    echo "Updating module dependencies for Linux $RELEASE:"
    /sbin/depmod -a
  else
    echo "Module dependencies up to date (no new kernel modules found)."
  fi
else # we don't have find, or there is no existing modules.dep, or it is out of date.
  echo "Updating module dependencies for Linux $RELEASE:"
  /sbin/depmod -A
fi

###Alsa OSS Emulatation layer###
/sbin/modprobe snd-pcm-oss
/sbin/modprobe snd-seq-oss
/sbin/modprobe snd-mixer-oss
###############################

if [ -x /etc/rc.d/rc.netdevice ]; then
  . /etc/rc.d/rc.netdevice
fi


/sbin/modprobe sg

## Kernel 2.4 base modules
if [ "$VERSION" = "2.4" ]; then

    ### load ide-scsi if specified on boot parameter
    if grep -q "=ide-scsi " /proc/cmdline ; then
	/sbin/modprobe ide-scsi
    fi
    fi
# end VERSION check

#lm_sensor modules:
modprobe i2c-nforce2 
modprobe i2c-viapro
modprobe i2c-isa
modprobe eeprom
modprobe w83627hf
/usr/bin/sensors -s

===============================
===============================

And my /etc/modules.conf:

#needed by lm_sensors:
alias char-major-89 i2c-dev

=====================

Hope to help you find the mistakes
