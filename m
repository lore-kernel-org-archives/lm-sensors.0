From: Giel van Schijndel <me@mortis.eu>
Date: Wed, 24 Mar 2010 08:46:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: f71882fg: properly acquire I/O
Message-Id: <20100324084643.GB6368@salidar.me.mortis.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2990433187585727570=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1269353535-23134-1-git-send-email-me@mortis.eu>
 <4BA9C9D6.4020903@redhat.com>
In-Reply-To: <4BA9C9D6.4020903@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


--===============2990433187585727570==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2010 at 09:14:14AM +0100, Hans de Goede wrote:
> I don't have any objections against the proposed changes, but there
> are 3 unrelated changes in this patch, please break them up in
> separate patches:
>=20
> 1) code cleanup: properly using, previously defined, functions rather
>    than duplicating their code.
> 2) properly acquire I/O regions while probing
> 3) Make the addresses to probe an array
>=20
> And IMHO you might just as well drop number 3, it does not really make
> the code any better readable, and the old way is how all superio hwmon
> drivers do things.

Okay, broken up patches will follow as replies to this message.

Regarding number (3), my goal wasn't to put the probe addresses in an
array. My goal (as I think should have been made clear by the commit
message I had added) was to make sure that upon failure f71882fg_find's
return value gets passed back from the module's init function. This to
make sure the *proper* error code gets passed back to the user of
insmod/modprobe (as opposed to it being replaced by -ENODEV).

Further I think non -ENODEV errors should probably immediately result in
module initialisation failing (rather than retrying a probe), that's a
design choice though (which my patch doesn't bother addressing right
now).

However, regarding the for-loop/array thing, the same behaviour can be
aqcuired with a patch like the one following this line. (Please tell me
if you like this approach or something similar better. Though,
personally, I think it's "hackisher"/dirtier).

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 4230729..42d6304 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -2295,9 +2295,11 @@ static int __init f71882fg_init(void)
=20
        memset(&sio_data, 0, sizeof(sio_data));
=20
-       if (f71882fg_find(0x2e, &address, &sio_data) &&
-           f71882fg_find(0x4e, &address, &sio_data))
-               goto exit;
+       if (f71882fg_find(0x2e, &address, &sio_data)) {
+               err =3D f71882fg_find(0x4e, &address, &sio_data);
+               if (err)
+                       goto exit;
+       }
=20
        err =3D platform_driver_register(&f71882fg_driver);
        if (err)

--=20
Met vriendelijke groet,
With kind regards,
Giel van Schijndel

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkup0XMACgkQZBYm/87l50IFwwCgoE+u1wVoFcVIIMduKz6QNHwE
bPIAn1q5pgStdDimvbUvNkMzXdCOUIKX
=GDYU
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--


--===============2990433187585727570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2990433187585727570==--
