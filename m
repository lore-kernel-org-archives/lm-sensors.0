From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Mar 2010 07:53:29 +0000
Subject: Re: [lm-sensors] Andigilog asc7621 driver: Temperature scaling
Message-Id: <20100307085329.73439056@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B930BB3.6030201@kenm.demon.co.uk>
In-Reply-To: <4B930BB3.6030201@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Ken,

On Sun, 07 Mar 2010 02:13:07 +0000, Ken Milmore wrote:
> Hi George et al,
>=20
> Its great to see the aSC7621 driver being resurrected, but I notice in=20
> the patches flying about recently (see LKML 22 Feb 2010 in particular)=20
> that the voltage calculation is a bit off, as I already pointed out in a =

> previous review.  To get the correct results, it is much easier to use=20
> the 3/4 scale values given in the data sheet, and also be careful to do=20
> the multiplication before the division to avoid loss of precision (Hint: =

> The BSD version of the driver does it correctly!).

The patch is already committed upstream:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=D58de038728221f780e11d50b32aa40d420c1150
Any further change must be provided as an incremental patch on top of
that.

>=20
> See below:
>=20
>=20
> static int asc7621_in_scaling[] =3D {
>      2500, 2250, 3300, 5000, 12000
> };
>=20
>=20
> For the 10-bit voltage registers, do something like this:
>=20
> long regval >      (data->reg[param->msb[0]] << 8) |
>      (data->reg[param->lsb[0]]);
> regval =3D (regval >> 6) * asc7621_in_scaling[index] / (192 << 2);
>=20
>=20
> And for the 8-bit registers:
>=20
> long regval =3D data->reg[param->msb[0]];
> regval =3D regval * asc7621_in_scaling[index] / 192;

Looking at the current code, show_in8() looks OK to me. Multiplication
happens before division. It uses a 256 scaling factor instead of 192
but that shouldn't make a difference because the per-channel scale
values have been adjusted meanwhile.

show_in10(), OTOH, indeed suffers from the problem you describe: the
divisions happens before the multiplication, leading to loss of
accuracy.

Care to send a patch fixing this issue?

> I've not yet checked the code thoroughly to look for any of the other=20
> fixes which were put in during our previous discussions, but I suspect=20
> that some of the other minor fixes which were discussed on the mailing=20
> list may have been left out.

Feel free to send patches fixing them.

> This was a very ambitious driver in that it included all the fancy=20
> thermal management features of the aSC7621, and a complete review and=20
> testing of everything in the driver was a lot more than I had the=20
> stomach for.  I'm glad to see others have now picked it up though!

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
