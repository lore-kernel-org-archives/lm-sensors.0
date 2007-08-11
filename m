From: "George Joseph \(dev\)" <gtj.devel@peakin.com>
Date: Sat, 11 Aug 2007 22:19:58 +0000
Subject: Re: [lm-sensors] Andigilog aSC7621 on Intel 975XBX2 - mostly working
Message-Id: <22E26940476D1E48AA6F292B5316C9C3389E@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <92c1df30b17dfff3995ea85f5562ddfc@flothow.de>
In-Reply-To: <92c1df30b17dfff3995ea85f5562ddfc@flothow.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Try ...
http://www.peakin.com/download/asc76xx-2.6.22.2.patch

Does fine with 2.6.21 as well.=20

> -----Original Message-----
> From: lm-sensors-bounces@lm-sensors.org=20
> [mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of=20
> George Joseph (dev)
> Sent: Saturday, August 11, 2007 2:58 PM
> To: Sebastian Flothow; lm-sensors
> Subject: Re: [lm-sensors] Andigilog aSC7621 on Intel 975XBX2=20
> - mostly working
>=20
> Oops...
> Turn off "Hardware monitoring chip debugging messages". =20
> That's what's causing it to not compile and I'll take a look at it.
>=20
> > -----Original Message-----
> > From: lm-sensors-bounces@lm-sensors.org=20
> > [mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of=20
> > George Joseph (dev)
> > Sent: Saturday, August 11, 2007 2:51 PM
> > To: Sebastian Flothow; lm-sensors
> > Subject: Re: [lm-sensors] Andigilog aSC7621 on Intel 975XBX2=20
> > - mostly working
> >=20
> > =20
> >=20
> > > -----Original Message-----
> > > From: lm-sensors-bounces@lm-sensors.org=20
> > > [mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of=20
> > > Sebastian Flothow
> > > Sent: Saturday, August 11, 2007 12:26 PM
> > > To: lm-sensors
> > > Subject: Re: [lm-sensors] Andigilog aSC7621 on Intel 975XBX2=20
> > > - mostly working
> > >=20
> > > Am 7. Aug 2007 um 03:49 Uhr schrieb George Joseph ((dev)):
> > > > Hmmm.  2.6.16 is definitely not going to work but 2.6.21=20
> > > should compile
> > > > fine.  In fact, I just tried it again on a freshly=20
> > untarred 2.6.21.6
> > > > with no errors.  If you tried the older driver, make sure it's
> > > > completely cleaned out. Did the patch apply cleanly?
> > >=20
> > > Yes, I applied it to a freshly untarred 2.6.21.6 as well.=20
> > There were=20
> > > slight offsets, but I think that shouldn't matter:
> > >=20
> > > |=A0magrathea linux-2.6.21.6 # patch -p1 < ../asc76xx-2.6.21.patch
> > > | patching file Documentation/hwmon/asc76xx
> > > | patching file drivers/hwmon/asc76xx.c
> > > | patching file drivers/hwmon/Kconfig
> > > | Hunk #1 succeeded at 153 (offset 11 lines).
> > > | patching file drivers/hwmon/Makefile
> > > | Hunk #1 succeeded at 21 (offset 1 line).
> > >=20
> > > However, I just found that it seems to be caused by my=20
> > config - if I=20
> > > use the default config (except for enabling asc76xx, of=20
> course), it=20
> > > compiles fine, yet if I use my usual .config I get the error:
> > >=20
> > > |   CC [M]  drivers/hwmon/asc76xx.o
> > > | drivers/hwmon/asc76xx.c: In function 'asc76xx_detect':
> > > | drivers/hwmon/asc76xx.c:1077: error: 'struct=20
> asc76xx_chip' has no=20
> > > member named 'smb_addr'
> > > | make[2]: *** [drivers/hwmon/asc76xx.o] Error 1
> > > | make[1]: *** [drivers/hwmon] Error 2
> > > | make: *** [drivers] Error 2
> > >=20
> > > This is lines 54 through 64 of drivers/hwmon/asc76xx.c:
> > >=20
> > > | struct asc76xx_chip {
> > > |     char *name;
> > > |     enum chips chip_type;
> > > |     u8 chip_mask;
> > > |     u8 company_reg;
> > > |     u8 company_id;
> > > |     u8 verstep_reg;
> > > |     u8 verstep_id;
> > > |     void (*setup) (struct i2c_client * client);
> > > |     u8 addresses[4];
> > > | };
> > >=20
> > > No smb_addr there indeed, so it seems one of my config=20
> > options breaks=20
> > > your driver. Any idea what I should look for?
> >=20
> > Just send me your config and I'll take a look.  Either that=20
> > or just start turning off things in your config until it works.
> >=20
> > >=20
> > >=20
> > > > I've got some info on C1E and EIST on the XBX2 specifically at
> > > > http://www.peakin.com/xbx2/index.html
> > >=20
> > > Thanks, useful page. There's just one thing which seems=20
> > > unclear to me:=20
> > > is Tjmax equal to Tcontrol, or is it even higher (kind of a hard=20
> > > limit)?
> > >=20
> >=20
> > I'm not sure that it's clear to anyone. :) =20
> > Intel's documentation is not clear and conflicts itself and=20
> > comments made by Intel employees. =20
> >=20
> > >=20
> > > _______________________________________________
> > > lm-sensors mailing list
> > > lm-sensors@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> > >=20
> >=20
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >=20
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
