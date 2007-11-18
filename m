From: Alexander Kiel <alexanderkiel@gmx.net>
Date: Sun, 18 Nov 2007 15:57:22 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <1195401442.6437.21.camel@alex>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4554620475759247580=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
To: lm-sensors@vger.kernel.org


--===============4554620475759247580==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FhWl20WISOITRJ4O/TnT"


--=-FhWl20WISOITRJ4O/TnT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> > Ok the problem with pwmconfig is the following:
> >=20
> > echo 0 > $ENABLE 2> /dev/null outputs actually 0. This is the 0 from th=
e
> > echo. echo 3 > $ENABLE 2> /dev/null would output 3. I have no clue why
> > this is the case.
>=20
> How did you try that, on the command line? $ENABLE is a variable in the
> pwmconfig script, on the command line it's undefined, so that can't
> work. Your original report doesn't show any "0" printed on the screen.

Yes I did this on the command line (bash). Of course, I replaced the
$ENABLE variable through pwm1_enable. Try the following command
in /sys/class/hwmon/hwmon0/device as root:

echo 255 > pwm1; echo 0 > pwm1_enable 2>/dev/null; echo 1 > pwm1_enable
2>/dev/null; echo 255 > pwm1; cat pwm1

This gives me a 0 on the stdout. But this:

echo 255 > pwm1; echo 0 > pwm1_enable >/dev/null 2>/dev/null; echo 1 >
pwm1_enable 2>/dev/null; echo 255 > pwm1; cat pwm1

gives me 255 on stdout.=20

PWM1 has no fan attached in my configuration. It may be the CPU fan
controller, but I don't have a CPU fan, I have water cooling. I don't
know if this makes a difference. Currently I have pwm4 working by BIOS
(ASUS Q-fan control).=20

> > This 0 causes the line echo $MAX > $1 to set pwm1 to 0 instead of 255.
>=20
> I very much doubt it. Both statements are separate, I fail to see how
> whatever the first one does could have any influence on the second.

I don't have much experience in shell programming. But is it possible
that the 0 at stdout stays there until the next command? And than the
cat 255 > pwm1 would be a echo 0 255 > pwm1.

> > If I add a > /dev/null to the line echo 0 > $ENABLE 2> /dev/null it
> > works as it should.
> >=20
> > So the diff is:
> > ----------------------------------------------------------------------
> > 127c127
> > <               echo 0 > $ENABLE > /dev/null 2> /dev/null
> > ---
> > >               echo 0 > $ENABLE 2> /dev/null
> > ----------------------------------------------------------------------
> >=20
> > Can you submit this patch? I don't have a reasonable access to the
> > lm-sensors community.
>=20
> This patch is not correct, it breaks pwmconfig more than it fixes it.

I have pwmconfig v0.8. Maybe the line numbers are not correct in your
version. I think you will find the right position per hand. a additional
> /dev/null should not hurt.

> As explained above, the problem you have is not with setting
> pwm1_enable to 1 (that works) but presumably with setting pwm1 to 255.
> So you're trying to fix the wrong line of the script.

Yes the problem is setting pwm1 to 255. But it is set to 0 by pwmconfig
v0.8. And after my investigation I find out that the 0 comes from this
echo 0 statement. I than fixed pwmconfig with this additional
> /dev/null and it worked for me. It worked completely. It found my fan
attached to pwm4 and all this stuff.

Regards
Alex

--=-FhWl20WISOITRJ4O/TnT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHQGDiCGe1jnrXt2QRAq4dAJ0TYyZq4ma3laMlkAN6NWE5beXzDgCghJFr
ANYK7ZjZUtBuO9AdzpmmwRE=
=zNcH
-----END PGP SIGNATURE-----

--=-FhWl20WISOITRJ4O/TnT--



--===============4554620475759247580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4554620475759247580==--

