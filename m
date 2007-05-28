From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 May 2007 15:05:28 +0000
Subject: Re: [lm-sensors] dynamic chip support in libsensors + generic chip
Message-Id: <20070528170528.111841a8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461A59D4.2050409@hhs.nl>
In-Reply-To: <461A59D4.2050409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 25 May 2007 22:10:20 +0200, Hans de Goede wrote:
> I've reviewed your patch here are some notes:
>=20
>=20
> > Index: prog/sensors/chips_generic.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> > --- prog/sensors/chips_generic.c	(r=E9vis=
ion 4405)
> > +++ prog/sensors/chips_generic.c	(copie de travail)
>=20
> you add a SENSORS_FEATURE_TEMP_MIN_HYST sensor type, but do not check / d=
o=20
> anything with it in print_generic_chip_temp()


Good point. I though we had temp[1-*]_min_hyst defined in our standard
sysfs interface, but in fact we don't. So SENSORS_FEATURE_TEMP_MIN_HYST
isn't needed.

> > @@ -208,24 +197,27 @@
> >    if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_FAULT) &&
> >        TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_FAULT) > 0.5) {
> >      printf(" FAULT");
> > -  } else if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_ALARM) &&=20
> > -      TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_ALARM) > 0.5) {
> > +  } else
> > +  if ((TEMP_FEATURE(SENSORS_FEATURE_TEMP_ALARM) &&=20
> > +       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_ALARM) > 0.5)
> > +   || (type =3D MINMAX &&
> > +       TEMP_FEATURE(SENSORS_FEATURE_TEMP_MIN_ALARM) &&=20
> > +       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_MIN_ALARM) > 0.5)
> > +   || (type =3D MINMAX &&
> > +       TEMP_FEATURE(SENSORS_FEATURE_TEMP_MAX_ALARM) &&=20
> > +       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_MAX_ALARM) > 0.5)) {
> >      printf(" ALARM");
> >    }
> >    printf("\n");
> >   =20
>=20
> -Is the type =3D MINMAX check for printing the alarms necessary, doesn't =
this=20
> has the risk of not showing an alarm for some chip with a funky combinati=
on of=20
> temp sysfs entries?

This will need to be double-checked. Removing the check altogether has
the risk of printing alarms where they do not belong, which isn't
better. Temperatures are a bit tricky because we may have up to 5 limit
values to display and we only have 2 slots on the first line. So some
of the limits may move to a second line. And I think we want to display
the ALARM flag on the right line in this case. Or maybe you think the
ALARM flag should always be on the first line even if it corresponds to
a limit which is on the second line?

> -Shouldn't the code somehow show the difference between a min and a max (=
and a=20
> generic) alarm? See how print_generic_chip_in() does this

Yes I know the voltage code does this, but the temperature code is much
more complex at the moment. I have no objection if you want to add this
feature, but let's first cleanup the code.

I see we have SENSORS_FEATURE_TEMP_OVER, SENSORS_FEATURE_TEMP_LOW and
SENSORS_FEATURE_TEMP_HIGH defined. What are these? We don't have names
for these in our standard sysfs interface, and they seem completely
redundant with SENSORS_FEATURE_TEMP_MAX and SENSORS_FEATURE_TEMP_MIN.
Did your students get confused by the non-standard names in the 2.4
driver somehow? It looks to me like we could plain delete these three
symbols.

> Some generic notes not directly related to your patch:
>=20
> This piece of code in print_generic_chip_temp() can be done much simpler:
>=20
>    if (type =3D LIM) {
>    } else {
>      print_temp_info_real(val, max, min, 0.0, type, 1, 1);
>    }
>=20
> Since lim always is 0.0 (this initalized to this) in the non LIM case, th=
is can=20
> be written as just:
>    print_temp_info_real(val, max, min, lim, type, 1, 1);
>=20
> Will you change this or shall I?

I would first need to be explained what this "LIM" thing is. It
doesn't correspond to anything in our standard sysfs interface as far
as I can see, and no legacy chip code was using it. I would get rid of
it.

> More in general print_generic_chip_temp(), needs a good review by someone=
 who=20
> is well aware of all possible tempX sysfs entry combo's (iow not by me).

We agree ;) see my comments above. If we get rid of the 4 unneeded
limits as I am suggesting, I'm certain things will be a lot easier. Of
course, even then, there are some decisions to make because we can have
many different combinations of temperature limits depending on the
chip, and we want to present them in the way that makes the more sense
each time. I will look into this after the cleanups are done.

> Also print_generic_chip_in(), has some dangerous and unneeded assumptions=
, for=20
> example:
> -it assumes that if there is a inX_max that there will also always be a i=
nX_min
> -it assumes that if there is no inX_max there will also be no alarms
>=20
> Shall I fix these or will you?

The code shouldn't assume anything like that. Please fix.

> Somewhat less "unneeded" assumption
> -it doesn't check for inX_max_alarm without an inX_min_alarm and visa ver=
sa, I
>   admit this would be a driver bug, as then the driver should have just a
>   inX_alarm, but still we might want to concider this.

Your own assumption is wrong. A chip could have a voltage input with a
min limit and a max limit, and an alarm which is only raised by the max
limit. In this case, the driver would indeed have inX_max_alarm and not
inX_min_alarm. Not to say that this particular hardware design would be
smart, but if it existed, that's what how our driver would support it.
And we've seen such weird hardware designs already... So you could fix
this too.

> Well thats about it. About all the "Shall I fix these or will you?", that=
 is=20
> not me being lazing, but rather me trying to avoid commit conflicts. Its =
fine=20
> if you want me to take care of them, but then I guess I should wait until=
 your=20
> patch is in svn.

I've committed my pending patches now, so if you could now fix the
problems you've seen, this would be welcome.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
