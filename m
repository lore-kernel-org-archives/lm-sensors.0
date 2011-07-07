From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jul 2011 11:22:42 +0000
Subject: Re: [lm-sensors] [PATCH v3] Add support for the Philips SA56004
Message-Id: <20110707132242.0aaff4ea@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307356845-10095-1-git-send-email-sdevrien@cisco.com>
	<BANLkTi=gAqpDNBjCXzvNEhSuzm=3Mg9rVg@mail.gmail.com>
In-Reply-To: <BANLkTi=gAqpDNBjCXzvNEhSuzm=3Mg9rVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Fubo Chen <fubo.chen@gmail.com>
Cc: sdevrien@cisco.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, guenter.roeck@ericsson.com

On Sun, 26 Jun 2011 21:54:37 +0200, Fubo Chen wrote:
> On Mon, Jun 6, 2011 at 12:40 PM,  <sdevrien@cisco.com> wrote:
> > + =A0 =A0 =A0 } else
> > + =A0 =A0 =A0 if (man_id =3D 0xA1) { /* =A0NXP Semiconductor/Philips */
>=20
> No kernel coder writes like this. Has this ever been run through checkpat=
ch ?

Actually, I wrote that code, and I am a kernel coder. You may not like
it, but at the time it seemed the best way to keep the function
readable. This particular style allows for better placement of
comments, which are many in this function.

As long as checkpatch doesn't complain about it, I will not consider
changing it, and will reject any attempt to do so (simply by comparing
the readability before and after the patch and inevitably coming up to
the conclusion that the change isn't worth it.)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
