From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 17 Dec 2014 18:06:08 +0000
Subject: Re: [lm-sensors] Supermicro X7DBU configuration
Message-Id: <20141217180608.GB29914@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU175-DS1275A243EB8731D1852460E66C0@phx.gbl>
In-Reply-To: <BLU175-DS1275A243EB8731D1852460E66C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Dec 17, 2014 at 12:59:38PM -0500, Sean O'Brien wrote:
> Thanks Guenter. Unfortunately I dont see the adapter in the output. I had=
 to load the i2c-dev driver manually and the output is as follows:
> $ sudo  i2cdetect -li2c-0   i2c             Radeon i2c bit bus DVI_DDC   =
           I2C adapteri2c-1   i2c             Radeon i2c bit bus VGA_DDC   =
           I2C adapteri2c-2   i2c             Radeon i2c bit bus MONID     =
           I2C adapteri2c-3   i2c             Radeon i2c bit bus CRT2_DDC  =
           I2C adapter
>=20
In general, please don't top-post. Also, your output seems to be
messed up. Do you use Outlook ? Just wondering.

Anyway, guess that explains why you don't see the chip ;-).
Wonder why you see it with sensors-detect, though.

Try "sudo modprobe i2c-i801".

Thanks,
Guenter

> > Date: Wed, 17 Dec 2014 09:40:24 -0800
> > From: linux@roeck-us.net
> > To: sean451@hotmail.com
> > CC: jdelvare@suse.de; lm-sensors@lm-sensors.org
> > Subject: Re: [lm-sensors] Supermicro X7DBU configuration
> >=20
> > On Wed, Dec 17, 2014 at 11:54:24AM -0500, Sean O'Brien wrote:
> > > Thanks for the help guys.
> > > The driver is loaded. It is placed into /etc/modules by a run of sens=
or-detect, so it sees it. It shows up in the output of lsmod and a replace =
of the module using modprobe doesn't show any errors when loading it. Howev=
er, as you point out, it doesn't show up in the output of the sensors comma=
nds (after running sensors -s also). Perhaps this is also and issue with th=
e /etc/sensors3.conf files not having the appropriate entries for this boar=
d? The entry in there for this chip is as follows:
> > > chip "w83793-*"
> > >     label in0 "VcoreA"    label in1 "VcoreB"    label in7 "+5V"    la=
bel in8 "5VSB"    label in9 "Vbat"
> > >     set in7_min  5.0 * 0.90    set in7_max  5.0 * 1.10    set in8_min=
  5.0 * 0.90    set in8_max  5.0 * 1.10    set in9_min  3.0 * 0.90    set i=
n9_max  3.0 * 1.10
> > >=20
> >=20
> > The configuration file should not cause the chip to disappear completel=
y.=20
> >=20
> > Can you provide the output of i2cdump for the w83793 ? i2cdetect -l sho=
uld show
> > you which bus it is on after loading the 2ic-dev driver; it is the i801=
 adapter.
> > Command would be "sudo i2cdump <bus> 0x2f".
> >=20
> > > Btw. I found the machine doesn't have the IPMI board fitted, so no go=
 there.
> > > Thanks again.
> > >=20
> > sensors-detect reports the IPMI BMC, though, so I would assume it is th=
ere.
> > Maybe you refer to the ipmi ethernet board ?
> >=20
> > Thanks,
> > Guenter
> >=20
> > > > Date: Wed, 17 Dec 2014 08:27:12 -0800
> > > > From: linux@roeck-us.net
> > > > To: jdelvare@suse.de
> > > > CC: sean451@hotmail.com; lm-sensors@lm-sensors.org
> > > > Subject: Re: [lm-sensors] Supermicro X7DBU configuration
> > > >=20
> > > > On Wed, Dec 17, 2014 at 04:47:58PM +0100, Jean Delvare wrote:
> > > > > Le Wednesday 17 December 2014 =E0 06:43 -0800, Guenter Roeck a =
=E9crit :
> > > > > > On 12/17/2014 02:08 AM, Jean Delvare wrote:
> > > > > > > This chip is missing from the output of "sensors" below. You =
need to
> > > > > > > figure out why. Is the w83793 kernel module available on your=
 system?
> > > > > > > Is it loaded? If not, what happens if you try to load it manu=
ally? Any
> > > > > > > error message in the kernel log? The fans are certainly conne=
cted to
> > > > > > > that chip.
> > > > > >=20
> > > > > > Hardware monitoring might be disabled for this chip. I have see=
n this
> > > > > > with other Supermicro boards; on mine, for example, they use th=
e second
> > > > > > SuperIO chip only for additional serial ports. The kernel log m=
ight
> > > > > > give a hint if that is the case.
> > > > >=20
> > > > > I doubt this is the case here, as the W83793G is a dedicated hard=
ware
> > > > > monitoring chip. There's no point in putting it on the board if t=
hey
> > > > > don't use the feature.
> > > > >=20
> > > > > > Another option might be that the missing chip is the one used f=
or hardware
> > > > > > monitoring but its register space is reserved by ACPI. That wou=
ld explain
> > > > > > why the chip listed below doesn't report much useful data. Agai=
n, the
> > > > > > kernel log should give a hint.
> > > > >=20
> > > > > I don't think this can happen for an SMBus device. If the SMBus
> > > > > controller had an ACPI I/O resource conflict, sensors-detect woul=
d not
> > > > > have been able to scan it. And there is no notion of I2C/SMBus re=
source
> > > > > space in ACPI.
> > > > >=20
> > > > Good point. Maybe the w83793 driver is simply not loaded.
> > > >=20
> > > > Guenter
> > >  		 	   		 =20
>  		 	   		 =20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
