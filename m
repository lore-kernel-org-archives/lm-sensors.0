From: Jeff Rickman <jrickman@myamigos.us>
Date: Tue, 11 Jan 2011 08:47:45 +0000
Subject: [lm-sensors] Accuracy of "via_cputemp" Module in LM_Sensors
Message-Id: <4D2C1931.5000301@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,

I am trying to track down a temperature discrepancy on a Jetway=20
J7F4K1G5D "Versa" motherboard. This board has a VIA C-7 D cpu (25W=20
version). The operating system is Fedora Core 14 i386, kernel=20
2.6.35.10-74.fc14.i686.PAE. I am running this version of "sensors":=20
sensors version 3.2.0 with libsensors version 3.2.0

LM_Sensors loads the following modules:
acpitz-virtual-0
f71805f-isa-0290 (using acpi_enforce_resources=3Dlax)
via_cputemp-isa-0000

I understand the risk of using "lax", but there is no ACPI version of=20
the "f71805f" module and Jetway ACPI grabs 0x295-0x296 from the IO range=20
0x290-0x297.

Back to my question....

When I boot this machine I can read the System and CPU temperatures from=20
the boot screen. I can also go into the BIOS and read the same values in=20
the "PC Health" screen as seen on the boot screen. The boot values=20
typically show as 12C-16C for CPU temp and 27C-30C for System temp.=20
Others have posted comments elsewhere saying this VIA CPU does not run=20
warm, especially when idle, but that temperature range is approximately=20
the ambient range for the room where that machine is located. I thought=20
pushing electrons through silicon generated some heat?

Once FC14 is booted, I can run the "sensors" command and see the=20
following values:

[root@XX ~]# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +11.0=B0C  (crit =3D +60.0=B0C)

f71805f-isa-0290
Adapter: ISA adapter
[...voltages and fan info removed...]
System Temp: +11.0=B0C  (high =3D +60.0=B0C, hyst =3D +49.0=B0C)  sensor =
=3D thermal=20
diode
CPU Temp:    +27.0=B0C  (high =3D +60.0=B0C, hyst =3D  +0.0=B0C)  sensor =
=3D thermal=20
diode

via_cputemp-isa-0000
Adapter: ISA adapter
Core 0:      +27.0=B0C

I modified my "/etc/sensors.d/local.conf" file to match the outputs=20
shown in "f71805f-isa-0290" to those seen in "via_cputemp-isa-0000" and=20
"acpitz-virtual-0" since there are no corresponding values in my=20
"/etc/sensors3.conf". In this case "temp1" is mapped to "System Temp"=20
and "temp2" is mapped to "CPU Temp" in my "local.conf" file.

After studying the code posted on "lm-sensors.org" for the standalone=20
"via_cputemp" module, I think the "via_cputemp" module pulls it's=20
temperature value from a MSR. I did not have the source code handy for=20
my distribution when I did this research, but does one expect=20
differences on what value is being accessed (doubt it)? Perhaps the=20
value being accessed is achieved through a different mechanism? If it=20
matters I will do the research in the FC14 source code.

Every time I run "sensors", the value shown in "via_cputemp" is within=20
+-2C or less of the "CPU Temp" value reported by "f71805f". The same=20
(+-2C or less) can be said for the "acpitz" value and the "System Temp"=20
value from "f71805f". Numbers that are that close on a consistent basis=20
are a coincidence that is too good to be true, which is why I suspect=20
Jetway has what could be a simple "label swap error" in their BIOS.

If the MSR value read by "via_cputemp" is correct, and I think it is,=20
then I think Jetway has their BIOS labels (what they display on screen)=20
switched for "CPU temp" and "System Temp". I have posted a message to=20
Jetway tech support asking them about this matter. Hopefully they will=20
respond in a timely manner.

Does my logic and understanding of the "via_cputemp" code make sense, or=20
have I gotten myself turned around the wrong way on this issue?

Thank you.

Jeff


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
