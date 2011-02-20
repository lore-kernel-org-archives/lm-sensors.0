From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Feb 2011 19:26:26 +0000
Subject: Re: [lm-sensors] [PATCH 0/4] Move lis3lv02d and hp_accel out of
Message-Id: <20110220202626.04851af6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219141219.47aba4f8@endymion.delvare>
In-Reply-To: <20110219141219.47aba4f8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi =C9ric,

On Sun, 20 Feb 2011 19:16:24 +0100, =C9ric Piel wrote:
> Op 19-02-11 14:12, Jean Delvare schreef:
> > Hi all,
> >
> > Here is a patch set moving lis3lv02d and hp_accel out of drivers/hwmon.
> > hp_accel goes where it belongs, i.e. drivers/platform/x86 (next to
> > hdaps.) For lis3lv02d, I would have preferred a more specific home, but
> > none seems to be suitable at the moment, so I went for drivers/misc. We
> > might revisit this later.
> >
> > [PATCH 1/4] Let Kconfig handle lis3lv02d dependencies
> > [PATCH 2/4] Move hp_accel to drivers/platform/x86
> > [PATCH 3/4] Move lis3lv02d drivers to drivers/misc
> > [PATCH 4/4] hp_accel: Fix driver name
> >
> > As with every patch moving files around, the patches look very large
> > but most of them can be ignored, all you really have to look at are the
> > Kconfig and Makefile changes.
> >
> > Note that I don't have supported hardware so I wasn't able to test the
> > patches. So I would welcome testing as much as review.
> >
> Hello,
> I'm completely fine with the move (it was in hwmon only because in the=20
> first place there were other accelerometers there). So here is my:
> Acked-by: =C9ric Piel <eric.piel@tremplin-utc.net>
>=20
> I'll try to test the changes tomorrow (on an HP notebook), to confirm.

Thanks.

> BTW, why do hp_accel has to be in a different directory than the rest?=20
> To me it's just a different interface to the chip: ACPI/HP, instead of=20
> SPI or I=B2C.

The difference is that the interface is platform-specific, contrary to
the SPI and I2C interfaces which are platform-neutral.
Platform-specific drivers are supposed to go to drivers/platform, or at
least this is my understanding. Plus, hp_accel isn't only an interface
to the accelerometer chip, it also links with a led. Having hp_accel
next to hdaps does make sense, don't you think?

That being said, I don't have a strong opinion on this, and it will
have to be revisited the day all accelerometer drivers gain a dedicated
home anyway. If anyone disagree with my decision and has a motivated
suggestion for something better, please speak up.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
