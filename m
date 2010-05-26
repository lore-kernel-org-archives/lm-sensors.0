From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 26 May 2010 06:50:27 +0000
Subject: Re: [lm-sensors] trouble configuring an ASUS M51VA laptop
Message-Id: <20100526085027.4f02786a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BF5069A.7030602@kalfaoglu.com>
In-Reply-To: <4BF5069A.7030602@kalfaoglu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi turgut,

On Tue, 25 May 2010 22:53:22 +0300, turgut kalfao=C4=9Flu wrote:
> I sent this message a few days, but I wonder if it was distributed..

It was distributed, but nobody replied.

> Hi there. Under Fedora 11, I am unable to get sensors-detect to detect=20
> my laptop's ACPI details.

This is expected. sensors-detect doesn't know anything about ACPI.

> It only finds coretemp, hence /proc/acpi/fans/ folder is empty, and the=20
> fan speed cannot be set or read.

The "fan" ACPI driver never provides fan speed anyway, nor does it let
you change it. In the best case, it can tell you whether the fan is on
or off, and that's about it.

> I was also unable to find any /etc/sensors3.conf example that had this=20
> laptop's hardware.

As this is an Asus laptop, you might give a try to the asus_atk0110
ACPI driver. It should load automatically though, and apparently it did
not. Maybe your kernel is too old: you need kernel 2.6.30 or later, and
I think Fedora 11 has 2.6.29.

Or maybe your laptop simply doesn't implement the ATK0110 interface. In
that case, the coretemp driver output is the best thing you can have on
this laptop.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
