From: Alexander Kiel <alexanderkiel@gmx.net>
Date: Sun, 18 Nov 2007 17:10:24 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <1195405824.6437.35.camel@alex>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5311493847883371154=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
To: lm-sensors@vger.kernel.org


--===============5311493847883371154==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-3jeieSxson4+8MknCJ3c"


--=-3jeieSxson4+8MknCJ3c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> May I ask what shell (and version) you're using? Both sequences above
> return 255 here.

bash -version says:

GNU bash, version 3.2.25(1)-release (i486-pc-linux-gnu)
Copyright (C) 2005 Free Software Foundation, Inc.

I have a fresh and totaly normal installed Ubuntu 7.10 32-bit without
any modifications. My user account and its homedir is also new. The bad
is that this is likely the most used distributation is the next year.

> It would take a broken shell to do what you describe, if that's
> possible at all. The following command should answer your question:
>=20
> echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable ; echo 255 > /tmp/pwm=
1 ; cat /tmp/pwm1
>=20
> Here, it prints the expected error message, then 255.

--------------------------------------------------------------------------
root@alex:~# echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable ; echo
255 > /tmp/pwm1 ; cat /tmp/pwm1
bash: echo: write error: Invalid argument
0
255
root@alex:~# cat /tmp/pwm1
0
255
--------------------------------------------------------------------------

As you can see it prints the error message, the 0 and the 255. And you
can see both go into /temp/pwm1.

--------------------------------------------------------------------------
root@alex:~# echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable
2>/dev/null ; echo 255 > /tmp/pwm1 ; cat /tmp/pwm1
0
255
--------------------------------------------------------------------------

Here the error goes to /dev/null.

--------------------------------------------------------------------------
root@alex:~# echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable
>/dev/null 2>/dev/null ; echo 255 > /tmp/pwm1 ; cat /tmp/pwm1
255
--------------------------------------------------------------------------

And so the 0.

> I meant that the patch is functionally incorrect, not that I was not
> able to apply it (although it is, indeed, technically incorrect, for
> it's reverted and not in unified format.)

Ok. Excuse me. This was a simple diff between the two files. I have no
experiences in creating a real patch.

> An additional > /dev/null can certainly hurt, as it overwrites the
> previous > $ENABLE, meaning that you do NOT write the value to the
> sysfs file at all. It doesn't make a difference for you because writing
> 0 to pwm1_enable doesn't actually work with the w83627ehf driver, but
> your change breaks drivers for which it works.

Ok. Thats a good point. I thought that it redirects the hanging zero
to /dev/null. But I see echo 0 is the command and > $ENABLE is the
regirection of the stdout. But why does pwm1_enable not consume the 0
and throws the error afterwards?

Regards
Alex

--=-3jeieSxson4+8MknCJ3c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHQHIACGe1jnrXt2QRAhDCAKCKjJkFXYphsiIbEACyLSEwyDvYRACfRVXQ
wGf82VnoqjAdqB6RblgI1WE=
=q1z+
-----END PGP SIGNATURE-----

--=-3jeieSxson4+8MknCJ3c--



--===============5311493847883371154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5311493847883371154==--

