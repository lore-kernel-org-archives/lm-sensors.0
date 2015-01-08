From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 08 Jan 2015 21:17:33 +0000
Subject: Re: [lm-sensors] hwmon strangeness, no fan control on w83627dhg
Message-Id: <20150108211733.GA31909@amd>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150108202919.GA25118@amd>
In-Reply-To: <20150108202919.GA25118@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu 2015-01-08 12:32:07, David Hubbard wrote:
> I see your machine is named "amd" but we need more information. Could you
> please post the output of "sensor-detect"?

That machine is named "amd", but it is actually a core2 intel
system. sensors-detect is below, sensors output is a bonus :-):


root@amd:~# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +40.0=B0C  (high =3D +76.0=B0C, crit =3D +100.0=B0C)
Core 1:       +40.0=B0C  (high =3D +76.0=B0C, crit =3D +100.0=B0C)

w83627dhg-isa-0a10
Adapter: ISA adapter
Vcore:        +1.26 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:          +1.11 V  (min =3D  +0.15 V, max =3D  +1.80 V)
AVCC:         +3.36 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:        +3.36 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:          +1.29 V  (min =3D  +1.78 V, max =3D  +0.49 V)  ALARM
in5:          +0.75 V  (min =3D  +1.94 V, max =3D  +1.41 V)  ALARM
in6:          +0.87 V  (min =3D  +1.18 V, max =3D  +0.73 V)  ALARM
3VSB:         +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:         +3.31 V  (min =3D  +2.70 V, max =3D  +3.63 V)
fan1:           0 RPM  (min =3D 5273 RPM, div =3D 64)  ALARM
fan2:         799 RPM  (min =3D 4440 RPM, div =3D 8)  ALARM
fan3:           0 RPM  (min =3D 4218 RPM, div =3D 64)  ALARM
fan4:           0 RPM  (min =3D 14673 RPM, div =3D 4)  ALARM
fan5:           0 RPM  (min =3D 28125 RPM, div =3D 4)  ALARM
temp1:        +35.0=B0C  (high =3D +34.0=B0C, hyst =3D  +4.0=B0C)  ALARM  s=
ensor
=3D thermistor
temp2:        +25.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D CPU
diode
temp3:        +41.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D
thermistor
cpu0_vid:    +0.000 V
intrusion0:  ALARM

root@amd:~# watch sensors
root@amd:~# sensors-detect
# sensors-detect revision 6209 (2014-01-14 22:51:58 +0100)
# Board: Intel Corporation DG41MJ

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded
sensors.
Do you want to scan for them? This is totally safe. (YES/no):
modprobe: ERROR: ../libkmod/libkmod.c:557 kmod_search_moddep() could
not open moddep file '/lib/modules/3.19.0-rc3/modules.dep.bin'
Failed to load module cpuid.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
AMD Family 16h power sensors...                             No
Intel digital thermal sensor...                             No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Winbond W83627DHG-P/W83527HG Super IO Sensors'       Success!
    (address 0xa10, driver `w83627ehf')
    Probing for Super-I/O at 0x4e/0x4f
    Trying family `National Semiconductor/ITE'...               No
    Trying family `SMSC'...                                     No
    Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
    Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common
interfaces
through which system health data may be retrieved, amongst other
things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O
ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have
any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
modprobe: ERROR: ../libkmod/libkmod.c:557 kmod_search_moddep() could
not open moddep file '/lib/modules/3.19.0-rc3/modules.dep.bin'
Failed to load module i2c-i801.
modprobe: ERROR: ../libkmod/libkmod.c:557 kmod_search_moddep() could
not open moddep file '/lib/modules/3.19.0-rc3/modules.dep.bin'
Failed to load module i2c-dev.

Next adapter: i915 gmbus ssc (i2c-0)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus vga (i2c-1)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus panel (i2c-2)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpc (i2c-3)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpb (i2c-4)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpd (i2c-5)
Do you want to scan it? (yes/NO/selectively):

Next adapter: DPDDC-C (i2c-6)
Do you want to scan it? (yes/NO/selectively):


Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83627ehf':
  * ISA bus, address 0xa10
      Chip `Winbond W83627DHG-P/W83527HG Super IO Sensors'
      (confidence: 9)

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
w83627ehf
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)




--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
