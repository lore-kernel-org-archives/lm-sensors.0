From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Nov 2013 19:41:01 +0000
Subject: Re: [lm-sensors] Ticket #2382
Message-Id: <20131119204101.15b7ea4d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <528A62DC.9030107@baymicrosystems.com>
In-Reply-To: <528A62DC.9030107@baymicrosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 19 Nov 2013 09:53:51 -0800, Guenter Roeck wrote:
> On Tue, Nov 19, 2013 at 06:18:57PM +0100, Jean Delvare wrote:
> > Hi Guenter, Mike,
> >=20
> > On Tue, 19 Nov 2013 08:38:40 -0800, Guenter Roeck wrote:
> > > On Tue, Nov 19, 2013 at 10:04:08AM -0500, Mike Gilbert wrote:
> > > >=20
> > > > Guenter,
> > > >=20
> > > > We're evaluating the new card in a open chassis. It is on the test
> > > > bench with a table fan for cooling. I turned off the fan and got:
> > > >=20
> > > >     ENTER show_temp
> > > >     cpu 0 (0)
> > > >     status_reg @ 19C
> > > >     eax =3D 885E0000 edx =3D 0
> > > >     temp =3D 1770 valid =3D 1
> > > >     EXIT show_temp
> > > >=20
> > > > It seems like you've seen this before. What's going on?
> > >=20
> > > No, I was just throwing darts at a wall with my eyes closed.
> >=20
> > Oh, you thought that was a wall? :D
> >=20
> > > Seriously, it was just a wild guess. Idea was that the valid bit may =
be 0
> > > if the temperature is too low to be even remotely close to the maximu=
m.
> >=20
> > That was my theory in ticket #2382, indeed. It was never tested until
> > today I think, thanks Mike for doing that.
> >=20
> > > For this chip, just to give you an example, the datasheet says that a=
ny
> > > reported temperature below 50 degrees C only means that the temperatu=
re
> > > is below 50 degrees C.
> >=20
> > That's a start... I didn't know it was documented. Is it documented for
> > all CPU models? If we can gather the values at least for all affected
>=20
> Uuh ... I didn't say it was documented. If it is, I don't know about it.
> As I said, it was just a wild guess.... even without reading your comment
> on the ticket.

I must have misread you. What where you talking about when you said
"For this chip, just to give you an example, the datasheet says that
any reported temperature below 50 degrees C only means that the
temperature is below 50 degrees C"?

> > Atom CPU models (as I suppose the value will vary per model) we could
> > tweak something in the driver.
> >=20
> > > Jean, any idea what we can do about this ? Report X degrees C (some c=
onstant
> > > below TjMax) if valid is 0 ?
> >=20
> > Well well, we don't really have a sane way to transmit the information
> > ("temperature is below X") down to the monitoring applications. The
> > sysfs interface has no provision for it, libsensors wouldn't handle it
> > and "sensors" wouldn't either, of course.
> >=20
> > We could hard-code an arbitrarily low temperature as you suggest,
> > however I'm not sure if we want to do it for all CPU models or only the
> > ones listed in ticket #2382. My concern is that the Intel specification
> > doesn't limit "valid =3D 0" to too low temperature values. They don't
> > give any detail, so assuming that "too low" is the only reason seems
> > weird. I remember we saw transient errors on coretemp readings in the
> > past, but I can't remember if that was on these Atom models (i.e. just
> > another incarnation of ticket #2382) or other CPU models. I'm afraid we
> > may start reporting temperature values instead of actual errors if the
> > fix-up is too broad.
> >=20
> > Either way, the current situation is rather bad, as "N/A" looks more
> > like "it's broken" than "it's cold". So I have no objection to crafting
> > "something" into the driver to make it look better, if you are
> > motivated to give it a try.
> >=20
> > If you are even more motivated and want to extend the sysfs to properly
> > report the situation to user-space, feel free to do that as well. I
> > volunteer to review any kernel patch related to this, and to write the
> > user-space code to deal with it. I'm just not sure it's worth the
> > effort for just 3 CPU models.
>=20
> I'd rather go with an exception table, or rather extend the existing tabl=
es.
> It is probably somewhat safe to assume that the problem applies to all CP=
Us
> with the same model/mask. Based on that we could declare a "tjmin" and
> report that if it is 1) defined and 2) the valid bit is 0. A somewhat "sa=
fe"
> temperature to report for the D5xx (model 0x1c/mask 10), based on Mike's
> numbers, would then be 36 degrees C (100 - 64).

Not sure where you drew the "36" from. From Mike's table it seems the
valid flag wears off when the reported temperature would be < 6=B0C. This
correlates with my findings in the ticket where the valid flag would be
0 for 1=B0C and 4=B0C.

> If you are ok with that I'll submit a patch for it.

Yes I am.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
