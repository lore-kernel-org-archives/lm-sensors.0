From: Frank Myhr <fmyhr@fhmtech.com>
Date: Tue, 02 Sep 2008 14:29:22 +0000
Subject: Re: [lm-sensors] lm-sensors Digest, Vol 41, Issue 2
Message-Id: <48BD4DC2.8000705@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hector Lahoz Gra=F1ena wrote:
> Are there any plans to implement Smartguardian (i.e. fan speed control) f=
or
> the it87 family? Should I write a daemon to control the fans or is the dr=
iver
> who has to do the work?
>=20
> Another possibility is using the smartguardian automatic mode which has t=
he
> advantage, I think; that it's easy to implement and causes no CPU overloa=
d.
> By the way, the programming interface thar appears in the datasheet does =
not
> correspond to my chip (it8705 version 2). I almost go crazy.

Hi Hector,

I've been working to add automatic fan mode to the it87 driver. It works on=
 the
it8718, but I'm still changing the sysfs interface, and adding auto mode su=
pport
for the other it87 chips. I'll post the code to this list when ready. It wo=
uld
be great if you could help test it on your it8705_v2, I don't have one here.

Auto mode varies a bit from chip to chip, and for the 8705, for different
versions of the chip*. For your it8705_v2, auto mode allows 5 discrete fan
speeds: off, low, medium, high, and all fans full speed. You could get smoo=
ther
control by using the software pwm mode you already have working along with =
the
lm_sensors fancontrol script.

* Note that the datasheet version does not always correspond to the version
that the chip reports in Global Configuration Register 0x22:[3-0]. For
example:

datasheet	chip-reported version
8705 0.3	0x02
8712 0.7	0x06
8712 0.81	0x07
8712 0.9.3	0x08

-Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
