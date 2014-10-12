From: Felix Schulthess <fsch@truthbox.ch>
Date: Sun, 12 Oct 2014 16:53:28 +0000
Subject: Re: [lm-sensors] Fan Control on 6027R TRF running Debian Wheezy
Message-Id: <543AB208.8060305@truthbox.ch>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2996816842309798507=="
List-Id: <lm-sensors.vger.kernel.org>
References: <5437E87B.8030206@truthbox.ch>
In-Reply-To: <5437E87B.8030206@truthbox.ch>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2996816842309798507==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wati5OurOmB0dckJTSjrWh6UXOsS8KoUw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wati5OurOmB0dckJTSjrWh6UXOsS8KoUw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear List,

On 10/12/2014 06:12 PM, Felix Schulthess wrote:

>> You cannot control the fan speeds. They are managed by the onboard
>> controller. You can choose one of several profiles in the bios but tha=
t
>> is it.
>=20
> That explains a lot. Thank you for your help, I am going to do some
> further research in this direction and read up on FreeIPMI.

in the meantime, I managed to change the fan settings back to normal
(i.e. optimized) fan control. For some reason, they were set to full
speed. What I had to do is connect via a browser to the management LAN
port and log in.

There is a manual for the IPMI Chip on the 6027R TRF main board.

http://www.supermicro.com/manuals/other/SMT_IPMI_Manual.pdf

It explains the underlying hardware quite well. I am adding this here
for the sake of completeness. Maybe so. else will appreciate this solutio=
n.

Best Felix.


--wati5OurOmB0dckJTSjrWh6UXOsS8KoUw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJUOrIIAAoJEAiVgzBCINKEQ2gIAKl382MLM3NM35E+695wEBo8
3ZJzSHNeAAF/6f9Xb62DtUSoJNJjbcbvgBPN30CRdiFrlJFwbuH5ddLk5WPQDSnW
n02gtczhHfKam7qAlNeLRAPfsYNbYOMgiTcLSYMbuwbwDeUz/gOXJW8nAuf6DCl0
nCysJ20KQFUTC1mF7DYhHdbe/sPw3HFcm0cdzpstOElr6OTdmcvNIp/CbbObKrVf
7y4MTs4n5UD/4wYMbPudYDolasC767JGD5m4WzxN2CQ+59lqiVh+YPkUIXSgn2Nz
V5Vjv1tcXDM/3XYIW5WiM3MlNDZDVnJwMjzK2x7zDuw5rBQWb/jEYstzoXL8JBU=
=SmpE
-----END PGP SIGNATURE-----

--wati5OurOmB0dckJTSjrWh6UXOsS8KoUw--


--===============2996816842309798507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2996816842309798507==--
