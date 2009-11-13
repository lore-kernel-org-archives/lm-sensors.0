From: Forest Bond <forest@alittletooquiet.net>
Date: Fri, 13 Nov 2009 02:44:34 +0000
Subject: Re: [lm-sensors] Combined C7 temp driver
Message-Id: <20091113024434.GA2711@alittletooquiet.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7163977594970906861=="
List-Id: <lm-sensors.vger.kernel.org>
References: <200908221933.14582.justin@justinzane.com>
In-Reply-To: <200908221933.14582.justin@justinzane.com>
To: lm-sensors@vger.kernel.org


--===============7163977594970906861==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Just checking in -- has this gone anywhere?

Thanks,
Forest

On Wed, Sep 02, 2009 at 07:30:36AM -0700, Juerg Haefliger wrote:
> Hi Justin,
>=20
> Thanks for doing this. Would you mind creating a patch and sending it
> to the list so that it can be properly reviewed?
>=20
> Thanks
> ...juerg
>=20
>=20
> On Sat, Aug 22, 2009 at 7:33 PM, Justin Chudgar<justin@justinzane.com> wr=
ote:
> > So, I have combined the working elements of both Juerg's and Harald's
> > drivers into one. I decided to keep the name c7temp since sensors-detect
> > already recognizes this.
> >
> > The combined source file is attached as c7temp.c
> >
> > Thanks to Juerg and Harald and everyone else.
> > --
> >
> > Justin Chudgar
> > Information Technology Consultant
> > 5040 Saddlehorn Rd, Weed, CA 96084
> > 530-938-9692 (Home Office)
> >
> > On Saturday 22 August 2009 02:16:16 am you wrote:
> >> Dear Justin,
> >>
> >> Harald had a updated version of via_cputemp,
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
> >> index 1032355..2abe516 100644
> >> --- a/drivers/hwmon/via-cputemp.c
> >> +++ b/drivers/hwmon/via-cputemp.c
> >> @@ -37,7 +37,7 @@
> >> #include <asm/msr.h>
> >> #include <asm/processor.h>
> >>
> >> -#define DRVNAME "via-cputemp"
> >> +#define DRVNAME "via_cputemp"
> >>
> >> typedef enum { SHOW_TEMP, SHOW_LABEL, SHOW_NAME } SHOW;
> >>
> >> @@ -81,7 +81,7 @@ static ssize_t show_temp(struct device *dev,
> >> if (err)
> >> return -EAGAIN;
> >>
> >> - err =3D sprintf(buf, "%d\n", eax & 0xffffff);
> >> + err =3D sprintf(buf, "%d\n", (eax & 0xffffff) * 1000);
> >>
> >> return err;
> >> }
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Had you try it?
> >> Just a remind.
> >>
> >> 2009/8/22 Justin Chudgar <justin@justinzane.com>:
> >> > I've been messing (clumsily, since I am learning C while doing this.=
=2E.
> >> > please be patient with me :) with Harald's via_cputemp.ko driver and
> >> > have
> >> > noticed that while I do not get readings using his driver as is, some
> >> > printk's added into his code show that there is a reading being
> >> > obtained.
> >> >
> >> > Here is some sample output:
> >> > acpitz-virtual-0
> >> > Adapter: Virtual device
> >> > temp1: +57.0=B0C (crit =3D +105.0=B0C)
> >> >
> >> > c7temp-isa-0000
> >> > Adapter: ISA adapter
> >> > in0: +0.84 V
> >> > temp1: +0.0=B0C
> >> >
> >> > via_cputemp-isa-0000
> >> > Adapter: ISA adapter
> >> > Core 0: +0.1=B0C
> >> >
> >> > root@justin-mininote:/lib/modules/2.6.31-rc6justin/kernel/drivers/hw=
mon#
> >> > dmesg | tail
> >> > [28068.954298] TEMP: 53
> >> > [28075.767438] show_temp: 3
> >> > [28075.767451] CPU: 0, MSR: 1169, eax: 35, edx: 0, err: 3
> >> > [28075.767459] TEMP: 53
> >> > [28096.575734] show_temp: 3
> >> > [28096.575746] CPU: 0, MSR: 1169, eax: 37, edx: 0, err: 3
> >> > [28096.575753] TEMP: 55
> >> > [28156.787908] show_temp: 3
> >> > [28156.787920] CPU: 0, MSR: 1169, eax: 38, edx: 0, err: 3
> >> > [28156.787928] TEMP: 56
> >> >
> >> > As you can see, the dmesg log shows a CPU temp that tracks with but =
does
> >> > not exactly duplicate the ACPI temp. To me, this means that I am
> >> > probably
> >> > getting good data.
> >> >
> >> > The function in question is show_temp on lines 69-86 in the attached
> >> > code. If someone can help me understand how the string buffer 'buf' =
with
> >> > the temperature reading is supposed to be passed on to userland code,
> >> > I'd
> >> > appreciate it.
> >> >
> >> > Once again, please be patient as I am NOT a programmer, just a guy w=
ith
> >> > a
> >> > C7 cpu who want to get lm-sensors working.
> >> >
> >> > Thanks.
> >> >
> >> >
> >> > _______________________________________________
> >> > lm-sensors mailing list
> >> > lm-sensors@lm-sensors.org
> >> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFK/MgSRO4fQQdv5AwRAmkkAJ9ng/UzECxHa415X4Au8dFSvTQbNQCePpBF
dpRrdLnZs5zyP+XHvGoaQA4=
=aAhI
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--


--===============7163977594970906861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7163977594970906861==--
