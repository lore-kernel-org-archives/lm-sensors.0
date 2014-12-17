From: Sean O'Brien <sean451@hotmail.com>
Date: Wed, 17 Dec 2014 16:54:24 +0000
Subject: Re: [lm-sensors] Supermicro X7DBU configuration
Message-Id: <BLU175-W125EBDFCF9E3E0E9225D75E66D0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU175-DS1275A243EB8731D1852460E66C0@phx.gbl>
In-Reply-To: <BLU175-DS1275A243EB8731D1852460E66C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Thanks for the help guys.
The driver is loaded. It is placed into /etc/modules by a run of sensor-det=
ect, so it sees it. It shows up in the output of lsmod and a replace of the=
 module using modprobe doesn't show any errors when loading it. However, as=
 you point out, it doesn't show up in the output of the sensors commands (a=
fter running sensors -s also). Perhaps this is also and issue with the /etc=
/sensors3.conf files not having the appropriate entries for this board? The=
 entry in there for this chip is as follows:
chip "w83793-*"
    label in0 "VcoreA"    label in1 "VcoreB"    label in7 "+5V"    label in=
8 "5VSB"    label in9 "Vbat"
    set in7_min  5.0 * 0.90    set in7_max  5.0 * 1.10    set in8_min  5.0 =
* 0.90    set in8_max  5.0 * 1.10    set in9_min  3.0 * 0.90    set in9_max=
  3.0 * 1.10

Btw. I found the machine doesn't have the IPMI board fitted, so no go there.
Thanks again.

> Date: Wed, 17 Dec 2014 08:27:12 -0800
> From: linux@roeck-us.net
> To: jdelvare@suse.de
> CC: sean451@hotmail.com; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Supermicro X7DBU configuration
>=20
> On Wed, Dec 17, 2014 at 04:47:58PM +0100, Jean Delvare wrote:
> > Le Wednesday 17 December 2014 =E0 06:43 -0800, Guenter Roeck a =E9crit :
> > > On 12/17/2014 02:08 AM, Jean Delvare wrote:
> > > > This chip is missing from the output of "sensors" below. You need to
> > > > figure out why. Is the w83793 kernel module available on your syste=
m?
> > > > Is it loaded? If not, what happens if you try to load it manually? =
Any
> > > > error message in the kernel log? The fans are certainly connected to
> > > > that chip.
> > >=20
> > > Hardware monitoring might be disabled for this chip. I have seen this
> > > with other Supermicro boards; on mine, for example, they use the seco=
nd
> > > SuperIO chip only for additional serial ports. The kernel log might
> > > give a hint if that is the case.
> >=20
> > I doubt this is the case here, as the W83793G is a dedicated hardware
> > monitoring chip. There's no point in putting it on the board if they
> > don't use the feature.
> >=20
> > > Another option might be that the missing chip is the one used for har=
dware
> > > monitoring but its register space is reserved by ACPI. That would exp=
lain
> > > why the chip listed below doesn't report much useful data. Again, the
> > > kernel log should give a hint.
> >=20
> > I don't think this can happen for an SMBus device. If the SMBus
> > controller had an ACPI I/O resource conflict, sensors-detect would not
> > have been able to scan it. And there is no notion of I2C/SMBus resource
> > space in ACPI.
> >=20
> Good point. Maybe the w83793 driver is simply not loaded.
>=20
> Guenter
 		 	   		 =20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
