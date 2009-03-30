From: Valmor de Almeida <val.lists@gmail.com>
Date: Mon, 30 Mar 2009 14:48:28 +0000
Subject: [lm-sensors] system temperature on lifebook 1610 fujitsu
Message-Id: <49D0DBBC.2090309@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hello,

I am new to lm_sensors and have recently installed version 2.10.7 in a=20
gentoo linux distro. The output of sensors is:

-> sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +54=B0C  (high =3D  +100=B0C)

and I am wondering why I am not seeing the system temperature which I=20
believe it is listed under

-> cat /proc/acpi/thermal_zone/TZ00/temperature
temperature:             27 C

or

-> cat /proc/acpi/thermal_zone/TZ01/temperature
temperature:             27 C

(why two zones? I am not sure either). The kernel modules loaded are:

-> lsmod
Module                  Size  Used by
coretemp                4736  0
sbs                    11144  0
sbshc                   4736  1 sbs
i2c_i801                8080  0

During the lm_sensors install it required the smartbatt module but the=20
kernel 2.6.27.12 would only build shs.ko. Which brings me to another=20
question of whether the battery info should be listed in the output of=20
sensors??

-> cat /proc/acpi/battery/CMB1/info
present:                 yes
design capacity:         5200 mAh
last full capacity:      5200 mAh
battery technology:      rechargeable
design voltage:          10800 mV
design capacity warning: 644 mAh
design capacity low:     72 mAh
capacity granularity 1:  1 mAh
capacity granularity 2:  1 mAh
model number:            CP229725 / CP229726
serial number:           1
battery type:            LION
OEM info:                Fujitsu

Thank you in advance for your help with these basic questions.

--
Valmor



-> sensors-detect
# sensors-detect revision 5291 (2008-06-23 23:40:46 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no): NO
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 18a0 (i2c-0)
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x0b
Probing for `Smart Battery'...                              Success!
     (confidence 5, driver `smartbatt')
Client found at address 0x19
Probing for `Analog Devices ADM1021'...                     No
Probing for `Analog Devices ADM1021A/ADM1023'...            No
Probing for `Maxim MAX1617'...                              No
Probing for `Maxim MAX1617A'...                             No
Probing for `Maxim MAX1668'...                              No
Probing for `Maxim MAX1805'...                              No
Probing for `Maxim MAX1989'...                              No
Probing for `Maxim MAX6655/MAX6656'...                      No
Probing for `TI THMC10'...                                  No
Probing for `National Semiconductor LM84'...                No
Probing for `Genesys Logic GL523SM'...                      No
Probing for `Onsemi MC1066'...                              No
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `Maxim MAX6680/MAX6681'...                      No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): YES
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown non-standard chip with ID 0x7a
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x0b00

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no): YES
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
     (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `smartbatt' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at 18a0'
     Busdriver `i2c-i801', I2C address 0x0b
     Chip `Smart Battery' (confidence: 5)

Driver `coretemp' (should be inserted):
   Detects correctly:
   * Chip `Intel Core family thermal sensor' (confidence: 9)

To load everything that is needed, execute the commands below...

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
# Chip drivers
# Warning: the required module smartbatt is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe smartbatt
# Warning: the required module coretemp is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe coretemp
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----end cut here----
Do you want to generate /etc/conf.d/lm_sensors? Enter s for other=20
filename (yes/NO/s): yes
Done.
You should now start the lm_sensors service to load the required
kernel modules.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
