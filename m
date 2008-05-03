From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 May 2008 19:27:12 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080503212712.23dcc451@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 3 May 2008 21:14:48 +0200, Jean Delvare wrote:
> On Sat, 03 May 2008 20:10:23 +0200, achim wrote:
> > ---------------------------- Output ---------------------------------
> > debian-9850:/home/achim# i2cdetect 0
> > WARNING! This program can confuse your I2C bus, cause data loss and
> > worse!
> > I will probe file /dev/i2c-0.
> > I will probe address range 0x03-0x77.
> > Continue? [Y/n]=20
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00:          -- -- -- -- -- -- -- -- -- -- -- -- --=20
> > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
> > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e --=20
> > 30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- --=20
> > 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 4e --=20
> > 50: -- -- 52 53 -- -- -- 57 -- -- -- -- -- -- -- --=20
> > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 6e --=20
> > 70: 70 -- -- -- -- -- -- --                        =20
> > debian-9850:/home/achim# i2cdetect -l
> > i2c-0	smbus     	SMBus PIIX4 adapter at 0b00     	SMBus adapter
> > =EF=BB=BF---------------------------- Output --------------------------=
------- =20
>=20
> Looks a lot like that older bug report I mentioned where probing
> address 0x2e rebooted the machine. Probably designed by the same
> person, using the same or similar chip.
>=20
> >=20
> > I'll try i2cdump 0 0x2e now and will also try the other adresses to
> > track down the problem.  =20
>=20
> I expect i2cdump 0 0x2e will freeze your system if not worse. Most
> likely, sensors-detect would complete if you skipped address 0x2e on
> SMBus probe. At least that was the case for the other bug report.

In fact I would be more interested in a dump of 0x4e. The other report
had a chip there too, I wonder if it could be the same chip as the one
at 0x2e (and maybe 0x6e? The other report didn't have that.) If we
could identify the device by reading from 0x4e, we could skip the probe
of 0x2e and that would hopefully solve the problem. But this will be
very difficult to identify the device as long as we don't know what
device it is. That's where the help of DFI or Sapphire would be
valuable.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
