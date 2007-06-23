From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Jun 2007 16:03:23 +0000
Subject: Re: [lm-sensors] question about dyn chip support generic temp print
Message-Id: <20070623180323.6552c338@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46767C9D.8040006@hhs.nl>
In-Reply-To: <46767C9D.8040006@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 18 Jun 2007 08:52:12 -0700, Juerg Haefliger wrote:
> On 6/18/07, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> > As said already I'm working on the fintek 71882 driver, I've currently =
given it
> > a tempX_input tempX_max tempX_max_hyst and a tempX_crit, with the curre=
nt dyn
> > chip + generic print support this results in:
> > CPU:            +38.0=B0C  (high =3D +80.0=B0C, hyst =3D  +4.0=B0C)  se=
nsor =3D transistor
> > temp1_crit:     +81.0=B0C
> >
> > This is because currently for max + hyst chips the first line gets prin=
ted, and
> > then for chips which have a crit to a sensors_get_label_and_valid is do=
ne on
> > the sensors_feature_data describing tempX_crit. Wouldn't it be better t=
o reuse
> > the main temp label and value, resulting in:
> > CPU:            +38.0=B0C  (high =3D +80.0=B0C, hyst =3D  +4.0=B0C)  se=
nsor =3D transistor
> > CPU:            +38.0=B0C  (crit =3D +81.0=B0C)
> >
> > Maybe change the label into all whitespace / "CPU (continued)"? The cur=
rent
> > printout seems very wrong, but my suggested one doesn't feel right eith=
er.
>=20
> Hmm... Neither looks right to me. I can see user comments/bug reports
> flying in...

At least the current way has been in use for years now. "sensors"
prints something like that for the LM90/ADM1032 PC87366 chips already,
and I don't remember anybody complaining. OTOH, printing the same value
twice seems pretty wrong. So while I agree none of these methods are
ideal, the latter seems even worse to me.

> Isn't there a way to make the print routine collect all the data and
> print in on a single line?

We could do that, the problem is that the list can get quite long.
There can be up to 5 limits for each temperature input: min, max,
max_hyst, crit and crit_hyst. A chip like the ADM1032 has all of them!

I think that the idea with multiple lines was to make the output fit in
80 columns. If we want to stick to that, this means a maximum of two
limits per line. So we could present things that way:

CPU:            +38.0=B0C  (high =3D +80.0=B0C, hyst =3D  +4.0=B0C,
                          crit =3D +81.0=B0C)                  sensor =3D t=
ransistor

The exact algorithm is not trivial because of hysteresis values, which
we always want on the same line as the limit they correspond to.

Or maybe we can have "sensors" read the COLUMNS environment
variable and print things differently depending on the value, for
example on multiple lines if COLUMNS=80 and all on one line if
COLUMNS>80. This can quickly get complex to implement though, and
might also be confusing (COLUMNS isn't exported by default.)

> And our sysfs standard defines hyst to be an absolute value, not relative.

True.

> > Also as already "explained" in my previous question, this chip has one
> > hysteresis for both max and crit, now to make the current code work I w=
ould
> > need to put that twice into sysfs, which would result in to both changi=
ng if
> > one gets written (I can make only one rw to make this obvious).
>=20
> That should be OK. I did something similar in the vt1211 where a
> single register was exported twice and one of the attributes was
> read-only.

Yes, that's the way to go.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
