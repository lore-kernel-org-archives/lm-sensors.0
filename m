From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 22 Aug 2013 16:13:36 +0000
Subject: Re: [lm-sensors] why does # of temperature sensors decrease in 3.11 (thinkfan config related)
Message-Id: <20130822161336.GA13004@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <52074F4B.5020003@gmx.de>
In-Reply-To: <52074F4B.5020003@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Aug 22, 2013 at 06:09:01PM +0200, Toralf F=F6rster wrote:
> On 08/22/2013 09:32 AM, Jean Delvare wrote:
> > Hi Toralf,
> >=20
> > On Sun, 11 Aug 2013 10:46:03 +0200, Toralf F=F6rster wrote:
> >> I'm just wondering why the # of sensors at my ThinkPad T420 lowers from
> >> 3 in kernel 3.10 :
> >>
> >> sensor /sys/devices/platform/coretemp.0/temp1_input     # physical id 0
> >> sensor /sys/devices/platform/coretemp.0/temp2_input     # core 0
> >> sensor /sys/devices/platform/coretemp.0/temp3_input     # core 1
> >>
> >> to just one for 3.11:
> >>
> >> /sys/class/hwmon/hwmon0/temp1_input
> >=20
> > Most likely this is not even the same sensor. Check the value
> > of /sys/class/hwmon/hwmon0/name to find out what this sensor is. Could
> > be the graphics chip temperature readout, or an ACPI thermal zone.
> >=20
> >> Do I miss a (new ?) kernel config ?
> >=20
> > Output of "sensors" in both cases would help. Also make sure that your
> > new kernel still has CONFIG_SENSORS_CORETEMP enabled, and that the
> > coretemp driver is loaded if modular.
> >=20
>=20
> $ zgrep CONFIG_SENSORS_CORETEMP /proc/config.gz
> CONFIG_SENSORS_CORETEMP=3Dm
>=20
> Ah thx - a "modprobe coretemp" helps a lot - is this new ?
>=20
> Now I do have the expected picture :
>=20
> # sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +51.0=B0C  (crit =3D +98.0=B0C)
>=20
> thinkpad-isa-0000
> Adapter: ISA adapter
> fan1:        3120 RPM
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +58.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
> Core 0:         +58.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
> Core 1:         +56.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
>=20
>=20
> Why is that module not auto loaded ? Hhm ?
>=20
It never was. Maybe your relase update replaced /etc/modules.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
