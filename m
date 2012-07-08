From: Mohsen Jamali <mohsen.aria@gmail.com>
Date: Sun, 08 Jul 2012 07:54:37 +0000
Subject: [lm-sensors] ACPI: I/O resource dme1737 [0xa70-0xa71] conflicts with ACPI region RNTR [0xa00-0xa7f]
Message-Id: <CAOi8JQyxPWqc4=w+NorQSWQfVyY3Mswmkf0wQ58BTvH0qKFFhg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8931328882443882967=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8931328882443882967==
Content-Type: multipart/alternative; boundary=20cf303dd5a4f5451004c44cb9e1

--20cf303dd5a4f5451004c44cb9e1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

*1Hi guys :)*
im using Debian squeeze on this machine :
http://www.advantech.com/products/PCM-9363/mod_235FB6C7-A605-4230-B8DA-33F5=
B4F6A1AA.aspx
*
this machine have a hardware watchdog that i want to use it on Debian.
these are the output of some command that i think is useful to know:
*
root@dhcppc2:/home/p# acpi -V
No support for device type: power_supply
No support for device type: power_supply
Cooling 0: Processor 0 of 0
Cooling 1: Processor 0 of 0

root@dhcppc2:/home/p# modprobe dme1737
FATAL: Error inserting dme1737
(/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/dme1737.ko): Device or
resource busy

root@dhcppc2:/home/p# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +45.0=B0C  (crit =3D +100.0=B0C)


*and here is the output of dmesg:*
[  403.388163] ACPI: I/O resource dme1737 [0xa70-0xa71] conflicts with ACPI
region RNTR [0xa00-0xa7f]
[  403.388175] ACPI: If an ACPI driver is available for this device, you
should use it instead of the native driver

*and when i uncomment this line of /etc/watchdog.conf the machine restarts!=
*
#watchdog-device        =3D /dev/watchdog

*what's the solution of this problem?
thanks :)*

--20cf303dd5a4f5451004c44cb9e1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font color=3D"#000066"><font><font face=3D"tahoma,sans-serif"><b>1Hi guys =
:)</b><br>im using Debian squeeze on this machine : <a href=3D"http://www.a=
dvantech.com/products/PCM-9363/mod_235FB6C7-A605-4230-B8DA-33F5B4F6A1AA.asp=
x">http://www.advantech.com/products/PCM-9363/mod_235FB6C7-A605-4230-B8DA-3=
3F5B4F6A1AA.aspx</a><br>

<b><br>this machine have a hardware watchdog that i want to use it on Debia=
n. these are the output of some command that i think is useful to know:<br>=
</b><br>root@dhcppc2:/home/p# acpi -V
<br>No support for device type: power_supply
<br>No support for device type: power_supply
<br>Cooling 0: Processor 0 of 0
<br>Cooling 1: Processor 0 of 0<br><br>root@dhcppc2:/home/p# modprobe dme17=
37
<br>FATAL: Error inserting dme1737 (/lib/modules/2.6.32-5-amd64/kernel/driv=
ers/hwmon/dme1737.ko): Device or resource busy
<br><br>root@dhcppc2:/home/p# sensors
<br>coretemp-isa-0000
<br>Adapter: ISA adapter
<br>Core 0:=A0=A0=A0=A0=A0 +45.0=B0C=A0 (crit =3D +100.0=B0C)=A0=A0=A0=A0 <=
br><br><br><b>and here is the output of dmesg:</b><br>[=A0 403.388163] ACPI=
: I/O resource dme1737 [0xa70-0xa71] conflicts with ACPI region RNTR [0xa00=
-0xa7f]
<br>[=A0 403.388175] ACPI: If an ACPI driver is available for this device, =
you should use it instead of the native driver<br><br><b>and when i uncomme=
nt this line of /etc/watchdog.conf the machine restarts!</b><br>#watchdog-d=
evice=A0=A0=A0=A0=A0=A0=A0 =3D /dev/watchdog<br>

<br><b>what&#39;s the solution of this problem? <br>thanks :)</b><br></font=
></font></font>

--20cf303dd5a4f5451004c44cb9e1--


--===============8931328882443882967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8931328882443882967==--
