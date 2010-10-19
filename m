From: Simon Guinot <simon@sequanux.org>
Date: Tue, 19 Oct 2010 08:36:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <20101019083656.GE29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8342567604801011486=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
	<20101018203610.GD29120@kw.sim.vm.gnt>
	<20101019065221.GA12406@ericsson.com>
In-Reply-To: <20101019065221.GA12406@ericsson.com>
To: linux-arm-kernel@lists.infradead.org


--===============8342567604801011486==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, Oct 18, 2010 at 11:52:21PM -0700, Guenter Roeck wrote:
> On Mon, Oct 18, 2010 at 04:36:10PM -0400, Simon Guinot wrote:
> [ ... ]
> > > I don't really understand the value of supporting pwm attributes,
> > > since you have to convert those to rpm anyway. Why not just stick
> > > with fan1_input and fan1_target ? This would simplify the code a lot.
> >=20
> > I don't know very well the hwmon API. I have simply been fooled by the
> > sysfs-interface document which claim that fan[1-*]_target only make
> > sense for a closed-loop fan. Moreover, I was expecting gpio-fan to be
> > compliant with the fancontrol shell script...
> >=20
> > But anyway, you are right. I just don't want the pwm interface.
> >=20
> Thinking more about this, another option might be to keep using
> the pwm interface (for fancontrol), but simplify your code.
> Your transitions are currently pwm -> rpm -> ctrl and vice versa.
> However, direct conversion pwm -> ctrl should also be possible
> and would be much simpler than the two-stage conversion.
>=20
> To do that, you could map num_speed directly to the pwm range of (0..255).
> Something like
>=20
> 	pwm =3D DIV_ROUND_CLOSEST(speed_index * 255, num_speed - 1);
> and
> 	speed_index =3D pwm * (num_speed - 1) / 255;
>=20
> Then use speed_index to get control value and rpm from the speed table.
>=20
> Would that make sense ? You could then also provide fan1_target
> for direct fan speed control.

Unfortunately, I believe this approximation is not possible. Take a look
at the Network Space Max fan speed array:

/* Designed for fan 40x40x16: ADDA AD0412LB-D50 6000rpm@12v */
static struct gpio_fan_speed netspace_max_v2_fan_speed[] =3D {
        {    0,  0 },
        { 1500, 15 },
        { 1700, 14 },
        { 1800, 13 },
        { 2100, 12 },
        { 3100, 11 },
        { 3300, 10 },
        { 4300,  9 },
        { 5500,  8 },
};

The function rpm_speed(index) is really not linear. I am not sure about
the resulting behaviour when this will be used by a userland fan control
process...

If the pwm interface must be exported, I think we have to respect the
fan speed array. But as you said, maybe the work is rather on the
fancontrol script side.

As a first step, we could keep the heavy pwm interface. Once the
fancontrol script (or something else) will be able to handle the rpm
attributes, we will drop the pwm compatibility.
Simply remove the gpio-fan pwm interface seems a good option too...

Both make sense for me. Let me know your favourite way.

Thanks,

Simon

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky9WKgACgkQgtp0PDeOcDr/jQCgke5pKynW5oj3yezcr4c77pul
OysAniSf9u1gxMcKSeqlJ6026IYgxEvh
=nyJb
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--


--===============8342567604801011486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8342567604801011486==--
