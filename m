From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 28 May 2013 11:19:23 +0000
Subject: Re: [lm-sensors] [PATCHv2 0/3] Add G762/G763 PWM fan controller
Message-Id: <20130528111921.GD11547@mithrandir>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6267802111882494969=="
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1369687670.git.arno@natisbad.org>
 <152190814.eApXVbVBPA@wuerfel>
 <87li6z2yxj.fsf@natisbad.org>
In-Reply-To: <87li6z2yxj.fsf@natisbad.org>
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Simon Guinot <simon.guinot@sequanux.org>


--===============6267802111882494969==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2013 at 12:15:04PM +0200, Arnaud Ebalard wrote:
> Hi Arnd,
>=20
> Arnd Bergmann <arnd@arndb.de> writes:
>=20
> > On Tuesday 28 May 2013 00:02:29 Arnaud Ebalard wrote:
> >>=20
> >> This series adds support for GMT G762/G763. This work is based on a
> >> basic version for 2.6.31 kernel developed Olivier Mouchet for LaCie
> >> NAS. Updates have been performed to run on recent kernels. Support has
> >> been completed and additional features added: ability to configure
> >> various characteristics from .dts file, better initialization, alarms
> >> and error reporting support, gear mode, polarity, fan pulse per
> >> revolution, fan startup voltage control.
> >
> > I wonder if this could be split into two separate drivers, one for
> > the pwm subsystem, and one for a hardware-independent fan controller
> > based on the pwm interfaces.
>=20
> To be honest, I wouldn't even know how to start in order to do that.
> Additionally, it would be worth the effort if other drivers could be
> easily refactored using this idea. I'll let hwmon people provide some
> feedback and try and comply with their directions (based on the cpu
> cycle I can spend on this).

What Arnd proposes doesn't sounds like a very good idea. PWM-controlled
fans should be able to work just fine using a generic driver that uses
the PWM framework, similar to the PWM backlight and LED drivers.

Thierry

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRpJK5AAoJEN0jrNd/PrOhue0QAIcSLqr+gJhZO2x6rZuABhqf
6jkQUhnJuGuJ5y/1LjP6nNfEVvWP1UKE9u1bBPccrj6l8xs3DeUjsZ5403wlTEjj
gAQB/Q1TbunBLDsFOO/H/WWLZXcyzgs2dc3gB/Fn3Sse49jRAe3+xSqQ1EiA6duB
0HuFDUfW0RGN8ZxakAG0abHnJiVtWUFXXEFVyd84GdyVs+mNI8rEauXpF/LKIDA7
EKhS/1suA7NyVwUHe/4ode16xOcp9dAk8zwHA1G3g9sQnBX1ATLpcOzelLzwC4WD
QE+Nx5wS5MtNTdbxl0ksurX6eUK1+qEIJGDMFGNDrssYOK110A3SPeCpnoestL1O
1XKuWf/pCKCYWKtGJR5KFAIT5E+X4g9/fWYVm8RkVs8hcrEupbNvMNO2AKTSkzam
b5VySEW6hNNZCIiqjl8rBvVfpOZtiltwj+HyviOp/DUlo6x9a6l2bnF9CZHgaa9v
Qvc/JGdi5Hhl3eEXcFsJSl3pHmQqPzjAhmfX3Nplx8sC8p+eo3fnlxWFpZC5oUQx
LSqgIHBGpvWCaGbaXMCAiQrY7a8HclbZEc8pocZv7mY+tSVrVfyIWsdjPMlTOch8
pk4p6D4G2y48hda7O2u0+O+1cFTzaut18O87d6/b791bpn1DYgjbXYcwBy2HHj93
CExvbuPjFGximXSHbbLk
=0+eo
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--


--===============6267802111882494969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6267802111882494969==--
