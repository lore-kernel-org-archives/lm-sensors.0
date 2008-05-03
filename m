From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 May 2008 19:14:48 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080503211448.32535833@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 03 May 2008 20:10:23 +0200, achim wrote:
> Am Samstag, den 03.05.2008, 18:27 +0200 schrieb Jean Delvare: =20
> > I take it that you had already tried higher overclocking settings on
> > your CPU. Honestly, I can't say I am surprised when hardware dies after
> > being overclocked. That's a risk you take when overclocking. =20
>
> To sort out overclocking issues i mounted an X25000BE and ran
> sensors-detect.
> Again the system froze at=20
>=20
> Next adapter PIIX4 at 0b00
>=20
> Fortunately the X2 cpu is still working. =20

I don't think that this rules out overclocking. The overclocked CPU
died, the non-overclocked one froze but is still alive. If nothing
else, it suggests that the overclocked CPU was more fragile against
whatever happened.

> For the record with the 9600BE the i2c_piix4 and the it87 modules work
> without issues (some sensor readings are labled wrong, but that's an
> other story whom i can fix by editin sensors.conf i guess). =20

Note that the i2c-piix4 driver doesn't do anything by itself.

>=20
> I read the bugreport and ran=20
>=20
> i2cdetect -l and i2cdetec 0
>=20
> Both runs did not freeze the system.
>=20
> ---------------------------- Output ---------------------------------
> debian-9850:/home/achim# i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]=20
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --=20
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e --=20
> 30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- --=20
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 4e --=20
> 50: -- -- 52 53 -- -- -- 57 -- -- -- -- -- -- -- --=20
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 6e --=20
> 70: 70 -- -- -- -- -- -- --                        =20
> debian-9850:/home/achim# i2cdetect -l
> i2c-0	smbus     	SMBus PIIX4 adapter at 0b00     	SMBus adapter
> =EF=BB=BF---------------------------- Output ----------------------------=
----- =20

Looks a lot like that older bug report I mentioned where probing
address 0x2e rebooted the machine. Probably designed by the same
person, using the same or similar chip.

>=20
> I'll try i2cdump 0 0x2e now and will also try the other adresses to
> track down the problem.  =20

I expect i2cdump 0 0x2e will freeze your system if not worse. Most
likely, sensors-detect would complete if you skipped address 0x2e on
SMBus probe. At least that was the case for the other bug report.

> > The good news is that the motherboard DMI data is present:
> >=20
> > Base Board Information
> > 	Manufacturer: SAPPHIRE Inc.
> > 	Product Name: PC-AM2RD790
> >=20
> > So we can blacklist it from i2c-piix4. I'll prepare a patch later today=
.. =20
>
> Thank you, I think that info changes if I use an DFI bios. Looks like
> the info is the same which CPU-Z shows on the motherboard page I might
> have an screenshot with the DFI info here also. =20

In general, people using a BIOS which was not meant for their
motherboard should know that they are doing something wrong and should
be ready to face the consequences. That being said, it would be easy
enough to blacklist this other motherboard as well, presumably it has
the same problems. Can you provide the dmidecode information for the
DFI board / BIOS?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
