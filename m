From: Lou@ParisiHome.net (Lou Parisi)
Date: Mon, 19 Jun 2006 04:49:08 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <000001c6935b$b59e5f40$7001a8c0@parisi02>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi again Jean,
I ran the commands to load the ic2-nforce2 module as per your instructions
and then ran sensors-detects again. =20

Several new sensors were detected and the result of sensors-detect was put
into /etc/sysconfig/lm_sensors but no new sensors were found when I ran the
sensors command line.  Output was the same as previous and behavior of
temperature values was unchanged. =20

I tried to look in the docs but is there something more I need to do for
these new sensors to be reported to output? =20

I copied a new sensors.conf from the source and edited the it87 section only
because I had heavily edited my previous sensors.conf and thought this may
be a reason why the new sensors were not output but this did not change
anything.  The output from all that I tried is below:

---------------------------------------------------------------
# modprobe i2c-nforce2
# echo "10de 00e4" > /sys/bus/pci/drivers/nForce2_smbus/new_id

---------------------------------------------------------------
# sensors-detect
# sensors-detect revision 1.413 (2006/01/19 20:28:00)

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
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce3
250Gb SMBus (MCP)
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus nForce2 adapter at 4c40
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x08
Client found at address 0x4c
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
Probing for `National Semiconductor LM90'... Failed!
Probing for `National Semiconductor LM89/LM99'... Failed!
Probing for `National Semiconductor LM86'... Failed!
Probing for `Analog Devices ADM1032'... Failed!
Probing for `Maxim MAX6657/MAX6658/MAX6659'... Failed!
Probing for `National Semiconductor LM63'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Probing for `Analog Devices ADT7461'... Failed!

Next adapter: SMBus nForce2 adapter at 4c00
Do you want to scan it? (YES/no/selectively): YES
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

