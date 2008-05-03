From: achim <achim@ag-web.biz>
Date: Sat, 03 May 2008 18:11:33 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <1209838293.3326.15.camel@debian-9850.ag-home.muc>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Am Samstag, den 03.05.2008, 18:27 +0200 schrieb Jean Delvare:
> On Sat, 03 May 2008 17:27:34 +0200, achim wrote:
> > Hi Jean and Pavel,
> >=20
> > Thank you for the fast replies.
> >=20
> > I run debian lenny 64bit which comes with sensors version 3.0.1. The
> > debian package version is 3.0.1-5.
>=20
> OK, so you have an up-to-date version of sensors-detect which only
> probes the I2C addresses it has to.
>=20
> > The board has no special overclocking chip.
>=20
> How do you know? If probing the SMBus did something bad to your
> hardware, then there has to be some special chip on the SMBus.
>=20
You are right i can not sort that out just by looking at the bios
options.

> Of course, it can also be that your hardware just happened to die when
> you ran sensors-detect but it was only a coincidence. To say the truth,
> I'd be very happy if that was the case.

> I take it that you had already tried higher overclocking settings on
> your CPU. Honestly, I can't say I am surprised when hardware dies after
> being overclocked. That's a risk you take when overclocking.
>=20
To sort out overclocking issues i mounted an X25000BE and ran
sensors-detect.
Again the system froze at=20

Next adapter PIIX4 at 0b00

Fortunately the X2 cpu is still working.

For the record with the 9600BE the i2c_piix4 and the it87 modules work
without issues (some sensor readings are labled wrong, but that's an
other story whom i can fix by editin sensors.conf i guess).

I read the bugreport and ran=20

i2cdetect -l and i2cdetec 0

Both runs did not freeze the system.

---------------------------- Output ---------------------------------
debian-9850:/home/achim# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]=20
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --=20
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e --=20
30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- --=20
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 4e --=20
50: -- -- 52 53 -- -- -- 57 -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 6e --=20
70: 70 -- -- -- -- -- -- --                        =20
debian-9850:/home/achim# i2cdetect -l
i2c-0	smbus     	SMBus PIIX4 adapter at 0b00     	SMBus adapter
=EF=BB=BF---------------------------- Output ------------------------------=
---

I'll try i2cdump 0 0x2e now and will also try the other adresses to
track down the problem.=20

> Please contact them. If nothing else, they should be aware that they
> (presumably) use a chip which causes trouble. If users report about the
> problem, maybe they can find a better chip / safer design in their next
> products.

The board is the same as the DFI one just rebranded, DFI is aware of
those issues. But I'll inform the Sapphire support as well.
>=20

> I guess it's a typo and you mean IT8716F-S.
Yepp, typo
>=20
> > load it manual. I'd like to look a little deeper into that sensor chip
> > reading issues so i'll start to read the source code now to find out
> > what happens. I attached the dmidecode and the lspci -nnv output.
> >=20
> > ---------- kenrel log output of the it87 module ----------------
> > it87: Found IT8716F chip at 0x228, revision 3
> > it87: in3 is VCC (+5V)
> > it87: in7 is VCCH (+5V Stand-By)
> > hwmon-vid: Unknown VRM version of your x86 CPU
> > ----------------------------------------------------------------
>=20
> What's wrong with the it87 driver?

Nothing I was just unsure what module caused the freeze.

>=20
> The good news is that the motherboard DMI data is present:
>=20
> Base Board Information
> 	Manufacturer: SAPPHIRE Inc.
> 	Product Name: PC-AM2RD790
>=20
> So we can blacklist it from i2c-piix4. I'll prepare a patch later today.
>=20
Thank you, I think that info changes if I use an DFI bios. Looks like
the info is the same which CPU-Z shows on the motherboard page I might
have an screenshot with the DFI info here also.

PS: Sorry for the double posts i'm to fast with the reply button here.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
