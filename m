From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Dec 2008 19:40:57 +0000
Subject: Re: [lm-sensors] lm-sensors 2.10.1 with newer 2.6.x.x kernel can't
Message-Id: <200812252040.57732.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
In-Reply-To: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi John,

Le Jeudi 25 D=E9cembre 2008 19:05, John Brier a =E9crit=A0:
> lm-sensors 3 and libsensors 4 want a newer version of libc6 than I
> have installed, and upgrading that seems like a bad idea (it would
> probably force upgrading all the packages on the system since they all
> depend on libc6, thus I might as well move the whole system from
> debian stable to debian testing) In the end this may be the only
> solution :-(

Ah, OK then. I only thought about libsensors compatibility issues,
not system-wide compatibility issues such as glibc.

That being said, I am a little surprised that Debian offers no half
way between lm-sensors 2.10.1 (over 2 year old!) and 3.0.2 (fairly
recent).

> > Which modules are these?
>=20
> i2c_nforce2
> w83627hf
> k8temp is compiled directly into the kernel (non modular).

Please note that i2c-nforce2 isn't actually needed.

> > Please provide the full output of sensors-detect.
> http://pastebin.ca/1293524

Looks sane.

> > Did this system ever work with a different combination of lm-sensors
> > version and kernel version? And what system is this?
>=20
> Yes it worked with an older kernel and same version of lm-sensors (not
> certain on the version of lm-sensors because I've updated since then
> of course, this was a year ago that it worked). The kernel it used to
> work on (I can test this again) was 2.6.20.1.

In kernel 2.6.22, the w83627hf driver was converted from an i2c-isa
driver to a platform driver. Even though this is supposedly supported
since lm-sensors 2.10.0, this may still be the cause for the
compatibility problem you're seeing, given how old lm-sensors 2.10.1
is.

Probably the best way to make sure what the exact problem is is to
run "strace sensors" and see where the failure occurs.

It would also be a good idea to check that everything is OK on the
kernel side. What does the following command return?

grep . /sys/class/hwmon/hwmon*/device/name

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
