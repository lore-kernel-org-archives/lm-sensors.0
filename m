From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 18 Oct 2008 19:18:07 +0000
Subject: Re: [lm-sensors] Problem with it87 module from Linux 2.6.26 onward
Message-Id: <20081018211807.1d1f17a5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hallo Johannes,

Adding the lm-sensors list in Cc, as well as Andrew Paprocki who has
been working on the it87 driver lately.

On Sat, 18 Oct 2008 19:18:15 +0200, Johannes Truschnigg wrote:
> Dear Linux kernel module authors,
>=20
> I'm the owner of an ASUS M2NPV-VM mainboard which features a chip driven =
by=20
> the it87 module. I used the PWM capabilities of this chip to reduce my=20
> system's noise level, by having its fan speeds regulated via `fancontrol`=
=20
> from lm_sensors, as the BIOS-provided PWM regulation isn't good enough (t=
he=20
> fans spin at full speed despite CPUtemp being lower than 40=B0C, etc.).
> However, this mechanism stopped working as soon as I upgraded to the 2.6.=
26=20
> kernel. I was able to dig up a commentary on some mailing list that=20
> this "bug" I hit was introduced by choice, and that I could probably work=
=20
> around it by specifying "fix_pwm_polarity=3D1" as a parameter to the modu=
le. I=20
> suppose it would work, if the debug ringbuffer wouldn't contain
>=20
> ### snip ###
> it87 it87.656: PWM configuration looks sane, won't touch
> ### snip ###
>=20
> after loading the module accordingly. Is there a way to _really_ force=20
> 2.6.25's behavior in this manner? Or am I doing it wrong, and there's ano=
ther=20
> way I can get what I want, which is PWM working the way I would like it t=
o?

There's no way to force the polarity change, for your own good. If you
did not need to pass fix_pwm_polarity=3D1 before, then passing it now
will not solve your problem.

> I'd really appreciate getting an answer on that matter - thank you in any=
 way=20
> for taking your time!

The it87 driver did not change between kernel 2.6.25 and kernel 2.6.26:
http://www.eu.kernel.org/diff/diffview.cgi?file=3D%2Fpub%2Flinux%2Fkernel%2=
Fv2.6%2Fpatch-2.6.26.bz2

So, I have a hard time believing that fan speed control is working with
kernel 2.6.25 and doesn't work with kernel 2.6.26 without any other
change to your system. You'll have to do more tests to figure out what
exactly broke fan speed control on your system.

Please also explain in more details what the actual problem is. "It
stopped working" doesn't tell us much.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
