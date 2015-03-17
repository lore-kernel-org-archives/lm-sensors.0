From: Alexander Bruns <mailinglisten@alexander-bruns.de>
Date: Tue, 17 Mar 2015 10:43:16 +0000
Subject: [lm-sensors] Problem with IT8620E
Message-Id: <55080544.5020202@alexander-bruns.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I have a Mainboard from Gigabyte which is this one:

GA-Z97X-Gaming G1 WIFI-BK

I am running the board with gentoo-linux and 3.18.3 Kernel


It has ITE 8620 onboard:

--------------------------- 8< Schnipp 8< ---------------------------
holodeck ~ # sensors-detect
# sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)
# System: Gigabyte Technology Co., Ltd. Z97X-Gaming G1 WIFI-BK

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
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
Intel digital thermal sensor...                             Success!
     (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0x8620
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0x8790
--------------------------- 8< Schnapp 8< ---------------------------




I try to use it like stated in the device overview as ITE 8728

--------------------------- 8< Schnipp 8< ---------------------------
holodeck ~ # cat /etc/modprobe.d/lm_sensors.conf
options it87 force_id=3D0x8728
--------------------------- 8< Schnapp 8< ---------------------------




Here is my Output of sensors:

--------------------------- 8< Schnipp 8< ---------------------------
holodeck ~ # sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +27.8=B0C  (crit =3D +105.0=B0C)
temp2:        +29.8=B0C  (crit =3D +105.0=B0C)

it8728-isa-0a30
Adapter: ISA adapter
in0:          +0.05 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in1:          +2.02 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in2:          +2.03 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in3:          +2.00 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in4:          +0.01 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in5:          +1.73 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in6:          +1.51 V  (min =3D  +0.00 V, max =3D  +3.06 V)
3VSB:         +3.38 V  (min =3D  +0.00 V, max =3D  +6.12 V)
Vbat:         +2.98 V
fan1:         627 RPM  (min =3D   10 RPM)
fan2:         607 RPM  (min =3D   10 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
fan4:           0 RPM  (min =3D    0 RPM)
fan5:           0 RPM  (min =3D    0 RPM)
temp1:        +34.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
thermistor
temp2:        +51.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
thermistor
temp3:       -128.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
Intel PECI
intrusion0:  ALARM
--------------------------- 8< Schnapp 8< ---------------------------


Now the Problem:

The Board has the possibility to connect 5 Case Fans and 2 CPU Fans

I have 1 CPU-Fan and 3 Case Fans.

CPU-Fan has 4 power-lanes, case-fans have all 3 power-lanes
where 4 are possible

fan1 above in sensors-output is the same as SYS_FAN2, so a case-fan
fan2 above in sensors-output is the same as SYS_FAN3, so a case-fan.

I tried to stop the fans to see which one of the two shown by sensors
is which one in the hardware I have.

So one case-fan is missing and !!! CPU-Fan is missing here.

I also tried to apply this patch to the kernel:
http://www.spinics.net/lists/lm-sensors/msg43167.html

I then see in sensors the same output, but instead of
it8728-isa-0a30
I see
it8620-isa-0a30

So I would like to do tests for you te get a working
patch for ITE 8620E


Onbaord I see on the chip this:
ITE 8620E
1404-CXS
SZOTZA

How can I help?

Alexander

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