Do you want to scan for Super I/O sensors? (YES/no): YES
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
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): YES
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
  * Bus `SMBus nForce2 adapter at 4c00'
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 4c00'
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE 8712F Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the I2C modules.

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
modprobe it87
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

------------------------------------------------------------
cat /etc/sysconfig/lm_sensors
  # Generated by sensors-detect on Sun Jun 18 22:23:50 2006
  MODULE_0=3Di2c-nforce2
  MODULE_1=3Di2c-isa
  MODULE_2=EEprom
  MODULE_3=3Dit87

------------------------------------------------------------
# cat /etc/modprobe.conf
  alias eth0 forcedeth
  alias scsi_hostadapter sata_nv
  alias snd-card-0 snd-intel8x0
  options snd-card-0 index=3D0
  install snd-intel8x0 /sbin/modprobe --ignore-install snd-intel8x0 &&
/usr/sbin/alsactl restore >/dev/null 2>&1 || :
  remove snd-intel8x0 { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-intel8x0
  alias usb-controller ehci-hcd
  alias usb-controller1 ohci-hcd
  alias char-major-89 i2c-dev

-------------------------------------------------------------
note: copied new sensors.conf from source and adjusted it87 device config as
per previous experience and emails

# service lm_sensors start
Starting lm_sensors: loading module i2c-nforce2 i2c-isa eep[  OK  ]

# lsmod
  Module		Size		Used by
  it87		28393		0
  eeprom		10465		0
  i2c_sensor	4161		2 it87,eeprom
  i2c_isa		2881		0
  i2c_dev		14145		0
  i2c_nforce2	7745		0
  i2c_core		27841		6
it87,eeprom,i2c_sensor,i2c_isa,i2c_dev,i2c_nforce2

# sensors -s

# sensors
it87-isa-0290
Adapter: ISA adapter
CPU Vcore: +1.07 V  (min =3D  +1.04 V, max =3D  +1.47 V)
+1.5V:     +1.47 V  (min =3D  +1.42 V, max =3D  +1.57 V)
+3.3V:     +3.31 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:       +4.89 V  (min =3D  +4.76 V, max =3D  +5.24 V)
+12V:     +11.71 V  (min =3D +11.39 V, max =3D +12.61 V)
-12V:     -12.11 V  (min =3D -12.60 V, max =3D -11.37 V)
-5V:       -4.80 V  (min =3D  -5.25 V, max =3D  -4.75 V)
Stdby:     +5.03 V  (min =3D  +4.76 V, max =3D  +5.24 V)
VBat:      +2.94 V
CPU Fan:  3183 RPM  (min =3D 2812 RPM, div =3D 8)
Sys Fan:   981 RPM  (min =3D  664 RPM, div =3D 8)
M/B Temp:    +36??C  (low  =3D   +15??C, high =3D   +40??C)   sensor thermi=
stor
CPU Temp:    +30??C  (low  =3D   +15??C, high =3D   +45??C)   sensor thermi=
stor
Temp3:        -7??C  (low  =3D   +15??C, high =3D   +45??C)   sensor thermi=
stor

---------------------------------------------------------
# pwd
  /sys/bus/pci/drivers/nForce2_smbus

# ls -ltra
  total 0
  drwxr-xr-x  35 root root 0 Jun 18 22:18 ..
  --w-------   1 root root 0 Jun 18 22:18 new_id
  lrwxrwxrwx   1 root root 0 Jun 18 22:19 0000:00:01.1 ->
../../../../devices/pci0000:00/0000:00:01.1
  drwxr-xr-x   2 root root 0 Jun 18 22:19 .

---------------------------------------------------------
# pwd
/sys/devices/pci0000:00/0000:00:01.1

# ls -R
.:
class   detach_state  i2c-1  irq    resource          subsystem_vendor
config  device        i2c-2  power  subsystem_device  vendor

./i2c-1:
1-0050  1-0051  detach_state  name  power

./i2c-1/1-0050:
detach_state  eeprom  name  power

./i2c-1/1-0050/power:
state

./i2c-1/1-0051:
detach_state  eeprom  name  power

./i2c-1/1-0051/power:
state

./i2c-1/power:
state

./i2c-2:
detach_state  name  power

./i2c-2/power:
state

./power:
state

-----------------------------------------------------------------
# lspci -v

00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev
a1)
        Subsystem: Elitegroup Computer Systems: Unknown device 1b53
        Flags: 66Mhz, fast devsel, IRQ 177
        I/O ports at ff00 [size2]
        I/O ports at 4c00 [sized]
        I/O ports at 4c40 [sized]
        Capabilities: [44] Power Management version 2

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org]=20
Sent: Sunday, June 18, 2006 1:13 PM
To: Lou Parisi
Cc: LM Sensors
Subject: Re: [lm-sensors] CPU Temp on ECS NFORCE3-A939

Hi Lou,

> > > The bios reads 1.37V for coreV but lm_sensors reads 1.07 consistently.
> >=20
> > This can be explained easily. Your Athlon64 3000+ must have the
> > so-called "Cool'n'Quiet" feature, which lets it adjust voltage and
> > frequency depending on load. I have a similar processor (Athlon64
> > 3200+, socket 939) those voltage ranges from 1.1V (idle) to 1.4V (full
> > load.) This seems to be roughly the same for you.
> >=20
> > You may try commenting out the following line in your configuration file
> > (in the it87-* section, of course):
> > #   ignore  vid
> > If the VID pins are properly wired on your system, this should report
> > the nominal voltage for your CPU and you should see it change depending
> > on the load.
> >=20
> > So it's really only a matter of setting the proper limits for that kind
> > of CPU. Try the following:
> >=20
> >    set in0_min 1.1 * 0.95
> >    set in0_max 1.4 * 1.05
>=20
>                  I set the alarm values based on the CPU VCore reported in
> the bios.  Perhaps this is not correct, I'm not sure.  I checked and my
> processor does have the Cool'n'Quiet technology.

I guess that either the Cool'n'Quiet is disabled when in the BIOS
screen, or the BIOS is in a tight loop waiting for a key to be pressed
and this keeps the CPU busy. Either way this means that the highest
voltage is used.

>                                                   I have had the ignore
VID
> uncommented but did not figure out how to use it in the sensors.conf.  Did
a
> little more checking on the web and tried out a few more things.  Tried to
> read vid as per the docs:
> 	# cat /sys/bus/i2c/devices/0-0290/in0_ref
> 	cat: /sys/bus/i2c/devices/0-0290/in0_ref: No such file or directory

The file would in fact be named cpu0_vid (it changed in 2.6.9.)

> Listing of /sys/bus/i2c/devices/0-0290:
> # ls /sys/bus/i2c/devices/0-0290
> alarms        fan3_input  in2_max    in5_max    name         temp2_type
> detach_state  fan3_min    in2_min    in5_min    power        temp3_input
> fan1_div      in0_input   in3_input  in6_input  temp1_input  temp3_max
> fan1_input    in0_max     in3_max    in6_max    temp1_max    temp3_min
> fan1_min      in0_min     in3_min    in6_min    temp1_min    temp3_type
> fan2_div      in1_input   in4_input  in7_input  temp1_type
> fan2_input    in1_max     in4_max    in7_max    temp2_input
> fan2_min      in1_min     in4_min    in7_min    temp2_max
> fan3_div      in2_input   in5_input  in8_input  temp2_min

So it's not there, as if your chip was detected as an IT8705F instead
of an IT8712F. Are you certain you are running a 2.6.9 kernel? All
these hints suggest an older kernel.

> When I try to use vid in alarm setting in sensors.conf as below:
> 	set in0_min vid * 0.95
> 	set in0_max vid * 1.05
>=20
> # sensors
> it87-isa-0290
> Adapter: ISA adapter
> CPU VCore: +1.07 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM

Because there is no vid reading, the value of the "vid" symbol is 0.
Anyway you shouldn't use "vid" in compute lines in this case, because
its value changes, and you want to allow the full range your CPU is
allowed to use.

> > What about temp3?
>=20
> Temp3 gives consistently -7C when set to thermistor and consistent +94C
when
> set to diode.  Perhaps temp3 is the correct one and just needs a
correction
> factor.  I will try to get cpuburn running in the next few days and check
to
> see if temp3 changes and send a new reply.

No, it's most certainly not correct either.

> Full output of sensors-detect:
> # sensors-detect
> # sensors-detect revision 1.413 (2006/01/19 20:28:00)
> (...)
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce3
> 250Gb SMBus (MCP)
> Probe succesfully concluded.

Support for this chip was only added in 2.6.11, and although
sensors-detect knows which driver should be used (i2c-nforce2), the
driver doesn't know it should support your chip. As a result, if there
are sensor chips on this bus cannot be accessed.

As I guess you don't really want to upgrade to a more recent kernel,
you should be able to add support for your chip at run time by doing the
following (as root):

$ modprobe i2c-nforce2
$ echo "10de 00e4" > /sys/bus/pci/drivers/nForce2_smbus/new_id

Then run sensors-detect again, and report the results.

> > In kernel 2.6.9 your chip is identified by the driver as "it87" (see
> > the first line of "sensors"), but in later kernels it is better
> > identified as "it8712". We put both in the configuration file so that
> > the same file works with all kernels.

I take that back, 2.6.9 is actually the first kernel which should name
the chip it8712. I'm really surprised it doesn't. Unless you're in fact
using a 2.6.8 kernel.

--=20
Jean Delvare




