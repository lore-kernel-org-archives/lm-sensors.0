From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 13 Jan 2011 16:43:49 +0000
Subject: Re: [lm-sensors] Accuracy of "via_cputemp" Module in LM_Sensors
Message-Id: <20110113174349.53a7ac28@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D2C1931.5000301@myamigos.us>
In-Reply-To: <4D2C1931.5000301@myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Tue, 11 Jan 2011 02:47:45 -0600, Jeff Rickman wrote:
> I am trying to track down a temperature discrepancy on a Jetway=20
> J7F4K1G5D "Versa" motherboard. This board has a VIA C-7 D cpu (25W=20
> version). The operating system is Fedora Core 14 i386, kernel=20
> 2.6.35.10-74.fc14.i686.PAE. I am running this version of "sensors":=20
> sensors version 3.2.0 with libsensors version 3.2.0
>=20
> LM_Sensors loads the following modules:
> acpitz-virtual-0
> f71805f-isa-0290 (using acpi_enforce_resources=3Dlax)
> via_cputemp-isa-0000
>=20
> I understand the risk of using "lax", but there is no ACPI version of=20
> the "f71805f" module and Jetway ACPI grabs 0x295-0x296 from the IO range =

> 0x290-0x297.

Yes, I have the same problem on my Jetway K8M8MS, also with a Fintek
F71805FG. ACPI uses the I/O ports to expose one temperature through the
thermal zone interface. On my system, the ACPI code is broken and reads
the wrong register, so the thermal zone interface is useless. At least
on your system, the reported value matches what the hardware monitoring
device returns when accessed directly.

> Back to my question....
>=20
> When I boot this machine I can read the System and CPU temperatures from =

> the boot screen. I can also go into the BIOS and read the same values in =

> the "PC Health" screen as seen on the boot screen. The boot values=20
> typically show as 12C-16C for CPU temp and 27C-30C for System temp.=20
> Others have posted comments elsewhere saying this VIA CPU does not run=20
> warm, especially when idle, but that temperature range is approximately=20
> the ambient range for the room where that machine is located. I thought=20
> pushing electrons through silicon generated some heat?
>=20
> Once FC14 is booted, I can run the "sensors" command and see the=20
> following values:
>=20
> [root@XX ~]# sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +11.0=B0C  (crit =3D +60.0=B0C)
>=20
> f71805f-isa-0290
> Adapter: ISA adapter
> [...voltages and fan info removed...]
> System Temp: +11.0=B0C  (high =3D +60.0=B0C, hyst =3D +49.0=B0C)  sensor =
=3D thermal=20
> diode
> CPU Temp:    +27.0=B0C  (high =3D +60.0=B0C, hyst =3D  +0.0=B0C)  sensor =
=3D thermal=20
> diode


Note: acpitz and f71805f apparently read the temperature value from the
same F71805FG device. Access isn't synchronized, so this is dangerous.
If you boot with acpi_enforce_resources=3Dlax, you should NOT use the
ACPI "thermal" driver.

> via_cputemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +27.0=B0C
>=20
> I modified my "/etc/sensors.d/local.conf" file to match the outputs=20
> shown in "f71805f-isa-0290" to those seen in "via_cputemp-isa-0000" and=20
> "acpitz-virtual-0" since there are no corresponding values in my=20
> "/etc/sensors3.conf". In this case "temp1" is mapped to "System Temp"=20
> and "temp2" is mapped to "CPU Temp" in my "local.conf" file.
>=20
> After studying the code posted on "lm-sensors.org" for the standalone=20
> "via_cputemp" module, I think the "via_cputemp" module pulls it's=20
> temperature value from a MSR. I did not have the source code handy for=20
> my distribution when I did this research, but does one expect=20
> differences on what value is being accessed (doubt it)? Perhaps the=20
> value being accessed is achieved through a different mechanism? If it=20
> matters I will do the research in the FC14 source code.

I don't quite understand your question, sorry. The via-cputemp indeed
gets its temperature value from an MSR, much like the coretemp driver.
This is a direct digital temperature reading. The f71805 driver, OTOH,
relies on external thermal sensors connected to its pins, and converts
the analog signal to a digital reading.

> Every time I run "sensors", the value shown in "via_cputemp" is within=20
> +-2C or less of the "CPU Temp" value reported by "f71805f". The same=20
> (+-2C or less) can be said for the "acpitz" value and the "System Temp"=20
> value from "f71805f". Numbers that are that close on a consistent basis=20
> are a coincidence that is too good to be true, which is why I suspect=20
> Jetway has what could be a simple "label swap error" in their BIOS.

Yes, I agree with your analysis. And they probably also have a bug in
their ACPI thermal zone implementation: it should really report the CPU
temperature and not the system temperature. Well, reporting the system
temperature isn't bad per se, but it's certainly less useful than
reporting the CPU temperature, if they decided to return a single value.

> If the MSR value read by "via_cputemp" is correct, and I think it is,=20
> then I think Jetway has their BIOS labels (what they display on screen)=20
> switched for "CPU temp" and "System Temp". I have posted a message to=20
> Jetway tech support asking them about this matter. Hopefully they will=20
> respond in a timely manner.
>=20
> Does my logic and understanding of the "via_cputemp" code make sense, or =

> have I gotten myself turned around the wrong way on this issue?

HTH,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
