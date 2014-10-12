From: Felix Schulthess <fsch@truthbox.ch>
Date: Sun, 12 Oct 2014 16:12:23 +0000
Subject: Re: [lm-sensors] Fan Control on 6027R TRF running Debian Wheezy
Message-Id: <543AA867.9010906@truthbox.ch>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0054275449088089430=="
List-Id: <lm-sensors.vger.kernel.org>
References: <5437E87B.8030206@truthbox.ch>
In-Reply-To: <5437E87B.8030206@truthbox.ch>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0054275449088089430==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="D3ET29q4HbQmXwaOsWQd2UruJGJTGuQM4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D3ET29q4HbQmXwaOsWQd2UruJGJTGuQM4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Phil,

thanks a lot for the quick reply! Great to see that this mailing list is
so active.

On 10/10/2014 04:53 PM, Phil Pokorny wrote:
>=20
> On Friday, October 10, 2014, Felix Schulthess <fsch@truthbox.ch
> <mailto:fsch@truthbox.ch>> wrote:
>=20
>     Dear lm-sensors Team,
>=20
>     on a 6027R TRF, I run the latest Debian Wheezy. I have a problem wi=
th
>     the server, because I cannot control fan speed anymore.
>=20
>=20
> Your system has an onboard management processor which supports IPMI. Yo=
u
> should not use lm-sensors. Install IPMITOOL or FreeIPMI and use those
> tools ( or super doctor ) to read sensors.
>=20
> You cannot control the fan speeds. They are managed by the onboard
> controller. You can choose one of several profiles in the bios but that=

> is it.

That explains a lot. Thank you for your help, I am going to do some
further research in this direction and read up on FreeIPMI.

Still, if I can't control the fan speeds but they are instead controlled
by some onboard controller, then how could the installation on the
fancontrol and lm-sensors mess up the control loop so bad? This still
keeps me wondering.

Maybe, the sensors somehow blocked the CPU temperature readout. This
could have caused the superdoctor program to resort to some failsafe
behavior (i.e. spinning the fans up to max RPM). Just wondering.

>     Since then I didn't manage to regain control of the fans. Even afte=
r a
>     reboot the fans start to speed. Also, removing the installed packag=
es
>     again does not help.
>=20
>=20
> You probably need to reset the management controller. The easiest way i=
s
> to shutdown the system and unplug it for several MINUTES to discharge
> all the capacitors and insure everything resets.  Then plug in and turn=

> on again.

Thank you, I already tried that -- without success.

Best, Felix


--D3ET29q4HbQmXwaOsWQd2UruJGJTGuQM4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJUOqhnAAoJEAiVgzBCINKEbb0IAJeFKjURGGBWOPk4ijAIdUrA
ojjWgju1ejd1FtAfJqcOHG/3JyVPbc7YP+6h6y474bG0fAsY32/OwxdlA4a3I1Ta
w4ib/NEpHEpcfRAx/fxmJUGT9zKJjlZEdxQdRdyxYRhU388is6gjmzN936mxuhR+
xiRE//KFQUWn91TOQC8Zga0UNYKvmuAvy1DCcwcivO4sxMqEQz05k5fiei2P3Mxo
NQB90ZCwaoaOX/qkjuw/e2VtLoIpaCmbrMd6KdWnOiB1zkl1eUzydx1k+Vj4Efk8
K5e40E71u+ZJlAwhPyGFY5++rGkSJ/jBk+nE2uDUAqidWeVPjSAiGY22A9Jz5B4=
=cFIp
-----END PGP SIGNATURE-----

--D3ET29q4HbQmXwaOsWQd2UruJGJTGuQM4--


--===============0054275449088089430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0054275449088089430==--
