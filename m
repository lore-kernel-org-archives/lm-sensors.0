From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 04 Jun 2011 16:57:57 +0000
Subject: Re: [lm-sensors] [PATCH] Add support for the Philips SA56004
Message-Id: <20110604165757.GA19677@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307183831-19627-2-git-send-email-sdevrien@cisco.com>
 <BANLkTimKB8PtFF72rOeDAmkbM_oq=ZMRgg@mail.gmail.com>
 <6E4D2678AC543844917CA081C9D6B33F049B1DE3@XMB-AMS-103.cisco.com>
In-Reply-To: <6E4D2678AC543844917CA081C9D6B33F049B1DE3@XMB-AMS-103.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Stijn Devriendt (sdevrien)" <sdevrien@cisco.com>
Cc: anish singh <anish198519851985@gmail.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jun 04, 2011 at 12:32:01PM -0400, Stijn Devriendt (sdevrien) wrote:
> > From: anish singh [mailto:anish198519851985@gmail.com]=20
> >
> > I am no expert on HWMON but just want to=20
> > add some points.
> > @@ -454,7 +477,7 @@ static struct lm90_data *lm90_update_device(struct =
device *dev)
> >
> >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data->flags & LM90_HAVE_LOCAL_EXT) {
> >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lm90_read16(client, LM90_=
REG_R_LOCAL_TEMP,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 M=
AX6657_REG_R_LOCAL_TEMPL,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d=
ata->reg_local_ext,
> >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&=
data->temp11[4]);
> > I don't think this variable reg_local_ext should exist as=20
> > register address should be "# defined" and should not be
> > part of lm90_data but i do see a case here where we are
> > assuming MAX6657 is only having this LM90_HAVE_LOCAL_EXT
> > flag set.So i think we should have some more branching here
> > to detect the device and pass the corresponding register but as
> > i said i am no expert.
> >=A0
>=20
> Only MAX6657 and SA56004 have the local temperature extension
> register and unfortunately they reside at different offsets.
> Therefore the probing will detect the right chip and, if supported,
> use the correct register.
>=20
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (lm90_read_reg(client,=
 LM90_REG_R_LOCAL_TEMP,
> > @@ -1372,6 +1400,11 @@ static int lm90_probe(struct i2c_client *new_cli=
ent,
> >=A0 =A0 =A0 =A0/* Set maximum conversion rate */
> >=A0 =A0 =A0 =A0data->max_convrate =3D lm90_params[data->kind].max_convra=
te;
> >
> > + =A0 =A0 =A0 if (data->flags & LM90_HAVE_LOCAL_EXT) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->reg_local_ext =3D lm90_params[data-=
>kind].reg_local_ext;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(data->reg_local_ext =3D 0);
> > + =A0 =A0 =A0 }
> > +
> > I think this BUG_ON is too harsh in probe.We generally use pr_err
> > to print if something which is supposed to be set is not set.As BUG_ON
> > will call kernel panic,right?
>=20
> The reason for adding the BUG_ON rather than the error was that it is
> in fact a coding error when the flag is set without specifying the offset.
> Such a condition should never make it into a running system and should be
> caught during coding or review.
> BUG_ON only does an oops, panic is optional depending on panic_on_oops be=
ing
> set.
>=20
Maybe use WARN_ON instead ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
