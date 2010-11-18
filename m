From: Thanasis <thanasis@asyr.hopto.org>
Date: Thu, 18 Nov 2010 07:31:36 +0000
Subject: [lm-sensors] Atom D525 (on GA-D525TUD)
Message-Id: <4CE4D658.8060805@asyr.hopto.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have a GA-D525TUD mainboard, here are its specs:
http://gigabyte.com/products/product-page.aspx?pid549#sp

I have installed linux (gentoo) with lm_sensors-3.1.2 and kernel
2.6.35-gentoo-r12
Here is the log of sensors-detect:

~ # sensors-detect
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: Gigabyte Technology Co., Ltd. D525TUD

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      Yes
Found `ITE IT8720F Super IO Sensors'                        Success!
    (address 0x290, driver `it87')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
FATAL: Module i2c_i801 not found.
Failed to load module i2c-i801.
Module i2c-dev loaded successfully.

Next adapter: intel drm CRTDDC_A (i2c-0)
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus I801 adapter at 0500 (i2c-1)
Do you want to scan it? (yes/NO/selectively): yes
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `it87':
  * ISA bus, address 0x290
    Chip `ITE IT8720F Super IO Sensors' (confidence: 9)

Driver `coretemp':
  * Chip `Intel Atom thermal sensor' (confidence: 9)


Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify
other file name?
  (yes/NO/s): yes
Done.
You should now start the lm_sensors service to load the required
kernel modules.

Unloading i2c-dev... OK

~ #

...here is the file written:

~ # cat /etc/conf.d/lm_sensors
# Generated by sensors-detect on Thu Nov 18 07:51:30 2010
# This file is sourced by /etc/init.d/lm_sensors and defines the modules to
# be loaded/unloaded.
#
# The format of this file is a shell script that simply defines variables:
# HWMON_MODULES for hardware monitoring driver modules, and optionally
# BUS_MODULES for any required bus driver module (for example for I2C or
SPI).

# Load modules at startup
LOADMODULES=3Dyes

# Initialize sensors at startup
INITSENSORS=3Dyes

HWMON_MODULES=3D"coretemp it87"

# For compatibility reasons, modules are also listed individually as
variables
#    MODULE_0, MODULE_1, MODULE_2, etc.
# Please note that the numbers in MODULE_X must start at 0 and increase in
# steps of 1. Any number that is missing will make the init script skip the
# rest of the modules. Use MODULE_X_ARGS for arguments.
#
# You should use BUS_MODULES and HWMON_MODULES instead if possible.

MODULE_0=3Dcoretemp
MODULE_1=3Dit87
~ #

Then I start lm_sensors:

~ # /etc/init.d/lm_sensors start
 * Loading lm_sensors modules...
 *   Loading coretemp
...                                                                        =
                                                    =20
[ ok ]
 *   Loading it87
...                                                                        =
                                                        =20
[ ok ]
 * Initializing sensors
...                                                                        =
                                                  =20
[ ok ]
~ #

...and finally I run sensors:

~ # sensors
coretemp-isa-0000
Adapter: ISA adapter
ERROR: Can't get value of subfeature temp1_input: Can't read
Core 0:       +0.0=B0C  (crit =3D +100.0=B0C)                =20

coretemp-isa-0001
Adapter: ISA adapter
ERROR: Can't get value of subfeature temp1_input: Can't read
Core 1:       +0.0=B0C  (crit =3D +100.0=B0C)                =20

it8720-isa-0290
Adapter: ISA adapter
in0:         +1.10 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
in1:         +1.52 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
in2:         +3.33 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
in3:         +2.98 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
in4:         +3.12 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
in5:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in6:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in7:         +2.98 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
Vbat:        +3.22 V
fan1:       3947 RPM  (min =3D    0 RPM)
fan2:       1776 RPM  (min =3D    0 RPM)
temp1:       -55.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
thermistor
temp2:       +63.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
thermistor
temp3:       +33.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
thermal diode
cpu0_vid:   +1.850 V
 ~ #

Is the above ERROR normal?
Is there something I can/should do/configure about it?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
