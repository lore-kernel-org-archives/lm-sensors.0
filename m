From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Nov 2009 20:44:29 +0000
Subject: Re: [lm-sensors] [PATCH v3] k10temp: temperature sensor for AMD
Message-Id: <20091126214429.6ac22d3f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AF91F70.10106@ladisch.de>
	<4B06501B.8080509@ladisch.de>
	<87ws1l5wcl.fsf@depni.sinp.msu.ru>
	<4B0673D7.5010006@ladisch.de>
	<20091120123016.19d98ab4@hyperion.delvare>
	<4B068402.7020606@ladisch.de>
	<20091120131855.7f8f8722@hyperion.delvare>
	<4B0A3DB6.9090703@ladisch.de>
	<20091123145154.5b2b5735@hyperion.delvare>
	<4B0AAA55.3040702@ladisch.de>
	<20091123200527.1114cbc2@hyperion.delvare>
	<4B0B9CB1.3090808@ladisch.de>
	<20091124142654.76f4d166@hyperion.delvare>
	<4B0BE935.1050708@ladisch.de>
	<20091124211134.12971937@hyperion.delvare>
	<4B0CFE2A.6010008@ladisch.de>
In-Reply-To: <4B0CFE2A.6010008@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Serge Belyshev <belyshev@depni.sinp.msu.ru>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Clemens,

On Wed, 25 Nov 2009 10:51:38 +0100, Clemens Ladisch wrote:
> Jean Delvare wrote:
> > On Tue, 24 Nov 2009 15:09:57 +0100, Clemens Ladisch wrote:
> > > This means that one of the already existing limit values must be the
> > > reference base, so we'd need just a mechanism to specify which of them
> > > is it, i.e., "temp1_relative_base: max".  If we'd have
> > > "temp1_relative: 70000", the application would have to search among t=
he
> > > limit values for one with the same value.
> >=20
> > I fail to see why the application would care about this at all. When in
> > relative mode, all other values would be offset by the temp#_relative
> > value. But that value itself would not be displayed (it has no physical
> > value, otherwise we wouldn't be in absolute mode, would we?)
> > ...
> >=20
> > > temp1_relative: true
> >=20
> > This is taking flexibility away from us, for no benefit that I can see.
> > Am I missing something?
>=20
> The application has to display something like "24 =B0C below the limit",
> so how should it know that the 70=B0C should be named "the limit"?

OK, I get your point now. We have to think about how applications will
present the information to the user. Admittedly my proposal doesn't
address this part of the problem.

> To use an example, my CPU has these entries like these:
> temp1_input: 29875
> temp1_max: 70000
> temp1_crit: 95000
> temp1_crit_hyst: 92500
>=20
> How should these entries be displayed?
> (we know that: "40.1 =B0C below limit", "limit", "25 =B0C above limit" et=
c.)
>=20
> But what algorithm should the application (or libsensors) use to create
> those labels?  If we have "temp1_relative: 70000", then this happens to
> be the "max" limit; but what if some CPU vendor decides to define, e.g.,
> the value 0 as the "normal" operating temperatire, so that the entries
> would look like this:
> temp1_input: -1000
> temp1_max: 40000
> temp1_relative: 0
> Should the values be labeled as "1 =B0C below normal" and "40 =B0C above
> normal", and how should the application know that 0 is to be labeled
> "normal"?  It might make more sense to display the temperature just as
> "41 =B0C below max", in which case the actual value of temp1_relative is
> not used at all.

Except that there may be no temp1_max, just a temperature value
relative to the "normal" operating point of the CPU. In that case we
can't fallback to the max limit.

Even your initial proposal doesn't work there yet: the hwmon interface
has no standard name for "normal operating temperature", so we can't put
that name in temp#_relative. And again there's the (potential) case
where we don't know what the reported temperature value is relative to.

I'm wondering if this would make sense to (ab)use the temp#_label
string for that. Or maybe create a new label (temp#_relative_label or
similar) but I'm not sure how we would integrate this into libsensors
and applications. In particular I am worried about translation issues
if we make the drivers too verbose.

> "Relative" means that any value is meaningful only in comparison with
> other values/limits, so it does not make sense to declare one point on
> the scale as base.

The _hardware_ does use one point of the scale as the base, not us. We
have to deal with what the hardware implements. If the base has a
meaning (normal operating temperature, or critical temperature, etc.)
we have to let the user know somehow.

> > Additionally it wouldn't fit in libsensors as it exists today.
>=20
> Then the best bet would probably be an entry like temp#_unit, with
> 0 =3D absolute =B0C (default); 1 =3D relative =B0C or =B0K; other values
> "unknown".  Even if some silly scale is introduced later, applications
> that read this entry then know that they must not display a unit like =B0C
> for unknown unit specifications.

This could work, yes. Note that current drivers and libsensors don't
have/know about this file yet, and they generally use an absolute =B0C
scale. So the absence of temp#_unit file would be interpreted exactly
as if the file was there and contained value 0.

(I'd rather name that file temp#_scale - but that's an implementation
detail.)

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
