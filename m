From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Sep 2008 14:28:43 +0000
Subject: Re: [lm-sensors] it8712 rev 7; fan speeds reported incorrectly.
Message-Id: <200809151628.43806.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9F6ACAE02B6DD040A1E259977622CFDB03E26A54@oslexcp1.eu.tandberg.int>
In-Reply-To: <9F6ACAE02B6DD040A1E259977622CFDB03E26A54@oslexcp1.eu.tandberg.int>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi John,

Le lundi 15 septembre 2008, John Gumb a =E9crit=A0:
> I've just picked up linux-2.6.27-rc5 and it would appear fan speeds are
> reported incorrectly now. We have it8712  rev7 on our systems. We see
> speeds of around 40K RPM (!!).
>=20
> The following hack fixes it - it just punts 16 bit fan support out to
> rev8. It would appear our it8172 does not have 16 bit tacho support. Or
> if it does, the driver isn't enabling it properly.

Thanks for reporting. I don't have access to my collection of IT87xx
datasheets and personal notes on chip revisions, so I can't check
now. I will check when I am back home. Andrew, what do you think?

John, how many fans are monitored on your systems, and were they all
screwed up in 2.6.27-rc5, or only some of them?

> --- drivers/hwmon/it87.c.orig   2008-09-05 15:51:11.000000000 +0100
>=20
> +++ drivers/hwmon/it87.c        2008-09-05 15:51:53.000000000 +0100
>=20
> @@ -283,7 +283,7 @@
>=20
>            IT8712F Datasheet 0.9.1, section 8.3.5 indicates 7h =3D
> Version I.
>=20
>            These are the first revisions with 16bit tachometer support.
> */
>=20
>         return (data->type =3D it87 && data->revision >=3D 0x03)
>=20
> -           || (data->type =3D it8712 && data->revision >=3D 0x07)
>=20
> +           || (data->type =3D it8712 && data->revision >=3D 0x08)
>=20
>             || data->type =3D it8716
>=20
>             || data->type =3D it8718;
>=20

Patch was totally destroyed by your mailer, so we can't apply it.
Please resend with HTML mails disabled or as a text attachment, or
whatever is needed for the patch to reach us in its original format.
We will also need a Signed-off-by statement from you as described in
section 12 of Documentation/SubmittingPatches.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
