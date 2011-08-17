From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 17 Aug 2011 13:39:17 +0000
Subject: Re: [lm-sensors] Alix 2D2
Message-Id: <20110817133917.GA12113@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E4A9BEE.5030108@sysnux.pf>
In-Reply-To: <4E4A9BEE.5030108@sysnux.pf>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Aug 17, 2011 at 03:59:42AM -0400, Jean-Denis Girard wrote:
> Le 16/08/2011 20:24, Guenter Roeck a =E9crit :
> > Looking into the i2c bus driver code, it was recently converted into a =
platform driver.
> > The supporting mfd driver would be cs5535-mfd. That might be one possib=
le reason
> > for your problem, though it happened less than a year ago.
>=20
> Thanks Guenter, that was my problem (cs5535_mfd missing); now it is
> working again:
> [admin@ix100 ~]$ sensors
> lm86-i2c-0-4c
> Adapter: CS5535 ACB0
> temp1:        +43.0=B0C  (low  =3D  +0.0=B0C, high =3D +70.0=B0C)
>                        (crit =3D +85.0=B0C, hyst =3D +75.0=B0C)
> temp2:        +49.8=B0C  (low  =3D  +0.0=B0C, high =3D +70.0=B0C)
>                        (crit =3D +85.0=B0C, hyst =3D +75.0=B0C)
>=20
Good.

> Shouldn't scx200_acb depend on cs5535_mfd in the kernel configuration
> options ?
>=20
I don't know. Again, you might want to ask that kind of question on the i2c=
 mailing list.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
