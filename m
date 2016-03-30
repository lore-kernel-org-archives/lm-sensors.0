From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Mar 2016 20:59:58 +0000
Subject: Re: [lm-sensors] ncpXXxh103 compensation values?
Message-Id: <20160330205958.GA21993@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <56FBDCBD.7080802@gmail.com>
 <CAP-bB-XEktLRGxtXY_fBUkMG96Hm1g7MhKG-tR1OUQhWjA151w@mail.gmail.com>
 <56FBF7B1.1030407@gmail.com>
In-Reply-To: <56FBF7B1.1030407@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Maxime Jayat <jayatmaxime@gmail.com>
Cc: Joseph McNally <jmcna06@gmail.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, Mar 30, 2016 at 05:58:41PM +0200, Maxime Jayat wrote:
> I don't think it is wrong to use ncpXXxh103 instead of ncp15xh103,
> because the first number refers to the physical size of the thermistor
> and should not change its behavior. In fact the datasheet does the same
> kind of grouping.
>=20
> I was just wondering what was the reason for the discrepancy between the
> datasheet and your values.
> Indeed the datasheet I linked earlier, at page 15, gives you verbatim
> the content of this array and the result of your calculation does not
> match it.
> It is not _absurdly_ wrong but, at first sight, it seems like there is a
> 10 degrees difference at the extremes (but 10 kOhm at 25 C is correct).
>=20

Can the two of you sort this out and send me a fixup patch if necessary ?

Thanks,
Guenter

p.s.: Please don't top-post.

> Le 30/03/2016 17:09, Joseph McNally a =E9crit :
> > Hello Maxime,
> >=20
> > This data was calculated for a Murata NCP15XH103XXXXX.
> >=20
> > You have illustrated something to me with your question though. When I
> > uploaded this patch, I was following the format of the compensation
> > tables that are already present in the file. So i used "ncpXXxh103"
> > instead of "ncp15xh103". Also, it was my first patch submitted to the
> > Linux kernel. So I may have been over thinking some things! With some
> > hindsight, I see that the name is misleading. I'm going to have to
> > revisit this patch to make it more 'generic' for other thermistors, or
> > make it more specific for this particular thermistor.
> >=20
> > I hope that answers your questions. Thanks for pointing this out to me.
> >=20
> > Regards,
> > Joseph
> >=20
> > On Wed, Mar 30, 2016 at 3:03 PM, Maxime Jayat <jayatmaxime@gmail.com
> > <mailto:jayatmaxime@gmail.com>> wrote:
> >=20
> >     Hello Joseph,
> >=20
> >     You recently added support for the ncpXXxh103 in
> >     drivers/hwmon/ntc_thermistor.c with the following array of values:
> >=20
> >     +static const struct ntc_compensation ncpXXxh103[] =3D {
> >     +       { .temp_c       =3D -40, .ohm     =3D 247565 },
> >     +       { .temp_c       =3D -35, .ohm     =3D 181742 },
> >     +       { .temp_c       =3D -30, .ohm     =3D 135128 },
> >     +       { .temp_c       =3D -25, .ohm     =3D 101678 },
> >     +       { .temp_c       =3D -20, .ohm     =3D 77373 },
> >     +       { .temp_c       =3D -15, .ohm     =3D 59504 },
> >     +       { .temp_c       =3D -10, .ohm     =3D 46222 },
> >     +       { .temp_c       =3D -5, .ohm      =3D 36244 },
> >     +       { .temp_c       =3D 0, .ohm       =3D 28674 },
> >     +       { .temp_c       =3D 5, .ohm       =3D 22878 },
> >     +       { .temp_c       =3D 10, .ohm      =3D 18399 },
> >     +       { .temp_c       =3D 15, .ohm      =3D 14910 },
> >     +       { .temp_c       =3D 20, .ohm      =3D 12169 },
> >     +       { .temp_c       =3D 25, .ohm      =3D 10000 },
> >     +       { .temp_c       =3D 30, .ohm      =3D 8271 },
> >     +       { .temp_c       =3D 35, .ohm      =3D 6883 },
> >     +       { .temp_c       =3D 40, .ohm      =3D 5762 },
> >     +       { .temp_c       =3D 45, .ohm      =3D 4851 },
> >     +       { .temp_c       =3D 50, .ohm      =3D 4105 },
> >     +       { .temp_c       =3D 55, .ohm      =3D 3492 },
> >     +       { .temp_c       =3D 60, .ohm      =3D 2985 },
> >     +       { .temp_c       =3D 65, .ohm      =3D 2563 },
> >     +       { .temp_c       =3D 70, .ohm      =3D 2211 },
> >     +       { .temp_c       =3D 75, .ohm      =3D 1915 },
> >     +       { .temp_c       =3D 80, .ohm      =3D 1666 },
> >     +       { .temp_c       =3D 85, .ohm      =3D 1454 },
> >     +       { .temp_c       =3D 90, .ohm      =3D 1275 },
> >     +       { .temp_c       =3D 95, .ohm      =3D 1121 },
> >     +       { .temp_c       =3D 100, .ohm     =3D 990 },
> >     +       { .temp_c       =3D 105, .ohm     =3D 876 },
> >     +       { .temp_c       =3D 110, .ohm     =3D 779 },
> >     +       { .temp_c       =3D 115, .ohm     =3D 694 },
> >     +       { .temp_c       =3D 120, .ohm     =3D 620 },
> >     +       { .temp_c       =3D 125, .ohm     =3D 556 },
> >     +};
> >     +
> >=20
> >     Where are these taken from?
> >     Unlike the other thermistors in the file, these values don't seem to
> >     match anything in the Murata NTC Thermistor Datasheet.
> >     See:
> >     http://www.murata.com/~/media/webrenewal/support/library/catalog/pr=
oducts/thermistor/ntc/r44e.ashx
> >=20
> >     --
> >     Maxime Jayat
> >=20
> >=20
> --=20
> Maxime Jayat

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
