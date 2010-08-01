From: Giel van Schijndel <me@mortis.eu>
Date: Sun, 01 Aug 2010 13:22:26 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: f71882fg: Add support for the
Message-Id: <20100801132226.GE3711@salidar.me.mortis.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1863158817347574754=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100323141718.GA23172@salidar.me.mortis.eu>
 <1269385936-3440-1-git-send-email-me@mortis.eu>
 <4BA9CC64.5010807@redhat.com>
 <20100324092357.GE6368@salidar.me.mortis.eu>
 <4BA9EA0C.6070200@redhat.com>
 <20100731233121.GD3711@salidar.me.mortis.eu>
 <4C551058.20509@redhat.com>
In-Reply-To: <4C551058.20509@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Wim Van Sebroeck <wim@iguana.be>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


--===============1863158817347574754==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 01, 2010 at 08:12:40 +0200, Hans de Goede wrote:
> On 08/01/2010 01:31 AM, Giel van Schijndel wrote:
>> On Wed, Mar 24, 2010 at 11:31:40 +0100, Hans de Goede wrote:
>>> On 03/24/2010 10:23, Giel van Schijndel wrote:
>>>> Ack. New and improved patch follows this line.
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> hwmon: f71882fg: Add support for the Fintek F71808E
>>>
>>> This new version looks good to me:
>>> Acked-by: Hans de Goede<hdegoede@redhat.com>
>>
>> Thanks.  Anyone else I need to poke in order to set this on track to
>> mainline?
>=20
> No,
>=20
> Jean should have picked this up, I guess it has fallen through the cracks.
>=20
> I think it is probably best if you resend this patch and the watchdog
> patches re-based against the latest upstream rc, then I'll re-review
> them and ack them and Jean can then put them into his tree.

Ack.  I'll resend them as replies to this mail.

--=20
Met vriendelijke groet,
With kind regards,
Giel van Schijndel

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkxVdRAACgkQZBYm/87l50JXQgCgjGFS6DWqWtnCOu9XCa2xJxAl
qI4AoKZVUWhecyIc3WjGvJNFtvIv8/uz
=Hyh7
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--


--===============1863158817347574754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1863158817347574754==--
