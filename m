From: Rodolfo Giometti <giometti@enneenne.com>
Date: Tue, 22 Sep 2009 08:33:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090922083322.GE17623@gundam.enneenne.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7101175007481373839=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
To: lm-sensors@vger.kernel.org


--===============7101175007481373839==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2009 at 01:48:37AM +0200, Samuel Ortiz wrote:
> > > Something like that:
> > >=20
> > > void superio_outb(struct w83627hf_sio_data *sio, int ld, int reg, int=
 val)
> > > {
> > > 	mutex_lock(&sio->lock);
> > >=20
> > > 	/* Enter */
> > > 	outb(0x87, sio->sioaddr)
> > > 	outb(0x87, sio->sioaddr)
> > >=20
> > > 	/* Select module */
> > > 	outb(0x07, sio->sioaddr);
> > > 	outb(ld, sio->sioaddr + 1);
> > >=20
> > > 	/* Write */
> > > 	outb(reg, sio->sioaddr);
> > > 	outb(val, sio->sioaddr + 1);
> > >=20
> > > 	/* Exit */
> > > 	outb(0xAA, sio->sioaddr);
> > >=20
> > > 	mutex_unlock(&sio->lock);
> > > }
> > >=20
> > > would look saner to me. I know we're wasting many IO ops here, but it=
 seems to
> > > me that the subdevices get to call the superio API only at init time.
> > > I think it's worth it as your subdevices wouldnt have to care about f=
ollowing
> > > these error prone steps, and you wouldnt have any more unbalanced loc=
king
> > > risks.
> >=20
> > The above has limitations. Think of the hwmon logical device enablement
> > function which we discussed above. In this function we must read a
> > register, and depending on the value, maybe write to it, but altering
> > only one bit (so based on the original value.)
> >=20
> > There is no way to achieve this in a race-free manner with your
> > proposed superio_outb() function and the equivalent superio_inb()
> > implementation. Even a superio_alterb() function wouldn't do, because
> > we want to print a message.
> I agree about that. But since this API is supposed to be used by subdevic=
es, I
> looked at what the only available one (w83627hf.c) would do with it. It s=
eems
> to me that this API would work well for w83627thf_read_gpio5() and
> w83627thf_read_vid(). The more complex register manipulations found in
> w83627hf_find() wouldnt have to use this API since it's an MFD core routi=
ne.
> I definitely see the limitation of the above API, but it looks like it fi=
lls
> the current need without introducing potential locking issues.
> Now, you guys know way better the HW than me and can tell if this API wil=
l be
> too limited for future subdevices. If that's the case, then let's go with
> Rodolfo's proposal but I'd like to have an additional check for all the
> superio_* routines (except superio_enter()), which would be a:
> WARN_ON(!mutex_is_locked(&sio->lock));
> That wont protect us from the "unlocking from a different process"
> > bug, but it
> would still be a progress.

If you can read chip's datasheet you may see that GPIOs sub-device
doesn't fix with your proposal. So I'm going to use my proposal but I
add your check about mutex locking.

Thanks,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq4i9IACgkQQaTCYNJaVjNkSQCeIhVIBpDDQciNiTmV+FWjf5ad
XD4An32SMh7P2mDoEWw5sJ7rCkOG9DPR
=PALo
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--


--===============7101175007481373839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7101175007481373839==--
