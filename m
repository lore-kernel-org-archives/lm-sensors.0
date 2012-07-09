From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Jul 2012 03:50:40 +0000
Subject: Re: [lm-sensors] ACPI: I/O resource dme1737 [0xa70-0xa71] conflicts with ACPI region RNTR [0xa00-0xa
Message-Id: <20120709035040.GA21820@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOi8JQyxPWqc4=w+NorQSWQfVyY3Mswmkf0wQ58BTvH0qKFFhg@mail.gmail.com>
In-Reply-To: <CAOi8JQyxPWqc4=w+NorQSWQfVyY3Mswmkf0wQ58BTvH0qKFFhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Jul 08, 2012 at 12:18:23PM +0430, Mohsen Jamali wrote:
> *1Hi guys :)*
> im using Debian squeeze on this machine :
> http://www.advantech.com/products/PCM-9363/mod_235FB6C7-A605-4230-B8DA-33=
F5B4F6A1AA.aspx
> *
> this machine have a hardware watchdog that i want to use it on Debian.
> these are the output of some command that i think is useful to know:
> *
> root@dhcppc2:/home/p# acpi -V
> No support for device type: power_supply
> No support for device type: power_supply
> Cooling 0: Processor 0 of 0
> Cooling 1: Processor 0 of 0
>=20
> root@dhcppc2:/home/p# modprobe dme1737
> FATAL: Error inserting dme1737
> (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/dme1737.ko): Device or
> resource busy
>=20
> root@dhcppc2:/home/p# sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +45.0=B0C  (crit =3D +100.0=B0C)
>=20
>=20
> *and here is the output of dmesg:*
> [  403.388163] ACPI: I/O resource dme1737 [0xa70-0xa71] conflicts with AC=
PI
> region RNTR [0xa00-0xa7f]
> [  403.388175] ACPI: If an ACPI driver is available for this device, you
> should use it instead of the native driver
>=20
> *and when i uncomment this line of /etc/watchdog.conf the machine restart=
s!*
> #watchdog-device        =3D /dev/watchdog
>=20
> *what's the solution of this problem?
> thanks :)*

Please see
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginke=
rnel2.6.31

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
