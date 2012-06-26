From: Michael Zintakis <michael.zintakis@googlemail.com>
Date: Tue, 26 Jun 2012 23:56:00 +0000
Subject: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <4FEA4C10.2060904@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

I hope this is the right place to place my query!

I am trying to take control and initialise my fan censors and=20
"sensors-detect" is telling me that the chip on the board is "Fintek=20
f71869a at 0x290, revision 32". However, when I run sensors (the=20
service) this driver is not loaded (I can't see any of the fan sensors=20
either) and dmesg is showing me the following:

[ 2312.804747] f71882fg: Found f71869a chip at 0x290, revision 32
[ 2312.804902] ACPI Warning: 0x00000290-0x00000297 SystemIO conflicts=20
with Region \_TZ_.IP__ 1 (20120111/utaddress-251)
[ 2312.804919] ACPI Warning: 0x00000290-0x00000297 SystemIO conflicts=20
with Region \_SB_.PCI0.LPCB.SIO1.RNTR 2 (20120111/utaddress-251)
[ 2312.804934] ACPI: If an ACPI driver is available for this device, you=20
should use it instead of the native driver

Could anybody tell me what the above means please? Is there a conflict=20
between ACPI and the Fintek kernel module sensors (the service) is=20
trying to load? Is there a separate "ACPI driver" I should be using=20
instead? If so, how can I activate it so that I could get to read my fan=20
sensors?

When I run "sensors" (the program) I see very limited information, like=20
this:

acpitz-virtual-0
Adapter: Virtual device
temp1:        +48.0=B0C  (crit =3D +127.0=B0C)
temp2:        +26.8=B0C  (crit =3D +127.0=B0C)
temp3:        +26.8=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +51.0=B0C  (crit =3D +100.0=B0C)
Core 1:       +51.0=B0C  (crit =3D +100.0=B0C)

This is not OK because I don't have any RPMs of any of the fans (I have=20
3 fans running) and various voltages I have on this board. I am using=20
Fedora Core 17 with kernel version 3.3.4 with the latest version of=20
lm_sensors (3.3.2, I think).

Many thanks!


MZ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
