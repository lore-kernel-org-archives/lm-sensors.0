From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 May 2013 03:53:13 +0000
Subject: Re: [lm-sensors] i2c multimaster and the device driver detect function
Message-Id: <20130509035313.GA26817@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130212164811.GV8668@pengutronix.de>
	<3D8D1B67-2846-4B78-B402-6B9FD1CB10E6@gmail.com>
	<20130508175417.GB29689@roeck-us.net>
	<FCF1B5D0-FF63-40D5-B7B4-D5969628AAD3@gmail.com>
In-Reply-To: <FCF1B5D0-FF63-40D5-B7B4-D5969628AAD3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Dagenais <jeff.dagenais@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, wsa@the-dreams.de

On Wed, May 08, 2013 at 09:50:44PM -0400, Jean-Fran=E7ois Dagenais wrote:
>=20
> On 2013-05-08, at 13:54, Guenter Roeck wrote:
>=20
> > [...]
> > Isn't it the point of having multiple masters on the same bus, that eac=
h of
> > them can manage the same devices ?
>=20
> I wouldn't think so. You mention why in your last paragraph and I totally=
 see
> and agree with that. So that is not my intention at all.
>=20
Guess the real conclusion is that one should avoid two active masters
in the first place if possible.

> >=20
> > Question for me is why you would want two masters in the same system co=
ntext
> > point to the same I2C bus. Usually the second master would be something=
 like an
> > IPMI controller or a second CPU/controller board in a redundant system.
>=20
> I guess that's one scenario. In our scenario, we have an assambled board =
stack.
> The main board has a sub-par i2c master onto which heavy slaves such as t=
he
> ad7147 capacitive input device consumes too much cpu power (cpu has to po=
ll the
> Kontron PLD which houses the i2c master core). Our hoped solution was to
> allocate an i2c IP core in our FPGA. But board inter-connect budget didn'=
t allow
> for separate i2c segments, especially in the light that both master are s=
aid to
> support multimaster operation. I got this working experimentally right no=
w, I
> just stumbled on jc42's detect, and am trying to project this kind of des=
ign to
> the future. Right now, my only solution is to patch my version of jc42 no=
t to
> auto-detect, and explicitely enumerate my temperature sensors like my oth=
er
> slaves in arch setup... yikes.
>=20
Is one of the I2C adapter drivers your own ? If so, you can disable auto-de=
tection
in the adapter code by setting the adapter class to 0 (specifically, don't =
set it
to I2C_CLASS_HWMON). You can do the same in the Kontron driver if you have =
the
source (it is GPL so you should be able to find it). While not perfect, tha=
t should
be better than disabling auto-detection in the affected chip drivers.
Note that the Kontron driver also sets I2C_CLASS_SPD, which means EEPROMs a=
re
auto-detected on address 0x50.

> >=20
> > Even then the multi-master scenario is problematic, as you still end up=
 with
> > multiple masters controlling the same device. That is a problem inheren=
t to I2C,
> > and especially problematic with multi-page devices (typical problem: ma=
ster 1
> > sets page, master 2 sets page, master 1 accesses wrong data). I don't t=
hink there
> > is a clean solution to solve that, other than to block i2c access for o=
ne of the
> > masters entirely.
>=20
> Other than the redundant/resiliency scenario, why would you setup the sam=
e slave
> on two different masters? Right now I have a working setup where some sla=
ves are
> declared on bus 0 (PLD i2c master) and others on bus 1 (FPGA i2c master).=
 I have
> yet to stress test the setup within the next day or so, but so far, it se=
ems to
> work ok.
>=20
Sure, it does work, I am just not sure what the benefits are of having two
masters in this scenario. Guess you are saying that the I2C master in the
Kontron PLD can not drive the AD7147 - is that correct ? If so, and if that
means you have to use your own I2C core anyway, why bother using the Kontron
PLD's I2C bus to start with ? You could just ignore it (ie not instantiate
or build it at all) and use your own.

Did you tell Kontron about the problems with their PLD ? Maybe they have a
solution.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
